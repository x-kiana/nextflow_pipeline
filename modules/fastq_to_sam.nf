#!/usr/bin/env nextflow

/* process to map reads using bwa mem
 * @input: paired-end read *.fastq files, sampleID
 * @output: .sam file for the given sample
 */

process FASTQTOSAM{
    beforeScript = 'source /project/st-sturvey-1/PrecisionHealthVirtualEnvironment/Workflows/nextflow_pipeline/miniconda3/etc/profile.d/conda.sh'

    input:
    tuple path(x), path(y), val(sampleID), val(familyID)

    output:
    tuple path("${familyID}_${sampleID}.sam"), val(sampleID), val(familyID)

    """
    bwa mem -t $task.cpus ${params.refgenome} $x $y > ${familyID}_${sampleID}.sam
    """
}
