#!/usr/bin/env nextflow

/* index the sorted bam file
 * @input: sample sorted bam file
 * @input: sampleID
 * @output: sample sorted bam bai file
 */

process INDEXEDBAM{

   input:
   tuple path(x), val(sampleID), val(familyID)

   output:
   tuple path("${familyID}_${sampleID}.sorted.bam.bai"), val(sampleID), val(familyID) 

   """
   samtools index $x
   """
}
