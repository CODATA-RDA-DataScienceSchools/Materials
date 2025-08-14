# HPC for Python

## Single Node Parallel Execution

### Montecarlo simulations
Calculating $\pi$ using Monte Carlo Simulation

A common example problem in numerical computing is the Monte Carlo computation of $\pi$
The way this works is as follows:

Consider the unit circle, centered on the origin. Now, imagine firing bullets at random locations in the square from the origin to the point (1, 1). The area of that square that overlaps with the circle is $\frac{\pi}{4}$, while the area of the square is 1. So the proportion of bullets that will land in the circle is $\frac{\pi}{4}$.

So, by generating a large number of random points in the unit square, and counting the number that lie within the unit circle, we can find an estimate for $\frac{\pi}{4}$, and by extension, $\pi$.

![image](https://hackmd.io/_uploads/ryRgAx3iC.png)

Overlay a unit square over a quadrant of a circle. Throw m random number pairs and count how many of the pairs lie inside the circle (the number pairs inside the circle is denoted by n). $\pi$ is then approximated by: $\pi=\frac{4m}{n}$, where 

For this example we will use the [pymp framework](https://github.com/classner/pymp), so we first need to install it, but before let's create a new anaconda environment and set up what is needed:
```bash
$ module load anaconda3
$ conda create -n pymp_example python=3
```
Now we can install the library:

```bash
$ conda install numpy
$ pip install pymp-pypi
```

The code for calculating pi is as follow:

```python=
import numpy as np
import sys
import pymp

def inside_circle(total_count):

    x = np.float32(np.random.uniform(size=total_count))
    y = np.float32(np.random.uniform(size=total_count))

    radii = np.sqrt(x*x + y*y)

    filtered = np.where(radii<=1.0)
    count = len(radii[filtered])

    return count


def estimate_pi(total_count,core_count):

    count = pymp.shared.array((core_count,), dtype='int32')

    with pymp.Parallel(core_count) as p:
        for i in p.range(0,core_count):
            local_count = inside_circle(int(total_count/core_count))

            with p.lock:
                count[i] = local_count

    return (4.0 * sum(count) / total_count)


if __name__ == "__main__":
    samples = int(sys.argv[1])
    ncores = int(sys.argv[2])
    pi = estimate_pi(samples, ncores)
    print("Pi within {}, is: {}".format(samples, pi))
                                  
```

Submission file:
```bash=
#!/bin/bash --login
###
# Number of processors we will use
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --exclusive
#SBATCH --cpus-per-task=40
# Output file location
#SBATCH --error pi.%J.error
#SBATCH --output pi.%J.out
# Time limit for this job
#SBATCH --time 00:01:00
#SBATCH --partition=testing
###

# Load Python and activate the environment we will use for this work
module load anaconda3/202105
conda activate pymp_example

export OMP_NUM_THREADS=1

time python calc_pi.py 100000000 ${SLURM_CPUS_PER_TASK}
```

#### Exercise

* Write a slurm submission script to test the serial version of this code with 100000000 samples. Time that!
* Now, modify it so we can allocate 8, 16, and 32 cpus. Was there any gain in performance?

## Distributed Memmory

Now we need to write the following code for running in a distributed environment. Save it into a file name `calc_pi_distributed.py`

```python
import numpy as np
import sys
from mpi4py import MPI

def inside_circle(total_count, seed=None):
    """
    Count points inside unit circle using Monte Carlo method.
    Uses different random seed for each MPI process to avoid correlation.
    """
    if seed is not None:
        np.random.seed(seed)

    x = np.random.uniform(0, 1, total_count).astype(np.float32)
    y = np.random.uniform(0, 1, total_count).astype(np.float32)
    radii = np.sqrt(x*x + y*y)
    count = np.sum(radii <= 1.0)
    return count

def estimate_pi_mpi(total_count):
    """
    Estimate π using MPI parallelization across multiple nodes/processes.
    """
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    # Distribute work among MPI processes
    local_count = total_count // size
    remainder = total_count % size

    # Handle remainder by giving extra samples to first few processes
    if rank < remainder:
        local_count += 1

    # Use rank as seed to ensure different random sequences per process
    local_inside = inside_circle(local_count, seed=rank * 12345)

    # Gather results from all processes to rank 0
    all_inside = comm.gather(local_inside, root=0)
    all_counts = comm.gather(local_count, root=0)

    if rank == 0:
        total_inside = sum(all_inside)
        actual_total = sum(all_counts)
        pi_estimate = 4.0 * total_inside / actual_total
        return pi_estimate, actual_total
    else:
        return None, None

def estimate_pi_hybrid(total_count):
    """
    Hybrid approach: MPI between nodes + local parallelization within nodes.
    This version uses only MPI for simplicity, but you could combine with
    multiprocessing or threading within each MPI process if needed.
    """
    return estimate_pi_mpi(total_count)

if __name__ == "__main__":
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()

    if len(sys.argv) != 2:
        if rank == 0:
            print("Usage: mpirun -n <num_processes> python pi_mpi.py <total_samples>")
            print("Example: mpirun -n 4 python pi_mpi.py 1000000")
        sys.exit(1)

    samples = int(sys.argv[1])

    if rank == 0:
        print(f"Estimating π with {samples} samples using {size} MPI processes")

    # Synchronize all processes before starting timing
    comm.Barrier()
    start_time = MPI.Wtime()

    pi_estimate, actual_samples = estimate_pi_mpi(samples)

    comm.Barrier()
    end_time = MPI.Wtime()

    if rank == 0:
        print(f"Pi estimate with {actual_samples} samples: {pi_estimate}")
        print(f"Error from true π: {abs(pi_estimate - np.pi):.6f}")
        print(f"Execution time: {end_time - start_time:.4f} seconds")
        print(f"Samples per second: {actual_samples / (end_time - start_time):.0f}")
```

And the submission script `submit_mpi.sbatch`:

```bash
#!/bin/bash
#SBATCH --job-name=pi_estimation_mpi
#SBATCH --partition=cmsp
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1

#SBATCH --time=00:10:00
#SBATCH --output=pi_estimation_%j.out
#SBATCH --error=pi_estimation_%j.err

# Load required modules (adjust based on your system)
module load anaconda3
conda activate pymp_example

# Print job information
echo "Job started at: $(date)"
echo "Job ID: $SLURM_JOB_ID"
echo "Running on nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "Total number of tasks: $SLURM_NTASKS"

# Set number of samples (adjust as needed)
SAMPLES=100000000

# Print MPI information
echo "MPI Configuration:"
mpirun --version
echo "Total MPI processes: $SLURM_NTASKS"

# Run the MPI program
echo "Starting π estimation with $SAMPLES samples..."
mpirun -n $SLURM_NTASKS python calc_pi_distributed.py $SAMPLES

echo "Job completed at: $(date)"
```
