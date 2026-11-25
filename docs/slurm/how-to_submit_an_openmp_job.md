---
layout: default
title: How-To Submit an OpenMP Job
parent: Slurm
nav_order: 3
---

# How-To Submit an OpenMP Job

## Step-by-step guide

There are two steps involved in writing a job script to run an [OpenMP](https://en.wikipedia.org/wiki/OpenMP) (OMP) job in Slurm:

1. Specify the number of CPU cores to reserve for your OMP job
2. Communicate that information to OpenMP by defining the environment variable `OMP_NUM_THREADS`

There are several ways to reserve a given number of CPU cores in Slurm. For example:

number of CPU cores = _number of nodes_ \* _number of tasks-per-node_ \* _number of cpus-per-task_

In a strictly OMP job (for hybrid jobs see the [How-To Submit a Hybrid Job]({% link docs/slurm/how-to_submit_a_hybrid_job.md %}) article) the _number of nodes_ will always be 1, because threads can only share memory within a single node. We leave the _number of tasks-per-node_ set to 1, as that option is best reserved for controlling the number of MPI processes. So _cpus-per-task_ controls the number of CPU cores reserved for our job. Here we reserve 8 cores:

```bash
#!/bin/bash

#SBATCH --account=<pirg>          ### your slurm account is the name of your pirg
#SBATCH --partition=compute       ### specify the partition, see Partition List
#SBATCH --job-name=HelloOMP       ### name of your job
#SBATCH --output=HelloOMP.out     ### name of batch script's standard output
#SBATCH --error=HelloOMP.err      ### name of batch script's standard error
#SBATCH --time=00:10:00           ### wall clock time limit
#SBATCH --nodes=1                 ### number of nodes, always 1 for OpenMP
#SBATCH --ntasks-per-node=1       ### number of tasks (MPI processes)
#SBATCH --cpus-per-task=8         ### number of threads per task (OMP threads)
#SBATCH --mem-per-cpu=1G          ### memory for each cpu requested

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

./hello_omp
```

Note that we define the value of `OMP_NUM_THREADS` to be equal to the value of the Slurm-defined environment variable `$SLURM_CPUS_PER_TASK`. By defining `OMP_NUM_THREADS` in this way we ensure that any change to the parameter `--cpus-per-task` in our script will automatically be communicated to OpenMP.

The number of cores you can request is limited by the size of the nodes in your partition. See the [Partition List]({% link docs/about_talapas/partition_list.md %}) for the number of CPUs per node.

## Thread placement (optional)

OpenMP can pin each thread to a core so that threads are not moved around by the operating system, which often improves performance. You can turn this on with standard OpenMP environment variables, for example:

```bash
export OMP_PROC_BIND=close   # keep threads near each other
export OMP_PLACES=cores      # one thread per physical core
```

Slurm already restricts your job to the cores it allocated, so these only control placement among those cores.

## See also

* [How-To Submit a Hybrid Job]({% link docs/slurm/how-to_submit_a_hybrid_job.md %})
* [How-To Submit an MPI Job]({% link docs/slurm/how-to_submit_an_mpi_job.md %})
* [How-To Submit a Batch Job]({% link docs/slurm/how-to_submit_a_batch_job.md %})
