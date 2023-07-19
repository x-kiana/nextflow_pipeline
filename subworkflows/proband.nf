#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"

workflow SINGLE {
    take:
    sample_matrix
    main:
    FASTQTOSAM(tuple sample_matrix.getAt([2]), sample_matrix.getAt([3]), sample_matrix.getAt([1]), sample_matrix.getAt([0]))
    SAMTOBAM(FASTQTOSAM.out, sample_matrix.getAt([1]), sample_matrix.getAt([0]))
    SORTEDBAM(SAMTOBAM.out, sample_matrix.getAt([1]), sample_matrix.getAt([0]))
    INDEXEDBAM(SORTEDBAM.out, sample_matrix.getAt([1]), sample_matrix.getAt([0]))
    DEEPVARIANT(INDEXEDBAM.out, sample_matrix.getAt([1]), sample_matrix.getAt([0]))
    emit: 
    deepvariant = DEEPVARIANT.out.gvcf
}

