#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastqc
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mbessire/assembly_annotation_course/logs/fastqc_output_%j.o
#SBATCH --error=/data/users/mbessire/assembly_annotation_course/logs/fastqc_error_%j.e

#for Dog-4
#WORKDIR=/data/users/mbessire/assembly_annotation_course/Dog-4
#OUTDIR=/data/users/mbessire/assembly_annotation_course/read_QC
#cd $WORKDIR

#FASTQC for Dog-4
#apptainer exec \
#--bind $WORKDIR \
#--bind $OUTDIR \
#/containers/apptainer/fastqc-0.12.1.sif \
#fastqc -o $OUTDIR /data/users/mbessire/assembly_annotation_course/Dog-4/ERR11437350.fastq.gz \

#for RNA_seq
WORKDIR=/data/users/mbessire/assembly_annotation_course/RNAseq_Sha
OUTDIR=/data/users/mbessire/assembly_annotation_course/read_QC
cd $WORKDIR

#FASTQC for RNA_seq
apptainer exec \
--bind $WORKDIR \
--bind $OUTDIR \
/containers/apptainer/fastqc-0.12.1.sif \
fastqc -o $OUTDIR /data/users/mbessire/assembly_annotation_course/RNAseq_Sha/*.fastq.gz \