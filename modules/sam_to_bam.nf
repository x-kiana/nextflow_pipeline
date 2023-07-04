#!/usr/bin/env nextflow

/* compile the sample sam into the binary bam file
 * @input: sample *.sam file
 * @input: sampleID
 * @output: sample bam file
 */

process SAMTOBAM{
   input:
   path x
   val sampleID

   output:
   path "${sampleID}.bam" 

   """
   samtools view $x -o ${sampleID}.bam
   """
}

