---
layout: default
title: Talapas2 (T2) Release Notes
nav_order: 1.5
---

# Talapas2 (T2) Release Notes

## Notable updates

- Operating system - Red Hat Enterprise Linux 8 (RHEL8)
- Kernel - 4.18
- Processors - 3rd generation Intel (Ice Lake) and AMD (Milan)
- GPUs - Nvidia Ampere A100s
- Memory - DDR4 3200MT/s and Intel Optane memory in the `memory` partitions
- Storage - 250GB home directories

## Login

### Duckids

Talapas uses UO Identity Access Management system, Microsoft Active Directory, for authentication which requires all users to have a valid UO Duckid.

Links are provided below for external collaborators, graduating researchers, or automation accounts to continue their access to the cluster.

- External collaborators (2 options):
  - [Sponsored Duck ID Account Request](https://service.uoregon.edu/TDClient/2030/Portal/Requests/ServiceDet?ID=20228)
  - [Courtesy, Campus Associate, and other Unpaid Appointments](https://hr.uoregon.edu/courtesy-campus-associate-and-other-unpaid-appointments)

- Graduating researchers:
  - [Courtesy, Campus Associate, and other Unpaid Appointments](https://hr.uoregon.edu/courtesy-campus-associate-and-other-unpaid-appointments)

- Automation Accounts (Role Accounts)
  - [Role/Department Account Request](https://service.uoregon.edu/TDClient/2030/Portal/Requests/ServiceDet?ID=20173)

### UO VPN

A virtual private network (VPN) connection is recommended to access the cluster. This adds an extra layer of security, and enables passwordless authentication for logging into Talapas with the use of SSH keys. See the [How-To Login to Talapas]({% link docs/how-to_articles/how-to_login_to_talapas.md %}) page for instructions on setting up SSH keys.

Instructions here: [Article - Getting Started with UO VPN](https://service.uoregon.edu/TDClient/2030/Portal/KB/ArticleDet?ID=31471)

Use “`uovpn.uoregon.edu`" as the connection URL and your duckid and password.

Do not repeatedly attempt to log in when you’re getting error messages. As with other uses of your DuckID at UO, if you generate a large number of login failures, all DuckID access (including things like e-mail) will be locked University-wide. Similarly, be aware of automated processes like cron jobs that might trigger this situation without your notice.

Once you’re on the VPN, you can access any one of the cluster login nodes:

- `login1.talapas.uoregon.edu`
- `login2.talapas.uoregon.edu`
- `login3.talapas.uoregon.edu`
- `login4.talapas.uoregon.edu`

### Load balancer

If you can’t use the OU VPN, you can also connect to the login load balancer at `login.talapas.uoregon.edu`

A load balancer is used to redirect SSH connections to different login nodes to spread the load. The load balancers choice of login node is “sticky” in that repeated connections from your IP address will go to the same login node - as long as there has been some activity within the last 24 hours.

## Slurm

### List of shared partitions

``` bash
compute
computelong
gpu
gpulong
interactive
interactivegpu
memory
memorylong
```

For more information see the [Partition List]({% link docs/partition_list.md %}) page.

### Job control

- A slurm account is still required for each job, use `--account=<your-PIRG>`
- There is no default partition, you must a specify partition(s) with `--partition`
- The default memory per CPU is 4GB; use the `--mem=<size>` or `--mem-per-cpu` or `--mem-per-gpu` to adjust as needed

### Slurm features

Each node in the cluster has at a minimum: processor make, generation, and model Slurm feature tags. For example,

`n0173 amd,milan,7713`

Nodes with GPUs include Slurm feature tags with GPU model and GPU memory size. For example,

`n0172 amd,milan,7413,a100,gpu-40gb`

Nodes with large memory include Slurm feature tags with memory size. For example,

`n0142 intel,icelake,6348,mem-4tb`

### Request a node based on processor

Nodes with AMD and Intel processors are available on Talapas2.

Constrain a job to allocate a node with legacy Intel broadwell processor,

`#SBATCH --constraint=intel,broadwell`

### Request a node based on GPU feature

Nodes with 10GB, 40GB, 80GB GPU memory are available on Talapas2.

Constrain a job to allocate a node with 10GB of GPU memory,

`#SBATCH --gpus=1`

`#SBATCH --constraint=gpu-10gb`

#### CUDA A100 MIG slicing

Due to limitations with CUDA MIG slicing, it appears that a job can only use one slice (GPU) per host. That means one GPU per job unless MPI is being used to orchestrate GPU usage on multiple hosts. See [NVIDIA Multi-Instance GPU User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/). On nodes which have 80GB GPUs MIG mode is not enabled. Request these nodes using, `--constraint=gpu-80gb,no-mig`

### Request node based on memory feature

Nodes with 1TB, 2TB, 4TB memory are available on Talapas2.

Constrain a job to allocate a node with 1TB of memory,

`#SBATCH --constraint=mem-1tb`

For the complete list of features run,

`/packages/racs/bin/slurm-show-features`

{: .note }
All features are not available in every partition. You may need to submit your job to the `preempt` partition in order to have access to the desired features, i.e. `--constraint=h100`

## Processor architectures

Talapas2 is comprised of nodes from multiple separate purchases over the course of several years. Therefore, it has several generations of processors from multiple (Intel and AMD) vendors.

Here is the current architecture layout (this is subject to change):

- `compute: AMD Milan and Intel Broadwell`
- `gpu: AMD Milan`
- `interactive: Intel Broadwell and IceLake`
- `interactivegpu: AMD Milan`
- `memory: Intel IceLake and Intel Broadwell`
- `login: Intel Broadwell`
- `preempt: All`

## Storage

See the [Directory Structure]({% link docs/storage/directory_structure.md %}) document.

## Software

_**Some existing software will run fine on the new cluster.**_

_**But, with the operating system update to RHEL8 there will likely be cases where software requires rebuilding.**_

Generally, issues would be due to differences with the new shared libraries in RHEL8. If you compile software in a way that specifically assumes one architecture (i.e. Intel IceLake) it might not run on all nodes.

### LMOD

We’ll provide all software centrally available, including conda environments, through LMOD.

`module load software/version`

See [How-To Use LMOD]({% link docs/how-to_articles/how-to_use_lmod.md %}) for more details, and the [All Packages]({% link docs/software/packages.md %}) page to see all of the centrally installed software you can load with LMOD on Talapas.

### Conda

Talapas2 uses `miniconda3` and new conda environments will be built with this base environment. If you have personal conda environments, you might need/want to recreate them using `miniconda3`. Note that _using_ existing Conda environments should work fine - it’s making changes that might cause problems.

{: .note }
miniconda-t2 is being deprecated in favor of miniconda3 which include the libmamba solver

### Spack

Talapas2 uses `spack-rhel8` and software provided centrally by this platform will built using this instance with gcc 13.1.0 on Intel Broadwell nodes.

`spack install <package>@version %gcc@13.1.0 arch=linux-rhel8-broadwell`

## Open OnDemand

Updated Open OnDemand is on Talapas2. Use Google Chrome or Firefox and navigate to,

`https://ondemand.talapas.uoregon.edu/`

Use your DuckID to log in.

{: .note}
Buttons in the drop down menu within the Talapas desktop may point to previous versions of software.
Ensure you load the most current Talapas2 compatible version by opening a Mate Terminal, then enter `module load <software/version>`

## Globus

Recently deployed Talapas2 Globus endpoint, [UO Talapas2 Globus Endpoint](https://app.globus.org/file-manager/collections/1b22bc07-95c5-47eb-8e62-97da36c46296/overview)

## Technical Differences

These probably won’t affect you, but they are visible differences that you might notice.

- Talapas2 domain name is `talapas.uoregon.edu`
- Hostnames now use the long form, `login1.talapas.uoregon.edu`
- Use the long form of hostnames to access other campus hosts, `some-other-host.uoregon.edu`.
- Linux User IDs (UID) centrally managed in Active Directory (AD)
- Linux groups IDs (GID) are centrally managed in Active Directory (AD). And the group names are longer, for example, `is.racs.pirg.racs` instead of just `racs`
