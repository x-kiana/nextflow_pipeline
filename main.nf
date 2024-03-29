#!/usr/bin/env nextflow

include { CREATE_PED } from "./modules/create_ped.nf"
include { SNV } from "./subworkflows/SNV.nf"
include { SV } from "./subworkflows/SV.nf"
include { mapping } from "./subworkflows/mapping.nf"

workflow {
    CREATE_PED(params.sample_sheet, params.ped_script)

    sample_matrix = Channel.fromPath(params.sample_sheet) \
                  | splitCsv(header: true, sep: '\t') \
                  | map { row -> tuple(file(row.FastqR1), file(row.FastqR2), row.SampleID, row.FamilyID) }

    mapping(sample_matrix)
    SV(mapping.out.dupremoved, mapping.out.indexed)
    SNV(mapping.out.dupremoved, CREATE_PED.out.family_ped)
}

