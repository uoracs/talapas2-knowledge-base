---
layout: default
title: How-To Login to Talapas
parent: How-To Articles
nav_order: 1
---

# How-To Login to Talapas

Your username on Talapas will be your [Duck ID](https://duckid.uoregon.edu/).  (That is, if your email address is [_alice@uoregon.edu_](mailto:alice@uoregon.edu), your Talapas username will be "alice".)  Your password is the same University-wide and can be managed at the UO password reset page.

**You must have a valid University of Oregon DuckID to use Talapas.**

We leverage the UO Identity Access Management system, Microsoft Active Directory, for authentication which requires all users to have a valid DuckID.

Links are provided below for external collaborators, graduating researchers, or automation accounts to continue their access to the cluster.

- External collaborators (2 options):
  - [Sponsored Duck ID Account Request](https://service.uoregon.edu/TDClient/2030/Portal/Requests/ServiceDet?ID=20228)
  - [Courtesy, Campus Associate, and other Unpaid Appointments](https://hr.uoregon.edu/courtesy-campus-associate-and-other-unpaid-appointments)

- Graduating researchers:
  - [Courtesy, Campus Associate, and other Unpaid Appointments](https://hr.uoregon.edu/courtesy-campus-associate-and-other-unpaid-appointments)

- Automation Accounts (Role Accounts)
  - [Role/Department Account Request](https://service.uoregon.edu/TDClient/2030/Portal/Requests/ServiceDet?ID=20173)

## UOVPN

A virtual private network (VPN) connection is recommended to access the cluster. This adds an extra layer of security, and will only prompt you for 2-factor authentication once.

Instructions here: [Getting Started with UO VPN](https://service.uoregon.edu/TDClient/2030/Portal/KB/ArticleDet?ID=31471)

## Connecting via SSH

The [SSH](https://en.wikipedia.org/wiki/Secure_Shell) protocol is used for all shell connections to the login nodes.  Multiple SSH are clients available–you can use whichever one you find most convenient.

If you’re not connected to the UOVPN, you’ll want to SSH to our login loadbalancer:

`login.talapas.uoregon.edu`

If you’re connected to the UOVPN, you can use any one of the 4 login nodes directly:

- `login1.talapas.uoregon.edu`
- `login2.talapas.uoregon.edu`
- `login3.talapas.uoregon.edu`
- `login4.talapas.uoregon.edu`

Your files will be present on all login nodes, so you don’t need to always use the same one!

Once logged into a login node, you can navigate the storage system, write scripts, edit code, and launch jobs.  Remember that login nodes are **NOT** an appropriate place to run applications or simulations. A good rule of thumb to use: if something takes longer than a few seconds to run, then it's inappropriate for a login node. Instead, _use a compute node_.  For information on launching an interactive session on a compute node see the [How-to Start an Interactive Job]({% link docs/how-to_articles/how-to_start_an_interactive_job.md %}) page.

## Mac OS X and Linux

If you're logging in from one of these operating systems, it's easiest to just use the builtin `ssh` command.  To do this, open a terminal emulation program (often called "Terminal") to get a command-line on your workstation.  Then enter a command like this:

```bash
$ ssh myDuckID@login.talapas.uoregon.edu
Welcome to Talapas!

myDuckID@login.talapas.uoregon.edu's password:
Last login: Thu May 25 10:18:23 2017 from somewhere.uoregon.edu

[myDuckID@ln1 ~]$

```

Note: For security, no characters will display when entering your password.

## Microsoft Windows

Windows has no builtin `SSH` client, but you can download and install one of several free clients:

- [MobaXterm](https://mobaxterm.mobatek.net/)
- [Putty](http://www.putty.org/)

Configuration varies, but it's generally sufficient to specify `SSH` as the protocol and to use the hostname, username, and password information as specified above.

## Google Chrome

On a Chromebook, or most other platforms that run the Google Chrome web browser, you can install the [Google Chrome Secure Shell extension](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwis7uuZs63XAhUXS2MKHZOKAEQQFggoMAA&url=https%3A%2F%2Fchrome.google.com%2Fwebstore%2Fdetail%2Fsecure-shell%2Fpnhechapfaindjhompbnflcldabbghjo%3Fhl%3Den&usg=AOvVaw3dZij4QITxPtMghcEoRuRX).  This is a terminal emulator and `SSH` client that runs in a Chrome window.

## SSH Timeout

You might want to configure your system to keep the connection alive longer during periods of inactivity. To do this, you’ll need to modify your SSH client settings, which can be found at `$HOME/.ssh/config`. Add a configuration entry that works for any of the Talapas systems like this:

```bash
*.talapas.uoregon.edu
    ServerAliveInterval 120
```

The next time you connect, you should no longer be logged out due to inactivity.

## X11 Forwarding

Some programs expect to show graphic output using the [X Window System](https://en.wikipedia.org/wiki/X_Window_System) (also known as X11).  This generally requires that you run an X server on your local workstation, and that you forward X traffic from the Talapas host that's running the graphic program.

- On Linux, you'll usually already be running an X server.
- On Mac OS X, you'll need to install and start [XQuartz](https://www.xquartz.org/).
- On Microsoft Windows, there are several solutions.  Perhaps the easiest is to install [MobaXterm](https://mobaxterm.mobatek.net/), which also includes an X server.

Once the server is running, you can forward X11 traffic to it when you start an `SSH` connection.  For command-line clients, this is as easy as adding the `-Y` flag for :

`ssh -Y myDuckID@login.talapas.uoregon.edu`

For other `SSH` clients, you may need to configure the corresponding option.

See the [How-to Run an X11 Application]({% link docs/how-to_articles/how-to_run_an_x11_app.md %}) page for more details on running an X11 program on a compute node.

## Blocked ports

Note that inbound access to the new cluster is only allowed for SSH and Open OnDemand. All other ports are blocked.
