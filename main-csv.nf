#!/usr/bin/env nextflow

include { FASTQTOSAM } from "./modules/fastq_to_sam_csv.nf"
include { SAMTOBAM } from "./modules/sam_to_bam_csv.nf"
include { SORTEDBAM } from "./modules/sorted_bam_csv.nf"
include { INDEXEDBAM } from "./modules/indexed_bam_csv.nf"
include { DEEPVARIANT } from "./modules/deepvariant_csv.nf"
include { GLNEXUS } from "./modules/glnexus_csv.nf"
include { GLNEXUS2 } from "./modules/glnexus-2_csv.nf"
include { EXOMISER } from "./modules/exomiser_csv.nf"

workflow {
   
    sample_matrix = Channel.fromPath(params.sample_sheet) \
                  | splitCsv(header: true, sep: '\t') \
                  | map { row -> tuple(file(row.FastqR1), file(row.FastqR2), row.SampleID, row.FamilyID) } 

    FASTQTOSAM(sample_matrix)
    SAMTOBAM(FASTQTOSAM.out)
    SORTEDBAM(SAMTOBAM.out)
    INDEXEDBAM(SORTEDBAM.out)
    DEEPVARIANT(INDEXEDBAM.out)

    family_deepvariant = DEEPVARIANT.out.collect()

    GLNEXUS(family_deepvariant, params.familyID) 
    GLNEXUS2(GLNEXUS.out)
    EXOMISER(params.exomiserConfig, GLNEXUS2.out)
}

