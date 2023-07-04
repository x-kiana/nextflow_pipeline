#!/usr/bin/env nextflow

/* sort the bam file
 * @input: sample bam file
 * @input: sampleID
 * @output: sample sorted bam file
 */

process SORTEDBAM{

   input:
   path x
   val sampleID

   output:
   path "${sampleID}.sorted.bam"

   """
   samtools sort $x -o ${sampleID}.sorted.bam
   """
}

