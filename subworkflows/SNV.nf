#!/usr/bin/env nextflow

include { FASTQTOSAM } from "../modules/fastq_to_sam.nf"
include { SAMTOBAM } from "../modules/sam_to_bam.nf"
include { SORTEDBAM } from "../modules/sorted_bam.nf"
include { INDEXEDBAM } from "../modules/indexed_bam.nf"
include { DUPREMOVED } from "../modules/dupremoved.nf"
include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { GLNEXUS } from "../modules/glnexus.nf"
include { GLNEXUS2 } from "../modules/glnexus-2.nf"
include { EXOMISER } from "../modules/exomiser.nf"

workflow SNV {
    take:
    sample_matrix

    main:
    FASTQTOSAM(sample_matrix)
    SAMTOBAM(FASTQTOSAM.out)
    SORTEDBAM(SAMTOBAM.out)
    INDEXEDBAM(SORTEDBAM.out)
    DUPREMOVED(SORTEDBAM.out, INDEXEDBAM.out)
    DEEPVARIANT(DUPREMOVED.out.dupremoved)

    family_deepvariant = DEEPVARIANT.out.gvcf.groupTuple(by: 1)

    GLNEXUS(family_deepvariant) 
    GLNEXUS2(GLNEXUS.out)
    EXOMISER(params.exomiserTestConfig, GLNEXUS2.out.fam)
}
