#!/usr/bin/env nextflow

/* process to map reads using bwa mem
 * @input: paired-end read *.fastq files, sampleID
 * @output: .sam file for the given sample
 */

process FASTQTOSAM{
    input:
    tuple path(x), path(y), val(sampleID), val(familyID)

    output:
    tuple path("${familyID}_${sampleID}.sam"), val(sampleID), val(familyID)

    """
    bwa mem -t $task.cpus ${params.refgenome} $x $y > ${familyID}_${sampleID}.sam
    """
}
