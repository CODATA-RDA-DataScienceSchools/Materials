---
title: 'High Performance Computing Trieste 2023'
tags: codata-rda, sords
---

Most of this content has been copied from the chpc [wiki page](https://wiki.chpc.ac.za/), Software Carpentries [lesson on HPC](https://carpentries-incubator.github.io/hpc-intro), and Epcced [tutorial on HPC](https://epcced.github.io/hpc-intro).

# High Performance Computing


## Table of Contents

[TOC]

## A few words about High Performance Computing - HPC

Frequently, research problems that use computing can outgrow the capabilities of the desktop or laptop computer where they started:

* A statistics student wants to cross-validate a model. This involves running the model 1000 times – but each run takes an hour. Running the model on a laptop will take over a month! In this research problem, final results are calculated after all 1000 models have run, but typically only one model is run at a time (in serial) on the laptop. Since each of the 1000 runs is independent of all others, and given enough computers, it’s theoretically possible to run them all at once (in parallel).
* A genomics researcher has been using small datasets of sequence data, but soon will be receiving a new type of sequencing data that is 10 times as large. It’s already challenging to open the datasets on a computer – analyzing these larger datasets will probably crash it. In this research problem, the calculations required might be impossible to parallelize, but a computer with more memory would be required to analyze the much larger future data set.
* An engineer is using a fluid dynamics package that has an option to run in parallel. So far, this option was not used on a desktop. In going from 2D to 3D simulations, the simulation time has more than tripled. It might be useful to take advantage of that option or feature. In this research problem, the calculations in each region of the simulation are largely independent of calculations in other regions of the simulation. It’s possible to run each region’s calculations simultaneously (in parallel), communicate selected results to adjacent regions as needed, and repeat the calculations to converge on a final set of results. In moving from a 2D to a 3D model, both the amount of data and the amount of calculations increases greatly, and it’s theoretically possible to distribute the calculations across multiple computers communicating over a shared network.  

In all these cases, access to more (and larger) computers is needed. Those computers should be usable at the same time, solving many researchers’ problems in parallel.

### What is HPC?

The words “cloud”, “cluster”, and “high-performance computing” are used a lot in different contexts and with varying degrees of correctness. So what do they mean exactly? And more importantly, how do we use them for our work?

The cloud is a generic term commonly used to refer to remote computing resources of any kind – that is, any computers that you use but are not right in front of you. Cloud can refer to machines serving websites, providing shared storage, providing webservices (such as e-mail or social media platforms), as well as more traditional “compute” resources. An HPC system on the other hand, is a term used to describe a network of computers. The computers in a cluster typically share a common purpose, and are used to accomplish tasks that might otherwise be too big for any one computer.

* The cluster can serve to **offload code execution from your laptop/workstation**
    * code that runs too long or needs too much memory or disk space 
* clusters are particularly useful for executing parallel code
    * on one compute node
    * on multiple compute nodes at once

>📝 **Note on speed of execution:**
> * the compute nodes have similar architecture to your desktop 
> * they are not much faster
> * the main advantage of cluster computing lies in parallel code execution

## Accessing the remote system

The first step in using a cluster is to establish a connection from our laptop to the cluster. When we are sitting at a computer (or standing, or holding it in our hands or on our wrists), we have come to expect a visual display with icons, widgets, and perhaps some windows or applications: a graphical user interface, or GUI. Since computer clusters are remote resources that we connect to over slow or intermittent interfaces (WiFi and VPNs especially), it is more practical to use a command-line interface, or CLI, to send commands as plain-text. If a command returns output, it is printed as plain text as well. The commands we run today will not open a window to show graphical results.

If you have ever opened the Windows Command Prompt or macOS Terminal, you have seen a CLI. If you have already taken The Carpentries’ courses on the UNIX Shell or Version Control, you have used the CLI on your local machine extensively. The only leap to be made here is to open a CLI on a remote machine, while taking some precautions so that other folks on the network can’t see (or change) the commands you’re running or the results the remote machine sends back. We will use the Secure SHell protocol (or SSH) to open an encrypted network connection between two machines, allowing you to send & receive text and data without having to worry about prying eyes.

SSH clients are usually command-line tools, where you provide the remote machine address as the only required argument. If your username on the remote system differs from what you use locally, you must provide that as well. If your SSH client has a graphical front-end, such as PuTTY or MobaXterm, you will set these arguments before clicking “connect.” From the terminal, you’ll write something like `ssh userName@hostname`, where the argument is just like an email address: the “@” symbol is used to separate the personal ID from the address of the remote machine.

```bash=
$ ssh rmendes@argo-login1.ictp.it 
Last login: Wed Aug 16 17:06:28 2023 from 140.105.22.11
[rmendes@login01 ~]$ 
```

### Where are we?

Very often, many users are tempted to think of a high-performance computing installation as one giant, magical machine. Sometimes, people will assume that the computer they’ve logged onto is the entire computing cluster. So what’s really happening? What computer have we logged on to? The name of the current computer we are logged onto can be checked with the `hostname` command. (You may also notice that the current hostname is also part of our prompt!)

```bash=
$ hostname

login01
```

```sequence
User->System: Connect to the system using SSH
Note right of System: System checks available login methods\nand selects password \nas authentication method
System-->User: Request Password
Note left of User: User fills password at prompt
User->System: Sends Password
Note right of System: Checks if password if valid
System-->User: User successfully authenticated
Note left of User: Receives remote prompt
User->System: Issue commands
```


## Job Scheduler

An HPC system might have thousands of nodes and thousands of users. How do we decide who gets what and when? How do we ensure that a task is run with the resources it needs? This job is handled by a special piece of software called the ***scheduler***. On an HPC system, the **scheduler manages which jobs run where and when**.

The Argo cluster uses Slurm as its job scheduler. With the exception of interactive jobs, all jobs are submitted to a batch queuing system and only execute when the requested resources become available. All batch jobs are queued according to priority. A user's priority is not static: the Argo uses the “Fairshare” facility to modify priority based on activity. This is done to ensure the finite resources of the Argo cluster are shared fairly amongst all users.


## Terminology

* **Job**: your program on the cluster
* **Submit job**: instruct the cluster to run your program
* **Node**: compute node = group of cores that can access the same memory (also known as a computer or a machine)
* **Memory**: main memory or RAM (fast memory directly connected to the processor, when your program is running it is stored in RAM together with needed data)
* **Core**: the basic computation unit inside a processor that can run a single process
* **Serial code**: runs on one core
* **Parallel code**: program that runs on two or more cores

## Creating our first batch job

The most basic use of the scheduler is to run a command non-interactively. Any command (or series of commands) that you want to run on the cluster is called a job, and the process of using a scheduler to run the job is called batch job submission.

In this case, the job we want to run is just a shell script. Let’s create a demo shell script to run as a test.

```bash=
#!/bin/bash

echo 'This script is running on:'
hostname
sleep 60
```

Now let us run or first job and see what happens?

```bash=
$ chmod +x job1.sh
$ ./job1.sh
```

Result:
```bash
> login1 
```

### Submitting the job to the cluster

We will be writing sbatch scripts with bash, but you can use any programming language as long as the pound sign (#) doesn’t cause an error. Your sbatch scripts will generally follow this format:

```bash=
#!/bin/bash -l
# Declaring Slurm Configuration Options

# Loading Software/Libraries

# Running Code
```

There are many configuration options available to Slurm. Some options can be confusing, others may not be able to work together, and some options may have unintended side-effects. You can see a full list of options [here](https://slurm.schedmd.com/sbatch.html), but we recommend you stick with the basics or ask for help if you need to use more advanced options. We can help you find the best set of configurations for your compute needs.

Configuration options are specified in your sbatch script like this:

```bash=
#SBATCH <option_1>=<value>
#SBATCH <option_2>=<value>
...
#SBATCH <option_N>=<value>
```

Note that the pound sign (#) is not a comment here. Slurm looks for lines starting with #SBATCH so it can find configuration options.


#### Accounting Configurations

**Job Name**: `#SBATCH --job-name=<job_name>` 
- The first thing you will want to do is give your job a name. It should be descriptive, but succinct. Example: `#SBATCH --job-name=LogisticRegression`.
- The point of the job name is to remind yourself what you are doing. If it’s not descriptive, then you can easily get confused.

**Comment**: `#SBATCH --comment=<comment>`
- If you want an extended description for your job, you can add a comment. Example: `#SBATCH --comment="Logistic Regression with L2 penalty and liblinear solver."`

**Account**: `#SBATCH --account=<account_name>`
- You need to tell Slurm which account to run your job under. This is not your user account, but your project account, which was assigned when you filled out the questionnaire. Example: `#SBATCH --account=cosmos` (we like to have fun with account names).
- If you don’t remember your account name, you can run my-accounts on the cluster to find it.

**Partition**: `#SBATCH --partition=testing`
- Slurm needs to know which partition to run your job on. A partition is just a group of nodes (computers). We have three partitions: debug, tier3, and interactive. Each partition has access to different resources and has a specific use case. Example: `#SBATCH --partition=debug`.

**Time Limit**: `#SBATCH --time=D-HH:MM:SS`
- You need to tell Slurm how long your job needs to run. The format is Days-Hours:Minutes:Seconds (D-HH:MM:SS). Example: `#SBATCH --time=1-12:30:00` (1 day, 12 Hours, 30 Minutes, 0 Seconds).
- The testing partition has a max time limit of 6 hours. If you try to specify more than that, Slurm will not schedule your job.
- It’s okay to specify a bit more time than you think your job needs. It will not be a good day if your job took 3 days to start running, another 4 days to actually run, and then you find out it actually needs 4 days and 1 minute to finish.
 
 #### Job Output Configurations

**Output File**: `#SBATCH --output=%x_%j.out`
- Any output from your compute job will be saved to the output file that your specify.
- `%x` is a variable that fills in your job name. `%j` is a variable that fills in your job ID number.
- You can place your output file in a folder (e.g. `#SBATCH --output=logs/%x_%j.out`).

**Error File**: `#SBATCH --error=%x_%j.err`
- Any errors from your compute job will be saved to the error file that your specify.
- `%x` is a variable that fills in your job name. `%j` is a variable that fills in your job ID number.
- You can place your error file in a folder (e.g. `#SBATCH --error=logs/%x_%j.err`).

#### Node Configurations
A node is just a computer in a cluster. Most of the time, it probably makes sense to only use one node, but if your code can leverage MPI (Message Passing Interface), then your job will probably schedule faster on multiple nodes. If you’re unsure how many nodes you need, we can help you figure that out.

**Nodes**: `#SBATCH --nodes=<num_nodes>`
- Example: #SBATCH --nodes=1
- The default is 1 node, so if you’re only using 1 node, you don’t need to include this configuration option. However, we recommend that you still include it to help remind yourself what resources your job is using.

**Excluding Nodes**: `#SBATCH --exclude=<node1,node2,...>`
- If for some reason you want to make sure your job does not run on a specific node (or nodes), you can do that with this option. Example: `#SBATCH --exclude=theocho`.

**Exclusive Access to a Node**: `#SBATCH --exclusive`
- If your job can fully utilize all of the resources on a single node, then you should specify `#SBATCH --exclusive` to get exclusive access to a whole node. If you’re not sure if your job can benefit from this configuration option, we can help you figure that out.

#### Task Configurations
In the context of Slurm, a task is a running instance of a program. In most situations, you can think of tasks as equivalent to processes.

**Number of Tasks**: `#SBATCH --ntasks=<num_tasks>`
- By default, Slurm will assign one task per node. If you want more, you can specify that with this configuration options. Example: `#SBATCH --ntasks=2`.

**Number of Tasks per Node**: `#SBATCH --ntasks-per-node=<num_tasks>`
- If your job is using multiple nodes, you can specify a number of tasks per node with this option. Example: `#SBATCH --ntasks-per-node=2`.

#### CPU & GPU Configurations

**CPUs per Task**: `#SBATCH --cpus-per-task=<num_cpus>`
- Slurm needs to know how many CPUs your job needs. Example: #SBATCH --cpus-per-task=4.
- By default, Slurm will assign 1 CPU per task if you do not use the configuration option.

**GPUs per Job**: ``#SBATCH --gres=gpu:<gpu_type>:<num_gpus>``
- By default, Slurm will not allocate any GPUs to your job. You need to specify how many and what type of GPUs your job needs. Example: `#SBATCH --gres=gpu:p4:2`.
 

#### Memory Configurations

**Memory per Node**: `#SBATCH --mem=<memory>`
- You can use this option to tell Slurm how much memory you need per node. Example: `#SBATCH --mem=10g` (10GB of memory per node).
- The default is megabytes (MB), so if you just say #SBATCH --mem=10, you will only get 10MB. You can use k for kilobytes (KB), m for megabytes (MB), g for gigabytes (GB), and t for terabytes (TB).

**Memory per CPU**: ``#SBATCH --mem-per-cpu=<memory>``
- You can also specify a memory limit per CPU. Example: `#SBATCH --mem-per-cpu=10g` (10GB of memory per CPU).
- You need to make sure `--mem` and `--mem-per-cpu` don’t conflict with each other. In the following example, we ask for 2 nodes with 1 task each, and 2 CPUs per task (4 CPUs total). 

#### Slurm Filename Variables
You saw with the `--output` and `--error` configuration options that we used two special variables: %x (job name) and `%j` (job ID). Slurm provides a number of variables for you to use for naming files. Here are a few that you may find useful:

Variable|Example|Description
--------|-------|-----------
%x	|`#SBATCH --output=%x_%j.out`| Fill in job name (set by --job-name)
%j	| `#SBATCH --error=%x_%j.err`| Fill in job ID (set by Slurm)
%N	|`#SBATCH --output=%n_%x_%j.out`|	Fill in hostname; creates separate file for each host
%a	|`#SBATCH --error=%x_%a_%j.err`|Fill in job array number (job arrays covered in Part 2 of this tutorial)
%%	|`#SBATCH --output=%x_20%%.out`|Escape percent sign; creates `<job_name>_20%.out`

### Example of Submission Job

Now we can combine some of the options above to create a simple job. Let’s create an sbatch script (`$ nano test_script.sh`) and place the following code inside of it:


```bash=
#!/bin/bash -l

#SBATCH --job-name=testJob		# Name for your job
#SBATCH --comment="Testing Job"		# Comment for your job

#SBATCH --partition=testing		# Partition to run your job on

#SBATCH --output=%x_%j.out		# Output file
#SBATCH --error=%x_%j.err		# Error file

#SBATCH --time=0-00:05:00		# Time limit
#SBATCH --nodes=1			# How many nodes to run on
#SBATCH --ntasks=2			# How many tasks per node
#SBATCH --cpus-per-task=1		# Number of CPUs per task
#SBATCH --mem-per-cpu=1g		# Memory per CPU

hostname				# Run the command hostname
```

So, in this example, we have requested a job with the following dimensions:

* **Max Run Time**: 5 Minutes
* **Number of Nodes**: 1
* **Number of Tasks Per Node**: 2
* **Number of CPUs Per Task**: 1
* **Memory Per CPU**: 1GB

Finally, we run the bash command `hostname`. You can run whatever kind of code you want here; *C*, *C++*, *bash*, *python*, *R*, *Ruby*, etc.

### Submitting Your Job
Submitting your job is easy! Simply use the command `$ sbatch <slurm_script.sh>`. In this example:
```bash=
$ sbatch test_script.sh
Submitted batch job 15289113
```
Notice above that Slurm responded and gave us a job ID. That job ID is unique and you can use it to monitor your job. We can also use it to help you debug if something goes wrong.

### Monitoring Your Job
After we submit a job, Slurm will create the output and error files. You can see them by running:
```
$ ls

testJob_15289113.out	testJob_15289113.err	test_script.sh
```

We can also see that our job is running using the squeue --me command:

```
$ squeue -u $USER
    JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    593274   testing  testJob  rmendes CF       1:50      1 node161
```

The squeue command gives us the following information:

* **JOBID**: The unique ID for your job.
* **PARTITION**: The partition your job is running on (or scheduled to run on).
* **NAME**: The name of your job.
* **USER**: The username for whomever submitted the job.
* **ST**: The status of the job. The typical status codes you may see are:
    * **CD** (Completed): Job completed successfully
    * **CG** (Completing): Job is finishing, Slurm is cleaning up
    * **CF** (Configuring): Node is being configured to run the job
    * **PD** (Pending): Job is scheduled, but the requested resources aren’t available yet
    * **R** (Running): Job is actively running
* **TIME**: How long your job has been running.
* **NODES**: How many nodes your job is using.
* **NODELIST(REASON)**: Which nodes your job is running on (or scheduled to run on). If your job is not running yet, you will also see one of the following reason codes:
    * **Priority**: When Slurm schedules a job, it takes into consideration how frequently you submit jobs. If you often submit many jobs, Slurm will assign you a lower priority than someone who has never submitted a job or submits jobs very infrequently. Don’t worry, your job will run eventually.
    * **Resources**: Slurm is waiting for the requested reasources to be available before starting your job.
    * **Dependency**: If you are using dependent jobs, the parent job may show this reason if it’s waiting for a dependent job to complete.


#### Exercise

1. Run the example seen before
2. Text Analysis
    * Download the book [Through the Looking-Glass by Lewis Carroll](https://www.gutenberg.org/ebooks/12);
    * Write a script to show the top 10 (unique) words in the file;
        * tip 1: Use the command `tr -s ' ' '\n'` in order to output one word per line
        * tip 2: you might want to look into the commands: `sort` and `uniq`
    * Create a job to run this analysis on the Argo Cluster (Don't forget to change the name of the job and the comment that describes what it does);

## Job Scheduling
When you submit your job, Slurm grabs your `#SBATCH` configurations and finds a time and place on the cluster to run your job. There are four things that impact when your job will run:

1. The resources you request
1. The frequency that you submit jobs
1. The other jobs in the queue
1. Maintenance windows

**Some examples:**

* If you request a lot of resources, you will have to wait until those resources are available, which may be a while depending on how many other jobs are in the queue.
* If you submit a lot of jobs with a small amount of resources, they will likely schedule quickly, but your future jobs may have a slightly lower priority than jobs submitted by someone who submits jobs infrequently.
* If you submit a job with a 3 day runtime (`#SBATCH --time=3-00:00:00`), but a maintenance window is scheduled for two days from now, there is no way your job will finish before the maintenance window, so it won’t be scheduled until after the maintenance window.
* If there is a maintenance window 4 days away, and you submit a job with a 2 day runtime, but the queue is full and the earliest the resources you requested will be available is in 3 days, there is no way your job will finish before the maintenance window (2+3=5), so your job won’t be scheduled until after the maintenance window.


## Interactive Jobs

So far we have only talked about batch jobs; jobs that you submit and just let run until they finish. The Argo cluster was designed primarily for batch jobs, however not all computational workloads fit within that bucket.

For compute workloads that require you to interact with the code or a software application (e.g. MATLAB, Ansys), you can submit an interactive job.

In order to request interactive access to a node, you must run:

```bash=
$ srun --partition testing --nodes 1 --tasks-per-node 1 --cpus-per-task 1 --time 00:05:00 --pty bash
```
After the node is allocated to run the interactive job, you will have your access redirected to the reserved node.
It is important to note that this is still a shared environment.

## Other useful commands

**`sinfo`**: The `sinfo` command will tell you some useful information about the available partitions on the cluster, including a partition’s time limit, how many nodes are available on that partition, which nodes are available on that partition, and the state of those nodes.

If you want more specifics, you can use `sinfo -o '%11P %5D %22N %4c %21G %7m %11l'`.

#### Exercise

1. Discover what is the amount of CPUs available in each node at the `long` queue at the Argo system.
2. How many nodes with GPU are there?

**`squeue`**: We already saw the squeue command, but it’s okay to review. The squeue command will show you what jobs are currently scheduled.

#### Exercise

1. How many jobs are there at the queue of the Argo system?
2. Can you see how many jobs are currently running?
3. What does the `--start` option does?

**`scancel`**: If you submit a job by mistake, or notice an error in your code after submitting, you can use the `scancel <job_id>` command to cancel your job.


## Accessing software via Modules

On a high-performance computing system, it is seldom the case that the software we want to use is available when we log in. It is installed, but we will need to “load” it before it can run.

Before we start using individual software packages, however, we should understand the reasoning behind this approach. The three biggest factors are:

* software incompatibilities
* versioning
* dependencies

Software incompatibility is a major headache for programmers. Sometimes the presence (or absence) of a software package will break others that depend on it. Two of the most famous examples are Python 2 and 3 and C compiler versions. Python 3 famously provides a python command that conflicts with that provided by Python 2. Software compiled against a newer version of the C libraries and then used when they are not present will result in a nasty 'GLIBCXX_3.4.20' not found error, for instance.

Software versioning is another common issue. A team might depend on a certain package version for their research project - if the software version was to change (for instance, if a package was updated), it might affect their results. Having access to multiple software versions allow a set of researchers to prevent software versioning issues from affecting their results.

Dependencies are where a particular software package (or even a particular version) depends on having access to another software package (or even a particular version of another software package). For example, the VASP materials science software may depend on having a particular version of the FFTW (Fastest Fourier Transform in the West) software library available for it to work.

### Environment Modules

Environment modules are the solution to these problems. A module is a self-contained description of a software package – it contains the settings required to run a software package and, usually, encodes required dependencies on other software packages.

There are a number of different environment module implementations commonly used on HPC systems: the two most common are TCL modules and Lmod. Both of these use similar syntax and the concepts are the same so learning to use one will allow you to use whichever is installed on the system you are using. In both implementations the module command is used to interact with environment modules. An additional subcommand is usually added to the command to specify what you want to do. For a list of subcommands you can use module -h or module help. As for all commands, you can access the full help on the man pages with man module.

On login you may start out with a default set of modules loaded or you may start out with an empty environment; this depends on the setup of the system you are using.

**Listing Available Modules**: to see available software modules, use `module avail`:

```bash=
$ module avail

---------------- MPI-dependent avx2 modules -----------------
 abinit/8.2.2     (chem)           ncl/6.4.0
 abyss/1.9.0      (bio)            ncview/2.1.7        (vis)
 boost-mpi/1.60.0 (t)              plumed/2.3.0        (chem)
 cdo/1.7.2        (geo)            pnetcdf/1.8.1       (io)
 lammps/20170331                   quantumespresso/6.0 (chem)
 mrbayes/3.2.6            (bio)    ray/2.3.1           (bio)


[removed most of the output here for clarity]

   t:        Tools for development / Outils de développement
   vis:      Visualisation software / Logiciels de visualisation
   chem:     Chemistry libraries/apps / Logiciels de chimie
   geo:      Geography libraries/apps / Logiciels de géographie
   phys:     Physics libraries/apps / Logiciels de physique
   Aliases:  Aliases exist: foo/1.2.3 (1.2) means that
             "module load foo/1.2" will load foo/1.2.3
   D:        Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching
any of the "keys".
```

### Listing Currently Loaded Modules
You can use the `module list` command to see which modules you currently have loaded in your environment. If you have no modules loaded, you will see a message telling you so

```bash=
$ module list

Currently Loaded Modules:
  1) autotools   2) prun/1.2   3) ohpc
```

### Loading and Unloading Software
To load a software module, use module load. In this example we will use *Python 3*.

Initially, *Python* 3 is not loaded. We can test this by using the `which` command. which looks for programs the same way that Bash does, so we can use it to tell us where a particular piece of software is stored.

```bash=
$ which python
/usr/bin/python
```
```bash=
$ python3 -V
Python 3.4.8
```

Now we will load python version 3.10:

```bash=
$ module load python/3.10.4 
```
```bash=
$ python3 -V
Python 3.10.4
```

#### Exercises
1. Create a job that is able to run python3 --version. Remember, no software is loaded by default! Running a job is just like logging on to the system (you should not assume a module loaded on the login node is loaded on a compute node).
    * *tip*: Remember to add the `module load` statement before running the `python3` command.

# Transfer file to/from the access node

To copy a single file to or from the cluster, we can use scp (“secure copy”). The syntax can be a little complex for new users, but we’ll break it down. The scp command is a relative of the ssh command we used to access the system, and can use the same public-key authentication mechanism.

To upload to another computer, the template command is

```bash=
$ scp local_file yourUsername@argo.ictp.it:remote_destination
```
in which @ and : are field separators and remote_destination is a path relative to your remote home directory, or a new filename if you wish to change it, or both a relative path and a new filename. If you don’t have a specific folder in mind you can omit the remote_destination and the file will be copied to your home directory on the remote computer (with its original name). If you include a remote_destination, note that scp interprets this the same way cp does when making local copies: if it exists and is a folder, the file is copied inside the folder; if it exists and is a file, the file is overwritten with the contents of local_file; if it does not exist, it is assumed to be a destination filename for local_file.

To transfer an entire directory, we add the `-r` flag for “recursive”: copy the item specified, and every item below it, and every item below those until it reaches the bottom of the directory tree rooted at the folder name you provided.

```bash=
$ scp -r dir yourUsername@argo.ictp.it:~/
```


# Reproducing Amdahl's Law

We now have the tools we need to run a multi-processor job. This is a very important aspect of HPC systems, as parallelism is one of the primary tools we have to improve the performance of computational tasks.

## Install the Amdahl Program

The Amdahl python software contains a pseudo-application that can be used as a black box to reproduce Amdahl's Law. It does not do real calculations, nor any real communication, so can easily be overloaded.

The application is installed as a Python module with a shell script wrapper.
The only requirements are a Message Passing Interface (MPI) library and the
MPI for Python module, [mpi4py](https://mpi4py.readthedocs.io/en/stable/).

First we need to install the mpi4py. We will use the conda environment manager for that. The conda command line is available within the `anaconda3` module. We need to load such module before moving further: `module load anaconda3`.

After loading the module, we can create a new environment at which we will install the Amdahl software and its dependencies:
```bash=
$ conda create -n amdahl python=3
```
```bash=
$ conda activate amdahl
```
Now, we need to install the mpi4py package:

```bash=
$ conda install mpi4py
```

We will talk later about the `mpi` paradigm. For now, it enough to now that this is a package that allows to build parallel workflows.

Now we can install the Amdahl python package:

```bash=
$ pip install --user amdahl
Collecting amdahl
...

Successfully installed amdahl-0.3.1
```

## Create a serial job

We need to create a submission script. Let's name this script amdahl_serial_job.sh with the content:

```bash=
#!/bin/bash -l

#SBATCH --job-name=AmdahlSerial # Name for your job
#SBATCH --partition=testing		# Partition to run your job on

#SBATCH --output=%x_%j.out		# Output file
#SBATCH --error=%x_%j.err		# Error file

#SBATCH --time=0-00:05:00		# Time limit
#SBATCH --nodes=1			    # How many nodes to run on
#SBATCH --ntasks=1			    # How many tasks per node
#SBATCH --cpus-per-task=1		# Number of CPUs per task
#SBATCH --mem-per-cpu=1g		# Memory per CPU

module load anaconda3
conda activate amdahl

amdahl 					# Run the command hostname
```

Now we can submit the job to the Argo Cluster by typing the command `sbatch amdahl_serial_job.sh`.
If everything went fine, you should see the following content at the output file:
```bash=
$ cat AmdahlSerial_593277.out 

Doing 30.000000 seconds of 'work' on 1 processor,
 which should take 30.000000 seconds with 0.800000 parallel proportion of the workload.

  Hello, World! I am process 0 of 1 on node161. I will do all the serial 'work' for 5.484733 seconds.
  Hello, World! I am process 0 of 1 on node161. I will do parallel 'work' for 20.605679 seconds.

Total execution time (according to rank 0): 26.135454 seconds
```

## Create a Parallel job

The amdahl program uses the **Message Passing Interface (MPI)** for parallelism – this is a common tool on HPC systems.

### What is MPI?

*The Message Passing Interface* is a set of tools which allow multiple tasks running simultaneously to communicate with each other. Typically, a single executable is run multiple times, possibly on different machines, and the MPI tools are used to inform each instance of the executable about its sibling processes, and which instance it is. MPI also provides tools to allow communication between instances to coordinate work, exchange information about elements of the task, or to transfer data. An MPI instance typically has its own copy of all the local variables.

While MPI-aware executables can generally be run as stand-alone programs, in order for them to run in parallel they must use an MPI run-time environment, which is a specific implementation of the MPI standard. To activate the MPI environment, the program should be started via a command such as `mpiexec` (or `mpirun`, or `srun`, etc. depending on the MPI run-time you need to use), which will ensure that the appropriate run-time support for parallelism is included.

### Modify the submission file

```bash=
$ cp amdahl_serial_job.sh amdahl_parallel_job.sh
```
Change the content of the `amdahl_parallel_job.sh` at the `--cpus-per-task` to 4 and add the `srun` command before the `amdahl` script: 

```bash=
#!/bin/bash -l

#SBATCH --job-name=AmdahlPar             # Name for your job
#SBATCH --partition=testing             # Partition to run your job on

#SBATCH --output=%x_%j.out              # Output file
#SBATCH --error=%x_%j.err               # Error file

#SBATCH --time=0-00:05:00               # Time limit
#SBATCH --nodes=1                       # How many nodes to run on
#SBATCH --ntasks=1                      # How many tasks per node
#SBATCH --cpus-per-task=4               # Number of CPUs per task
#SBATCH --mem-per-cpu=1g                # Memory per CPU

module load anaconda3
conda activate amdahl

mpirun -n 4 amdahl                      # Run the command hostname
```

Now we submit the job by running the `sbatch amdahl_parallel_job.sh`.

The output should look more or less like:

```bash=
$ cat AmdahlPar_593279.out 
Doing 30.000000 seconds of 'work' on 4 processors,
 which should take 12.000000 seconds with 0.800000 parallel proportion of the workload.

  Hello, World! I am process 0 of 4 on node161. I will do all the serial 'work' for 5.527917 seconds.
  Hello, World! I am process 0 of 4 on node161. I will do parallel 'work' for 6.443110 seconds.
  Hello, World! I am process 3 of 4 on node161. I will do parallel 'work' for 5.514671 seconds.
  Hello, World! I am process 1 of 4 on node161. I will do parallel 'work' for 6.287220 seconds.
  Hello, World! I am process 2 of 4 on node161. I will do parallel 'work' for 6.756802 seconds.

Total execution time (according to rank 0): 12.007939 seconds
```

The last line shows that execution time dropped from 29.0 to 12.0 seconds in total.

#### Exercises
1. Try running the same script with 8 and 16 CPUS. How does that effect the execution time?
2. Calculate the Speedup for each execution;


# Configuring Parallel Slurm Jobs

Shared Memory Example
Now, what if we need to share memory between CPUs? That’s where threads come in and we need to use OpenMP (in the case of C).

Let’s grab an example hello world program in C from [wikipedia](https://en.wikipedia.org/wiki/OpenMP#Thread_creation) and call it `hello_omp.c`. Now we can compile it like this:

```bash=
$ module load gcc/8.2.0
$ gcc hello_omp.c -o hello_omp
```
Now, we can run this code in parallel and with shared memory by requesting `#SBATCH --tasks-per-node=1` and `#SBATCH --cpus-per-task=4` with the following sbatch script:

```bash=
$ cat job_omp1.sh 
#!/bin/bash -l
#SBATCH --job-name=simple_mpi	# Name of your job
#SBATCH --partition=testing	# Run on tier3
#SBATCH --output=%x_%j.out	# Output file
#SBATCH --error=%x_%j.err	# Error file
#SBATCH --time=0-00:10:00	# 10 minute time limit
#SBATCH --nodes=1		# 1 node
#SBATCH --tasks-per-node=1	# 1 tasks 
#SBATCH --cpus-per-task=4	# 4 processes
#SBATCH --mem-per-cpu=1g	# 1GB RAM per CPU

module load gcc/8.2.0

srun hello_omp
```

The output of the execution should look like this: 
```bash=

```

## Embarassingly Parallel Example
Many (but not all) compute jobs are what we call embarassingly parallel, meaning that each parallel process doesn’t care about the other parallel processes (i.e. tasks).

For example, consider a program that needs 10,000 randomly drawn samples. You could run this in serial, but that might be slow if drawing a sample is slow. Alternatively, you could break up your problem and run 10 processes in parallel with each process drawing 1,000 random samples; then write those samples to disk and combine them later with another process. (If you’ve heard of Monte-Carlo simulations, this should sound similar to you.)

Or consider a program that runs the same code many times, but each run differs by some initial value (such as a learning rate in a machine learning model). In this example, you could iterate over every learning rate that you’re interested in and train each model (with a different learning rate) sequentially, but this could be brutally slow. Instead, you could redesign your code to take the learning rate as a command line argument, and implement what we call a parameter sweep using Slurm.

### Job Arrays

The following R code calculates samples 3 random numbers from a normal distribution:

```R
$ cat r_omp.R 
args = commandArgs(trailingOnly=TRUE)
seed = as.numeric(args[1])
print(paste("SEED: ",seed))
set.seed(seed)
for (x in 1:3) {
    x = rnorm(1,mean=0, sd=1)
    print(x)
}
```

It receives one parameter from the command line. Now, imagine that we want to vary the vary the seed values from 1 to 4. We need to create a *Job Array*:

```bash=
#!/bin/bash -l
#SBATCH --job-name=simple_r_omp # Name of your job
#SBATCH --partition=long        # Run on long
#SBATCH --output=%x_%j.out      # Output file
#SBATCH --error=%x_%j.err       # Error file
#SBATCH --time=0-00:10:00       # 10 minute time limit
#SBATCH --nodes=1               # 1 node
#SBATCH --ntasks=1              # 1 tasks 
#SBATCH --cpus-per-task=1       # 4 processes
#SBATCH --mem-per-cpu=1g        # 1GB RAM per CPU
#SBATCH --array=1-4

module load R/3.5.1

srun Rscript --vanilla r_omp.R $SLURM_ARRAY_TASK_ID
```

Notice the `#SBATCH --array=1-4`. This tells Slurm to execute a job array, basically to execute many similar jobs. In this case, Slurm will launch 4 jobs in the array, each with a unique index between 1 and 4. Now, we can leverage this to feed different random seeds to each run of `r_omp.R` using the `$SLURM_ARRAY_TASK_ID` environment variable. For each run, `$SLURM_ARRAY_TASK_ID` will have a different value between 1 and 4, and we can pass that to `r_omp.R` as a random seed.

**Be aware that this can take a long time to start running**, if we change that array size to 2 we can submit that job to the testing partition.


The expected output should look like this: 

```r=
[1] "SEED:  4"
[1] 0.2167549
[1] -0.5424926
[1] 0.8911446
[1] "SEED:  1"
[1] -0.6264538
[1] 0.1836433
[1] -0.8356286
[1] "SEED:  2"
[1] -0.8969145
[1] 0.1848492
[1] 1.587845
[1] "SEED:  3"
[1] -0.9619334
[1] -0.2925257
[1] 0.2587882

```


### Running a Parallel R job

We will use the `doParallel` [package](https://cran.r-project.org/web/packages/doParallel/index.html) for running for loops in parallel by means of the `%dopar%` operator.

```r=
library(foreach)
library(doParallel)
library(iterators)
library(metrics)
args = commandArgs(trailingOnly=TRUE)
workers = as.numeric(args[1])
registerDoParallel(workers)
formulas <- c("Species ~ Sepal.Length", "Species ~ Sepal.Width", "Species ~ Petal.Length", "Species ~ Petal.Width", "Species ~ .")
x <- iris[which(iris[,5] != "setosa"),]
system.time({
  r <- foreach(i=1:length(formulas), .combine=c) %dopar% {
    model <- glm(eval(parse(text=formulas[i])), 
                     data = x,
                     family="binomial") 
    accuracy(model)
  }
})
```
and the submission file:

```bash=
#!/bin/bash -l
#SBATCH --job-name=demo_r_omp	# Name of your job
#SBATCH --partition=testing    	# Run on long
#SBATCH --output=%x_%j.out	    # Output file
#SBATCH --error=%x_%j.err	    # Error file
#SBATCH --time=0-00:10:00	    # 10 minute time limit
##SBATCH --nodes=1		        # 1 node
#SBATCH --ntasks=1		        # 1 tasks 
#SBATCH --cpus-per-task=2	    # 4 processes
#SBATCH --mem-per-cpu=1g	    # 1GB RAM per CPU

module load anaconda3

conda activate r-analysis

srun Rscript --vanilla r_dopar.R 2
```

Make sure to create the `r-analysis` environment. It must contain the packages:

* *r-foreach*
* *r-doparallel*
* *r-iterators*
* *r-metrics*


#### Exercises
1. Try increasing the number of CPUs and check if that affects the time;
2. Build the speedup table for the example 
    * You will have to first find the time it would consume to run the job in serial mode. How would you do that? 
