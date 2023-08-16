#!/usr/bin/env nextflow

/* compile the sample sam into the binary bam file
 * @input: sample *.sam file
 * @input: sampleID
 * @output: sample bam file
 */

process SAMTOBAM{
   input:
   tuple path(x), val(sampleID), val(familyID)

   output:
   tuple path("${familyID}_${sampleID}.bam"), val(sampleID), val(familyID)
//add multithreading
   """
   samtools view $x -o ${familyID}_${sampleID}.bam
   #add rm $x after adding condition to check for bam 
   """
}

