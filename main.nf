#!/usr/bin/env nextflow

include { FASTQTOSAM } from "./fastq_to_sam.nf"
include { SAMTOBAM } from "./sam_to_bam.nf"
include { SORTEDBAM } from "./sorted_bam.nf"
include { INDEXEDBAM } from "./indexed_bam.nf"
include { DEEPVARIANT } from "./DeepVariant_Proband.nf"

workflow {
    DEEPVARIANT(INDEXEDBAM(SORTEDBAM(SAMTOBAM(FASTQTOSAM(channel.fromPath(params.r1), channel.fromPath(params.r2))))))
}

