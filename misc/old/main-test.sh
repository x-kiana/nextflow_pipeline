#!/bin/sh

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --mail-user=kiana.rashidi@bcchr.ca
#SBATCH --mail-type=ALL

#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.error

source /home/BCRICWH.LAN/kiana.rashidi/miniconda3/etc/profile.d/conda.sh 
module load singularity
Nextflow=/mnt/common/Precision/NextFlow/June2023/nextflow
$Nextflow run main.nf -resume -profile gpcc -params-file params.yml -with-report -with-trace -with-timeline -with-dag pipeline_flowchart_test.png
#add work (-w) for separate processes
