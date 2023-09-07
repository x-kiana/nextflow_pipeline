#!/usr/bin/env nextflow

/* sort the bam file
 * @input: sample bam file
 * @input: sampleID
 * @output: sample sorted bam file
 */

process SORTEDBAM{

   input:
   tuple path(x), val(sampleID), val(familyID)

   output:
   tuple path("${familyID}_${sampleID}.sorted.bam"), val(sampleID), val(familyID)

   """
   samtools sort $x -o ${familyID}_${sampleID}.sorted.bam
   """
}

