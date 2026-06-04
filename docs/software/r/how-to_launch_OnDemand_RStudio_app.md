---
layout: default
title: How-To Launch OnDemand RStudio app
parent: R
nav_order: 2
---

## Navigating to RStudio on OnDemand

1. Log in to [ondemand.talapas.uoregon.edu](https://ondemand.talapas.uoregon.edu/)
2. In the top menu bar, click **Interactive Apps**
3. Select **RStudio**

---

## Launching RStudio

Fill in the launch form with the following settings:

| Field | Notes |
|---|---|
| **Account** | Your PIRG name |
| **Partition** | Your Slurm partition |
| **Cores** | Default is 1 — sufficient for most workflows |
| **Hours** | Duration you want the session to run |
| **Memory (GB)** | 4 GB per core is a good default|

Click **Launch** when ready.

---

## Choosing an R Version

### Option 1 — Default R (Recommended)

RStudio instance will automatically launch using the standard module `R/4.4.2`. This is a RACS-managed module with a large collection of R libraries pre-installed. No additional configuration needed.

### Option 2 — Custom R via Conda

Use this option if you need a specific R version not available in the default module.

1. Complete the launch form as described above *(don't click Launch yet)*
2. Check the box labeled **Use R built from conda Environment**
3. Select the **conda module** used to build your environment
4. Enter the **name of your conda environment**
5. Click **Launch**
