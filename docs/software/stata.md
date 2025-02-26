---
layout: default
title: Stata
nav_order: 6
parent: Software
---

# Stata

Stata is a general-purpose statistical software package.

## Commands

The commands `stata`, `stata-se`, and `stata-mp` run Stata in command-line mode.  The `stata` command is the "standard version", and `stata-se` is the "special edition", which has larger limits.  These are both single-core programs.

The `stata-mp` command uses multiple CPU cores, which might be faster for some scenarios. By default, it will use all cores available on the host.  This behavior can be controlled using the Stata `set processors` command.

There are corresponding commands `xstata`, `xstata-se`, and `xstata-mp` that will start Stata in GUI mode.  In order for this to work, you must use X forwarding, of which there are instructions in: [[How-to Run an X11 Application]].

## Local Details

The current license is _limited to three users_.  Please be sure to exit the program when you are done.

When running `stata-mp`, it's important match the SLURM resource request to the number of cores used by `stata-mp`.  For the default behavior (use all cores), use the SLURM `--cpus-per-task` flag to request the cores.  See [[How-to Submit an OpenMP Job]] for an example of this in a batch script, or [[How-to Start an Interactive Job]] for an interactive session.

## Documentation

[Stata Website](https://www.stata.com/) – [Documentation](https://www.stata.com/support/) – [Wikipedia](https://en.wikipedia.org/wiki/Stata)

## Usage Examples

### Hello World

```bash
$ module load stata
$ cat helloworld.do

/* stata hello world program */

program define hello
    di "Hello World"
end

hello

$ stata -b do helloworld.do
$ ls

helloworld.do  helloworld.log

$ less helloworld.log
.
.
.
. do helloworld.do

. /* stata hello world program */
.
. program define hello
  1.         di "Hello World"
  2. end
.
. hello
Hello World

.
end of do-file
```

### Simple Regression

Given an input file `auto.do`

```stata
sysuse auto
regress price weight mpg
regress price weight mpg foreign
```

run the command: `stata -b do auto.do`, which gives the result in `auto.log`

```bash
. do auto.do

. sysuse auto
(1978 Automobile Data)

.
. regress price weight mpg
      Source |       SS       df       MS              Number of obs =      74
-------------+------------------------------           F(  2,    71) =   14.74
       Model |   186321280     2  93160639.9           Prob > F      =  0.0000
    Residual |   448744116    71  6320339.67           R-squared     =  0.2934
-------------+------------------------------           Adj R-squared =  0.2735
       Total |   635065396    73  8699525.97           Root MSE      =    2514
------------------------------------------------------------------------------
       price |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      weight |   1.746559   .6413538     2.72   0.008      .467736    3.025382
         mpg |  -49.51222   86.15604    -0.57   0.567    -221.3025     122.278
       _cons |   1946.069    3597.05     0.54   0.590    -5226.245    9118.382
------------------------------------------------------------------------------

.
. regress price weight mpg foreign

      Source |       SS       df       MS              Number of obs =      74
-------------+------------------------------           F(  3,    70) =   23.29
       Model |   317252881     3   105750960           Prob > F      =  0.0000
    Residual |   317812515    70  4540178.78           R-squared     =  0.4996
-------------+------------------------------           Adj R-squared =  0.4781
       Total |   635065396    73  8699525.97           Root MSE      =  2130.8
------------------------------------------------------------------------------
       price |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
      weight |   3.464706    .630749     5.49   0.000     2.206717    4.722695
         mpg |    21.8536   74.22114     0.29   0.769    -126.1758     169.883
     foreign |    3673.06   683.9783     5.37   0.000     2308.909    5037.212
       _cons |  -5853.696   3376.987    -1.73   0.087    -12588.88    881.4934
------------------------------------------------------------------------------
```
