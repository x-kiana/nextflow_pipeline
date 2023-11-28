#!/bin/sh

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --mail-user=kiana.rashidi@bcchr.ca
#SBATCH --mail-type=ALL
#SBATCH --account=st-sturvey-1

#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.error

cd $SLURM_SUBMIT_DIR
source /project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Workflows/nextflow_pipeline/miniconda3/etc/profile.d/conda.sh
export NXF_HOME=$SLURM_SUBMIT_DIR/.nextflow
export NXF_OFFLINE='TRUE'
Nextflow=/scratch/st-sturvey-1/Sandbox/nextflow_pipeline/nextflow-23.04.3-all
$Nextflow run main.nf -profile sockeye -resume -with-report -with-trace -with-timeline -with-dag pipeline_flowchart.png --sample_sheet /scratch/st-sturvey-1/Sandbox/nextflow_pipeline/Case6Test.tsv --seq_type WGS
