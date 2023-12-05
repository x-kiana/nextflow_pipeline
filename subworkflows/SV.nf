#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DUPREMOVED } from "../modules/dupremoved.nf"
include { EXPANSION } from "../modules/expansion_hunter.nf"

workflow SV {
    take:
    sample_matrix

    main:
    FASTQTOSAM(sample_matrix)
    SAMTOBAM(FASTQTOSAM.out)
    SORTEDBAM(SAMTOBAM.out)
    INDEXEDBAM(SORTEDBAM.out)
    DUPREMOVED(SORTEDBAM.out, INDEXEDBAM.out)
    EXPANSION(DUPREMOVED.out.dupremoved, DUPREMOVED.out.dupremoved_indexed)
}
