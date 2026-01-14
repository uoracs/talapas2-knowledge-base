---
layout: default
title: Open OnDemand
nav_order: 4
---

# Open OnDemand

We've installed an [Open OnDemand](https://openondemand.org/ "http://openondemand.org/") instance on Talapas.  This provides a way to access Talapas resources via a web browser.  You can edit files, launch a shell, launch a Jupyter instance, and even launch an X11 desktop (accessed via VNC), which in turn provides access to applications like XStata, MATLAB, and RStudio.  There are limitations, but it's quite usable for many tasks.

## Accessing via Web Browser and Security

**Summary: Open a new window in Google Chrome or Firefox and navigate to:**

- [**https://ondemand.talapas.uoregon.edu/**](https://ondemand.talapas.uoregon.edu/ "https://ondemand.talapas.uoregon.edu/")

Use your DuckID to log in.

{: .note }
If you see a "Bad Request" error page when navigating to Talapas's Open OnDemand portal you may need to clear your browser cache. It is recommended to always use a private or incognito browser window to go to Open OnDemand to avoid this issue. 

## Web Browser Oddities

There are a few things to know about web browser access.

First, the Safari web browser (and possibly others) lacks support for some OnDemand features.  The VNC desktop does not work at all, for example.  We've also seen more subtle bugs.  Chrome and Firefox appear to work on all operating systems, and we recommend that you use these instead.

Second, web browsers typically capture and interpret certain keystrokes themselves.  So, for example, Control-W might close the current tab, etc.  If you need to send such keystrokes through to your OnDemand session, an easy workaround is to put your browser in "full screen" mode.  Far fewer keystrokes are captured in this case.

Third, due to a bug, the VNC client used for the Desktop app seems not to work correctly on some older hardware.  If this happens, you'll notice that characters on not properly echoed in a terminal, or screen repainting may stop.  At the moment, the best solution is to try a different machine.  The relatively new machines we've tried (with updated OSes and browsers) all seem to work fine.

Fourth, on startup, the VNC client will try to resize to fill the enclosing tab.  Sometimes this doesn't happen, and instead you'll see a smaller desktop in the center of the tab with black borders around it.  Usually you can just close the tab, hit the "launch" button again, and it will properly resize.  (You might have to try this more than once.)

## SLURM Jobs

The OnDemand interface has a mechanism for launching SLURM jobs.  We haven't experimented with it yet, but it seems to work.

Beyond that, some heavier OnDemand apps also run within SLURM jobs.  You'll recognize these as they have a start page asking you to choose a partition, core count, etc.  Once you submit the job, you'll be taken to your job list, and a "launch" button will appear once the job has started.

You can use any partition, but for quick access, the `interactive` partition is ideal, since it usually has immediately available slots.  Please delete your job when you're done using it.  Also, note that like all SLURM jobs, your job will be unceremoniously killed when time runs out.  So plan ahead, save your work periodically, etc.

Specifying an account for SLURM jobs is now required.  This is the PIRG account that will be charged for your usage.  A list of the accounts you can use is provided–just enter your choice into the box.  

Note that jobs continue running, even if you log out of OnDemand or close your browser.  This is good, in that even if your local computer disconnects or crashes, you'll be able to log into OnDemand anew and reconnect to the job.  But it also means that it's important to delete the job when you're done, as it will continue to use Talapas resources until you kill it (or time runs out).

Please be judicious in the job time, CPU count, and memory requested.

## Jupyter

Jupyter Lab is available via OnDemand. We're still working on ways to offer a wider variety of packages, but the existing jupyter instance has quite a bit!

## Desktop

The Desktop app runs a complete X11 desktop on a compute node.  It will look quite familiar if you've used Gnome 2 or MATE before.  Access is via a noVNC client that runs in a browser tab.  It's more network-intensive than the other apps, so it might seem a bit sluggish, especially if accessed from off-campus.

**You can run several Talapas-specific applications by clicking on the "Application" menu in the upper left hand corner and choosing the "Education" sub-menu.  Currently these include XStata, MATLAB, and RStudio.**

In addition, you're welcome to look around and run other applications that look useful.  (Many things that you wouldn't expect to work, like "reboot", indeed do not work.)

No special Talapas modules are loaded in the desktop.  But, in many cases you can start a terminal, load whatever modules you like, and run your GUI app.

As mentioned in the oddity list above, if the desktop does not properly resize, you might have to close and re-launch it.

It's possible, though painful, to run Firefox within this desktop.  Be aware that the version is a bit dated and may not have the latest security fixes.  Take extra care to stick to web sites that you trust.

## Additional Features

You can copy files to and from the OnDemand File Explorer by dragging and dropping from your local computer.

## Common Problems

Unfortunately, OnDemand doesn't always report errors in a very helpful fashion.  Here are some things to look out for.

- If you're seeing things fail unexpectedly, your home directory might be full.  Run `du -sh ~` and verify that your usage is well below 10G, which is the current home directory quota.

## The Glorious Future

We'll be working on adding more apps and other improvements.  Let us know if there's something you'd like to see, or if something stops working.
