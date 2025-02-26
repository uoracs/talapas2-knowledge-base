---
layout: default
title: How-To Run an X11 Application
parent: How-To Articles
nav_order: 9
---

# How-To Run an X11 Application

A wrapper script has been created to run X11 applications, called `idev` (interactive-development), or nicknamed `xrun`.  This has been installed into `/usr/local/bin` on login and compute nodes.

To use it, do the following steps:

1. Install an X11 server on your desktop or laptop, e.g. "Xming" on Windows, or "XQuartz" on MacOS.
2. `SSH` to one of the Talapas login nodes (`talapas-ln1.uoregon.edu`) with X11 forwarding enabled:
    - If using the Putty `SSH` client on Windows, make sure that the X11 forwarding box is checked.
    - If using MacOS or Linux, connect using `ssh -Y`
3. Once on a Talapas login node, you have two options available, `xrun` or `srun`.
    - DEPRECATED: Using `xrun`, you can pass many of the same arguments to `xrun` as you can to `srun`.
    - Using `srun`, use the `--x11` flag (available in the Slurm 17.11 module)
4. Launch your X11 application, e.g. type `xclock`

```bash
# I believe this is deprecated.  Use srun instead.
xrun -N1 -n1 --time=02:00:00

# This is the more up-to-date command to run.
srun -A hpcrcf -N1 -n1 --time=02:00:00 --x11 --pty bash -i
```
