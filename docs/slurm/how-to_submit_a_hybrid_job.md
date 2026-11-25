---
layout: default
title: How-To Submit a Hybrid Job
parent: Slurm
nav_order: 5
---

# How-To Submit a Hybrid Job

A hybrid job is one that uses both multiple processes and multiple threads within a process. Typically, MPI is used to start the multiple processes, and each process uses a multithreading library like [OpenMP](https://en.wikipedia.org/wiki/OpenMP) to perform computation with multiple threads.

Starting such jobs is very similar to starting an MPI job. See the [How-To Submit an MPI Job]({% link docs/slurm/how-to_submit_an_mpi_job.md %}) and [How-To Submit an OpenMP Job]({% link docs/slurm/how-to_submit_an_openmp_job.md %}) pages for details.

The main difference is that you have to tell Slurm that each task (MPI process) should get multiple CPU cores, rather than just one. If you omit this step, all threads of a process will share a single core, and it's unlikely that you will see any speedup from threading.

To do this, add a parameter like this to your sbatch script:

```bash
#SBATCH --cpus-per-task=8
```

The number of CPU cores you request is _tasks_ \* _cpus-per-task_, and the cores for a single task must all be on the same node. So `--cpus-per-task` cannot be larger than the number of cores on a node, and the product of `--ntasks-per-node` and `--cpus-per-task` cannot be greater than the number of cores on a node. See the [Partition List]({% link docs/about_talapas/partition_list.md %}) for the number of CPUs on the nodes in each partition.

## Example

Here is a small hybrid MPI/OpenMP program in C, saved as `hybrid_hello.c`. Each MPI rank starts a team of OpenMP threads and each thread reports where it is running:

```c
// hybrid_hello.c: MPI/OpenMP example with diagnostic output
#include <mpi.h>
#include <omp.h>
#include <sched.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
  int provided, rank, size, namelen;
  char name[MPI_MAX_PROCESSOR_NAME];

  // FUNNELED: only the main thread of each rank makes MPI calls
  MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &provided);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Get_processor_name(name, &namelen);

  #pragma omp parallel
  {
    printf("rank %d of %d on %s, thread %d of %d, cpu %d\n",
           rank, size, name, omp_get_thread_num(), omp_get_num_threads(),
           sched_getcpu());
  }

  MPI_Finalize();
  return 0;
}
```

Compile it with an MPI compiler wrapper and the OpenMP flag for your compiler. For example, with GNU compilers and MPICH:

```bash
module load gcc/15.2.0-5dhqpt3
module load mpich/4.3.2-khdddkb
mpicc -fopenmp hybrid_hello.c -o hybrid_hello
```

Here is an example Slurm job script (`hybrid.sbatch`) to run the program with 4 MPI tasks, each using 8 threads, spread over 2 nodes:

```bash
#!/bin/bash

#SBATCH --account=<pirg>          ### your slurm account is the name of your pirg
#SBATCH --partition=compute       ### specify the partition, see Partition List
#SBATCH --job-name=hybrid         ### name of your job
#SBATCH --output=hybrid.out       ### name of batch script's standard output
#SBATCH --error=hybrid.err        ### name of batch script's standard error
#SBATCH --time=00:10:00           ### wall clock time limit
#SBATCH --nodes=2                 ### number of nodes
#SBATCH --ntasks-per-node=2       ### MPI tasks per node (4 tasks in total)
#SBATCH --cpus-per-task=8         ### cores per task (OMP threads per MPI task)
#SBATCH --mem-per-cpu=1G          ### memory for each cpu requested

module load gcc/15.2.0-5dhqpt3
module load mpich/4.3.2-khdddkb

# one OpenMP thread per core assigned to each task
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=close
export OMP_PLACES=cores

# pass --cpus-per-task to srun explicitly so every task gets all of its cores
srun --cpus-per-task=$SLURM_CPUS_PER_TASK ./hybrid_hello
```

A few notes on this script:

* `--nodes` and `--ntasks-per-node` determine the number of MPI processes (here 2 \* 2 = 4). If your program does little communication between processes, you can instead specify only `--ntasks` and let Slurm place the tasks wherever there is room. If the program communicates a lot, it's generally better to specify the layout, so that more of the communication stays within a node. The trade-off is that a job with a more demanding layout may take longer to be scheduled.
* `--cpus-per-task` sets how many CPU cores each task gets. We tell OpenMP to use that many threads by setting `OMP_NUM_THREADS` from `$SLURM_CPUS_PER_TASK`.
* We repeat `--cpus-per-task` on the `srun` line so that each task is given all of the cores you requested for it. Being explicit costs nothing, and it avoids the case where tasks end up confined to a single core.
* `OMP_PROC_BIND` and `OMP_PLACES` pin threads to cores within each task's allocation. Slurm itself already keeps each task on its own cores.
* The same pattern works with OpenMPI or Intel MPI; only the `module load` lines, the compiler wrapper and the OpenMP flag (for example `-qopenmp` or `-fopenmp` for Intel compilers) change. See the MPI page for details.

## Example output

The output file `hybrid.out` will contain one line per thread, 32 lines in this case. The order varies from run to run, and the host names and CPU numbers will differ. It will look something like this (abbreviated, illustrative only):

```
rank 0 of 4 on n0111, thread 0 of 8, cpu 3
rank 0 of 4 on n0111, thread 1 of 8, cpu 4
...
rank 3 of 4 on n0112, thread 7 of 8, cpu 61
```

Each rank should report threads on different CPUs, and `thread N of 8` should match your `--cpus-per-task`. If every thread of a rank reports the same CPU, check that `--cpus-per-task` is set and passed to `srun` as above.

## Memory

Memory is requested per CPU with `--mem-per-cpu`, so each task gets `--cpus-per-task` times that amount. If a task uses more memory than it was allocated, Slurm kills it and you will see an out-of-memory message such as `slurmstepd: error: Detected 1 oom-kill event(s) in StepId=... cgroup`. Request more memory, or reduce the number of tasks per node.

## See also

* [How-To Submit an MPI Job]({% link docs/slurm/how-to_submit_an_mpi_job.md %})
* [How-To Submit an OpenMP Job]({% link docs/slurm/how-to_submit_an_openmp_job.md %})
* [How-To Submit a Batch Job]({% link docs/slurm/how-to_submit_a_batch_job.md %})
