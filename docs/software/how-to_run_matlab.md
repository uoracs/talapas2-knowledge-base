---
layout: default
title: How-To Run MATLAB
parent: Software
nav_order: 12
---

# How-To Run MATLAB

This article gives 3 simple examples showing how to run MATLAB on Talapas.

## Versions

We have several versions available, to view run, `module available matlab`

## Talapas Desktop

1. Access [Open OnDemand]({% link docs/open_ondemand.md %})
2. In the top ribbon, select the ‘Interactive Apps' dropdown menu. Choose ‘Talapas Desktop'.
3. Enter account and job resource information. Once an allocation is granted, click 'Launch noVNC in New Tab'.
4. In the top ribbon of the Talapas Desktop, select Applications, Education, MATLAB. This will launch the MATLAB R2018b GUI.

## Interactive

1. ssh onto a talapas login node ([How-To Login to Talapas]({% link docs/connecting_to_talapas/how-to_login_to_talapas.md %}))
2. Start an interactive job ([How-To Start an Interactive Job]({% link docs/slurm/how-to_start_an_interactive_job.md %}))
3. Once on the allocated node run:

```bash
module load matlab
matlab
```

## Batch

For longer running non-interactive use cases call matlab in batch. Create the file `matlab-job.sbatch`. In the file, add the desired Slurm declarations, load the matlab module, call the application.

```bash
#!/bin/bash

#SBATCH --account=<pirg>          # your slurm account is the name of your pirg
#SBATCH --partition=compute       # specify the partition, see Partition List
#SBATCH --job-name=matlab-job     # name of your job
#SBATCH --output=matlab-job.out   # name of batch script's standard output
#SBATCH --error=matlab-job.err    # name of batch script's standard error
#SBATCH --time=0-01:00:00         # set a limit on the total run time of the job
#SBATCH --nodes=1                 # request 1 node
#SBATCH --ntasks=1                # request 1 task
#SBATCH --cpus-per-task=1         # request 1 cpu per task
#SBATCH --mem=4G                  # request 4GB RAM

module load matlab

matlab -nodisplay -nosplash < matlab-file.m
```

{: .note }
On MATLAB R2019a and newer you can instead run `matlab -batch "matlab_file"`, where `matlab_file` is the name of your script without the `.m` extension. It runs without a display and exits when the script finishes.

## Submit the job

Use the sbatch command to submit the job.

`$ sbatch matlab-job.sbatch`
