---
layout: default
title: How-To Pull an Apptainer Container Image
nav_order: 1
parent: Apptainer
grand_parent: Software
---

# How-To Pull an Apptainer Container Image

Most of the time you don't need to build a container yourself. Thousands of ready-made images for scientific software are published on registries such as [Docker Hub](https://hub.docker.com/), and Apptainer can download one and convert it into a single file you can run on Talapas. This page shows how to do that. Once you have your image, see [How-To Run an Apptainer Container]({% link docs/software/apptainer/how-to_run_a_container.md %}) to use it in a job.

Apptainer is available on Talapas without loading a module. Apptainer images are saved as `.sif` files (Singularity Image Format). A `.sif` is just a file, so you can copy it, move it, and share it with your PIRG like any other data.

## Choose where to keep your images and cache

Pulling an image downloads its layers into a cache and then assembles the `.sif`. By default the cache lives in `~/.apptainer/cache`, and images can be several gigabytes, so it is easy to fill up your home directory quota. We recommend keeping both the cache and your images in your PIRG's project directory (see [Storage]({% link docs/storage/storage.md %}) for quotas):

```bash
mkdir -p /projects/<pirg>/$USER/containers
mkdir -p /projects/<pirg>/$USER/apptainer_cache
```

Then tell Apptainer to use that cache and a temporary directory there:

```bash
export APPTAINER_CACHEDIR=/projects/<pirg>/$USER/apptainer_cache
export APPTAINER_TMPDIR=/projects/<pirg>/$USER/apptainer_cache
```

To make this permanent, add those two `export` lines to your `~/.bashrc`.

## Pull an image on a compute node

Pulling and converting an image takes more than a few seconds of work, so don't do it on a login node. Start an interactive job first (see [How-To Start an Interactive Job]({% link docs/slurm/how-to_start_an_interactive_job.md %})):

```bash
$ srun --account=<pirg> --partition=interactive --cpus-per-task=2 --mem=8G --time=1:00:00 --pty bash
```

Make sure the two `APPTAINER_*` variables above are set in that shell, then pull the image you want. For example, to pull the official Python image from Docker Hub:

```bash
$ cd /projects/<pirg>/$USER/containers
$ apptainer pull python_3.12-slim.sif docker://python:3.12-slim
```

The first argument is the name of the `.sif` file to create, and `docker://python:3.12-slim` is the registry, image name, and tag to download. If you leave the filename off, Apptainer names the file after the image and tag.

{: .note }
Always include a specific tag (such as `3.12-slim`) instead of relying on `latest`. A tag pins the version you tested, which keeps your results reproducible.

Docker Hub limits how many anonymous downloads can be made from the same address in a given period. If a pull fails with a rate-limit or "too many requests" message, wait a while and try again.

## Check the image

Confirm that the image works by running a command inside it:

```bash
$ apptainer exec python_3.12-slim.sif python --version
```

You can also look at the image's metadata with `apptainer inspect`:

```bash
$ apptainer inspect python_3.12-slim.sif
```

When you are finished, type `exit` to leave the interactive job and release the node.

## Next steps

- [How-To Run an Apptainer Container]({% link docs/software/apptainer/how-to_run_a_container.md %}) shows how to use your image in a Slurm job script.
- Need an image built a particular way, or having trouble with a pull? Submit a request at the [Service Desk](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1).
