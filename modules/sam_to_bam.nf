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
   val familyID

   output:
   path "${familyID}_${sampleID}.bam" 

   """
   samtools view $x -o ${familyID}_${sampleID}.bam
   #add rm $x after adding condition to check for bam 
   """
}

