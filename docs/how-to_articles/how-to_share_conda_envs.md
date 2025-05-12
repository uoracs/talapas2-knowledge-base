---
layout: default
title: How-To Share and Export Conda Environments
parent: How-To Articles
nav_order: 18
---

# How-To Share and Export Conda Environments

In the world of software development and data science, ensuring that your environment is consistent across different systems is crucial for collaboration, reproducibility, and avoiding dependency issues. Conda, a popular package management and environment management system, provides a great solution for managing environments. One of the most effective ways to share your Conda environment with others is by creating an `environment.yml` file.

This guide will walk you through the process of exporting your conda environment to an `environment.yml` file, which can then be shared with others to help them easily recreate the same environment on their systems.

This process can also be used to create an `environment.yml` file for public conda environment that were created by RACS. An example scenerio would be that you have been using a public conda environment and wanted to test a new package within that environment. However, users do not have permissions to add/remove packages in environments that are not owned by them. By using this process, you can essentially “clone” an environment, remake it yourself (so that the new one is owned by you), and test/experiment new workflows/packages **without** affecting anyone else using the original environment.

## Steps to Share a Conda Environment

### 1. Activate the Conda Environment

First, ensure that you activate the environment you wish to export.

- Open a terminal and load the correct conda module and activate your environment. In this example, the conda environment `example-environment-name` is built within the `miniconda3/20240410` module on Talapas:
  `$ module load miniconda3/20240410`
  `$ conda activate example-environment-name`
  Replace `example-environment-name` with the name of the conda environment you want to share.
- Confirm that the environment is active by checking your command prompt which should display the environment name as seen below.
  `(example-environment-name) [user@login1 /] $`

### 2. Export the Conda Environment

After activating the environment, export its details into a `.yml` file. This file will contain all the packages, versions, and dependencies required to recreate the environment.

Run the following command to export the environment to a file:

`$ conda env export | sed '/prefix:/d' > environment.yml`

This will create an `environment.yml` file in the current directory. The file will contain:

- A list of all the installed packages and their versions.
- The Python version used in the environment.
- The channels from which the packages were installed.
- The `sed '/prefix:/d' > environment.yml` portion will remove the `prefix:` reference to the original conda environment location and prevent any conda errors and/or permission issues for users replicating the environment in the future.

### 3. Review the `environment.yml` File

Open the `environment.yml` file in a text editor to review it. The content will look roughly like this:

{: .note }
The name within the `environment.yml` file will be the **exact** same as the original environment which could lead to confusion and you will need to change it. The convention we like to use when naming our environment is by editing/adding a “date of creation” tag at the end so that way theres a sure way of telling similarly named environments apart. However, you can choose any name you want that helps you identify the environment and what its used for.

```yml
name: example-environment-name-YYYYMMDD
channels:
  - defaults
dependencies:
  - python=3.9
  - numpy=1.21.2
  - pandas=1.3.3
  - scikit-learn=0.24.2
```

You can manually remove any unnecessary packages or adjust the list of dependencies as needed.

### 4. Share the `environment.yml` File

Once you have verified your `environment.yml` file and everything looks good, you are ready to share it with others! Creating conda environments from `environment.yml` files is simple and a guide can be found in the [How-to Create Personalized Conda Environments]({% link docs/how-to_articles/how-to_create_personal_conda_envs.md %}) page.

## Common Issues and Solutions

- **Error during environment creation**: If the environment creation fails, it could be due to conflicting package versions. Check the error messages and try removing problematic dependencies.
- **Packages not available on another platform**: Ensure that your `environment.yml` file does not contain platform-specific dependencies if sharing between Windows, Linux, and macOS.
