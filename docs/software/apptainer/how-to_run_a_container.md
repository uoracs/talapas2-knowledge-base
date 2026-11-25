---
layout: default
title: How-To Run an Apptainer Container
nav_order: 2
parent: Apptainer
grand_parent: Software
---

# How-To Run an Apptainer Container

Running a container is similar to running a regular job in Slurm. Please visit [How-To Submit a Batch Job]({% link docs/slurm/how-to_submit_a_batch_job.md %}) for further information on general job submission.

Below is how to setup a job script to run Apptainer.

```bash
#!/bin/bash

#SBATCH --account=<pirg>            ### your slurm account is the name of your pirg
#SBATCH --partition=compute         ### specify the partition, see Partition List
#SBATCH --job-name=ApptainerRing    ### name of your job
#SBATCH --time=00:10:00             ### wall clock time limit
#SBATCH --nodes=3                   ### number of nodes
#SBATCH --ntasks-per-node=28        ### number of tasks (MPI processes) per node

mpirun apptainer exec --bind /cm/shared/:/cm/shared/ --bind /packages/:/packages/ ./container.img ./ring.out
```

Just as with a general job Apptainer is run on allocated nodes based on the size and requirements specified in the job script. In this example, the --bind directive is used to allow for file systems mounted outside of the container be visible and usable as the running user and application inside the container.
