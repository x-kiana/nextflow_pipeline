#!/usr/bin/env nextflow

include { SNV } from "./subworkflows/SNV.nf"

workflow {
    sample_matrix = Channel.fromPath(params.sample_sheet) \
                  | splitCsv(header: true, sep: '\t') \
                  | map { row -> tuple(file(row.FastqR1), file(row.FastqR2), row.SampleID, row.FamilyID) } 

    SNV(sample_matrix)
}

