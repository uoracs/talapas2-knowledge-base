---
layout: default
title: How-To Install Globus CLI
nav_order: 6
parent: Globus
grand_parent: Transferring Data
ancestor: Storage
---

# How-To Install Globus CLI

## What is Globus CLI?

Globus CLI allows you to programmatically transfer files. Globus CLI is installed on Talapas login nodes and accessed by running:

`$ module load globus`

You can also install Globus CLI on your laptop of lab server for use with Globus Personal Connect.

Below are instructions for installing on a Mac:

- [Globus CLI reference documentation](https://docs.globus.org/cli/reference/)
- [Globus CLI installation documentation](https://docs.globus.org/cli/#installation)
- Install any prerequisites as needed. The installation uses pip and the full version of python3 is recommended. If installed with pip, then the necessary requirements should be installed with Globus CLI.
  - Here's the documentation to install python3 on a mac using the homebrew package manager: [MacOS Python Installation](https://docs.python-guide.org/starting/install3/osx/#install3-osx)

## Install Globus CLI

`pip install --upgrade --user globus-cli`

## Globus CLI examples

Globus Login

After running `globus login` in your terminal window, you will be directed to a web page to login with your UO credentials.

```bash
Marks-MacBook-Pro:~ marka$ globus login
You are running 'globus login', which should automatically open a browser window for you to login.
If this fails or you experience difficulty, try 'globus login --no-local-server'
---

You have successfully logged in to the Globus CLI!

You can check your primary identity with
  globus whoami

For information on which of your identities are in session use
  globus session show

Logout of the Globus CLI with
  globus logout

Marks-MacBook-Pro:~ marka$ globus whoami
marka@uoregon.edu
Marks-MacBook-Pro:~ marka$ globus get-identities 'marka@uoregon.edu'
c7108429-4afb-44b0-9957-e28e56bdf396
```

List available commands

`globus list-commands`

Search for a Globus endpoint:

```bash
Marks-MacBook-Pro:~ marka$ globus endpoint search Talapas
ID                                   | Owner                 | Display Name
------------------------------------ | --------------------- | ---------------
b4221f50-6dc5-11e9-bf46-0e4a062367b8 | uoregon@globusid.org  | Talapas
```

Search for a Globus endpoint with filter:

```bash
Marks-MacBook-Pro:~ marka$ globus endpoint search --filter-scope my-endpoints
ID                                   | Owner             | Display Name
------------------------------------ | ----------------- | ----------------
97e58874-d33f-11e9-939f-02ff96a5aa76 | marka@uoregon.edu | marka-MacBookPro
79c2ad02-acd1-11e9-a379-0a2653bc2660 | marka@uoregon.edu | marka-testing
```

Display information about the Talapas endpoint:

```bash
Marks-MacBook-Pro:~ marka$ globus endpoint show b4221f50-6dc5-11e9-bf46-0e4a062367b8
Display Name:              Talapas
ID:                        b4221f50-6dc5-11e9-bf46-0e4a062367b8
Owner:                     uoregon@globusid.org
Activated:                 False
Shareable:                 True
Department:                Research Advanced Computing Services
Keywords:                  attached storage
Endpoint Info Link:        https://hpc.uoregon.edu
Contact E-mail:            racs@uoregon.edu
Organization:              University of Oregon
Department:                Research Advanced Computing Services
Other Contact Info:
Visibility:                True
Default Directory:         /~/
Force Encryption:          False
Managed Endpoint:          True
Subscription ID:           cc122247-7d3e-11e7-8d49-22000b9923ef
Legacy Name:               uoregon#Talapas2
Local User Info Available: True
```

Activate/Authenticate against an endpoint

You will be directed to a web page to login with your UO credentials. Click 'Advanced' to enter credential lifetime.

```bash
Marks-MacBook-Pro:~ marka$ globus endpoint activate --web 97e58874-d33f-11e9-939f-02ff96a5aa76
```

Transfer file from one endpoint to another

For example, transfer a directory on my local macbook endpoint to an endpoint I've created on Talapas.

{: .note }
A destination directory name is required. Also, `$dest_ep` has a 'Host Path' of `/projects/hpcrcf/marka/testing/` this is not visible in the CLI command ouput '`globus endpoint show $dest_ep`'

```bash
Marks-MacBook-Pro:~ marka$ source_ep=97e58874-d33f-11e9-939f-02ff96a5aa76
Marks-MacBook-Pro:~ marka$ dest_ep=79c2ad02-acd1-11e9-a379-0a2653bc2660
Marks-MacBook-Pro:~ marka$ globus transfer -r --verify-checksum $source_ep:/Users/marka/globus_ep/linux-5.2.13-copy1/ $dest_ep:linux-copy1
Message: The transfer has been accepted and a task has been created and queued for execution
Task ID: ad31ba86-d35d-11e9-939f-02ff96a5aa76
```

View tasks:

`globus task list`

View only active tasks:

`globus task list --filter-status ACTIVE`

Show details of a task:

```bash
Marks-MacBook-Pro:~ marka$ globus task show 4a86fc98-d358-11e9-9cf3-0edb67dd7a14
Label:                   None
Task ID:                 4a86fc98-d358-11e9-9cf3-0edb67dd7a14
Is Paused:               False
Type:                    TRANSFER
Directories:             4302
Files:                   64545
Status:                  SUCCEEDED
Request Time:            2019-09-09 23:19:38+00:00
Faults:                  0
Total Subtasks:          68848
Subtasks Succeeded:      68848
Subtasks Pending:        0
Subtasks Retrying:       0
Subtasks Failed:         0
Subtasks Canceled:       0
Subtasks Expired:        0
Completion Time:         2019-09-09 23:24:40+00:00
Source Endpoint:         marka-MacBookPro
Source Endpoint ID:      97e58874-d33f-11e9-939f-02ff96a5aa76
Destination Endpoint:    marka-testing
Destination Endpoint ID: 79c2ad02-acd1-11e9-a379-0a2653bc2660
Bytes Transferred:       819556855
Bytes Per Second:        2714391
```
