---
layout: default
title: How-To Submit an MPI Job
parent: How-To Articles
nav_order: 5
---

# How-To Submit an MPI Job

## General Principles

Jobs that run on multiple nodes generally use a parallel programming API called [MPI (Message Passing Interface)](https://en.wikipedia.org/wiki/Message_Passing_Interface), which allows processes on multiple nodes to communicate with high throughput and low latency (especially over Talapas' [InfiniBand](https://en.wikipedia.org/wiki/InfiniBand) network).  MPI is a standard and has multiple implementations—several are available on Talapas, notably [Intel MPI](https://software.intel.com/en-us/intel-mpi-library) and [MPICH](https://www.mpich.org/).
The [Slurm]({% link docs/slurm.md %}) scheduler has built-in support for MPI jobs. Jobs can be run in a generic way, or if needed, you can use extra parameters to carefully control how MPI processes are mapped to the hardware.

Most parts of job setup are the same for all MPI flavors.  Notably, you'll want to decide how many simultaneous tasks (processes) you want to run your job across.

## Specifying Node and Task Counts

You can simply specify the number of tasks and let Slurm place them on available nodes as it sees fit, for example:

```bash
#SBATCH --partition=compute
#SBATCH --ntasks=500
#SBATCH --ntasks-per-core=1
#SBATCH --mem-per-cpu=500m
#SBATCH --constraint=7713
```

With this approach the job will probably be scheduled sooner since Slurm is free to use any available cores. It’s recommended to keep the job tied to cores of the same type through use of Slurm’s `--constraint` flag.

Another method is to specify the number nodes you want the job to run on and how many tasks to run on each node.

```bash
#SBATCH --partition=compute_intel
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=28
#SBATCH --mem-per-cpu=500m
#SBATCH --constraint=intel,e5-2690
```

This will result in an MPI job with 84 processes (28 processes on each of the 3 nodes). In this case, we've specified 28 tasks per node with the knowledge that our constraint of ‘intel,e5-2690’ will allocate only nodes which have 28 CPU cores to the job.

See `sinfo -o "%10R %8D %25N %8c %10m %40f %35G"`for a complete list of nodes properties and features relative to their partitions.

Also see `/packages/racs/bin/slurm-show-features`

## Memory

For single-node jobs use the Slurm `--mem` flag to specify the amount of memory to allocate to the job.

For multi-node jobs use the Slurm `--mem-per-cpu` flag to specify the amount of memory available to allocate to each task.

## Slurm Invocation

Slurm provides two slightly different ways to invoke your MPI program.

1. The preferred way is to invoke it directly with the `srun` command within your `sbatch` script.
2. An alternative is to invoke it using the `mpirun/mpiexec` program within your `sbatch` script.

See the [Slurm MPI guide](https://slurm.schedmd.com/mpi_guide.html) for more information.

## MPI compilers

### Intel

To access Intel OneAPI MPI compilers,

```bash
module load intel-oneapi-compilers/2023.1.0
module load intel-oneapi-mpi/2021.9.0
mpiicc helloworld_mpi.c -o helloworld_mpi.x
```

Batch script example using`srun`:

```bash
#!/bin/bash
#SBATCH --account=<myPIRG>
#SBATCH --partition=compute
#SBATCH --job-name=intel-mpi
#SBATCH --output=intel-mpi.out
#SBATCH --error=intel-mpi.err
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=28
#SBATCH --ntasks-per-core=1
module load intel-oneapi-compilers/2023.1.0
module load intel-oneapi-mpi/2021.9.0
srun ./helloworld_mpi.x
```

### MPICH

GNU + MPICH

To access MPICH MPI compilers:

```bash
module load gcc/13.1.0
module load mpich/4.1.1
mpicc helloworld_mpi.c -o helloworld_mpich.x
```

```bash
#!/bin/bash
#SBATCH --account=<myPIRG>
#SBATCH --partition=compute,computelong
#SBATCH --job-name=mpich-mpi-test
#SBATCH --output=mpich-mpi-test.out
#SBATCH --error=mpich-mpi-test.err
#SBATCH --ntasks=200
#SBATCH --ntasks-per-core=1
#SBATCH --mem-per-cpu=500m
#SBATCH --constraint=7713
module load gcc/13.1.0
module load mpich/4.1.1
srun ./helloworld_mpich.x
```

## Pitfalls

Choosing parameters for MPI job submission can unfortunately be rather complicated.  One pitfall you may encounter is failing to make use of all requested CPU cores, leading to needlessly long job times and wasted resources.  To verify that all is well, check that you are getting significant speedups with increasing process count.  If your jobs don't run faster when you add cores, something is probably wrong.  You can also log into the compute nodes while your job is running to observe the processes and check that compute-bound processes are using 100% CPU; the `htop` command is useful here.

One combination that we've seen work quite poorly is specifying `--nodes` and `--ntasks` (with no `--ntasks-per-node`).  This seems to sometimes lead to the above wasted-resource problem.

If you have concerns, please reach out to us—we'd be happy to check for problems and make recommendations.

Also see [sbatch script parameters](https://slurm.schedmd.com/sbatch.html) for more information.
