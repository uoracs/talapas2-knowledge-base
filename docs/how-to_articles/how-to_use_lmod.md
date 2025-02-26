---
layout: default
title: How-To Use LMOD
parent: How-To Articles
nav_order: 11
---

# How-To Use LMOD

Software on Talapas is managed via "environment modules".  If you need to run a particular software package, you can search for a module associated with that package, and load it.  The module contains everything required by your shell environment for running the software, including any dependencies the software may have.  Using environment modules makes it very convenient to switch from one version of a software package to another.

LMod is used to manage your software environment on Talapas.   This HOWTO contains some common use cases for LMod.

**To see modules currently loaded in your environment:**

`$ module list`

**To see what modules are currently available to you:**

`$ module avail`

**To load a software package, e.g. matlab:**

`$ module load matlab`

If there are multiple versions of a software package (e.g. matlab/r2016b and matlab/r2017a), then the most recent version (matlab/r2017a) is often the version loaded by default.

**To load a specific version of a package, e.g. matlab/r2016b:**

`$ module load matlab/r2016b`

**To unload a software package, e.g. matlab:**

`$ module unload matlab` or `$ module unload matlab/r2016b

LMod supports module hierarchy. An hierarchy is a family of modules that were built using the same environment using a particular compiler.  Hierarchies help prevent conflicts that can occur between packages built using different environments or compilers.  Packages that conflict with your current environment may not be available or visible via "module avail" - conflicting packages are under a different hierarchy.  An example of this would be an MVAPICH package that was built with a recent version of a GCC6 compiler and sits under the "Bright" hierarchy, but it is not visible because it conflicts with the MPI packages under the "Intel" hierarchy that was built using the Intel compiler, which is loaded into your environment by default.

The "Core" hierarchy supported by RACS and located in /packages/modulefiles/Core, is loaded by default.  From this Core hierarchy, other hierarchies and modules can be accessed.  Other hierarchies include:

intel/* :  consists of modules built using different versions of Intel compilers, supported by RACS

gcc/* : consists of modules build using different versions of GCC (versions more recent than the stock GCC 4.8.5 version that comes with RHEL7.x), supported by RACS

bright/* : consists of stock modules provided and managed by Bright Cluster Manager software

easybuild/* : consists of modules provided and managed by Jason Sydes using EasyBuild

prl/* : consists of modules provided and managed by Sameer Shende from the PRL group

userapps/* : consists of modules provided and managed by various Talapas users, a general place for users to install and share their apps

To search for software packages that are not visible to your current environment, you can use `module spider`, which will list all possible modules in your MODULEPATH.

**To search for all possible versions of a package, e.g. python:**

`$ module spider python`

This should be enough to get you started, but stay tuned, there is more to come!!
