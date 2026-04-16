---
layout: default
title: Available Packages
nav_order: 5
parent: Software
---

# Available Software on Talapas

Talapas provides hundreds of software packages for research computing, including many versions of each package to support compatibility and reproducibility.
The table below lists all currently available modules that users can load on the system. To request additional packages to be installed centrally on Talapas, please [submit a ticket](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1).

## Loading Software with LMOD

Talapas uses the LMOD module system to manage software environments.
To load a package, you must specify both the package name and the version you want to use.

For example, to load version 2.1.0 of the ants package:
```bash
module load ants/2.1.0
```
And unload software with:
```bash
module unload ants/2.1.0
```
You can also search for available versions using:
```bash
module avail ants
```

See the [How-to Use LMOD]({%link docs/software/how-to_use_lmod.md %}) page for more details on using [LMOD](https://lmod.readthedocs.io/en/latest/010_user.html).

## Available Software Packages


| Module Name | Module Versions/Variants |
|:------------|:---------------------|
| `adapterremoval` | `2.1.7`<br>`2.3.3` |
| `afni` | `24.1.22` |
| `alphafold3` | `3.0.0` |
| `amber` | `22` |
| `ancestry_hmm` | `0.92-old`<br>`0.92` |
| `angsd` | `0.941-22-gc877e7f` |
| `ansible` | `9.3.0` |
| `ants` | `2.1.0`<br>`2.5.1`<br>`2.5.2` |
| `aocc` | `4.0.0`<br>`5.0.0` |
| `aocl` | `4.2.0`<br>`5.0.0` |
| `arcs` | `1.0.3` |
| `argweaver` | `0.8.1` |
| `armadillo` | `12.2.0` |
| `aspect` | `3.1.0` |
| `augustus` | `3.3.2` |
| `awscli` | `2.22.5` |
| `bamm` | `2.5.0` |
| `bamtools` | `2.4`<br>`2.5.1` |
| `bayestraits` | `3.0.2` |
| `bbmap` | `38.16`<br>`39.06` |
| `bcftools` | `1.18`<br>`1.19` |
| `beagle` | `5.4` |
| `bedops` | `2.4.41` |
| `bedtools` | `2.25.0` |
| `bgc` | `1.0.3-patched`<br>`1.0.3` |
| `bgchm` | `1.0.0` |
| `binutils` | `binutils` |
| `blast` | `2.14.1+`<br>`2.2.29+` |
| `bowtie2` | `2.3.3`<br>`2.4.4` |
| `brainiak` | `20240412` |
| `braker` | `2.0`<br>`2.1.0`<br>`2.1.3-WIP-20190826` |
| `breseq` | `0.31.0` |
| `bwa` | `0.7.17` |
| `cactus` | `2.8.1` |
| `casa` | `6.7.0` |
| `cdbfasta` | `20191010` |
| `cellranger` | `3.0.2` |
| `clinfo` | `3.0.23` |
| `cmake` | `3.26.3` |
| `computem` | `11-jul-2021` |
| `comsol` | `5.6.0.401` |
| `conn-matlabR2024a` | `22v2407` |
| `counter` | `counter` |
| `cuda` | `11.8.0`<br>`12.4.1`<br>`13.0` |
| `cuda-opencl` | `12.4.1` |
| `cufflinks` | `2.2.1` |
| `cutadapt` | `4.9-20240729` |
| `cyrus-sasl` | `2.1.27` |
| `datamash` | `1.4` |
| `datascience` | `20200826`<br>`20201104` |
| `dataselect` | `3.22` |
| `dcm2bids` | `3.1.1`<br>`3.2.0` |
| `dcm2niix` | `1.0.20200331`<br>`1.0.20230411`<br>`15`<br>`20240416` |
| `dcmtk` | `3.6.8` |
| `dcmtk-src` | `3.6.8` |
| `deepvariant` | `0.6.1`<br>`1.1.0` |
| `diamond` | `0.8.22`<br>`0.9.10` |
| `diploshic` | `diploshic` |
| `discoal` | `0.1.4` |
| `dmtcp` | `3.1.2` |
| `dorado` | `0.8.2` |
| `duc` | `1.4.3` |
| `duohmm` | `0.1.7` |
| `dynare` | `6.0` |
| `ea-utils` | `1.04.807` |
| `eggnog-mapper` | `20250122` |
| `eigen` | `3.4.0` |
| `energyplus` | `8.9.0` |
| `exonerate` | `2.4.0` |
| `fastprongs` | `20190625` |
| `fastqc` | `0.11.5` |
| `fastsimcoal2` | `26` |
| `ffmpeg` | `6.0.0` |
| `fftw3` | `3.3.10` |
| `fix` | `1.06` |
| `flash` | `1.2.11` |
| `flexbar` | `3.0.0` |
| `fmf` | `1.5.0` |
| `fmriprep` | `23.2.0`<br>`23.2.1` |
| `freebayes` | `1.3.1` |
| `freesurfer` | `6.0.0`<br>`7.2.0`<br>`7.3.0`<br>`7.3.2`<br>`7.4.1`<br>`8.2.0` |
| `fsl` | `5.0.10`<br>`5.0.9`<br>`6.0.1`<br>`6.0.7.9`<br>`6.0.7` |
| `fsleyes` | `0.23.0` |
| `fxtract` | `fxtract` |
| `gambit_bsm` | `2.4.4-miniconda3`<br>`2.4.4` |
| `gamess` | `Jun302023R1` |
| `gamess-us` | `20180930-R3` |
| `gaussian` | `g09e01` |
| `gausssum` | `1.0.5` |
| `gcc` | `13.1.0`<br>`8.5.0` |
| `gcta` | `1.94.4` |
| `Geneious` | `Geneious` |
| `genemark` | `4.33`<br>`4.46`<br>`4.71` |
| `genomethreader` | `1.7.0`<br>`1.7.1` |
| `geos` | `3.6.2` |
| `gephi` | `0.9.2` |
| `globus` | `3.26.0` |
| `gmap-gsnap` | `2017-09-11`<br>`2025-04-19` |
| `golang` | `1.12.1`<br>`1.16.3`<br>`1.21.3`<br>`1.22.0`<br>`1.24.0` |
| `grace` | `5.1.25` |
| `gromacs` | `2019.1`<br>`2023.1`<br>`2023.4`<br>`2024.1-beta`<br>`2024.1`<br>`2024.3-plumed-2.11.0-cuda-12.4.1`<br>`2024.3-plumed-2.11.0`<br>`2024.3-plumed-2.9.3-cuda-12.4.1-pytorch` |
| `gurobi` | `9.5.1` |
| `haploview` | `4.2` |
| `hdf5` | `1.14.1`<br>`1.8.13`<br>`1.8.19` |
| `hmmer` | `3.1b2` |
| `homer` | `homer` |
| `hpcx` | `hpcx` |
| `hpl` | `hpl` |
| `hypre` | `2.28.0` |
| `ilastik` | `1.4.1` |
| `ilastik-gpu` | `1.4.1` |
| `intel-oneapi-advisor` | `2023.1.0` |
| `intel-oneapi-aitools-deeplearning` | `20240416` |
| `intel-oneapi-ccl` | `2021.9.0` |
| `intel-oneapi-compilers` | `2023.1.0` |
| `intel-oneapi-compilers-classic` | `2021.9.0` |
| `intel-oneapi-dal` | `2023.1.0` |
| `intel-oneapi-dnn` | `2023.1.0` |
| `intel-oneapi-dpct` | `2023.1.0` |
| `intel-oneapi-dpl` | `2022.1.0` |
| `intel-oneapi-inspector` | `2023.1.0` |
| `intel-oneapi-ipp` | `2021.8.0` |
| `intel-oneapi-ippcp` | `2021.7.0` |
| `intel-oneapi-itac` | `2021.8.0` |
| `intel-oneapi-mkl` | `2023.1.0` |
| `intel-oneapi-mpi` | `2021.9.0` |
| `intel-oneapi-tbb` | `2021.9.0` |
| `intel-oneapi-vpl` | `2023.1.0` |
| `intel-oneapi-vtune` | `2023.1.0` |
| `interproscan` | `5.27-66.0` |
| `ior` | `4.0.0` |
| `issm` | `4.21`<br>`4.24` |
| `itksnap` | `3.6.0` |
| `java` | `1.8.0`<br>`17.0.10` |
| `jq` | `1.6` |
| `julia` | `0.6.2`<br>`1.1.1`<br>`1.10.3`<br>`1.3.1`<br>`1.5.1`<br>`1.6.3`<br>`1.8.5` |
| `julia-singularity` | `20220318` |
| `jupyter` | `4.1.6` |
| `jupyter-datascience` | `20240801` |
| `jupyter-pymer4` | `0.7.1` |
| `krona` | `2.7` |
| `lammps` | `20220623.3` |
| `latex` | `20250228` |
| `lcmlkin` | `20200212` |
| `libconfig` | `1.7.3` |
| `libra` | `1.1.2` |
| `libvips` | `8.7.1` |
| `libxc` | `5.2.3` |
| `llava` | `1.7.0` |
| `lobster` | `5.1.1` |
| `macs3` | `3.0.3-20250717` |
| `mafft` | `7.313` |
| `maker` | `2.31.9` |
| `mango` | `4.1` |
| `Mathematica` | `11.3`<br>`12.0` |
| `matlab` | `R2016b`<br>`R2017b`<br>`R2017b_pas`<br>`R2018b`<br>`R2019b`<br>`R2020b`<br>`R2021a`<br>`R2022a`<br>`R2024a` |
| `maven` | `3.5.0` |
| `maxssmap` | `v1` |
| `merlin` | `1.1.2` |
| `mesos` | `1.9.0` |
| `metabat` | `2.12.1` |
| `mfix` | `25.3` |
| `miniconda-t2` | `20230523` |
| `miniconda3` | `20240410`<br>`20260319` |
| `miniforge3` | `20240410`<br>`20260327` |
| `mixtral` | `20240315` |
| `moose` | `20231205` |
| `moose-dev-gcc` | `20220124` |
| `mpi` | `mpi` |
| `mpi4py` | `3.0` |
| `mplus` | `demo` |
| `mptp` | `0.2.4` |
| `MRIConvert` | `2.1.0` |
| `mricrogl` | `1.2.20210624` |
| `mriqc` | `0.16.1`<br>`24.0.0-conda`<br>`24.0.0`<br>`24.0.2` |
| `mrtrix` | `3.0.4`<br>`3.0_RC3`<br>`MRtrix3Tissue` |
| `mrtrix-singularity` | `3.0_RC3` |
| `mseedindex` | `2.7.1` |
| `msolve` | `0.4.4` |
| `mujoco` | `2.2.1` |
| `muscle` | `3.8.31` |
| `namd` | `2.13-multicore` |
| `ncbi_cxx` | `17`<br>`18`<br>`21` |
| `ncview` | `2.1.11` |
| `neovim` | `0.9.1` |
| `netcdf` | `4.9.2`<br>`4.9.3-intel`<br>`4.9.3` |
| `netcdf-fortran` | `4.6.1`<br>`4.6.2-intel` |
| `ngsolve` | `6.2.2102` |
| `ngsrelate` | `v2` |
| `nipype` | `1.8.6-20240503`<br>`nipype-old`<br>`nipype` |
| `node` | `20.16.0` |
| `NonLinLoc` | `20221102` |
| `nvhpc` | `25.7`<br>`25.9` |
| `ondemand-jupyter` | `ondemand-jupyter` |
| `oneapi-level-zero` | `1.9.9` |
| `openbabel` | `3.1.1` |
| `openblas` | `0.3.23` |
| `OpenDX` | `4.4.4` |
| `openfoam` | `12` |
| `openmpi` | `4.1.5` |
| `orca` | `6.0.1`<br>`6.1.0` |
| `orfm` | `0.7.1` |
| `ovito` | `3.13.1` |
| `papi` | `5.5.1` |
| `parallel` | `20241222` |
| `paraview` | `5.11.0-RC2`<br>`5.11.0`<br>`5.13.0`<br>`5.13.1`<br>`5.7.0`<br>`5.8.1`<br>`5.9.0-RC2`<br>`5.9.0`<br>`6.0.0` |
| `pasa` | `2.3.3` |
| `pbjelly` | `15.8.24` |
| `pear` | `0.9.10` |
| `perl` | `5.24.2` |
| `pgi` | `18`<br>`19` |
| `pixi` | `0.65.0` |
| `plink` | `plink` |
| `plumed` | `2.9.2` |
| `pplacer` | `1.1` |
| `prl` | `1` |
| `proj` | `6.1.1` |
| `prosplign` | `20180810` |
| `psass` | `3.1.0-20240411`<br>`3.1.0-20240424`<br>`3.1.0` |
| `psmc` | `0.6.5` |
| `pycharm` | `2020.1.2`<br>`2022.3` |
| `pyfftw3` | `3.3.10` |
| `pylith` | `4.0.0` |
| `pymer4` | `20240321`<br>`20240410` |
| `pypi-env` | `pypi-env` |
| `pypi-packages` | `pypi-packages` |
| `python` | `2.7.18` |
| `python2` | `2.7.13`<br>`2.7.14-old`<br>`2.7.14`<br>`2.7.15`<br>`2.7.17` |
| `python3` | `3.10.13`<br>`3.11.4`<br>`3.6.1`<br>`3.6.5`<br>`3.6.7`<br>`3.6.9`<br>`3.7.5` |
| `python3-t2-test` | `3.7.5` |
| `pytorch` | `2.1.2` |
| `pytorch-refinegnn` | `20240820` |
| `pytorch-thermompnn` | `2.1.2` |
| `quantum-espresso` | `7.1` |
| `R` | `3.4.2-lcni`<br>`4.3.2`<br>`4.3.3`<br>`4.4.2` |
| `racs-spack-t2-test` | `racs-spack-t2-test` |
| `rclone` | `1.38`<br>`1.52.2`<br>`1.66.0`<br>`1.70.3` |
| `RECON` | `1.08` |
| `RepeatMasker` | `4.0.7racs1` |
| `RepeatModeler` | `1.0.10` |
| `RepeatScout` | `1.0.5` |
| `RFdiffusion1` | `RFdiffusion1` |
| `rfdiffusion2` | `20250919` |
| `ribodetector` | `0.3.1` |
| `ripser-plusplus` | `20200806` |
| `rmblastn` | `2.2.28` |
| `rosetta` | `3.14` |
| `rstudio` | `2022.07.1+554`<br>`2023.12.1+402`<br>`2024.04.1+748-condaGLIBX`<br>`2024.04.1+748-gdalgeos-20250121`<br>`2024.04.1+748`<br>`2024.09.1+394`<br>`base`<br>`rstudio-cont` |
| `rstudio-bare` | `1.3`<br>`2022.07.1+554` |
| `rstudio-server` | `2026.01.1+403` |
| `ruby` | `2.4.3` |
| `rust` | `1.82` |
| `sagemath` | `8.0` |
| `sambamba` | `0.7.0` |
| `samtools` | `1.19` |
| `skbio` | `0.6.0-20240429` |
| `slurm` | `23.11.1` |
| `smrtlink` | `5.1.0` |
| `snakemake` | `1.0.0` |
| `sortmerna` | `4.3.7` |
| `spack-rhel8` | `spack-rhel8` |
| `spades` | `3.13.0`<br>`3.15.3` |
| `specfem3d` | `20190918-devel`<br>`3.0-gpu` |
| `spines` | `1.15` |
| `stable-diffusion` | `stable-diffusion` |
| `stacks` | `2.0b`<br>`2.68` |
| `star` | `2.7.11b` |
| `stata` | `17`<br>`18` |
| `strace` | `4.26` |
| `subread` | `1.6.0`<br>`2.0.6` |
| `sw4` | `3.0.0` |
| `tau` | `2.33.2` |
| `tensorflow-relernn5` | `20240904` |
| `tensorflow` | `tensorflow` |
| `tensorflow2` | `tensorflow2` |
| `test-nbgrader` | `test-nbgrader` |
| `tiptop` | `2.3` |
| `tmux` | `3.4` |
| `transpose` | `2.0` |
| `transposonpsi` | `def` |
| `trf` | `trf` |
| `trim_galore` | `0.6.10` |
| `ucsc-userapps` | `20191024` |
| `usearch` | `11.0`<br>`8.0` |
| `vasp` | `agnelab-6.5.1`<br>`nazingroup-6.5.1`<br>`racs-6.5.1` |
| `vaspkit` | `1.5.1` |
| `vcftools` | `0.1.17` |
| `velvet` | `20240416` |
| `vmd` | `1.9.3` |
| `wannier90` | `3.1.0` |
| `wps` | `4.5` |
| `wrf` | `4.4.2` |
| `xtb` | `6.2.1` |
| `yambo` | `5.1.1` |
