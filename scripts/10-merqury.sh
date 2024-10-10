#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/merqury_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/merqury_%j.e

cd /data/users/mbessire/assembly_annotation_course/merqury

# Define paths to the assemblies
FLYE_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/flye/assembly_flye.fasta"
HIFIASM_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/hifiasm/ERR11437350.asm.bp.p_utg.fa"
LJA_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/LJA/assembly_lja.fasta"

DATA_DIR="/data/users/mbessire/assembly_annotation_course/Dog-4"

# Define output directories for meryl and merqury
OUT_DIR_BASE="/data/users/mbessire/assembly_annotation_course/merqury"
FLYE_OUT_DIR="$OUT_DIR_BASE/flye"
HIFIASM_OUT_DIR="$OUT_DIR_BASE/hifiasm"
LJA_OUT_DIR="$OUT_DIR_BASE/lja"

# Load necessary modules or set up environment
export MERQURY="/usr/local/share/merqury"

#Prepare meryl for Flye
#apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
    #meryl k=21 count \
    #$DATA_DIR/*.fastq.gz \
    #output $OUT_DIR_BASE/meryl

#Run merqury for Flye
cd $FLYE_OUT_DIR
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
    $MERQURY/merqury.sh \
    $OUT_DIR_BASE/meryl.meryl \
    $FLYE_ASSEMBLY \
    merqury_flye

# Run merqury for Hifiasm
cd $HIFIASM_OUT_DIR
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
    $MERQURY/merqury.sh \
    $OUT_DIR_BASE/meryl.meryl \
    $HIFIASM_ASSEMBLY \
    merqury_hifiasm

#Run merqury for LJA
cd $LJA_OUT_DIR
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
    $MERQURY/merqury.sh \
    $OUT_DIR_BASE/meryl.meryl \
    $LJA_ASSEMBLY \
    merqury_lja
