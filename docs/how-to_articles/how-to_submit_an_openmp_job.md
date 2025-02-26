---
layout: default
title: How-To Submit an OpenMP Job
parent: How-To Articles
nav_order: 4
---

# How-To Submit an OpenMP Job

## Step-by-step guide

There are two steps involved in writing a job script to run an [OpenMP](https://en.wikipedia.org/wiki/OpenMP) (OMP) job in SLURM:

1. Specify the number of cores to reserve for your OMP job
2. Communicate that information to OpenMP by defining the environment variable `OMP_NUM_THREADS`

 There are several ways to reserve a given number of CPU cores in SLURM. For example

number of physical CPU cores = _number of nodes_ \* _number of tasks-per-node_ \* _number of cpus-per-task_

In a strictly OMP job (for hybrid jobs see the [[How-to Submit a Hybrid Job]] article) the _number of nodes_ will always be 1.  We will leave the _number of tasks-per-node_ set to its default value of 1 as this option is best reserved for controlling the number of MPI processes.  So the _number of cpus-per-task_ will control the number of physical CPU cores reserved for our job.  Most nodes on Talapas have 28 physical CPU cores per node (dual E5-2690v4 Intel chips).  Let's reserve all of them for our job:

```bash
#!/bin/bash
#SBATCH --partition=short   ### Partition
#SBATCH --job-name=HelloOMP ### Job Name
#SBATCH --time=00:10:00     ### WallTime
#SBATCH --nodes=1           ### Number of Nodes
#SBATCH --ntasks-per-node=1 ### Number of tasks (MPI processes)
#SBATCH --cpus-per-task=28  ### Number of threads per task (OMP threads)
#SBATCH --account=hpcrcf    ### Account used for job submission

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./hello_omp
```

Note that we define the value of `OMP_NUM_THREADS` to be equal to the value of the SLURM defined environment variable `$SLURM_CPUS_PER_TASK`. By defining `OMP_NUM_THREADS` in the this way we ensure that any change to the parameter `--cpus-per-task` in our script will automatically be communicated to OMP.
