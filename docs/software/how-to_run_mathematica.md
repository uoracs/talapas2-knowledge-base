---
layout: default
title: How-To Run Mathematica
parent: Software
nav_order: 11
---

# How-To Run Mathematica

This article gives 3 simple examples showing how to run Mathematica on Talapas.

## Versions

We have several versions available, to view run, `module available Mathematica`

## Talapas Desktop

1. Access [Open OnDemand]({% link docs/open_ondemand.md %})
2. In the top ribbon, select the ‘Interactive Apps' dropdown menu. Choose ‘Talapas Desktop'.
3. Enter account and job resource information. Once an allocation is granted, click 'Launch noVNC in New Tab'.
4. In the top ribbon of the Talapas Desktop, click the MATE Terminal icon to open a terminal window.
5. Now in the terminal Run:

```bash
module load Mathematica
mathematica
```

This will launch the Mathematica 12 **GUI**.

## Interactive

1. ssh onto a talapas login node ([How-To Login to Talapas]({% link docs/connecting_to_talapas/how-to_login_to_talapas.md %}))
2. Start an interactive job ([How-To Start an Interactive Job]({% link docs/slurm/how-to_start_an_interactive_job.md %}))
3. Once on the allocated node enter

```bash
module load Mathematica
math
```

This will launch the Mathematica 12 **Kernel**.

## Batch

For longer running non-interactive use cases call Mathematica in batch. Create the file `math-job.sbatch`. In the file, add the desired Slurm declarations, load the module, call the application.

```bash
#!/bin/bash

#SBATCH --account=<pirg>          # your slurm account is the name of your pirg
#SBATCH --partition=compute       # specify the partition, see Partition List
#SBATCH --job-name=math-job       # name of your job
#SBATCH --output=math-job.out     # name of batch script's standard output
#SBATCH --error=math-job.err      # name of batch script's standard error
#SBATCH --time=0-01:00:00         # set a limit on the total run time of the job
#SBATCH --nodes=1                 # request 1 node
#SBATCH --ntasks=1                # request 1 task
#SBATCH --cpus-per-task=1         # request 1 cpu per task
#SBATCH --mem=4G                  # request 4GB RAM

module load Mathematica

math -script math-file.m
```

## Submit the job

Use the sbatch command to submit the job.

`$ sbatch math-job.sbatch`
