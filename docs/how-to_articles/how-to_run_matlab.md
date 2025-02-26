---
layout: default
title: How-To Run MATLAB
parent: How-To Articles
nav_order: 12
---

# How-To Run MATLAB

This article gives a 3 simple examples showing how to run MATLAB on Talapas.

## Versions

We have several versions available, to view run, `module available matlab`

## Talapas Desktop

1. Access [Open OnDemand]({% link docs/open_ondemand.md %})
2. In the top ribbon, select the ‘Interactive Apps' dropdown menu. Choose ‘Talapas Desktop'.
3. Enter account and job resource information. Once an allocation is granted, click 'Launch noVNC in New Tab'.
4. In the top ribbon of the Talapas Desktop, select Applications, Education, MATLAB. This will launch the MATLAB R2018b GUI.

## Interactive

1. ssh onto a talapas login node ([How-to Login to Talapas]({% link docs/how-to_articles/how-to_login_to_talapas.md %}))
2. Start an interactive job ([How-to Start an Interactive Job]({% link docs/how-to_articles/how-to_start_an_interactive_job.md}))
3. Once on the allocated node run:

```bash
module load matlab
matlab
```

## Batch

For longer running non-interactive use cases call matlab in batch. Create the file `matlab-job.srun`. In the file, add the desired slurm declarations, load the matlab module, call the application.

```bash
#!/bin/bash

#SBATCH --account=<pirg-name>
#SBATCH --job-name=matlab-job
#SBATCH --output=matlab-job.out
#SBATCH --error=matlab-job.err

module load matlab

matlab -nodisplay < matlab-file.m
```

## Submit the job

Use the sbatch command to submit the job.

`$ sbatch matlab-job.srun`
