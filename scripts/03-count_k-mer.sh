#!/usr/bin/env bash

#SBATCH --time=1-00:00:00              # Set the max running time
#SBATCH --mem=40G                      
#SBATCH --cpus-per-task=4              # Use 4 threads
#SBATCH --job-name=kmer_counting       # Job name
#SBATCH --partition=pibu_el8           # Partition name
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/kmer_output_%j.o  # Output log file
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/kmer_error_%j.e    # Error log file

# Set working directories
WORKDIR=/data/users/mbessire/assembly_annotation_course/Dog-4
OUTDIR=/data/users/mbessire/assembly_annotation_course/kmer_output
HISTODIR=/data/users/mbessire/assembly_annotation_course/kmer_output/histogram

# Load Jellyfish module
module load Jellyfish/2.3.0-GCC-10.3.0

# Create output directories if they don't exist
mkdir -p $OUTDIR
mkdir -p $HISTODIR

# Move to the working directory
cd $WORKDIR

# Perform k-mer counting using process substitution for the paired-end compressed FASTQ files
jellyfish count \
  -C \
  -m 21 \
  -s 5G \
  -t 4 \
  <(zcat ERR11437350.fastq.gz) \
  -o $OUTDIR/dog_reads.jf

# Generate k-mer histogram
jellyfish histo \
  -t 4 \
  $OUTDIR/dog_reads.jf > $HISTODIR/dog_reads.histo


