---
layout: default
title: How-To Install R and R Packaged with Conda
parent: How-To Articles
nav_order: 19
---

# How-To Install R and R Packaged with Conda

R is a programming language used for statistical computing and data analysis, while Conda is a package manager that simplifies software installation and environment management across platforms. You can use Conda to create environments where R can be run, and install R packages within these environments, ensuring a consistent and isolated setup for your projects. This method will also allow you to share your exact custom `R` environments with others.

## Creating a Conda environment with R installed

There are two methods in which you can create a conda environment with your desired version of R, along with any R packages you wish to install. The preferred way (for sake of reproducibility), is by creating an `environment.yml` file for the conda environment and specifying the R version and packages you wish to install. The second is to create a new environment with R installed and install packages as you need.

## Loading miniconda3

In order to create a conda environment, we need to have conda available within out session. To do this, simply load miniconda using `module load`:

`$ module load miniconda3/20240410`

Once miniconda3 is loaded successfully, choose a method in which to create your environment.

## Using an `environment.yml`

- **Creating** `environment.yml`
  start by creating a new text file named `environment.yml` in your project directory
  `$ touch environment.yml`
- **installing R packages**
  Conda also allows users to be able to create environments for R and allows users to create and manage their own R environments. To do this, you will need to specify a few additional channels for the `R` libraries. An example `environment.yml` with the necessary channels and some example packages can be seen below:

```bash
name: name-of-your-choosing
channels:
  - defaults
  - conda-forge
  - bioconda
  - R
dependencies:
  - r-base=4.4 # change to desired R version
  - r-scales
  - r-seqinr
  - r-ape
  - r-castor
  - r-phytools
  - and any other additionall packages...
```

{: .note }
The conda channels `defaults` and `conda-forge` are standard conda channels which are, as the first name implies, the default channels. Conda will look here first when trying to satisfy package installations. However, this is not enough to satisfy installing R and its available packages. This is why the `bioconda` and `R` channels need to be specified.

- **Creating the conda environment with miniconda3:** Once the `environment.yml` is complete with all required dependencies, we can create the environemnt with the following commands
  `$ conda env create --solver=libmamba -f environment.yml`
  Upon successful completion, you can activate the environment by using:
  `$ conda activate name-specified-in-environment-file`

- **Deactivating conda environment:**Once finished with your session, simply enter:
  `$ conda deactivate`

This will quit the conda environment until you reactivate it again when needed.

## Not using `environment.yml`

- **Create a conda environment:**
  - To create a conda environment without using an `environment.yml` file, simply provide a name (“example_environemnt")for your environment in the command below:
    `$ conda create --solver=libmamba --name example_environment r=4.2.0`
    Note: This documents focuses on using `R` you can specify the version of python as seen above with `python=VERSION` and `r=VERSION` If not specified, conda will use its default python version.
- **Activate environment:**
  - Once the environemnt has been created, simply activate it via the command: `$ conda activate example_environment` (where “example_environment” is the name you specifed in the previous command).
- **Using R to install packages:** Once activated, you have the flexibility to incrementally add new packages and dependencies to your environment as needed to adapt to changing workflow requirements using R’s `install.packages()` or using conda. This allows you to create a tailor the environment with only the packages you need.
  - **Using** `install.packages()`

```R
$ R
R version 4.2.0 (2022-04-22) -- "Vigorous Calisthenics"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-conda-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.


> install.packages("ggplot2")
```

- **Using** `conda` (example r package: `ggplot2`)
  `$ conda install -c conda-forge -c R r-ggplot2`
- **Deactivating conda environment:**
  - Once finished with your session, simply enter: `$ conda deactivate`

This will quit the conda environment until you reactivate it again when needed.

## Reactivating Existing Conda Environments

To reactivate an existing environment that was created:

- **Load miniconda3:**
  `$ module load miniconda3/20240410`
- **Find environment name:**
  - If you forgot what your environments name was, you can either refer back to your `environment.yml` file or use the command: `$ conda env list`. This will produce a list of all the available conda environments and should help you remember what the name was.
- **Activate environment:**
  - As before, once you have the name of your created environment, simply do: `$ conda activate environment_name`
