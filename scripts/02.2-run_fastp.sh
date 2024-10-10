#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/fastp_output_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/fastp_error_%j.e

WORKDIR=/data/users/mbessire/assembly_annotation_course/Dog-4
OUTDIR=/data/users/mbessire/assembly_annotation_course/read_QC
REPORTDIR=/data/users/mbessire/assembly_annotation_course/read_QC/reports

# Load module
module load fastp/0.23.4-GCC-10.3.0

# Create output directories if they don't exist
mkdir -p $OUTDIR
mkdir -p $REPORTDIR

# Move to the working directory
cd $WORKDIR

# Define input and output files
INPUT="ERR11437350.fastq.gz"
OUTPUT="$OUTDIR/ERR11437350.fastq.gz"
REPORT="$REPORTDIR/fastp_genomic_report.html"

# Run fastp for single-end reads
fastp -i $INPUT -o $OUTPUT -h $REPORT
