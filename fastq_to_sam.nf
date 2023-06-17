#!/usr/bin/env nextflow

/* process to map reads using bwa mem
 * @input: paired-end read *.fastq files
 * @output: .sam file for the given sample
 */

process FASTQTOSAM{
    input:
    path x
    path y

    output:
    path "${params.sampleID}.sam"

    """
    bwa mem ${params.refgenome} $x $y > ${params.sampleID}.sam
    """
}
