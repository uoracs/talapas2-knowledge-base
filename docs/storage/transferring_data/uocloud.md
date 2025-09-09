---
layout: default
title: UO Cloud
nav_order: 6
parent: Transferring Data
grand_parent: Storage
---

# UO Cloud

RACS has provided access to UO Information Services (IS) storage (UOCloud) from Talapas. This makes available a lower cost and lower performance storage tier for research data management needs. UOCloud is not intended for use as a data target or destination with jobs on the cluster and is therefore not available on compute nodes.

## Request UOCloud storage

Visit the [IS service portal](https://service.uoregon.edu/TDClient/2030/Portal/Requests/ServiceDet?ID=18714&SIDs=3235) and click the ‘Request Help’ button to open a ticket. In the ticket, enter the following:

- What Type of Storage Do You Need?
  - select ‘_**Server Attached Storage (SMB, NFS, iSCSI)**_'
- What do you need help with?
  - select '_**New storage allocation**_’
- Storage name?
  - _**enter your PIRG**_
- Storage access method?
  - _**select NFS**_
- Storage size?
  - _**enter size in TB**_
- Export client IP netmask?
  - _**enter 10.223.40.6/27**_
- Storage snapshots?
  - _**Yes**_
- Index?
  - _**enter your billing index**_
- Confirm Requirements
  - _**click the check box**_
- Description
  - _**enter ‘Talapas’**_

## Access /uocloud

UOCloud mount points are available on the data transfer node dtn01 at `/uocloud/<pirg>`

Login to dtn01 is available from the Talapas login nodes through `ssh`. On dtn01 standard Linux tools such as `cp`, `mv`, and `rsync` are available to use to transfer data movement between Talapas storage `/gpfs` and UOCloud storage `/uocloud`

## Data transfer

Copy or move data from the CLI or a script. Working with a large amount of data takes time. When running your data transfer commands interactively through the CLI avoid network disconnects interrupting your file transfers by wrapping your shell session in a persistent session with `screen` or `tmux` or a similar utility.

Simple screen commands,

```bash
#create a new session and attach to it
$ screen -S <name>
#detach from screen session
$ <cntl> <a><d>
#show your screen sessions
$ screen -ls
#attach to a session
screen -r <name>
#delete session, while inside the session
$ exit
```

See `man screen`

For example, create a screen session, run an rsync command, then detach from the session while the rsync runs,

```bash
screen -S myscreen
rsync ...
<cntl> <a><d>
```

## rsync script example

Here is an example script, we’ll call it `rsyncjob.sh`,

```bash
#!/bin/bash

#
# example script to rsync files to /uocloud
#

#check the host and only run on dtn01
whathost=$(hostname -s)
if [ "$whathost" != "dtn01" ]; then
  echo "Usage: this script runs from dtn01 only, exiting..."
  exit 1
fi

#capture date for the log file
thedate=$(date +%y%m%d%H%M)
logfile="/projects/pirg/cron/rsyncjob.sh.out.$thedate"

#variables for rsync source and destination
sourcepath="/projects/pirg/5GB-in-small-files/"
destpath="/uocloud/pirg/testdir/5GB-in-small-files/"

#check that /uocloud/dir is mounted
if [ ! -d "$destpath" ]; then
  echo "$destpath is not mounted, exiting..."
  exit 1
fi

#rsync files, send output to the log file
/usr/bin/rsync -axv "$sourcepath" "$destpath" > $logfile 2>&1

echo "All done."
exit 0
```

See `man rsync` for an explanation of the options as well as more examples.

{: note }
rsync: include the trailing slash “/” on both source and destination directories. Makes the syntax easier to remember and gives the most desired behavior with rsync. For a deeper explanation, see man rsync

{: bp }
redirect output to a log file so you can validate output and review any errors (2>&1 captures stderr and sends it to the logfile as well)

Login to dtn01 from a login node

Run the rsync script on dtn01 for the initial copy of the data to UOCloud

```bash
[user@dtn01 cron]$ ./rsyncjob.sh
sending incremental file list
...
sent 5,001,353,727 bytes  received 40,761 bytes  52,370,622.91 bytes/sec
total size is 5,000,000,000  speedup is 1.00
```

## cron example

On dtn01 you can create a crontab entry to trigger your rsync script.

Simple cron commands,

```bash
#open your crontab for editing using the editor set in your environment, most likely vi
$ crontab -e
#list the contents of your crontab, if it exists
$ crontab -l
```

In a `crontab` each line is made up of two parts, 1) when to run and 2) what to run. For example,

```bash
#part 1, run at 2:01pm
#part 2, run the command, 'echo "hello" > /projects/pirg/hello.txt'
1 14 * * * echo "hello" > /projects/pirg/hello.txt 2>&1
```

See the wikipedia page on cron,

For example on dtn01,

```bash
[user@dtn01 ~]$ crontab -l
#rsync example
#run at 1:20pm every Sunday
#run the command, rsyncjob.sh
20 13 * * 6 /projects/pirg/cron/rsyncjob.sh > /projects/pirg/cron/rsyncjob.cron.out 2>&1
```

Best practice: redirect output from your crontab to a log file so you can validate output and review any errors.
