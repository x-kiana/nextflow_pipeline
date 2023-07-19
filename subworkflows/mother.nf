#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"

workflow MOTHER {
    take:
    fastq1
    fastq2
    sampleID
    familyID
    main:
    FASTQTOSAM(tuple fastq1, fastq2, sampleID, familyID)
    SAMTOBAM(FASTQTOSAM.out, sampleID, familyID)
    SORTEDBAM(SAMTOBAM.out, sampleID, familyID)
    INDEXEDBAM(SORTEDBAM.out, sampleID, familyID)
    DEEPVARIANT(INDEXEDBAM.out, sampleID, familyID)
    emit:
    mother_deepvariant = DEEPVARIANT.out.gvcf
}

