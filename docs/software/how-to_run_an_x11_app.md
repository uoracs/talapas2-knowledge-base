---
layout: default
title: How-To Run an X11 Application
parent: Software
nav_order: 18
---

# How-To Run an X11 Application

Slurm can forward X11 graphical applications from a compute node to your desktop or laptop with the `srun --x11` flag.

To use it, do the following steps:

1. Install an X11 server on your desktop or laptop, e.g. "Xming" on Windows, or "XQuartz" on MacOS.
2. `SSH` to one of the Talapas login nodes (`login.talapas.uoregon.edu`) with X11 forwarding enabled:
    - If using the Putty `SSH` client on Windows, make sure that the X11 forwarding box is checked.
    - If using MacOS or Linux, connect using `ssh -Y`
3. Once on a Talapas login node, start an interactive job with the `--x11` flag (see [How-To Start An Interactive Job]({% link docs/slurm/how-to_start_an_interactive_job.md %}) for more on interactive jobs).
4. Launch your X11 application, e.g. type `xclock`

```bash
srun --account=<pirg> --partition=interactive --nodes=1 --ntasks=1 --time=02:00:00 --x11 --pty bash -i
```

{: .note }
`srun --x11` only works when the cluster has X11 forwarding enabled in Slurm (the `PrologFlags=X11` setting, which RACS controls).

{: .note }
The older `xrun` (or `idev`) wrapper script is deprecated. Use `srun --x11` instead.
