---
layout: default
title: Available Packages
nav_order: 1
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

See the [How-to Use LMOD]({%link docs/how-to_articles/how-to_use_lmod.md %}) page for more details on using [LMOD](https://lmod.readthedocs.io/en/latest/010_user.html).

## Available Software Packages


| Module Name | Module Versions/Variants |
|:------------|:---------------------|
| `Geneious` | `Geneious` |
| `MRIConvert` | `MRIConvert/2.1.0` |
| `Mathematica` | `Mathematica/11.3`<br>`Mathematica/12.0` |
| `NonLinLoc` | `NonLinLoc/20221102` |
| `OpenDX` | `OpenDX/4.4.4` |
| `R` | `R/3.4.2-lcni`<br>`R/4.3.2`<br>`R/4.3.3`<br>`R/4.4.2` |
| `RECON` | `RECON/1.08` |
| `RFdiffusion1` | `RFdiffusion1/RFdiffusion1` |
| `RepeatMasker` | `RepeatMasker/4.0.7racs1` |
| `RepeatModeler` | `RepeatModeler/1.0.10` |
| `RepeatScout` | `RepeatScout/1.0.5` |
| `adapterremoval` | `adapterremoval/2.1.7`<br>`adapterremoval/2.3.3` |
| `afni` | `afni/24.1.22` |
| `alphafold3` | `alphafold3/3.0.0` |
| `amber` | `amber/22` |
| `ancestry_hmm` | `ancestry_hmm/0.92-old`<br>`ancestry_hmm/0.92` |
| `angsd` | `angsd/0.941-22-gc877e7f` |
| `ansible` | `ansible/9.3.0` |
| `ants` | `ants/2.1.0`<br>`ants/2.5.1`<br>`ants/2.5.2` |
| `aocc` | `aocc/4.0.0`<br>`aocc/5.0.0` |
| `aocl` | `aocl/4.2.0`<br>`aocl/5.0.0` |
| `arcs` | `arcs/1.0.3` |
| `argweaver` | `argweaver/0.8.1` |
| `armadillo` | `armadillo/12.2.0` |
| `aspect` | `aspect/3.1.0` |
| `augustus` | `augustus/3.3.2` |
| `awscli` | `awscli/2.22.5` |
| `bamm` | `bamm/2.5.0` |
| `bamtools` | `bamtools/2.4`<br>`bamtools/2.5.1` |
| `bayestraits` | `bayestraits/3.0.2` |
| `bbmap` | `bbmap/38.16`<br>`bbmap/39.06` |
| `bcftools` | `bcftools/1.18`<br>`bcftools/1.19` |
| `beagle` | `beagle/5.4` |
| `bedops` | `bedops/2.4.41` |
| `bedtools` | `bedtools/2.25.0` |
| `bgc` | `bgc/1.0.3-patched`<br>`bgc/1.0.3` |
| `bgchm` | `bgchm/1.0.0` |
| `blast` | `blast/2.2.29+`<br>`blast/2.14.1+` |
| `bowtie2` | `bowtie2/2.3.3`<br>`bowtie2/2.4.4` |
| `brainiak` | `brainiak/20240412` |
| `braker` | `braker/2.0`<br>`braker/2.1.0`<br>`braker/2.1.3-WIP-20190826` |
| `breseq` | `breseq/0.31.0` |
| `bwa` | `bwa/0.7.17` |
| `cactus` | `cactus/2.8.1` |
| `casa` | `casa/6.7.0` |
| `cdbfasta` | `cdbfasta/20191010` |
| `cellranger` | `cellranger/3.0.2` |
| `clinfo` | `clinfo/3.0.23` |
| `cmake` | `cmake/3.26.3` |
| `computem` | `computem/11-jul-2021` |
| `comsol` | `comsol/5.6.0.401` |
| `counter` | `counter` |
| `cuda` | `cuda/11.8.0`<br>`cuda/12.4.1` |
| `cuda-opencl` | `cuda-opencl/12.4.1` |
| `cufflinks` | `cufflinks/2.2.1` |
| `cutadapt` | `cutadapt/4.9-20240729` |
| `cyrus-sasl` | `cyrus-sasl/2.1.27` |
| `datamash` | `datamash/1.4` |
| `datascience` | `datascience/20200826`<br>`datascience/20201104` |
| `dataselect` | `dataselect/3.22` |
| `dcm2bids` | `dcm2bids/3.1.1`<br>`dcm2bids/3.2.0` |
| `dcm2niix` | `dcm2niix/1.0.20200331`<br>`dcm2niix/1.0.20230411`<br>`dcm2niix/15`<br>`dcm2niix/20240416` |
| `dcmtk` | `dcmtk/3.6.8` |
| `dcmtk-src` | `dcmtk-src/3.6.8` |
| `deepvariant` | `deepvariant/0.6.1`<br>`deepvariant/1.1.0` |
| `diamond` | `diamond/0.8.22`<br>`diamond/0.9.10` |
| `diploshic` | `diploshic` |
| `discoal` | `discoal/0.1.4` |
| `dmtcp` | `dmtcp/3.1.2` |
| `dorado` | `dorado/0.8.2` |
| `duc` | `duc/1.4.3` |
| `duohmm` | `duohmm/0.1.7` |
| `dynare` | `dynare/6.0` |
| `ea-utils` | `ea-utils/1.04.807` |
| `eggnog-mapper` | `eggnog-mapper/20250122` |
| `eigen` | `eigen/3.4.0` |
| `energyplus` | `energyplus/8.9.0` |
| `exonerate` | `exonerate/2.4.0` |
| `fastprongs` | `fastprongs/20190625` |
| `fastqc` | `fastqc/0.11.5` |
| `fastsimcoal2` | `fastsimcoal2/26` |
| `ffmpeg` | `ffmpeg/6.0.0` |
| `fftw3` | `fftw3/3.3.10` |
| `fix` | `fix/1.06` |
| `flash` | `flash/1.2.11` |
| `flexbar` | `flexbar/3.0.0` |
| `fmf` | `fmf/1.5.0` |
| `fmriprep` | `fmriprep/23.2.0`<br>`fmriprep/23.2.1` |
| `freebayes` | `freebayes/1.3.1` |
| `freesurfer` | `freesurfer/6.0.0`<br>`freesurfer/7.2.0`<br>`freesurfer/7.3.0`<br>`freesurfer/7.3.2`<br>`freesurfer/7.4.1` |
| `fsl` | `fsl/5.0.9`<br>`fsl/5.0.10`<br>`fsl/6.0.1`<br>`fsl/6.0.7`<br>`fsl/6.0.7.9` |
| `fsleyes` | `fsleyes/0.23.0` |
| `fxtract` | `fxtract` |
| `gambit_bsm` | `gambit_bsm/2.4.4-miniconda3`<br>`gambit_bsm/2.4.4` |
| `gamess` | `gamess/Jun302023R1` |
| `gamess-us` | `gamess-us/20180930-R3` |
| `gaussian` | `gaussian/g09e01` |
| `gcc` | `gcc/8.5.0`<br>`gcc/13.1.0` |
| `gcta` | `gcta/1.94.4` |
| `genemark` | `genemark/4.33`<br>`genemark/4.46`<br>`genemark/4.71` |
| `genomethreader` | `genomethreader/1.7.0`<br>`genomethreader/1.7.1` |
| `geos` | `geos/3.6.2` |
| `gephi` | `gephi/0.9.2` |
| `globus` | `globus/3.26.0` |
| `gmap-gsnap` | `gmap-gsnap/2017-09-11`<br>`gmap-gsnap/2025-04-19` |
| `golang` | `golang/1.12.1`<br>`golang/1.16.3`<br>`golang/1.21.3`<br>`golang/1.22.0`<br>`golang/1.24.0` |
| `grace` | `grace/5.1.25` |
| `gromacs` | `gromacs/2019.1`<br>`gromacs/2023.1`<br>`gromacs/2023.4`<br>`gromacs/2024.1`<br>`gromacs/2024.3-plumed-2.9.3-cuda-12.4.1-pytorch`<br>`gromacs/2024.3-plumed-2.11.0-cuda-12.4.1`<br>`gromacs/2024.3-plumed-2.11.0` |
| `gurobi` | `gurobi/9.5.1` |
| `haploview` | `haploview/4.2` |
| `hdf5` | `hdf5/1.8.13`<br>`hdf5/1.8.19`<br>`hdf5/1.14.1` |
| `hmmer` | `hmmer/3.1b2` |
| `homer` | `homer` |
| `hpcx` | `hpcx/v1.8.0-ompi-v2.x`<br>`hpcx/v1.8.0-stack` |
| `hypre` | `hypre/2.28.0` |
| `intel-oneapi-advisor` | `intel-oneapi-advisor/2023.1.0` |
| `intel-oneapi-aitools-deeplearning` | `intel-oneapi-aitools-deeplearning/20240416` |
| `Intel AI Tools` | `Deep Learning. https://www.intel.com/content/www/us/en/developer/tools/oneapi/ai-tools-selector.html` |
| `intel-oneapi-ccl` | `intel-oneapi-ccl/2021.9.0` |
| `intel-oneapi-compilers` | `intel-oneapi-compilers/2023.1.0` |
| `intel-oneapi-compilers-classic` | `intel-oneapi-compilers-classic/2021.9.0` |
| `intel-oneapi-dal` | `intel-oneapi-dal/2023.1.0` |
| `intel-oneapi-dnn` | `intel-oneapi-dnn/2023.1.0` |
| `intel-oneapi-dpct` | `intel-oneapi-dpct/2023.1.0` |
| `intel-oneapi-dpl` | `intel-oneapi-dpl/2022.1.0` |
| `intel-oneapi-inspector` | `intel-oneapi-inspector/2023.1.0` |
| `intel-oneapi-ipp` | `intel-oneapi-ipp/2021.8.0` |
| `intel-oneapi-ippcp` | `intel-oneapi-ippcp/2021.7.0` |
| `intel-oneapi-itac` | `intel-oneapi-itac/2021.8.0` |
| `intel-oneapi-mkl` | `intel-oneapi-mkl/2023.1.0` |
| `intel-oneapi-mpi` | `intel-oneapi-mpi/2021.9.0` |
| `intel-oneapi-tbb` | `intel-oneapi-tbb/2021.9.0` |
| `intel-oneapi-vpl` | `intel-oneapi-vpl/2023.1.0` |
| `intel-oneapi-vtune` | `intel-oneapi-vtune/2023.1.0` |
| `interproscan` | `interproscan/5.27-66.0` |
| `issm` | `issm/4.21`<br>`issm/4.24` |
| `itksnap` | `itksnap/3.6.0` |
| `java` | `java/1.8.0`<br>`java/17.0.10` |
| `jq` | `jq/1.6` |
| `julia` | `julia/0.6.2`<br>`julia/1.1.1`<br>`julia/1.3.1`<br>`julia/1.5.1`<br>`julia/1.6.3`<br>`julia/1.8.5`<br>`julia/1.10.3` |
| `julia-singularity` | `julia-singularity/20220318` |
| `jupyter` | `jupyter/4.1.6` |
| `jupyter-datascience` | `jupyter-datascience/20240801` |
| `jupyter-pymer4` | `jupyter-pymer4/0.7.1` |
| `krona` | `krona/2.7` |
| `lammps` | `lammps/20220623.3` |
| `latex` | `latex/20250228` |
| `lcmlkin` | `lcmlkin/20200212` |
| `libconfig` | `libconfig/1.7.3` |
| `libra` | `libra/1.1.2` |
| `libvips` | `libvips/8.7.1` |
| `libxc` | `libxc/5.2.3` |
| `llava` | `llava/1.7.0` |
| `lmod` | `lmod` |
| `Lmod` | `An Environment Module System` |
| `lobster` | `lobster/5.1.1` |
| `macs3` | `macs3/3.0.3-20250717` |
| `mafft` | `mafft/7.313` |
| `maker` | `maker/2.31.9` |
| `mango` | `mango/4.1` |
| `matlab` | `matlab/R2016b`<br>`matlab/R2017b_pas`<br>`matlab/R2017b`<br>`matlab/R2018b`<br>`matlab/R2019b`<br>`matlab/R2020b`<br>`matlab/R2021a`<br>`matlab/R2022a`<br>`matlab/R2024a` |
| `maven` | `maven/3.5.0` |
| `maxssmap` | `maxssmap/v1` |
| `merlin` | `merlin/1.1.2` |
| `mesos` | `mesos/1.9.0` |
| `metabat` | `metabat/2.12.1` |
| `mfix` | `mfix/23.2`<br>`mfix/24.1.1` |
| `miniconda-t2` | `miniconda-t2/20230523` |
| `miniconda3` | `miniconda3/20240410` |
| `miniforge3` | `miniforge3/20240410` |
| `mixtral` | `mixtral/20240315` |
| `moose` | `moose/20231205` |
| `moose-dev-gcc` | `moose-dev-gcc/20220124` |
| `mpi/aocc/5.0.0/openmpi` | `mpi/aocc/5.0.0/openmpi/4.1.6` |
| `mpi/gcc/13.1.0/mpich` | `mpi/gcc/13.1.0/mpich/4.1.1` |
| `mpi/gcc/13.1.0/openmpi` | `mpi/gcc/13.1.0/openmpi/4.1.6` |
| `mpi/gcc/8.5.0/mpich` | `mpi/gcc/8.5.0/mpich/4.1.1` |
| `mpi4py` | `mpi4py/3.0` |
| `mpich` | `mpich/4.1.1` |
| `mplus` | `mplus/demo` |
| `mptp` | `mptp/0.2.4` |
| `mricrogl` | `mricrogl/1.2.20210624` |
| `mriqc` | `mriqc/0.16.1`<br>`mriqc/24.0.0-conda`<br>`mriqc/24.0.0`<br>`mriqc/24.0.2` |
| `mrtrix` | `mrtrix/MRtrix3Tissue`<br>`mrtrix/3.0_RC3`<br>`mrtrix/3.0.4` |
| `mrtrix-singularity` | `mrtrix-singularity/3.0_RC3` |
| `mseedindex` | `mseedindex/2.7.1` |
| `msolve` | `msolve/0.4.4` |
| `mujoco` | `mujoco/2.2.1` |
| `muscle` | `muscle/3.8.31` |
| `namd` | `namd/2.13-multicore` |
| `ncbi_cxx` | `ncbi_cxx/17`<br>`ncbi_cxx/18`<br>`ncbi_cxx/21` |
| `ncview` | `ncview/2.1.11` |
| `neovim` | `neovim/0.9.1` |
| `netcdf` | `netcdf/4.9.2`<br>`netcdf/4.9.3-intel`<br>`netcdf/4.9.3` |
| `netcdf-fortran` | `netcdf-fortran/4.6.1`<br>`netcdf-fortran/4.6.2-intel` |
| `ngsolve` | `ngsolve/6.2.2102` |
| `ngsrelate` | `ngsrelate/v2` |
| `nipype` | `nipype/nipype-old`<br>`nipype/nipype`<br>`nipype/1.8.6-20240503` |
| `node` | `node/20.16.0` |
| `nvhpc` | `nvhpc/22.2`<br>`nvhpc/25.7` |
| `ondemand-jupyter` | `ondemand-jupyter` |
| `oneapi-level-zero` | `oneapi-level-zero/1.9.9` |
| `openbabel` | `openbabel/3.1.1` |
| `openblas` | `openblas/0.3.23` |
| `openfoam` | `openfoam/12` |
| `openmpi` | `openmpi/2.1`<br>`openmpi/3.1`<br>`openmpi/4.1.5`<br>`openmpi/4.1.6` |
| `orca` | `orca/6.0.1`<br>`orca/6.1.0` |
| `orfm` | `orfm/0.7.1` |
| `ovito` | `ovito/3.13.1` |
| `papi` | `papi/5.5.1` |
| `parallel` | `parallel/20241222` |
| `paraview` | `paraview/5.7.0`<br>`paraview/5.8.1`<br>`paraview/5.9.0-RC2`<br>`paraview/5.9.0`<br>`paraview/5.11.0-RC2`<br>`paraview/5.11.0`<br>`paraview/5.13.0`<br>`paraview/5.13.1`<br>`paraview/6.0.0` |
| `pasa` | `pasa/2.3.3` |
| `pbjelly` | `pbjelly/15.8.24` |
| `pear` | `pear/0.9.10` |
| `perl` | `perl/5.24.2` |
| `pgi` | `pgi/18`<br>`pgi/19` |
| `plink` | `plink` |
| `plumed` | `plumed/2.9.2` |
| `pplacer` | `pplacer/1.1` |
| `prl` | `prl/1` |
| `proj` | `proj/6.1.1` |
| `prosplign` | `prosplign/20180810` |
| `psass` | `psass/3.1.0`<br>`psass/3.1.0-20240411`<br>`psass/3.1.0-20240424` |
| `psmc` | `psmc/0.6.5` |
| `pycharm` | `pycharm/2020.1.2`<br>`pycharm/2022.3` |
| `pyfftw3` | `pyfftw3/3.3.10` |
| `pylith` | `pylith/4.0.0` |
| `pymer4` | `pymer4/20240321`<br>`pymer4/20240410` |
| `pypi-env` | `pypi-env/pypi-env` |
| `pypi-packages` | `pypi-packages/pypi-packages` |
| `python` | `python/2.7.18` |
| `python2` | `python2/2.7.13`<br>`python2/2.7.14-old`<br>`python2/2.7.14`<br>`python2/2.7.15`<br>`python2/2.7.17` |
| `python3` | `python3/3.6.1`<br>`python3/3.6.5`<br>`python3/3.6.7`<br>`python3/3.6.9`<br>`python3/3.7.5`<br>`python3/3.10.13`<br>`python3/3.11.4` |
| `python3-t2-test` | `python3-t2-test/3.7.5` |
| `pytorch` | `pytorch/2.1.2` |
| `pytorch-refinegnn` | `pytorch-refinegnn/20240820` |
| `pytorch-thermompnn` | `pytorch-thermompnn/2.1.2` |
| `quantum-espresso` | `quantum-espresso/7.1` |
| `racs-spack-t2-test` | `racs-spack-t2-test` |
| `rclone` | `rclone/1.38`<br>`rclone/1.52.2`<br>`rclone/1.66.0`<br>`rclone/1.70.3` |
| `rfdiffusion2` | `rfdiffusion2/20250919` |
| `ribodetector` | `ribodetector/0.3.1` |
| `ripser-plusplus` | `ripser-plusplus/20200806` |
| `rmblastn` | `rmblastn/2.2.28` |
| `rosetta` | `rosetta/3.14` |
| `rstudio` | `rstudio/base`<br>`rstudio/rstudio-cont`<br>`rstudio/2022.07.1+554`<br>`rstudio/2023.12.1+402`<br>`rstudio/2024.04.1+748-condaGLIBX`<br>`rstudio/2024.04.1+748-gdalgeos-20250121`<br>`rstudio/2024.04.1+748`<br>`...` |
| `rstudio-bare` | `rstudio-bare/1.3`<br>`rstudio-bare/2022.07.1+554` |
| `ruby` | `ruby/2.4.3` |
| `rust` | `rust/1.82` |
| `sagemath` | `sagemath/8.0` |
| `sambamba` | `sambamba/0.7.0` |
| `samtools` | `samtools/1.19` |
| `settarg` | `settarg` |
| `skbio` | `skbio/0.6.0-20240429` |
| `slurm` | `slurm/23.11.1` |
| `smrtlink` | `smrtlink/5.1.0` |
| `snakemake` | `snakemake/1.0.0` |
| `sortmerna` | `sortmerna/4.3.7` |
| `spack-rhel8` | `spack-rhel8` |
| `spades` | `spades/3.13.0`<br>`spades/3.15.3` |
| `specfem3d` | `specfem3d/3.0-gpu`<br>`specfem3d/20190918-devel` |
| `spines` | `spines/1.15` |
| `stable-diffusion` | `stable-diffusion/stable-diffusion` |
| `stacks` | `stacks/2.0b`<br>`stacks/2.68` |
| `star` | `star/2.7.11b` |
| `stata` | `stata/17`<br>`stata/18` |
| `strace` | `strace/4.26` |
| `subread` | `subread/1.6.0`<br>`subread/2.0.6` |
| `sw4` | `sw4/3.0.0` |
| `tau` | `tau/2.33.2` |
| `tensorflow` | `tensorflow` |
| `tensorflow-relernn5` | `tensorflow-relernn5/20240904` |
| `tensorflow2` | `tensorflow2` |
| `test-nbgrader` | `test-nbgrader` |
| `tiptop` | `tiptop/2.3` |
| `tmux` | `tmux/3.4` |
| `transpose` | `transpose/2.0` |
| `transposonpsi` | `transposonpsi/def` |
| `trf` | `trf` |
| `trim_galore` | `trim_galore/0.6.10` |
| `ucsc-userapps` | `ucsc-userapps/20191024` |
| `usearch` | `usearch/8.0`<br>`usearch/11.0` |
| `vasp` | `vasp/agnelab-6.5.1`<br>`vasp/nazingroup-6.5.1`<br>`vasp/racs-6.5.1` |
| `vaspkit` | `vaspkit/1.5.1` |
| `vcftools` | `vcftools/0.1.17` |
| `velvet` | `velvet/20240416` |
| `vmd` | `vmd/1.9.3` |
| `wannier90` | `wannier90/3.1.0` |
| `wps` | `wps/4.5` |
| `wrf` | `wrf/4.4.2` |
| `xtb` | `xtb/6.2.1` |
| `yambo` | `yambo/5.1.1` |
