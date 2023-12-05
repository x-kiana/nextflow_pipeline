#!/usr/bin/env nextflow

include { CREATE_PED } from "./modules/create_ped.nf"
include { SNV } from "./subworkflows/SNV.nf"
include { SV } from "./subworkflows/SV.nf"

workflow {
    CREATE_PED(params.sample_sheet, params.ped_script)

    sample_matrix = Channel.fromPath(params.sample_sheet) \
                  | splitCsv(header: true, sep: '\t') \
                  | map { row -> tuple(file(row.FastqR1), file(row.FastqR2), row.SampleID, row.FamilyID) } 
    
    SV(sample_matrix)
    SNV(sample_matrix, CREATE_PED.out.family_ped)
}

