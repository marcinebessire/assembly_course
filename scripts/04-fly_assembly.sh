#!/bin/bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=fly_assembly
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/flye_assembly_output_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/flye_assembly_error_%j.e

WORKDIR="/data/users/mbessire/assembly_annotation_course"
HIFI_READS=$WORKDIR/read_QC
OUTDIR=$WORKDIR/assemblies/flye


module load Flye/2.9-GCC-10.3.0

flye --pacbio-hifi $HIFI_READS/ERR11437350.fastq.gz --out-dir $OUTDIR \
    --threads 16 --genome-size 125m