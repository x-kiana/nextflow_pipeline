#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { DUPREMOVED } from "../modules/dupremoved.nf"

workflow PROBAND {
    FASTQTOSAM(tuple params.probandR1, params.probandR2, params.probandID, params.familyID)
    SAMTOBAM(FASTQTOSAM.out, params.probandID, params.familyID)
    SORTEDBAM(SAMTOBAM.out, params.probandID, params.familyID)
    INDEXEDBAM(SORTEDBAM.out, params.probandID, params.familyID)
    DUPREMOVED(INDEXEDBAM.out, params.probandID, params.familyID)
    DEEPVARIANT(DUPREMOVED.out.dupremoved, params.probandID, params.familyID)
    emit: 
    proband_deepvariant = DEEPVARIANT.out.gvcf
}
