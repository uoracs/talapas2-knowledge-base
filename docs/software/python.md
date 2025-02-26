---
layout: default
title: Python
nav_order: 3
parent: Software
---

# Python

Python is a popular interpreted programming language. Talapas has a large number of Python instances installed, but choosing the best one for your need can be a bit daunting. Here is some guidance.

## Python 2 vs Python 3

Although Python3 was derived from Python2, it’s best to think of them as two distinct and incompatible languages. These days, Python2 is deprecated, and it’s best not to use it for new work unless you really need to (perhaps because a module you need is not available for Python3).

In any case, you will want to choose the correct one for your need, as they are not interchangeable at all.

As a detail, always use the commands `python3` and `pip3` when using Python3, and `python2` and `pip2` when using Python2. Historically, there were commands `python` and `pip` that more or less mean “the version of Python I have installed or that I intend”. But these days, they are ambiguous and deprecated.

## There Can Be Only One

In any given shell, you should choose only one of the below alternatives. Trying to load two in the same shell can lead to obscure crashes and other bugs. You can always unload everything with

`module purge`

but you might be better off just starting a new shell.

## Versions within Versions

Unfortunately, each Python installation typically has a significant number of Python packages installed within it (typically from PyPI or an Anaconda repo). Although we would prefer to create a Python install with all versions set and never modify it again, for reproducibility, this would in practice lead to an explosion of versions. (And as you can see, we have many already.)

Instead, we occasionally update a minimal set of installed packages upon user request, if it seems that this can be done without disrupting other users. With Miniconda (see below), we often just create a new environment to avoid such issues.

## Environment Modules

If you just want quick access to a somewhat generic Python install, you can get one with one of these commands

`module load python3`

or

`module load python2`

You can also look for versions newer than the default with commands like

`module avail python3`

and so on.

Note that each version has a distinct set of “add-on” modules that have been installed via `pip3` (or `pip2`). We can add modules by request, but often it might be easier to find a version that already has them.

## Miniconda

This is our “go to” solution for most new Python installs these days.

We have a `miniconda` module (The most up-to-date version is now called `miniconda3/20240410`), which contains within it a large number of environments, almost all of which have a `python` installed. Some of these are the instances that sit behind our Open OnDemand Jupyter instance, so you might be using one already without realizing it.

The most used one currently can be loaded with

`module load tensorflow`

which is equivalent to

`module load miniconda`
`conda activate anaconda-tensorflow-gpu`

The name is a bit of an artifact, but refers to the fact that TensorFlow version 1 is included. It also has a large number of other data packages like `pandas`, `numpy`, `scipy`, etc.

A similar module is

`module load tensorflow2`

which is equivalent to

`module load miniconda`
`conda activate anaconda-tensorflow2-gpu`

**This is one recommended alternative, if you’re not sure how to start.**

It’s quite similar, except that it has TensorFlow version 2. (Note that version 1 is largely deprecated upstream at this point.)

The above choices are stable, but also a bit dated, having been created in mid-2020 or so.

If you’d like to use a similar but quite up-to-date environment, you can do this

`module load miniconda`
`conda activate jupyterlab-tf-pyt-20211020`

This is the module that currently the new Open OnDemand Jupyter instance uses. (Look for the one with the similar date.) This is still in testing and might change a bit, but it’s pretty stable.

### An Environment of One’s Own

When we get requests to install combinations of packages that might disrupt other users, we often just create a custom conda environment. All of these are visible to all users (see ‘conda env list’), but their contents might be obscure. In any case, if you have a particular set of packages and versions that you need, we can often provide a custom environment for you (which will also be available to other Talapas users). Or, you are welcome to create your own conda env, and here are the steps to on how to do this: [[How-to Create Personalized Conda Environments]].

## Out With the Old

There are a number of other possibilities available, but you probably don’t want to use them, unless perhaps your instructor has recommended them.

### RHEL Distribution

If you have no modules loaded, you’ll see `python3` and `python2` from the underlying RedHat distribution. These typically live in `/usr/bin/python3` and so on. If you need an exceedingly generic Python, these might be fine. But, we do not recommend them, nor install additional packages. These get updated as we update RHEL.

### Anaconda Modules

There are environment modules `anaconda2` and `anaconda3`. These were from an early attempt to get Anaconda working on Talapas. You can still use them, but they are not recommended, and we no longer update them. These are superseded by the `miniconda` modules, of which `miniconda3/20240410` is the most up-to-date as of January 2025.

### EasyBuild

There are some versions of Python available via the `easybuild` module. Unless you are in a class or lab that recommends them, you should not use them.

Similarly, there is a `racs-eb` module. Same drill--avoid unless told otherwise.

### Spack

Spack (available via `spack-rhel8`) is great, but we generally do not support Python this way. You can try them, but avoid unless told otherwise. We usually don’t add modules except to support software that requires it.

### Singularity

Some Singularity images have Python inside. If this works for you, it’s great. If you don’t understand this option, it’s likely not for you.

## Go Your Own Way

You can install your own Python: modules or entire instance. This might be good in that it’s entirely under your control. But, support from RACS will be more limited.

### Just Modules

In principle, for any of the above solutions, you could layer on code of your own by modifying `PYTHONPATH`, or perhaps by using the “per-user” flags for `pip` or `conda install`. Some users make this work, but there are dragons here, especially with the latter options. It’s easy to create a combination that fails obscurely. If you’re a relatively novice user, you might do better to ask us for what you want.

### Entire Instance

In this case, you’d install Python from scratch, manage it, install your own packages, etc. You might do this from source, or perhaps you’d install your own Anaconda instance. If you’re up to it, this might be a great idea. But, mixing and matching with the above Talapas-provided solutions likely won’t end well. Don’t cross the streams.
