---
layout: default
title: How-To Submit a Hybrid Job
parent: How-To Articles
nav_order: 6
---

# How-To Submit a Hybrid Job

A hybrid job is one that uses both multiple processes and multiple threads within a process.  Typically, MPI is used to start the multiple processes, and each process will use a multithreading library like [OpenMP](https://en.wikipedia.org/wiki/OpenMP) to perform computation with multiple threads.

Starting such jobs is very similar to starting an MPI job.  See the [How-to Submit an MPI Job]({% link docs/how-to_articles/how-to_submit_an_mpi_job.md %}) and [How-to Submit an OpenMP Job]({% link docs/how-to_articles/how-to_submit_an_openmp_job.md %}) pages for details.

The main difference is that you will have to tell SLURM that you intend for each task to be bound to multiple CPU cores (rather than just one).  If you omit this step, all threads for a process will be bound to the same core, and it's unlikely that you will see any speedup from threading.

To do this, add a parameter like this to your sbatch script

`#SBATCH --cpus-per-task=28`

In this case, we're choosing 28 cores with the knowledge that our hardware has 28 cores per node.  A smaller number could be chosen, but the number cannot be larger than the number of cores available on the hardware.

Note also that if you specify the `--ntasks-per-node` parameter, the product of these two parameters cannot be greater than the number of available cores on the hardware.

## Extended Example

In this section, we'll show a simple example of a hybrid MPI/OpenMP program.  The program prints some useful diagnostic information and performs a trivial CPU-bound computation.  It uses the Intel MPI implementation, but it could be adapted to use OpenMPI instead.

Here's the code in a file named `test-verbose.cpp`:

```c++
// MPI/OpenMP example with diagnostic output

// example compile command:
// module load intel intel-mpi
// mpiicpc -mt_mpi -qopenmp test-verbose.cpp -o test-verbose

#include <errno.h>
#include <error.h>
#include <iostream>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "mpi.h"
#include <omp.h>


int main(int argc, char *argv[]) {
  int usemem_gb = 0;
  if (argc > 1)
    usemem_gb = atoi(argv[1]);
  if (errno || usemem_gb < 0)
    error(1, errno,
          "argument (if present) must be integer number of GB to allocate");

  if (usemem_gb > 0) {
    const size_t usemem_bytes = size_t(usemem_gb) * 1024 * 1024 * 1024;
    void *mem = malloc(usemem_bytes);
    if (!mem)
      error(1, errno, "malloc failed (not enough memory?)");
    // writing memory to force it into RSS
    memset(mem, 86, usemem_bytes);
    // NB: not freeing memory until exit()
  }

  MPI::Init(argc, argv);
  int size = MPI::COMM_WORLD.Get_size();
  int rank = MPI::COMM_WORLD.Get_rank();
  bool am_master = (rank == 0);
  char name[MPI_MAX_PROCESSOR_NAME];
  int namelen;
  MPI::Get_processor_name(name, namelen);

  cpu_set_t cpuset;
  if (sched_getaffinity(0, sizeof cpuset, &cpuset))
    error(1, errno, "sched_getaffinity failed");
  int cpucount = CPU_COUNT(&cpuset);

  if (am_master) {
    std::cout << "rank " << rank << " of " << size << " running on " << name
              << " alloc " << usemem_gb << "GB" << " cpu count "
              << cpucount << " mask ";
    for (int cpu=0; cpu < CPU_SETSIZE; cpu++)
      if (CPU_ISSET(cpu, &cpuset))
        std::cout << cpu << ",";
    std::cout << std::endl;

    for (int i=1; i < size; i++) {
      MPI::Status stat;
      MPI::COMM_WORLD.Recv(&rank, 1, MPI_INT, i, 1, stat);
      MPI::COMM_WORLD.Recv(&size, 1, MPI_INT, i, 1, stat);
      MPI::COMM_WORLD.Recv(&namelen, 1, MPI_INT, i, 1, stat);
      MPI::COMM_WORLD.Recv(name, namelen + 1, MPI_CHAR, i, 1, stat);
      std::cout << "rank " << rank << " of " << size << " running on " << name
                << " alloc " << usemem_gb << "GB";

      int cpucount_i;
      MPI::COMM_WORLD.Recv(&cpucount_i, 1, MPI_INT, i, 1, stat);
      std::cout << " cpu count " << cpucount_i << " mask ";
      for (int cpu_i=0; cpu_i < cpucount_i; cpu_i++) {
        int cpu;
        MPI::COMM_WORLD.Recv(&cpu, 1, MPI_INT, i, 1, stat);
        std::cout << cpu << ",";
      }
      std::cout << std::endl;
    }
  } else {
    MPI::COMM_WORLD.Send(&rank, 1, MPI_INT, 0, 1);
    MPI::COMM_WORLD.Send(&size, 1, MPI_INT, 0, 1);
    MPI::COMM_WORLD.Send(&namelen, 1, MPI_INT, 0, 1);
    MPI::COMM_WORLD.Send(name, namelen + 1, MPI_CHAR, 0, 1);

    MPI::COMM_WORLD.Send(&cpucount, 1, MPI_INT, 0, 1);
    for (int cpu=0; cpu < CPU_SETSIZE; cpu++)
      if (CPU_ISSET(cpu, &cpuset))
        MPI::COMM_WORLD.Send(&cpu, 1, MPI_INT, 0, 1);
  }

  // junk computation to spin the CPUs in OpenMP threads
  int result=0;
  int iam=0, np=1;
#pragma omp parallel default(shared) private(iam, np)
  {
    np = omp_get_num_threads();
    iam = omp_get_thread_num();

    int s=iam*rank;
    // each rank-thread to do approx equal share a fixed-size workload
    for (long int i=0; i<(1024*1024*1000/(np*size)); i++)
      for (int j=0; j<10000; j++)
        s += j;
    result += s;
  }
  // output the result to keep compiler from optimizing it away
  if (rank == 0)
    std::cout << "(meaningless) result " << result << std::endl;

  // synchronize to wait for all workers to finish
  // (maybe use MPI::Barrier instead?)
  int value=0;
  if (am_master) {
    for (int i=1; i < size; i++) {
      MPI::Status stat;
      MPI::COMM_WORLD.Recv(&value, 1, MPI_INT, i, 1, stat);
    }
  } else {
    MPI::COMM_WORLD.Send(&value, 1, MPI_INT, 0, 1);
  }

  MPI::Finalize();

  if (usemem_gb > 0)
    sleep(90);       // long enough for SLURM to kill us if RAM usage too high

  return 0;
}
```

The program takes one optional, integer parameter.  If specified, each task will allocate that number of gigabytes of RAM.  This is useful for testing the effects of SLURM memory allocation.

Here is an example SLURM `sbatch` script to invoke the program:

```bash
#!/bin/bash

#SBATCH --partition=preempt
#SBATCH --job-name=test-verbose-srun
#SBATCH --output=%x.out
#SBATCH --time=4:00:00
#SBATCH --account=hpcrcf
###SBATCH --nodes=2
###SBATCH --ntasks-per-node=28
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1G

module purge
module load slurm
module load intel
module load intel-mpi
module load mkl

# print some diagnostic info
echo env for main task
env | sort | egrep -e '^(SLURM|OMP|I_MPI)_'
echo

camask=$(fgrep -ie cpus_allowed: /proc/self/status | awk '{ print $2 }' | tr -d ,)
ca=$(python -c 'print(bin(0x'${camask}').count("1"))')
echo Cpus_allowed count for main task before mpi startup is $ca
echo
# end diagnostic info

# could choose another mpi lib config, but release_mt is the default
# source mpivars.sh {debug,release}{,_mt}

# https://software.intel.com/en-us/mpi-developer-reference-linux-interoperability-with-openmp
# export I_MPI_PIN_DOMAIN=omp

# possibly redundant?
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# https://software.intel.com/en-us/mpi-developer-reference-linux-other-environment-variables
# export I_MPI_DEBUG=5,host,level

\time srun ./test-verbose ${1+"$@"}
```

Note that only the `--ntasks` flag is used to determine the number of MPI worker processes.  This means that the individual tasks may be spread across available nodes as SLURM sees fit.  This is usually a good approach if the program does little inter-worker communication.  And indeed, this example program does very little–most of its computation is performed by each thread without communication.

If the MPI program does a lot of inter-worker communication, it's generally better to specify a layout of tasks on nodes.  By uncommenting the `--nodes` and `--ntasks-per-node` flags (and commenting out the `--ntasks` flag), we could specify that two compute nodes are to be used, each with 28 tasks.  The advantage of packing lots of tasks onto a minimal number of nodes is that most of the inter-worker communication happens locally on the node, which is faster and more efficient.  The disadvantage is that it may take longer for SLURM to schedule such a job, since we're being more demanding about what we require.

With either approach, the SLURM `srun` command will ensure that the total number of tasks is communicated to our program.  We don't need to pass this in explicitly.

The `--cpus-per-task` flag specifies how many CPU cores are assigned to each task.  This can make the program run much faster if the tasks are able to make use of multiple CPUs.  In this example, we do so using OpenMP.  SLURM will constrain each task to use only the CPUs assigned to it (see below).  Note that we tell OpenMP how many CPUs are available to each task by setting the `$OMP_NUM_THREADS` variable.

This script prints some diagnostic information, but these lines could be removed or commented out.

## Sample Timings

Here are some sample times (in seconds) for a workload split across **n** MPI workers each using **c** OpenMP threads, all on Skylake nodes.  These times are from single runs, so include noticeable noise.  For the shorter timings, startup times play a significant role.  Broadly speaking, though, we see almost linear speedup as more cores are added.  Since the computations in this example program are entirely independent, the particular combination of worker count and thread count makes little difference.

|      | *c=1* | *c=2* | *c=4* | *c=8* | *c=16* | *c=32* |
| ---- | ----- | ----- | ----- | ----- | ------ | ------ |
| n=1  | 4479  | 2350  | 1272  | 642   | 318    | 160    |
| n=2  | 2348  | 1272  | 637   | 319   | 160    | 85     |
| n=4  | 1183  | 637   | 322   | 160   | 87     | 41     |
| n=8  | 639   | 319   | 160   | 81    | 42     | 22     |
| n=16 | 309   | 161   | 81    | 56    | 21     | 13     |
| n=32 | 162   | 83    | 42    | 24    | 23     | 8      |

## Sample Output

For the n=4, c=16 case, here is some sample output:

```bash
env for main task
I_MPI_PMI_LIBRARY=/cm/shared/apps/slurm/17.11/lib/libpmi.so
I_MPI_ROOT=/packages/intel/17/linux/mpi
SLURM_CHECKPOINT_IMAGE_DIR=/var/slurm/checkpoint
SLURM_CLUSTER_NAME=slurm_cluster
SLURM_CPUS_ON_NODE=32
SLURM_CPUS_PER_TASK=16
SLURM_GTIDS=0
SLURM_JOBID=6112602
SLURM_JOB_ACCOUNT=hpcrcf
SLURM_JOB_CPUS_PER_NODE=32(x2)
SLURM_JOB_GID=2000
SLURM_JOB_ID=6112602
SLURM_JOB_NAME=test-verbose-srun
SLURM_JOB_NODELIST=n[177,180]
SLURM_JOB_NUM_NODES=2
SLURM_JOB_PARTITION=preempt
SLURM_JOB_QOS=normal
SLURM_JOB_UID=1665
SLURM_JOB_USER=mkc
SLURM_LOCALID=0
SLURM_MEM_PER_CPU=1024
SLURM_NNODES=2
SLURM_NODEID=0
SLURM_NODELIST=n[177,180]
SLURM_NODE_ALIASES=(null)
SLURM_NPROCS=4
SLURM_NTASKS=4
SLURM_PRIO_PROCESS=0
SLURM_PROCID=0
SLURM_SUBMIT_DIR=/gpfs/home/mkc/mpi/test
SLURM_SUBMIT_HOST=talapas-ln2
SLURM_TASKS_PER_NODE=2(x2)
SLURM_TASK_PID=349764
SLURM_TOPOLOGY_ADDR=ibcore[1-4].ib8.n177
SLURM_TOPOLOGY_ADDR_PATTERN=switch.switch.node
SLURM_WORKING_CLUSTER=slurm_cluster:hpc-hn1:6817:8192
Cpus_allowed count for main task before mpi startup is 32
rank 0 of 4 running on n177 alloc 0GB cpu count 16 mask 6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,
rank 1 of 4 running on n177 alloc 0GB cpu count 16 mask 1,3,5,7,9,11,13,15,17,19,21,23,27,31,33,38,
rank 2 of 4 running on n180 alloc 0GB cpu count 16 mask 1,6,8,10,12,14,16,20,22,24,28,30,32,34,36,38,
rank 3 of 4 running on n180 alloc 0GB cpu count 16 mask 3,5,9,11,15,17,19,21,23,25,27,29,31,35,37,39,
```

We can see the various SLURM parameters passed in as environment variables.

Also, note that each MPI workers is restricted to its own set of CPUs, with no overlap.  (In the main task on n177, before MPI starts, the initial CPU mask has 32 CPUs, but when MPI starts, it allots 16 each to the two workers that end up running on n177.)

Finally, adding a parameter (16) to have our program use more RAM per CPU than we have requested from SLURM, the job will fail with an error like this

```bash
slurmstepd: error: Detected 1 oom-kill event(s) in step 6139636.0 cgroup. Some of your processes may have been killed by the cgroup out-of-memory handler.
srun: error: n126: task 8: Out Of Memory
slurmstepd: error: Detected 2 oom-kill event(s) in step 6139636.0 cgroup. Some of your processes may have been killed by the cgroup out-of-memory handler.
0.01user 0.01system 0:06.34elapsed 0%CPU (0avgtext+0avgdata 5116maxresident)k
0inputs+0outputs (0major+1619minor)pagefaults 0swaps
slurmstepd: error: Detected 2 oom-kill event(s) in step 6139636.batch cgroup. Some of your processes may have been killed by the cgroup out-of-memory handler.
```
