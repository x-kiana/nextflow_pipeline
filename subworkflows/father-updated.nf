#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { DUPREMOVED } from "../modules/dupremoved.nf"

workflow FATHER {
    FASTQTOSAM(tuple params.fatherR1, params.fatherR2, params.fatherID)
    SAMTOBAM(FASTQTOSAM.out, params.fatherID)
    SORTEDBAM(SAMTOBAM.out, params.fatherID)
    INDEXEDBAM(SORTEDBAM.out, params.fatherID)
    DUPREMOVED(INDEXEDBAM.out, params.fatherID)
    INDEXEDBAM(DUPREMOVED.out, params.fatherID) //change to fatherID.dupremoved?
    DEEPVARIANT(INDEXEDBAM.out, params.fatherID)
    emit:
    father_deepvariant = DEEPVARIANT.out.gvcf
}

