#!/bin/sh

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --mail-user=kiana.rashidi@bcchr.ca
#SBATCH --mail-type=ALL

#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.error

module load singularity
Nextflow=/mnt/common/Precision/NextFlow/June2023/nextflow
$Nextflow run modules/exomiser.nf
