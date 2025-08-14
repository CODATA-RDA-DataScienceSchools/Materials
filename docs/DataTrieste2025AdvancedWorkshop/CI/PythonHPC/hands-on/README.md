# HPC for Python: Shared vs Distributed Memory Parallelization

This tutorial demonstrates two fundamental approaches to parallel computing in Python: **shared memory** parallelization using OpenMP-style libraries and **distributed memory** parallelization using MPI (Message Passing Interface).

## Parallel Computing Paradigms

### Shared Memory vs Distributed Memory

**Shared Memory Parallelization:**
- Multiple threads/processes share the same memory space
- Communication happens through shared variables and data structures
- Typically limited to a single compute node
- Examples: OpenMP, threading, multiprocessing within a node
- Pros: Easy data sharing, low communication overhead
- Cons: Limited scalability, memory contention issues

**Distributed Memory Parallelization:**
- Each process has its own private memory space
- Communication happens through explicit message passing
- Can scale across multiple compute nodes and clusters
- Example: MPI (Message Passing Interface)
- Pros: Excellent scalability, fault tolerance, no memory contention
- Cons: More complex programming model, communication overhead

## Monte Carlo π Estimation

### The Problem

A common example in numerical computing is the Monte Carlo computation of π. The algorithm works as follows:

1. Consider the unit circle centered at the origin
2. Generate random points in the unit square from (0,0) to (1,1)
3. Count how many points fall inside the circle (distance from origin ≤ 1)
4. The ratio of points inside to total points approximates π/4

The mathematical basis: The area of a quarter circle with radius 1 is π/4, while the area of the unit square is 1. Therefore:

$$π ≈ 4 × \frac{\text{points inside circle}}{\text{total points}}$$

