#!/bin/bash

#SBATCH --job-name=lja_assembly         
#SBATCH --time=1-00:00:00               
#SBATCH --mem=64G                       
#SBATCH --cpus-per-task=32   
#SBATCH --partition=pibu_el8                   
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/lja_assembly_output_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/lja_assembly_error_%j.e   

# Set paths to input data and output directory
WORKDIR="/data/users/mbessire/assembly_annotation_course"
HIFI_READS="$WORKDIR/read_QC/ERR11437350.fastq.gz" 
OUTDIR="$WORKDIR/assemblies/LJA"

#Run LJA with PacBio HiFi reads
apptainer exec \
    --bind /data \
    --bind $OUTDIR \
    /containers/apptainer/lja-0.2.sif \
    lja -o $OUTDIR --reads $HIFI_READS --threads 32
    
