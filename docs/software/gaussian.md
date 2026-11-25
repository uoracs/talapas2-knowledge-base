---
layout: default
title: Gaussian
nav_order: 3
parent: Software
---

# Gaussian

In order to use this software, you must be a member of the “gaussian” Linux group, due to licensing restrictions. If you need to be added, please [submit a ticket](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1).

{: .note }
Gaussian cannot use multiple hosts, but it can use multiple CPUs on the same host. **The Gaussian input file needs to include information about the number of CPUs and amount of memory available (per your Slurm job requests).**

Your Slurm (sbatch) input file might look like this

```bash
#!/bin/bash
#SBATCH --account=<pirg>           # your slurm account is the name of your pirg
#SBATCH --partition=compute        # specify the partition, see Partition List
#SBATCH --job-name=yourjob         # name of your job
#SBATCH --output=yourjob.slurm.out # name of batch script's standard output
#SBATCH --time=0-04:00:00          # set a limit on the total run time of the job
#SBATCH --nodes=1                  # Gaussian cannot use more than one node
#SBATCH --ntasks=1                 # request 1 task
#SBATCH --cpus-per-task=28         # request 28 cpus for that task
#SBATCH --mem=4G                   # request 4GB RAM for the job

module load gaussian

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}

# The CPU and memory parameters requested from Slurm should match those in the
# Gaussian input file.  For the above, use

# %NProcShared=28
# %Mem=4GB

# Gaussian doesn't seem to use much memory, but you may as well give it at
# least 4GB.  (The default seems to be 800MB.)

\time g09 < yourinput > youroutput
```

{: .note }
> The file `yourinput` should include the two mentioned “%” lines at the top, like so:
> ```
> %NProcShared=28
> %Mem=4GB
> ```

You can choose to use fewer or more CPUs, but not more than the hosts in the partition you select have.

If your job crashes (or produces an “oom” or “out of memory” error), you should increase the memory request. Gaussian doesn’t seem to use a lot of memory, but for some jobs, you might have to double or quadruple this value.
