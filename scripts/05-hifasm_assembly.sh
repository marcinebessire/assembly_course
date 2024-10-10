#!/bin/bash

#SBATCH --time=1-00:00:00              # Time limit of 1 day
#SBATCH --mem=64G                      # Allocate 64 GB of memory
#SBATCH --cpus-per-task=32             # Allocate 32 CPUs
#SBATCH --job-name=hifiasm_assembly    # Job name
#SBATCH --partition=pibu_el8           # Partition name
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/hifiasm_assembly_output_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/hifiasm_assembly_error_%j.e

# Load the appropriate hifiasm module
module load hifiasm/0.16.1-GCCcore-10.3.0

# Set paths for the working directory and output
WORKDIR="/data/users/mbessire/assembly_annotation_course"
HIFI_READS="$WORKDIR/read_QC/ERR11437350.fastq.gz"  
OUTDIR="$WORKDIR/assemblies/hifiasm"

# Run Hifiasm assembly
hifiasm -o $OUTDIR/ERR11437350.asm -t 32 $HIFI_READS
