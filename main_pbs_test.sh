#!/bin/sh

#PBS -A st-sturvey-1 
#PBS -l walltime=48:00:00,select=1:ncpus=2:mem=24gb
#PBS -m abe
#PBS -M kiana.rashidi@bcchr.ca

cd $PBS_O_WORKDIR
source /project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Workflows/nextflow_pipeline/miniconda3/etc/profile.d/conda.sh
export NXF_HOME=$PBS_O_WORKDIR/.nextflow
export NXF_OFFLINE='TRUE'
Nextflow=/project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Software/nextflow-23.04.3-all
$Nextflow run main.nf -profile sockeye -resume -with-report -with-trace -with-timeline -with-dag pipeline_flowchart.png 
