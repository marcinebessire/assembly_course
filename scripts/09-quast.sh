#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=quast
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/quast_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/quast_%j.e

# Define paths to the assemblies
FLYE_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/flye/assembly.fasta"
HIFIASM_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/hifiasm/ERR11437350.asm.bp.p_utg.fa"
LJA_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/LJA/assembly.fasta"

# Define paths to the Arabidopsis thaliana reference genome and annotation
REFERENCE_GENOME="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
REFERENCE_ANNOTATION="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

# Define output base directory
OUTPUT_DIR="/data/users/mbessire/assembly_annotation_course/quast"

# Define the Quast container path
QUAST_CONTAINER="/containers/apptainer/quast_5.2.0.sif"

# Run QUAST without a reference for Flye, Hifiasm, and LJA assemblies
apptainer exec --bind /data $QUAST_CONTAINER quast.py $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY \
  --eukaryote \
  --est-ref-size 135000000 \
  --threads $SLURM_CPUS_PER_TASK \
  --labels flye,hifiasm,lja \
  --large \
  --output-dir $OUTPUT_DIR/no_reference

# Run QUAST with a reference for Flye, Hifiasm, and LJA assemblies
apptainer exec --bind /data $QUAST_CONTAINER quast.py $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY \
  --eukaryote \
  --est-ref-size 135000000 \
  --threads $SLURM_CPUS_PER_TASK \
  --labels flye,hifiasm,lja \
  --large \
  --reference $REFERENCE_GENOME \
  --features $REFERENCE_ANNOTATION \
  --output-dir $OUTPUT_DIR/with_reference
