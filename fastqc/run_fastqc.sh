#!/bin/bash

# set locale environment variables to prevent (in case of any) Perl warnings
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# define the input directory where your *.fastq files are being stored
data_dir="your R1/R2 input directory"

# define the output directory for FastQC results
output_dir="your output directory"

# ensure the output directory exists
mkdir -p "$output_dir"

# loop through each *.fastq.gz file in the input directory
for file in "$data_dir"/*.fastq.gz; do
    # extract the filename from the path
    filename=$(basename "$file")

    # echo the processing message
    echo "Processing the file [$filename]."

    # run FastQC on the current file using Singularity
    singularity run -B "$data_dir":/data -B "$output_dir":/output /path-to-.sif-file/fastqc_v0.11.9_cv8.sif fastqc /data/"$filename" -o /output
done
