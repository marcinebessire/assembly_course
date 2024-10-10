#!/bin/bash

#SBATCH --time=1-00:00:00              # Time limit of 1 day
#SBATCH --mem=64G                      # Allocate 64 GB of memory
#SBATCH --cpus-per-task=32             # Allocate 32 CPUs
#SBATCH --job-name=comparing_genomes    # Job name
#SBATCH --partition=pibu_el8           # Partition name
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/comparing_genomes_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/comparing_genomes_%j.e

cd /data/users/mbessire/assembly_annotation_course/nucmer_mummer

# Define paths to the assemblies
FLYE_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/flye/assembly_flye.fasta"
HIFIASM_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/hifiasm/ERR11437350.asm.bp.p_utg.fa"
LJA_ASSEMBLY="/data/users/mbessire/assembly_annotation_course/assemblies/LJA/assembly_lja.fasta"

# Define paths to the Arabidopsis thaliana reference genome and annotation
REF_GENOME="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

OUT_DIR="/data/users/mbessire/assembly_annotation_course/nucmer_mummer"

#Step 1: Run nucmer for each assembly vs reference genome
#fly
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix="$OUT_DIR/flye_vs_ref" --breaklen=1000 --mincluster=1000 "$REF_GENOME" "$FLYE_ASSEMBLY"

#hifiasm
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix="$OUT_DIR/hifiasm_vs_ref" --breaklen=1000 --mincluster=1000 "$REF_GENOME" "$HIFIASM_ASSEMBLY"

#lja
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix="$OUT_DIR/lja_vs_ref" --breaklen=1000 --mincluster=1000 "$REF_GENOME" "$LJA_ASSEMBLY"

#STEP 2: generate dot plot (mummer)
#fly
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R "$REF_GENOME" -Q "$FLYE_ASSEMBLY" --filter -t png --large --layout --fat \
    "$OUT_DIR/flye_vs_ref.delta" -p "$OUT_DIR/flye_vs_ref"

#hifiasm
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R "$REF_GENOME" -Q "$HIFIASM_ASSEMBLY" --filter -t png --large --layout --fat \
    "$OUT_DIR/hifiasm_vs_ref.delta" -p "$OUT_DIR/hifiasm_vs_ref"

#lja 
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R "$REF_GENOME" -Q "$LJA_ASSEMBLY" --filter -t png --large --layout --fat \
    "$OUT_DIR/lja_vs_ref.delta" -p "$OUT_DIR/lja_vs_ref"

#Step 3: Pairwise comparisons between assemblies
#fly vs hifiasm(nucmer)
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix="$OUT_DIR/flye_vs_hifiasm" --breaklen=1000 --mincluster=1000 "$FLYE_ASSEMBLY" "$HIFIASM_ASSEMBLY"

#fly vs hifiasm(mummer)
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R "$FLYE_ASSEMBLY" -Q "$HIFIASM_ASSEMBLY" --filter -t png --large --layout --fat \
    "$OUT_DIR/flye_vs_hifiasm.delta" -p "$OUT_DIR/flye_vs_hifiasm"

#fly vs lja(nucmer)
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix="$OUT_DIR/flye_vs_lja" --breaklen=1000 --mincluster=1000 "$FLYE_ASSEMBLY" "$LJA_ASSEMBLY"

#fly vs lja(mummer)
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R "$FLYE_ASSEMBLY" -Q "$LJA_ASSEMBLY" --filter -t png --large --layout --fat \
    "$OUT_DIR/flye_vs_lja.delta" -p "$OUT_DIR/flye_vs_lja"

#hifiasm vs lja(nucmer)
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix="$OUT_DIR/hifiasm_vs_lja" --breaklen=1000 --mincluster=1000 "$HIFIASM_ASSEMBLY" "$LJA_ASSEMBLY"

#hifiasmvs lja (mummer)
apptainer exec --bind /data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R "$HIFIASM_ASSEMBLY" -Q "$LJA_ASSEMBLY" --filter -t png --large --layout --fat \
    "$OUT_DIR/hifiasm_vs_lja.delta" -p "$OUT_DIR/hifiasm_vs_lja"