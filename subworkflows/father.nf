#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { DUPREMOVED } from "../modules/dupremoved.nf"

workflow FATHER{
    FASTQTOSAM(tuple params.fatherR1, params.fatherR2, params.fatherID, params.familyID)
    SAMTOBAM(FASTQTOSAM.out, params.fatherID, params.familyID)
    SORTEDBAM(SAMTOBAM.out, params.fatherID, params.familyID)
    INDEXEDBAM(SORTEDBAM.out, params.fatherID, params.familyID)
    DUPREMOVED(INDEXEDBAM.out, params.probandID, params.familyID)
    DEEPVARIANT(DUPREMOVED.out.dupremoved, params.fatherID, params.familyID)
    emit: 
    father_deepvariant = DEEPVARIANT.out.gvcf
}
