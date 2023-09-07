#!/bin/bash

#SBATCH --partition=defq

## Change to be your email address
#SBATCH --mail-user=kiana.rashidi@bcchr.ca
#SBATCH --mail-type=ALL

## CPU Usage
## 60 Gb of RAM for the whole job
#SBATCH --mem=160G

## Using 16 CPUs
#SBATCH --cpus-per-task=20

## Running for a max time of 48 hours
#SBATCH --time=48:00:00

## Using only a single node
#SBATCH --nodes=1

## Output and Stderr
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.error

##########
# Set up #
##########

NSLOTS=20
source  /mnt/common/Precision/Miniconda3/opt/miniconda3/etc/profile.d/conda.sh
conda  activate  GenomeAnalysis
REFGENOME=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/GRCh38-lite.fa
cd /mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline

# Dad
OUTBAM=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/father_test.bam
OUTBAM_SORTED=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/father_test.namesorted.bam
OUTFQ1=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/father_r1.fastq
OUTFQ2=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/father_r2.fastq
INBAM=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/work/cb/642d6ffa9e8d4c0e19409dfda11da3/father_nf.sorted.bam
REGION=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/misc/case6_chrX.bed

# Samtools extract subregion
samtools view -L $REGION $INBAM -b -o $OUTBAM 
samtools index $OUTBAM

# Samtools sort & index
samtools sort -n $OUTBAM -@ $NSLOTS -o $OUTBAM_SORTED

# Convert to fastq
samtools fastq \
	-@ $NSLOTS \
	-1 $OUTFQ1 -2 $OUTFQ2 \
	-0 /dev/null \
	-s /dev/null \
	-n $OUTBAM_SORTED
bgzip $OUTFQ1
bgzip $OUTFQ2
#########################3

# Mom
OUTBAM=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/mother_test.bam
OUTBAM_SORTED=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/mother_test.namesorted.bam
OUTFQ1=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/mother_r1.fastq
OUTFQ2=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/mother_r2.fastq
INBAM=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/results/mother_nf.sorted.bam

# Samtools extract subregion
samtools view -L $REGION $INBAM -b -o $OUTBAM
samtools index $OUTBAM

# Samtools sort & index
samtools sort -n $OUTBAM -@ $NSLOTS -o $OUTBAM_SORTED

# Convert to fastq
samtools fastq \
        -@ $NSLOTS \
        -1 $OUTFQ1 -2 $OUTFQ2 \
        -0 /dev/null \
        -s /dev/null \
        -n $OUTBAM_SORTED

bgzip $OUTFQ1
bgzip $OUTFQ2
######################

# Proband 
OUTBAM=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/proband_test.bam
OUTBAM_SORTED=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/proband_test.namesorted.bam
OUTFQ1=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/proband_r1.fastq
OUTFQ2=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/proband_r2.fastq
INBAM=/mnt/common/Precision/NextFlow/kiana_nextflow_pipeline/nextflow_pipeline/results/proband_nf.sorted.bam

# Samtools extract subregion
samtools view -L $REGION $INBAM -b -o $OUTBAM
samtools index $OUTBAM

# Samtools sort & index
samtools sort -n $OUTBAM -@ $NSLOTS -o $OUTBAM_SORTED

# Convert to fastq
samtools fastq \
        -@ $NSLOTS \
        -1 $OUTFQ1 -2 $OUTFQ2 \
        -0 /dev/null \
        -s /dev/null \
        -n $OUTBAM_SORTED
bgzip $OUTFQ1
bgzip $OUTFQ2
