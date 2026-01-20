---
layout: default
title: Partition List
nav_order: 5
---

# Partition List

The computational resources of Talapas are divided into groups of nodes called partitions. A partition needs to be specified when submitting a job to tell the workload manager Slurm where to run the job.

Partitions are separate queues for submitted jobs and each partition has different resources and constraints that the user should be aware of when submitting a job. Talapas partitions fall into two categories: open-use shared partitions and "condo" partitions (i.e. research group-owned). The open-use shared partitions are freely open to all Talapas users to submit jobs to. These partitions are grouped by what types of jobs are most applicable, listed below:
* `compute`: generic CPU jobs, max time limit of 1day
* `computelong`: generic CPU jobs, max time limit of 14days
* `gpu`: jobs that need a GPU, max time limit of 1day
* `gpulong`: jobs that need a GPU, max time limit of 14days
* `interactive`: meant for shorter interactive CPU jobs, max time limit of 12 hours
* `interactivegpu`: meant for shorter interactive GPU jobs, max time limit of 8 hours
* `memory`: CPU jobs that need LOTS of memory (up to 4tb), max time limit of 1day
* `memorylong`: CPU jobs that need lots of memory (up to 4tb), max time limit of 14days

This table lists *ALL* Slurm partitions on Talapas. This includes the "condo" partitions (those listed in the table below `memorylong`) that have resources that you may not have access to (you’re not a member of the PIRG). These resources are available through the `preempt` partition, but jobs on the `preempt` partition could be canceled if/when the owner of those resources requests them. See the [How-To Use the preempt Partition]({% link docs/how-to_articles/how-to_use_the_preempt_partition.md %}) page for more details.

