---
layout: default
title: Jupyter
nav_order: 2
parent: Software
---

# Jupyter

{: .note }
Most users will find it far easier to start Jupyter using [Open OnDemand]({% link docs/open_ondemand.md %}) instead.  This procedure still works, but is rather involved, and has few advantages.

[Jupyter Notebook](https://jupyter.org) (and its new incarnation [JupyterLab](http://jupyterlab.readthedocs.io/en/stable/)) is a web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text.  Its uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more.

Jupyter can be installed on Windows, MacOS, and Linux PCs, and many users use it on their local machines.  For more demanding analysis, Jupyter can be run on Talapas, providing access to more RAM, faster CPUs, and the Talapas filesystem.

The Jupyter interface runs in a web browser, and this browser talks to a back-end "kernel", which is an interpreter for a programming language like Python or R.  There are several ways to make this happen on our cluster.  Here we document one method that is fairly simple, general, and secure.

## Initial Setup

First, you will want to determine which version of Jupyter to run.  For almost all users, the tensorflow (Python3) version is best.  This provides access to Python 3 and R.  If you need Python 2, `anaconda2` is the best choice.  Whichever module you choose, load the same one now and in the SLURM script below.

`module load tensorflow`

Next, if you've not run `jupyter` before, you'll want to run this command

`jupyter notebook --generate-config`

This will create a configuration file in `~/.jupyter`.  You can edit this if needed, though most users will not.  It also prepares us for the next step, which is to set a web password.  Run the command below to do that.  **Do not use your Talapas password here.**  Choose a password you don't use anywhere else.

`jupyter notebook password`

### Create a SLURM script

Next we need to create an `sbatch` script to start the Jupyter server.  You'll need a directory for your Jupyter notebooks, and it's probably easy to place this there.  Copy the contents below into a file named `jupyter.sbatch`, for example.

The SLURM parameters given are suitable for small-scale usage.  Edit them as needed, or override them on the `sbatch` command-line.  Unless you are using special parallelization libraries, Jupyter will not benefit from multiple CPUs.

In order to set up the required port forwarding, two port numbers need to be chosen.  In the script below, they're chosen randomly.  Alternatively you could stick with fixed ports, for convenience.

At the bottom of the script, modules are loaded and `jupyter` is invoked.  Edit these as needed.

```bash
`#!/bin/bash

#SBATCH --account=<youraccount>
#SBATCH --partition=interactive
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time 0-4:00:00
#SBATCH --job-name jupyter
#SBATCH --output jupyter-%J.log

case $(hostname) in talapas-ln*)
    echo 'this script should be run with sbatch'; exit 1;;
esac

# work around jupyter bug
unset XDG_RUNTIME_DIR

# The ports need to be not otherwise in use.  The 'shuf' command can
# be used to choose ports at random, which almost always works.  Or,
# for convenience, you can choose a fixed port within the given range
# (8000 to 64000), though this may collide more often.
port=$(shuf -i8000-64000 -n1)
# port=12345

hostport=$(shuf -i8000-64000 -n1)
# hostport=12345

node=$(hostname -s)
user=$(whoami)

loginnode=${SLURM_SUBMIT_HOST:?'error: you must use sbatch to submit this script'}.uoregon.edu

# print tunneling instructions to above output log
cat <<EOF
##########################################################

For MacOS or Linux, use this command to create SSH tunnel:

    ssh -N -L localhost:${port}:${node}:${hostport} ${user}@${loginnode}

For Windows/MobaXterm, use this info:

    Forwarded port: ${port}
    Remote server: ${node}
    Remote port: ${hostport}
    SSH server: ${loginnode}
    SSH login: ${user}
    SSH port: 22

Then use this URL to access Jupyter (NOT the one in the log below):

    http://localhost:${port}

##########################################################
EOF

module purge

# uncomment just one: tensorflow is a good start for most purposes
module load tensorflow
# module load tensorflow2
# module load anaconda3
# module load python3
# module load anaconda2
# module load python2

# uncomment just one: lab is the new interface, but otherwise compatible with notebook
jupyter lab --no-browser --port=${hostport} --port-retries=0 --ip='*' --NotebookApp.shutdown_no_activity_timeout=600
# jupyter notebook --no-browser --port=${hostport} --port-retries=0 --ip='*' --NotebookApp.shutdown_no_activity_timeout=600
```

## Starting a Jupyter SLURM job and Session

To start a session, `cd` to your Jupyter directory and submit the SLURM script.

`sbatch jupyter.sbatch`

Once the job starts, port information information will be provided in the job output log (`jupyter-<jobid>.log`).  At this point, you will need to start port forwarding from your local PC to the compute node.  If your local PC runs MacOS or Linux, open a terminal and run the provided `ssh` command.  If your local PC runs Windows, you will need to start forwarding via whatever means your SSH client provides.  If you're using MobaXterm, go to the _Tools_ menu, choose _MobaSSHTunnel_, and follow the instructions.

After port forwarding is started, you can then visit the provided URL to access Jupyter.

## Ending a Jupyter Session and SLURM job

When you're done with Jupyter, you'll want your SLURM job to terminate.  There are several ways that this can happen.

1. If your job hits the time limit specified with the `--time` flag, it will be killed by the SLURM scheduler.
2. You can manually kill it with the `scancel` command.
3. If you kill all of your Jupyter kernels and terminals, `jupyter` will exit by itself after ten minutes, as long as you have included the `shutdown_no_activity_timeout` flag as above.
4. Some versions of Jupyter have a _Quit_ button on the web page that you can press to kill the server.

You should use some combination of these methods to make sure that your job doesn't sit idle for long periods, as this prevents other users from making use of its resources.
