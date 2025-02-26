---
layout: default
title: How-To Run AlphaFold3 on Talapas
parent: How-To Articles
nav_order: 15
---

# How-To Run Alphafold3 on Talapas

An Alphafold3 module is available on Talapas. For convenience and ease of use we have included some scripts to make running the Alphafold3 pipeline straightforward, but the containerized alphafold3 can also be run directly.

An Alphafold3 image file can be found at:

`/packages/alphafold3/3.0.0/alphafold3.sif`

This image file can be run with Apptainer/Singulatrity. For example with this command:

```bash
apptainer exec \
     --nv \
     --bind $HOME/af_input:/<UID>/af_input \
     --bind $HOME/af_output:/<UID>/af_output \
     --bind /packages/alphafold3/models:/home/<UID>/models \
     --bind /packages/alphafold3/public_databases:/home/<UID>/public_databases \
     alphafold3.sif \
     python /packages/alphafold3/3.0.0/src/run_alphafold.py \
     --json_path=<INPUT_FILE_LOCATION> \
     --model_dir=/packages/alphafold3/models \
     --db_dir=/packages/alphafold3/public_databases \
     --output_dir=<OUTPUT_LOCATION>
```

When you run `module load alphafold3/3.0.0` in the command line, some helper scripts will be added to your path. Using the `alphafold3` helper method will run the container and set the correct paths so Alphafold3 can use the public databases and model parameters centrally stored on Talapas. You will still have to supply inputs for the path to the input directory (or input json) and the desired output directory path:

```bash
alphafold3 \
    --json_path=/path/to/input_file.json \
    --output_dir=/home/<UID>/af_out/ \
    <OTHER_OPTIONS>
```
