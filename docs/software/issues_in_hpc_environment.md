---
layout: default
title: Software Issues in an HPC Environment
nav_order: 5
parent: Software
---

# Software Issues in an HPC Environment

Talapas is fundamentally a set of Linux hosts, so software that runs on Linux should usually work. But, the hosts are multi-user (like all Unix hosts used to be). Some scientific software has been written and tested with the assumption that it would only ever run on a single-user laptop, etc. Adaptation might be needed.

Similarly, Talapas has shared GPFS storage, which makes directories and files accessible on multiple hosts. Some scientific software might not be ready for that.

Here are some aspects to consider:

- Some software chooses names for temporary files that aren’t unique on a host. So, for example, if the software wants to use a filename like `/tmp/asdf`, and multiple people use that software at the same time, this typically won’t work. Or in other cases, the file will be created by one user and then another can’t create it later. (RStudio and VSCode are or were offenders.) Sometimes, setting the `TMPDIR` environment variable to something unique can help, though some software ignores that variable
- A related problem is trying to use the same pathname on GPFS via different Slurm jobs, perhaps running on different hosts. The usual workaround is to get the software to use unique names, perhaps by including the hostname, the username, a PID, and even `$RANDOM`
- Some Talapas paths include symlinks, so for example, `/projects/foo/bar` refers to the same file/directory as `/gpfs/projects/foo/bar` This occasionally leads to problems or surprises
- As with any shared filesystem, beware of doing things like `scp ~/asdf somehost:asdf`. That is, we’re copying a file to the same location on another host. Depending on exactly how the program is implemented, this will typically destroy the file’s contents
- Scientific software sometimes uses outdated mechanisms for guessing the CPU or memory resources available. (“Everything I can see belongs to me!”) This works on single-user machines, but often doesn’t on Talapas. For CPUs within a Slurm job, it’s the number that you request that’s actually available, and there may be a way to tell the software that. Far more critical is the memory use, and again, it’s the amount you request in the Slurm job. If the program just tries to use all memory on the host, it will probably be killed
- Some software assumes that huge amount of data can be stored in your home directory. The Talapas quotas are quite large, but in general, the really big stuff should go under `/projects`
- Some programs (_cough_ VSCode _cough_) think that it’s okay to enumerate large parts of the GPFS filesystem. Something like `find /projects -print`. This filesystem has around a billion files currently, so that sort of action is pointless and causes performance problems on Talapas as well
- Some programs will use `mmap` and friends on GPFS files. For serious usage, this will cause horrendous problems on any shared filesystem. If your program seems at all slow, or even if you just see an option, turn this off
- Some programs and/or users sometimes decide to put huge numbers of files in a single GPFS directory. This sort of works up to around 100,000 files. Beyond that performance drops dramatically, because under GPFS, directory entry creation is quadratic
- A few software packages want to fire off their own set of Slurm jobs. This is usually okay, but massive numbers of very short jobs (taking less than a minute) can cause noticeable Slurm performance problems. When possible, try not to submit more than (say) 100 jobs per minute over a significant period

No doubt there are more failure modes. If you see slow or odd behavior, ask your RACS admins. If your tech skills are good, consider watching your software run with `strace` or `lsof`. Sometimes these can help you spot bad behavior.
