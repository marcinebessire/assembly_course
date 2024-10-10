#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=busco
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/bucso_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/busco_%j.e

# Load the BUSCO module
module load BUSCO/5.4.2-foss-2021a

# Define lineage to use, or leave empty for auto-lineage
LINEAGE="brassicales_odb10"

# Path to the assemblies
FLYE_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/flye/assembly.fasta"
HIFIASM_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/hifiasm/ERR11437350.asm.bp.p_utg.fa"
LJA_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/LJA/assembly.fasta"
TRINITY_TRANSCRIPTOME="/data/users/mbessire/assembly_annotation_course/assemblies/trinity.Trinity.fasta"

# Define output base directory
OUTPUT_DIR="/data/users/mbessire/assembly_annotation_course/busco"

cd /data/users/mbessire/assembly_annotation_course/busco

#Run BUSCO on Flye assembly (genome mode)
#busco --in $FLYE_ASSEMBLY \
     # --out $OUTPUT_DIR/flye \
      #--mode genome \
      #--lineage $LINEAGE \
      #--cpu $SLURM_CPUS_PER_TASK

# Run BUSCO on Hifiasm assembly (genome mode)
#busco --in $HIFIASM_ASSEMBLY \
#      --out $OUTPUT_DIR/hifiasm \
#      --mode genome \
#      --lineage $LINEAGE \
#      --cpu $SLURM_CPUS_PER_TASK
    
# Run BUSCO on LJA assembly (genome mode)
#busco --in $LJA_ASSEMBLY \
#      --out $OUTPUT_DIR/lja \
#      --mode genome \
#      --lineage $LINEAGE \
#      --cpu $SLURM_CPUS_PER_TASK

#Run BUSCO on Trinity transcriptome (transcriptome mode)
busco --in $TRINITY_TRANSCRIPTOME \
      --out $OUTPUT_DIR/trinity \
      --mode transcriptome \
      --lineage $LINEAGE \
      --cpu $SLURM_CPUS_PER_TASK \
      -f
