#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"

workflow MOTHER {
    FASTQTOSAM(tuple params.motherR1, params.motherR2, params.motherID)
    SAMTOBAM(FASTQTOSAM.out, params.motherID)
    SORTEDBAM(SAMTOBAM.out, params.motherID)
    INDEXEDBAM(SORTEDBAM.out, params.motherID)
    DEEPVARIANT(INDEXEDBAM.out, params.motherID)
    emit:
    mother_deepvariant = DEEPVARIANT.out.gvcf
}

