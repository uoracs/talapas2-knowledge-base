---
layout: default
title: How-To Run a Apptainer Container
nav_order: 2
parent: Apptainer
grand_parent: Software
---

# How-To Run a Apptainer Container

Running a container is similar to running a regular job in SLURM. Please visit [How-to Submit a Job]({% link docs/how-to_articles/how-to_submit_a_job.md %}) for further information on general job submission.

Below is how to setup a job script to run Apptainer.

```bash
#!/bin/bash

#SBATCH --partition=computelong     ### Partition
#SBATCH --job-name=ApptainerRing ### Job Name
#SBATCH --time=00:10:00             ### WallTime
#SBATCH --nodes=3                   ### Number of Nodes
#SBATCH --ntasks-per-node=28        ### Number of tasks (MPI processes)

#
mpirun Apptainer exec --bind /cm/shared/:/cm/shared/ --bind /packages/:/packages/ ./container.img ./ring.out
```

Just as with a general job Apptainer is ran on allocated nodes based on the size and requirements specified in the job script. In this example, the --bind directive is used to allow for file systems mounted outside of the container be visible and usable as the running user and application inside the container.
