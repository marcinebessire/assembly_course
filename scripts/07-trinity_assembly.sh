#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity_asmbly
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/trinity_assembly_output_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/trinity_assembly_error_%j.e 
#SBATCH --partition=pibu_el8


# Set paths to input data and output directory
WORKDIR="/data/users/mbessire/assembly_annotation_course"
HIFI_READS="$WORKDIR/read_QC/ERR11437350.fastq.gz" 
SHADIR="$WORKDIR/read_QC/RNA_processed"
OUTDIR="$WORKDIR/assemblies/trinity"

module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --left $SHADIR/ERR754081_1.fastq.gz --right $SHADIR/ERR754081_2.fastq.gz \
        --CPU 32 --max_memory 60G --output $OUTDIR