---
layout: default
title: Partition List
nav_order: 5
---

# Partition List

The computational resources of Talapas are divided into groups of nodes called partitions. A partition needs to be specified when submitting a job to tell the workload manager Slurm where to run the job.

Partitions are separate queues for submitted jobs and each partition has different resources and constraints that the user should be aware of when submitting a job.

The tables below lists Slurm partitions on Talapas. This includes partitions with resources that you may not have access to (you’re not a member of the PIRG) but the resources are available through the `preempt` partition.

```bash
# sinfo -o "%12P %8D %8c %10m %50f"|grep -v preempt
PARTITION    NODES    CPUS     MEMORY     AVAIL_FEATURES
compute      42       128      504433     amd,milan,7713
compute_inte 84       28       117595     intel,broadwell,e5-2690
computelong  29       128      504433     amd,milan,7713
computelong_ 61       28       117595     intel,broadwell,e5-2690
gpu          5        48       504433     amd,milan,7413,a100,gpu-10gb
gpu          2        48       504433     amd,milan,7413,a100,gpu-80gb,3xgpu-80gb,no-mig
gpu          4        48       504433     amd,milan,7413,a100,gpu-80gb,2xgpu-80gb,no-mig
gpu          8        48       246385     amd,milan,7413,a100,gpu-40gb
gpu          4        48       246385     amd,milan,7413,a100,gpu-80gb,no-mig
gpulong      3        48       504433     amd,milan,7413,a100,gpu-80gb,2xgpu-80gb,no-mig
gpulong      6        48       246385     amd,milan,7413,a100,gpu-40gb
gpulong      2        48       504433     amd,milan,7413,a100,gpu-10gb
gpulong      1        48       504433     amd,milan,7413,a100,gpu-80gb,3xgpu-80gb,no-mig
gpulong      2        48       246385     amd,milan,7413,a100,gpu-80gb,no-mig
interactive  1        48       246385     intel,icelake,6342
interactive  4        28       117595+    intel,broadwell,e5-2690
interactive  13       28       246385     intel,broadwell,e5-2690v4
interactiveg 1        48       504433     amd,milan,7413,a100,gpu-10gb
interactiveg 1        64       504416     amd,rome,7542,a100,gpu-40gb,gpu-80gb,no-mig
memory       1        56       1020522    intel,broadwell,e7-4830,mem-1t
memory       2        56       4117194    intel,broadwell,e7-4830,mem-4tb
memory       4        56       2052811    intel,broadwell,e7-4830,mem-2tb
memory       2        56       4067951    intel,icelake,6348,mem-4tb
memory       4        56       2027750    intel,icelake,6348,mem-2tb
memory       2        56       1003878    intel,icelake,6348,mem-1tb
memory       1        56       1020522    intel,broadwell,e7-4830,mem-1tb
memorylong   2        56       2027750    intel,icelake,6348,mem-2tb
memorylong   1        56       1003878    intel,icelake,6348,mem-1tb
memorylong   1        56       1020522    intel,broadwell,e7-4830,mem-1t
memorylong   1        56       4117194    intel,broadwell,e7-4830,mem-4tb
memorylong   2        56       2052811    intel,broadwell,e7-4830,mem-2tb
memorylong   1        56       4067951    intel,icelake,6348,mem-4tb
amt          2        40       180771     intel,cascadelake,6248
amt          8        40       374307     intel,cascadelake,6230,tmp-9tb
bgmp         3        48       247635     amd,milan,7413
bgmp         7        40       180771     intel,cascadelake,6230
cisds        2        48       1020522    intel,sapphirerapids,6442y,mem-1tb,h100,gpu-80gb
cisds        3        40       374307     intel,cascadelake,6248,v100,gpu-32gb
cryoc        1        64       247635     intel,icelake,6338n
ctn          1        40       180771     intel,cascadelake,6248
dasa         1        48       1020522    amd,milan,7413,mem-1tb
datascience  3        40       180771     intel,cascadelake,6230
datascience  4        48       247635     amd,milan,7413
datascience  1        56       6059427    intel,cascadelake,8280l,mem-6tb
dsci100      1        128      504433     amd,milan,7713
dufek        35       40       374307     intel,skylake,6148
gc3f         8        40       180771+    intel,skylake,6148
hendon       4        40       180771     intel,skylake,6148
jhp          8        28       246385     intel,broadwell,e5-2690
karlstrom    1        40       374307     intel,cascadelake,6248
karlstrom    1        40       374307     intel,skylake,6148
kern         17       40       180771     intel,cascadelake,6248
kern         10       40       374307     intel,skylake,6148
kern         7        128      504433     amd,milan,7713
kern         4        64       504416     amd,milan,7513
kerngpu      2        64       1003520    amd,milan,7543,a100,gpu-20gb
kerngpu      1        64       1003520    amd,milan,7543,a100,gpu-40gb,no-mig
kerngpu      1        40       374307     intel,cascadelake,6248,v100,gpu-32gb
kerngpu      1        112      2052811    intel,sapphirerapids,8480cl,mem-2tb,h100,gpu-80gb
kuhl         4        40       180771     intel,cascadelake,6248
lowd         1        128      1003520    amd,milan,7713,a100,gpu-80gb,no-mig
melgar       2        40       180771     intel,cascadelake,6248
murray       1        32       247635     amd,genoa,9354p,l40,gpu-48gb
paty         8        40       374307     intel,skylake,6148
phillips     1        40       374307     intel,cascadelake,6248
phillips     2        40       754000     intel,skylake,6148
racs         1        40       180771     intel,skylake,6148
racsgpu      1        64       504416     amd,rome,7542,a100,gpu-40gb,gpu-80gb,no-mig
rohlfs       2        56       1003878    intel,icelake,6348,mem-1tb
rohlfs       2        48       247635     intel,icelake,6342
```
