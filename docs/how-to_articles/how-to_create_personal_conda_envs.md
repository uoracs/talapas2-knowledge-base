---
layout: default
title: How-To Create Personal Conda Environments
parent: How-To Articles
nav_order: 17
---

# How-To Create Personal Conda Environments

Conda is an open-source package management and environment management system that simplifies the process of installing, updating, and managing software packages and their dependencies across various programming languages. It is particularly useful for creating isolated environments for different projects, ensuring compatibility and reproducibility. miniconda3 is currently available on Talapas2, enabling users to create and manage their own environments at their convenience and according to their workflow needs.

## Methods for Creating Conda Environment

There are two primary methods for creating conda environments. The first method involves using an `environment.yml` file, which specifies the desired packages and their versions. This approach allows for easy sharing and replication of environments across different systems, ensuring consistency in dependencies. The second method involves manually creating a base conda environment and then using `pip` to install additional packages as needed. This approach offers flexibility for adding packages incrementally and customizing the environment on-the-fly. Both methods have their advantages and can be chosen based on the specific needs of the project.

## Loading miniconda3

In order to create a conda environment, we need to have conda available within out session. To do this, simply load miniconda using `module load`:

`$ module load miniconda3/20240410`

Once miniconda3 is loaded successfully, choose a method in which to create your environment.

## Using an `environment.yml`

- **Create an environment.yml file**: Start by creating a new text file named `environment.yml` in your project directory: `$ touch environment.yml`
- **Specify Environment Configuration**: Open the `environment.yml` file in a text editor of your choice and specify the desired configuration for your environment. This typically includes the name of the environment (`name`), the list of packages to be installed (`dependencies`), and optionally the channels from which to install packages (`channels`). For example:

```bash
name: example_environment-20240930
channels:
  - defaults
  - conda-forge
dependencies:
  - python=3.12.0
  - numpy=1.26.2
  - pandas=2.1.1
  - matplotlib=3.8.0
  - scikit-learn=1.3.1
```

- **Note regarding environment names**
  - Sometimes we create multiple conda environments for specific software such as **nipype** or **py4dstem** but within each environment, packages and versions might be tweaked for different reasons. Due to this, it is helpful to add the date of creation to the end of the title of your environment or some kind of unique identifier. An example of this `example_environment-20240930`, where the `YYYYMMDD` tag is added to the end of the name.
- **Note regarding channels:**
  - In many instances, the default channels, along with conda-forge, are adequate for installing the specified dependencies. However, should certain packages not be available in either of these channels, you have the option to specify the channel where the package can be located. Typically, the package's documentation will indicate the appropriate channel.
- **Data Science packages**
  - If you are creating an environment in which you would like many of the common packages used for data science, there exists a dependency you can include named `datascience` that will install those common packages without needing to specify each one.
- **Creating the conda environment with miniconda3:** Once the `environment.yml` is complete with all required dependencies, we can create the environemnt with the following command:
  `$ conda env create --solver=libmamba -f environment.yml`
  Upon successful completion, you can activate the environment by using:
  `$ conda activate example_environment`

  Note: (“example_environment” is the name specified in `environment.yml`)
  This will activate the environment within your session and allow you to access all the packages that were installed. If it turns out you need more packages than originally specified, you can add more by using `$ pip install <package name>` . This will add said package onto your environment.
- **Deactivating conda environment:**Once finished with your session, simply enter:
  `$ conda deactivate`
  This will quit the conda environment until you reactivate it again when needed.

## Not using `environment.yml`

- **Create a conda environment:** To create a conda environment without using an `environment.yml` file, simply provide a name (“example_environemnt")for your environment in the command below:
  `$ conda create --solver=libmamba --name example_environment python=3.12.9`
  Note: you can specify the version of python as seen above with `python=VERSION`. If not specified, conda will use its default python version.

- **Activate environment:** Once the environment has been created, simply activate it via the command: `$ conda activate example_environment` (where “example_environment” is the name of your environment).

- **Using pip to install packages:** Once activated, you have the flexibility to incrementally add new packages and dependencies to your environment as needed to adapt to changing workflow requirements. This allows you to create a tailor the environment with only the packages you need. An example using pip to install a `pytorch` can be seen below:
  `$ pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124`

- **Deactivating conda environment:** Once finished with your session, simply enter:
  `$ conda deactivate`

This will quit the conda environment until you reactivate it again when needed.

## Reactivating Existing Conda Environments

To reactivate an existing environment that was created:

- **Load miniconda3:**
  `$ module load miniconda3/20240410`
- **Find environment name:** If you forgot what your environments name was, you can either refer back to your `environment.yml` file or use the command: `$ conda env list`. This will produce a list of all the available conda environments and should help you remember what the name was.
- **Activate environment:** As before, once you have the name of your created environment, simply do:
  `$ conda activate environment_name`
- **Deactivating conda environment:** Once finished with your session, simply enter**:
    `$ conda deactivate`
