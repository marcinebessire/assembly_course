#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=busco
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/bucso_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/busco_%j.e

# load modules


# set variables
ASSEMBLY_HIFIASM=/data/users/mbessire/assembly_annotation_course/busco/data/users/mbessire/assembly_annotation_course/busco/hifiasm/short_summary.specific.brassicales_odb10.hifiasm.txt
ASSEMBLY_LJA=/data/users/mbessire/assembly_annotation_course/busco/data/users/mbessire/assembly_annotation_course/busco/lja
ASSEMBLY_FLYE=/data/users/mbessire/assembly_annotation_course/busco/data/users/mbessire/assembly_annotation_course/busco/flye/short_summary.specific.brassicales_odb10.flye.txt
ASSEMBLY_TRINITY=/data/users/mbessire/assembly_annotation_course/busco/data/users/mbessire/assembly_annotation_course/busco/trinity/short_summary.specific.brassicales_odb10.trinity.txt
OUT_DIR="/data/users/mbessire/assembly_annotation_course/busco/all"
CONTAINER_SIF=/containers/apptainer/busco_5.7.1.sif

# create directory if not available
mkdir -p $OUT_DIR && cd $OUT_DIR

# copy all summaries into my output directory 
cp $ASSEMBLY_FLYE .
cp $ASSEMBLY_LJA .
cp $ASSEMBLY_HIFIASM .
cp $ASSEMBLY_TRINITY .

# generate plots
apptainer exec\
 --bind $OUT_DIR\
  $CONTAINER_SIF\
  generate_plot.py -wd $OUT_DIR