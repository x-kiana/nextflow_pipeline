#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"

workflow PROBAND {
    FASTQTOSAM(tuple params.probandR1, params.probandR2, params.probandID)
    SAMTOBAM(FASTQTOSAM.out, params.probandID)
    SORTEDBAM(SAMTOBAM.out, params.probandID)
    INDEXEDBAM(SORTEDBAM.out, params.probandID)
    DEEPVARIANT(INDEXEDBAM.out, params.probandID)
    emit: 
    proband_deepvariant = DEEPVARIANT.out.gvcf
}

