#!/bin/sh

#PBS -A st-sturvey-1 
#PBS -l walltime=24:00:00,select=1:ncpus=2:mem=24gb
#PBS -m abe
#PBS -M kiana.rashidi@bcchr.ca

sh create_ped.sh
source /project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Workflows/nextflow_pipeline/miniconda3/etc/profile.d/conda.sh
Nextflow=/project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Workflows/nextflow_pipeline/nextflow/nextflow
$Nextflow run main.nf -profile sockeye -resume -with-report -with-trace -with-timeline -with-dag pipeline_flowchart.png
#add work (-w) for separate processes