```bash
# sinfo -o "%17P %6D %6c %12m %50f"|grep -v preempt
PARTITION         NODES  CPUS   MEMORY       AVAIL_FEATURES
compute           42     128    515047       amd,milan,7713
compute_intel     47     28     128301+      intel,broadwell,e5-2690
computelong       30     128    515047       amd,milan,7713
computelong_intel 47     28     128301+      intel,broadwell,e5-2690
gpu               3      48     515072+      amd,milan,7413,a100,gpu-10gb
gpu               10     48     257024+      amd,milan,7413,a100,gpu-40gb
gpu               1      48     515072       amd,milan,7413,a100,3xgpu-80gb,no-mig
gpu               3      48     515072       amd,milan,7413,a100,gpu-80gb,2xgpu-80gb,no-mig
gpu               4      48     257024       amd,milan,7413,a100,gpu-80gb,no-mig
gpu               1      48     515072       amd,milan,7413,a100,gpu-80gb,3xgpu-80gb,no-mig
gpulong           2      48     515072+      amd,milan,7413,a100,gpu-10gb
gpulong           8      48     257024+      amd,milan,7413,a100,gpu-40gb
gpulong           1      48     515072       amd,milan,7413,a100,3xgpu-80gb,no-mig
gpulong           2      48     515072       amd,milan,7413,a100,gpu-80gb,2xgpu-80gb,no-mig
gpulong           1      48     515072       amd,milan,7413,a100,gpu-80gb,3xgpu-80gb,no-mig
gpulong           2      48     257024       amd,milan,7413,a100,gpu-80gb,no-mig
interactive       4      28     128301+      intel,broadwell,e5-2690
interactive       14     28     257325       intel,broadwell,e5-2690v4
interactivegpu    1      48     515072       amd,milan,7413,a100,gpu-10gb
memory            2      56     4079197      intel,icelake,6348,mem-4tb
memory            1      56     1031323      intel,broadwell,e7-4830,mem-1t
memory            2      56     4127897      intel,broadwell,e7-4830,mem-4tb
memory            4      56     2063514      intel,broadwell,e7-4830,mem-2tb
memory            4      56     2039007+     intel,icelake,6348,mem-2tb
memory            2      56     1014880      intel,icelake,6348,mem-1tb
memory            1      56     1031323      intel,broadwell,e7-4830,mem-1tb
memorylong        1      56     1014880      intel,icelake,6348,mem-1tb
memorylong        1      56     1031323      intel,broadwell,e7-4830,mem-1t
memorylong        1      56     4079197      intel,icelake,6348,mem-4tb
memorylong        2      56     2039007      intel,icelake,6348,mem-2tb
memorylong        1      56     4127897      intel,broadwell,e7-4830,mem-4tb
memorylong        2      56     2063514      intel,broadwell,e7-4830,mem-2tb
bgmp              3      48     257024       amd,milan,7413
bgmp              7      40     191517       intel,cascadelake,6230
cengiz            1      48     257024       amd,milan,7413
chen              1      48     1031071      intel,sapphirerapids,6442y,mem-1tb,h100,gpu-80gb
cisds             3      40     385051       intel,cascadelake,6248,v100,gpu-32gb
cisds             2      48     1031071      intel,sapphirerapids,6442y,mem-1tb,h100,gpu-80gb
cryoc             1      64     256865       intel,icelake,6338n
ctn               1      40     191517       intel,cascadelake,6248
dasa              1      48     1031167      amd,milan,7413,mem-1tb
datascience       1      56     6070163      intel,cascadelake,8280l,mem-6tb
datascience       4      48     257024       amd,milan,7413
dgl               1      64     1031069      intel,sapphirerapids,6448y,mem-1tb,l40s,gpu-48gb
dsci100           3      40     191517       intel,cascadelake,6230
dufek             35     40     385053       intel,skylake,6148
gc3f              7      40     191517+      intel,skylake,6148
heidl             1      96     257012       amd,milan,7413,a100,no-mig
hendon            4      40     191517+      intel,skylake,6148
jhp               8      28     257325       intel,broadwell,e5-2690
jurov             1      64     515053       amd,rome,7542,a100,gpu-40gb,gpu-80gb,no-mig
karlstrom         1      40     385053       intel,cascadelake,6248
karlstrom         1      40     385053       intel,skylake,6148
kern              1      128    2051239      amd,milan,7763,mem-2tb
kern              7      128    515047       amd,milan,7713
kern              17     40     191517       intel,cascadelake,6248
kern              4      64     515068       amd,milan,7513
kern              10     40     385053+      intel,skylake,6148
kerngpu           1      110    2063463      intel,sapphirerapids,8480cl,mem-2tb,h100,gpu-80gb
kerngpu           2      64     1031159      amd,milan,7543,a100,gpu-20gb
kerngpu           1      64     1031159      amd,milan,7543,a100,gpu-40gb,no-mig
kerngpu           1      40     385051       intel,cascadelake,6248,v100,gpu-32gb
kuhl              4      40     191517       intel,cascadelake,6248
kxn               1      64     1031067      intel,emeraldrapids,6548Y,mem-1tb,l40s,gpu-48gb
lowd              1      128    1031144      amd,milan,7713,a100,gpu-80gb,no-mig
melgar            8      40     385060       intel,cascadelake,6230,tmp-9tb
melgar            4      40     191517       intel,cascadelake,6248
murray            1      32     256861       amd,genoa,9354p,l40,gpu-48gb
paty              8      40     385053       intel,skylake,6148
phillips          2      40     772125       intel,skylake,6148
phillips          1      40     385053       intel,cascadelake,6248
racs              1      40     191517       intel,skylake,6148
racsgpt           1      96     257012       amd,milan,7413,a100,no-mig
ray               2      32     514909       amd,genoa,9354p,a40,gpu-48gb
rohlfs            2      56     1014880      intel,icelake,6348,mem-1tb
rohlfs            2      48     256869       intel,icelake,6342
searcy            1      128    1546666      amd,turin,9555,mem-1tb,h200,gpu-141gb
```
