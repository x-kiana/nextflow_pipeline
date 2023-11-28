#!/bin/sh

#PBS -A st-sturvey-1 
#PBS -l walltime=48:00:00,select=1:ncpus=2:mem=24gb
#PBS -m abe
#PBS -M kiana.rashidi@bcchr.ca

cd $PBS_O_WORKDIR
sh create_ped.sh
source /project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Workflows/nextflow_pipeline/miniconda3/etc/profile.d/conda.sh
export NXF_HOME=$PBS_O_WORKDIR/.nextflow
export NXF_OFFLINE='TRUE'
Nextflow=/scratch/st-sturvey-1/Sandbox/nextflow_pipeline/nextflow-23.04.3-all
$Nextflow run main.nf -profile sockeye -resume -with-report -with-trace -with-timeline -with-dag pipeline_flowchart.png -work-dir /scratch/st-sturvey-3/kiana_test --sample_sheet Case6Test.tsv --seq_type WGS
#add work (-w) for separate processes