![Monte Carlo Pi Estimation](https://hackmd.io/_uploads/ryRgAx3iC.png)

## Part 1: Shared Memory Parallelization with PyMP

### What is OpenMP?

OpenMP (Open Multi-Processing) is a programming model for shared memory parallelization. Key characteristics:

- **Fork-Join Model**: Master thread spawns worker threads, then joins them
- **Shared Address Space**: All threads can access the same memory
- **Directive-Based**: Uses compiler directives to parallelize code
- **Thread Synchronization**: Provides locks, barriers, and critical sections

PyMP is a Python implementation that mimics OpenMP's behavior using multiprocessing.

### Environment Setup

First, create and set up your environment:

```bash
$ module load anaconda3
$ conda create -n hpc_example python=3.9
$ conda activate hpc_example
```

Install required packages:

```bash
$ conda install numpy
$ pip install pymp-pypi
```

### Code Implementation

The shared memory version uses PyMP for parallelization within a single node:

```python
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

def estimate_pi(total_count, core_count):
    # Create shared array accessible by all threads
    count = pymp.shared.array((core_count,), dtype='int32')
    
    # Parallel execution block
    with pymp.Parallel(core_count) as p:
        for i in p.range(0, core_count):
            local_count = inside_circle(int(total_count/core_count))
            # Thread-safe write to shared memory
            with p.lock:
                count[i] = local_count
    
    return (4.0 * sum(count) / total_count)

if __name__ == "__main__":
    samples = int(sys.argv[1])
    ncores = int(sys.argv[2])
    pi = estimate_pi(samples, ncores)
    print("Pi within {}, is: {}".format(samples, pi))
```

### SLURM Submission Script (Shared Memory)

```bash
#!/bin/bash --login
#SBATCH --nodes=1                    # Single node only
#SBATCH --ntasks=1                   # One main process
#SBATCH --exclusive                  # Exclusive node access
#SBATCH --cpus-per-task=40          # Multiple CPUs for threading
#SBATCH --error pi.%J.error
#SBATCH --output pi.%J.out
#SBATCH --time 00:01:00
#SBATCH --partition=testing

# Load environment
module load anaconda3/202105
conda activate hpc_example

# Prevent OpenMP from interfering
export OMP_NUM_THREADS=1

# Run with specified number of cores
time python calc_pi.py 100000000 ${SLURM_CPUS_PER_TASK}
```

### Exercise: Shared Memory Performance

1. **Serial Baseline**: Test with 1 core and 100,000,000 samples
2. **Scaling Test**: Compare performance with 8, 16, and 32 cores
3. **Analysis**: Calculate speedup and efficiency for each configuration

Expected observations:
- Initial speedup with more cores
- Diminishing returns due to overhead
- Possible performance degradation at high core counts

## Part 2: Distributed Memory Parallelization with MPI

### What is MPI?

MPI (Message Passing Interface) is the standard for distributed memory parallel computing:

**Key Concepts:**
- **Processes**: Independent execution units with private memory
- **Communicators**: Define groups of processes that can communicate
- **Point-to-Point Communication**: Direct message exchange between processes
- **Collective Communication**: Operations involving all processes (broadcast, gather, reduce)
- **Synchronization**: Barriers to coordinate process execution

**MPI Advantages:**
- Scales from single nodes to supercomputers
- Language independent (C, C++, Fortran, Python)
- Fault tolerance through process isolation
- Standardized and portable

### MPI Programming Model

```
Process 0    Process 1    Process 2    Process 3
[Memory]     [Memory]     [Memory]     [Memory]
    |            |            |            |
    +---- MPI Communication Network ------+
```

### Environment Setup for MPI

```bash
$ conda activate hpc_example
$ conda install mpi4py
```

### MPI Implementation

Save this as `calc_pi_distributed.py`:

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
    comm = MPI.COMM_WORLD  # Global communicator
    rank = comm.Get_rank() # Process ID (0 to size-1)
    size = comm.Get_size() # Total number of processes
    
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

if __name__ == "__main__":
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    size = comm.Get_size()
    
    if len(sys.argv) != 2:
        if rank == 0:
            print("Usage: mpirun -n <num_processes> python calc_pi_distributed.py <total_samples>")
        sys.exit(1)
    
    samples = int(sys.argv[1])
    
    if rank == 0:
        print(f"Estimating π with {samples} samples using {size} MPI processes")
    
    # Synchronize all processes before timing
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

### SLURM Submission Script (Distributed Memory)

Save as `submit_mpi.sbatch`:

```bash
#!/bin/bash
#SBATCH --job-name=pi_estimation_mpi
#SBATCH --partition=cmsp
#SBATCH --nodes=2                    # Multiple nodes
#SBATCH --ntasks-per-node=8         # MPI processes per node
#SBATCH --cpus-per-task=1           # One CPU per MPI process
#SBATCH --mem-per-cpu=1G            # Memory per process
#SBATCH --time=00:10:00
#SBATCH --output=pi_estimation_%j.out
#SBATCH --error=pi_estimation_%j.err

# Load required modules
module load anaconda3
conda activate hpc_example

# Print job information
echo "Job started at: $(date)"
echo "Job ID: $SLURM_JOB_ID"
echo "Running on nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "Total number of tasks: $SLURM_NTASKS"

# Set number of samples
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

## Key Differences in Implementation

| Aspect | Shared Memory (PyMP) | Distributed Memory (MPI) |
|--------|---------------------|---------------------------|
| **Memory Model** | Shared arrays, locks needed | Private memory, explicit communication |
| **Scalability** | Single node only | Multiple nodes |
| **Communication** | Direct memory access | Message passing (gather/broadcast) |
| **Synchronization** | Locks and barriers | MPI barriers and collective operations |
| **Random Seeds** | Implicit handling | Explicit seed management per process |
| **Error Handling** | Thread exceptions | Process-level error handling |

## Running the Examples

### Shared Memory Version:
```bash
# Submit the job
sbatch submit_pymp.sbatch

# Check status
squeue -u $USER

# View results
cat pi.JOBID.out
```

### Distributed Memory Version:
```bash
# Submit the job
sbatch submit_mpi.sbatch

# Monitor progress
tail -f pi_estimation_JOBID.out
```

## Performance Analysis

### Expected Results:
1. **Shared Memory**: Good scaling up to ~16-32 cores, then diminishing returns
2. **Distributed Memory**: Better scaling across nodes, linear speedup possible
3. **Communication Overhead**: MPI has initial overhead but scales better
4. **Memory Usage**: Distributed memory uses less memory per process

### Exercises:

1. **Baseline Comparison**: Run both versions with the same total core count
2. **Scaling Study**: Test 1, 2, 4, 8, 16 processes for each approach
3. **Accuracy Analysis**: Compare π estimates with different sample sizes
4. **Hybrid Approach**: Combine MPI between nodes with threading within nodes

## Best Practices

### When to Use Shared Memory:
- Single node applications
- Frequent data sharing between threads
- Memory-intensive algorithms
- Quick prototyping

### When to Use Distributed Memory:
- Multi-node scaling required
- Large-scale simulations
- Production HPC applications
- Fault tolerance needed

## Troubleshooting

### Common Issues:
- **Module loading**: Ensure correct MPI and Python modules
- **Memory limits**: Adjust `--mem-per-cpu` for larger problems
- **Time limits**: Increase `--time` for larger sample sizes
- **Network issues**: Check MPI configuration between nodes

### Debugging Tips:
- Start with small sample sizes
- Test on single node before scaling
- Check SLURM output files for errors
- Use `srun --pty bash` for interactive debugging


## GPU

Try the [following notebook with experiments of math operations using GPU](https://colab.research.google.com/drive/1anVbRXx2zRcR4AYSsDwpClUoafgc3UUj#scrollTo=66bBu8XWkYvM)
