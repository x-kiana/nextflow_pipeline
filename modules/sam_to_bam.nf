#!/usr/bin/env nextflow

/* compile the sample sam into the binary bam file
 * @input: sample *.sam file
 * @output: sample bam file
 */

process SAMTOBAM{
   input:
   path x

   output:
   path "${params.sampleID}.bam"

   """
   samtools view $x -o ${params.sampleID}.bam
   """
}

