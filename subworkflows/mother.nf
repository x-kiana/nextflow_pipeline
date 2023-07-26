#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { DUPREMOVED } from "../modules/dupremoved.nf"

workflow MOTHER {
    FASTQTOSAM(tuple params.motherR1, params.motherR2, params.motherID, params.familyID)
    SAMTOBAM(FASTQTOSAM.out, params.motherID, params.familyID)
    SORTEDBAM(SAMTOBAM.out, params.motherID, params.familyID)
    INDEXEDBAM(SORTEDBAM.out, params.motherID, params.familyID)
    DUPREMOVED(INDEXEDBAM.out, params.probandID, params.familyID)
    DEEPVARIANT(DUPREMOVED.out.dupremoved, params.motherID, params.familyID)
    emit: 
    mother_deepvariant = DEEPVARIANT.out.gvcf
}
