#!/usr/bin/env nextflow

include { PROBAND } from "./subworkflows/proband.nf"
include { MOTHER } from "./subworkflows/mother.nf"
include { FATHER } from "./subworkflows/father.nf"
include { GLNEXUS } from "./modules/glnexus.nf"
include { GLNEXUS2 } from "./modules/glnexus-2.nf"
include { EXOMISER } from "./modules/exomiser.nf"

workflow {
    PROBAND()
    MOTHER()
    FATHER()
    GLNEXUS(PROBAND.out.proband_deepvariant, MOTHER.out.mother_deepvariant, FATHER.out.father_deepvariant, params.familyID) 
    GLNEXUS2(GLNEXUS.out, params.familyID)
    EXOMISER(params.exomiserConfig, params.familyPed, GLNEXUS2.out, params.probandID, params.hg38)
}

