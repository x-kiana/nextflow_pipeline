#!/usr/bin/env nextflow

/* index the sorted bam file
 * @input: sample sorted bam file
 * @output: sample sorted bam bai file
 */

process INDEXEDBAM{

   input:
   path x

   output:
   path "${params.sampleID}.sorted.bam.bai"

   """
   samtools index $x
   """
}
