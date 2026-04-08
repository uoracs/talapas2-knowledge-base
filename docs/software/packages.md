---
layout: default
title: Available Packages
nav_order: 1
parent: Software
---

# Available Software on Talapas

Talapas provides hundreds of software packages for research computing, including many versions of each package to support compatibility and reproducibility.
The table below lists all currently available modules that users can load on the system. To request additional packages to be installed centrally on Talapas, please [submit a ticket](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1).

## Loading Software with LMOD

Talapas uses the LMOD module system to manage software environments.
To load a package, you must specify both the package name and the version you want to use.

For example, to load version 2.1.0 of the ants package:
```bash
module load ants/2.1.0
```
And unload software with:
```bash
module unload ants/2.1.0
```
You can also search for available versions using:
```bash
module avail ants
```

See the [How-to Use LMOD]({%link docs/how-to_articles/how-to_use_lmod.md %}) page for more details on using [LMOD](https://lmod.readthedocs.io/en/latest/010_user.html).

## Available Software Packages


| Module Name | Module Versions/Variants |
|:------------|:---------------------|
