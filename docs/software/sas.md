---
layout: default
title: SAS
nav_order: 4
parent: Software
---

# SAS

SAS is a software suite that can mine, alter, manage and retrieve data from a variety of sources and perform statistical analysis on it.

## Commands

The `sas` command is used to run SAS.

## Local Details

**Base SAS** is available, providing the command-line `sas` program.

The GUI version of SAS is not currently available–run this on your workstation if needed.  Note that if you invoke `sas` with no filename arguments, it will try and fail to invoke the GUI version.  To avoid this, always specify a filename argument and/or the `--nodms` option.

`sas` is a single-core program.

## Documentation

[SAS Unix Guide](http://support.sas.com/documentation/cdl/en/hostunx/63053/HTML/default/viewer.htm) – [Wikipedia](https://en.wikipedia.org/wiki/SAS_(software))

## Usage Examples

### Hello World

```bash
$ module load SAS
$ cat helloworld.sas
/* Print Hello World */
data _null_;
   put "Hello, World!";
run;

$ sas helloworld.sas
$ ls
helloworld.log  helloworld.sas

$ less helloworld.log
1   The SAS System                 09:44 Thursday, November 9, 2017

NOTE: Copyright (c) 2002-2010 by SAS Institute Inc., Cary, NC, USA.
NOTE: SAS (r) Proprietary Software 9.3 (TS1M1)
      Licensed to UNIVERSITY OF OREGON - SFA T&R, Site 70055064.
.
.
.
Hello, World!
NOTE: DATA statement used (Total process time):
      real time           0.11 seconds
      cpu time            0.00 seconds
```

## Simple Statistics and Plot

Given input file `example-1.sas`

```SAS
DATA CLASS;
     INPUT NAME $ 1-8 SEX $ 10 AGE 12-13 HEIGHT 15-16 WEIGHT 18-22;
CARDS;
JOHN     M 12 59  99.5
JAMES    M 12 57  83.0
ALFRED   M 14 69 112.5
ALICE    F 13 56  84.0
PROC MEANS;
     VAR AGE HEIGHT WEIGHT;
PROC PLOT;
     PLOT WEIGHT*HEIGHT;
ENDSAS;
;
```

Run this command: `sas example-1.sas`, which will produce a log file: `example-1.log` and output file `example-1.lst`

```bash
                              The SAS System                     15:17 Wednesday, November 29, 2017   1

                                                       The MEANS Procedure

                          Variable    N            Mean         Std Dev         Minimum         Maximum
                          -----------------------------------------------------------------------------
                          AGE         4      12.7500000       0.9574271      12.0000000      14.0000000
                          HEIGHT      4      60.2500000       5.9651767      56.0000000      69.0000000
                          WEIGHT      4      94.7500000      14.0386372      83.0000000     112.5000000
                          -----------------------------------------------------------------------------

                              The SAS System                     15:17 Wednesday, November 29, 2017   2

                                    Plot of WEIGHT*HEIGHT.  Legend: A = 1 obs, B = 2 obs, etc.

   115 +
       |
       |
       |                                                                                                                       A
       |
       |
       |
   110 +
       |
       |
       |
       |
       |
       |
   105 +
       |
       |
WEIGHT |
       |
       |
       |
   100 +
       |                             A
       |
       |
       |
       |
       |
    95 +
       |
       |
       |
       |
       |
       |
    90 +
       |
       |
       |
       |
       |
       |
    85 +
       |  A
       |
       |           A
       |
       |
       |
    80 +
       ---+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--
         56       57       58       59       60       61       62       63       64       65       66       67       68       69
                                                                  HEIGHT
```
