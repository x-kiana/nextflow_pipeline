#!/usr/bin/env nextflow

/* process to map reads using bwa mem
 * @input: paired-end read *.fastq files, sampleID
 * @output: .sam file for the given sample
 */

process FASTQTOSAM{
    input:
    tuple path(x), path(y), val(sampleID), val(familyID)
    //each mode

    output:
    path "${familyID}_${sampleID}.sam"

    """
    bwa mem -t $task.cpus ${params.refgenome} $x $y > ${familyID}_${sampleID}.sam
    """
}
