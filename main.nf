#!/usr/bin/env nextflow

include { SINGLE } from "./subworkflows/proband.nf"
include { MOTHER } from "./subworkflows/mother.nf"
include { FATHER } from "./subworkflows/father.nf"
include { GLNEXUS } from "./modules/glnexus.nf"
include { GLNEXUS2 } from "./modules/glnexus-2.nf"
include { EXOMISER } from "./modules/exomiser.nf"

workflow {
    sample_matrix = Channel.fromPath(params.sample_sheet) \
    | splitCsv(header:true) \
    | map { row -> tuple(row.FamilyID, row.SampleID, file(row.FastqR1), file(row.FastqR2)) }

    SINGLE(sample_matrix)
    gvcfs = SINGLE.out.collect()
    GLNEXUS(gvcfs[0], gvcfs[1], gvcfs[2], params.familyID) 
    GLNEXUS2(GLNEXUS.out, params.familyID)
    EXOMISER(params.exomiserConfig, GLNEXUS2.out)
}

