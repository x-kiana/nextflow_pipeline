#!/usr/bin/env nextflow

/* sort the bam file
 * @input: sample bam file
 * @output: sample sorted bam file
 */

process SORTEDBAM{

   input:
   path x

   output:
   path "${params.sampleID}.sorted.bam"

   """
   samtools sort $x -o ${params.sampleID}.sorted.bam
   """
}

