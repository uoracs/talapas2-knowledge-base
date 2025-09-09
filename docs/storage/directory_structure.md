---
layout: default
title: Directory Structure
nav_order: 1
parent: Storage
---

# Directory Structure

The directory structure on a Talapas login node or compute node follows the typical directory structure found on a standard Linux server. As a user, there are several locations to store your data:

## Home directory

`/home/<username>` - your home directory has a 250GB quota and is only accessible by you. Store your personal work related data here.

## Projects directory

`/projects/<pirg>` - your PIRG project directory has its own quota, the standard is 2TB. Store PIRG work related data here and data used in collaborations with other members. At creation, a new project space is a flat, simplified directory structure. It is at the discretion of the PI to manage this space to best meet the needs of the PIRG. Members of the PIRG have read/write/execute access to files and directories in the project space for collaboration.

A symbolic link is created by default in each users home directory to provide a direct link to each PIRG that you are a member of. For example, members of racs each have the following link in their home directories,

`racs -> /projects/racs`

Navigate to the PIRG projects directory through the symbolic link `racs`:

`$ cd racs`

Or through the explicit directory direct path:

`$ cd /projects/racs`

## Projects directory - Legacy

`/projects/<pirg>` - your PIRG project directory has its own quota, the standard is 2TB. Store PIRG work related data here and data used in collaborations with other members. At creation, a new project space has a directory named `shared` for collaboration with other PIRG members and named directories for each member of the PIRG. It is at the discretion of the PI to manage this space to best meet the needs of the PIRG. Members of the PIRG have read/write/execute access to files and directories in the project space shared directory for collaboration.

A symbolic link is created by default in each users home directory to provide a direct link to your named directory in each PIRG that you are a member of. For example, members of racs each have the following link in their home directories,

`racs -> /projects/racs/username`

Navigate to the PIRG projects directory through the symbolic link `racs`:

`$ cd racs`

Or through the explicit directory direct path:

`$ cd /projects/racs/username`
