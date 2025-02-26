---
layout: default
title: How-To Run Mathematica
parent: How-To Articles
nav_order: 13
---

# How-To Run Mathematica

This article gives a 3 simple examples showing how to run Mathematica on Talapas.

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

1. ssh onto a talapas login node ([How-to Login to Talapas]({% link docs/how-to_articles/how-to_login_to_talapas.md %}))
2. Start an interactive job ([How-to Start an Interactive Job]({% link docs/how-to_articles/how-to_start_an_interactive_job.md %}))
3. Once on the allocated node enter

```bash
module load Mathematica
mathematica
```

This will launch the Mathematica 12 **Kernel**.

## Batch

For longer running non-interactive use cases call Mathematica in batch. Create the file `math-job.srun`. In the file, add the desired slurm declarations, load the module, call the application.

```bash
#!/bin/bash

#SBATCH --account=<pirg-name>
#SBATCH --job-name=math-job
#SBATCH --output=math-job.out
#SBATCH --error=math-job.err

module load Mathematica

math -run < math-file.m
```

## Submit the job

Use the sbatch command to submit the job.

`$ sbatch math-job.srun`
