#!/bin/sh

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --mail-user=kiana.rashidi@bcchr.ca
#SBATCH --mail-type=ALL

#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.error

source /home/BCRICWH.LAN/kiana.rashidi/miniconda3/etc/profile.d/conda.sh 
module load singularity
Nextflow=/mnt/common/Precision/NextFlow/June2023/nextflow
$Nextflow run main.nf --probandID 'Proband_nf_2' --motherID 'Mother_nf_2' --fatherID 'Father_nf_2' --familyID 'Family_nf_2' -profile gpcc
