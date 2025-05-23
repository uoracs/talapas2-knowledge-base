---
layout: default
title: How-To Submit a GPU Job
parent: How-To Articles
nav_order: 7
---

# How-To Submit a GPU Job

Step-by-step guide

1. Specify a partition containing GPU equipped compute nodes.
2. Reserve some number of GPUs for your job using the SLURM gres option.
3. (optional) Communicate the GPU ordinal to your executable using the SLURM_JOB_GPU variable.

Most of the GPU equipped compute nodes on Talapas have 4 GPUs per node (Run `/packages/racs/bin/slurm-show-gpus` to see more information) Suppose we only needed one GPU for our simulation, then our job script may take the (new) form

```bash
#!/bin/bash

#SBATCH --account=<myPIRG>    ### Account used for job submission
#SBATCH --partition=gpu       ### Similar to a queue in PBS
#SBATCH --job-name=GPUjob     ### Job Name
#SBATCH --time=1-00:00:00     ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1             ### Node count required for the job
#SBATCH --ntasks-per-node=1   ### Nuber of tasks to be launched per Node
#SBATCH --gpus=1              ### General REServation of gpu:number of gpus
./my_executable $SLURM_JOB_GPUS
```

In this example, the program `my_executable` expects the GPU ordinal as an input. We use of the variable `SLURM_JOB_GPUS` to pass that information from SLURM without knowing a-priori which GPU I will run on.

`SLURM_JOB_GPUS` is a list of the ordinal indexes of the gpus assigned to my job by slurm. With the request of a single GPU, this variable will store a single numeral from 0 to 3 (we have 4 GPUs on each node). If I wanted to use two GPUs, I would change `gres=gpu:1` to `gres=gpu:2`, and then `SLURM_JOB_GPUS` would store a list of the form 0,1 (for example).

NOTE:  The `SLURM_JOB_GPUS` variable is not set when using `srun`. The variable `GPU_DEVICE_ORDINAL` is set when using `srun` or `sbatch` and can be used instead.

There is also an old form that is similar.  For most purposes, the new form is what you should use.  Note, however, that with the new form, it's very important to specify `--nodes=1` if you need all of the GPUs to be allocated on a single node.

```bash
#!/bin/bash

#SBATCH --account=<myPIRG>    ### Account used for job submission
#SBATCH --partition=gpu       ### Similar to a queue in PBS
#SBATCH --job-name=GPUjob     ### Job Name
#SBATCH --time=1-00:00:00     ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1             ### Node count required for the job
#SBATCH --ntasks-per-node=1   ### Nuber of tasks to be launched per Node
#SBATCH --gpus=1              ### General REServation of gpu:number of gpus

./my_executable $SLURM_JOB_GPUS
```

## GPU types

Currently, the `gpu` and `gpulong` partitions contain only NVidia A100 GPUs.  Thus, you don't need to explicitly specify a GPU type.  Similarly, most other partitions contain only one kind of GPU.

Nvidia A100's have a feature called "Multi-Instance-GPU Slicing" or MiG slicing that lets you split up the A100 into multiple "virtual GPUs" with a section of the total card's VRAM allocated to each MiG device. On Talapas we have different slice's available with vram settings of 10,40, and 80Gbs. To specify the amount of vram you want you would add a constraint flag to your sbatch script where the constraint can be ONE of: `--constraint=gpu-10gb,gpu-40gb,gpu-80gb`

The notable exception is the `preempt` partition, which contains most Talapas nodes.  The easiest way to see the available types is by running the command `/packages/racs/bin/slurm-show-gpus`.

Alternatively, you can use node features (with the `--constraint` flag) to limit your job to other GPUs (if available in your partition) by tagging the gpu card type (i.e. a100, l40s, a40, v100, or h100). See available node features by running: `/packages/racs/bin/slurm-show-features`.
