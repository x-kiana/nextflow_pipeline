#!/usr/bin/env nextflow

/* process to map reads using bwa mem
 * @input: paired-end read *.fastq files, sampleID
 * @output: .sam file for the given sample
 */

process FASTQTOSAM{
    input:
    tuple path(x), path(y), val(sampleID)
    //each mode

    output:
    path "${sampleID}.sam"

    """
    bwa mem -t $task.cpus ${params.refgenome} $x $y > ${sampleID}.sam
    """
}
