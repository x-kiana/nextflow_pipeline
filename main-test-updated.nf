#!/usr/bin/env nextflow

include { PROBAND } from "./subworkflows/proband-updated.nf"
include { MOTHER } from "./subworkflows/mother-updated.nf"
include { FATHER } from "./subworkflows/father-updated.nf"
include { GLNEXUS } from "./modules/glnexus.nf"
include { GLNEXUS2 } from "./modules/glnexus-2.nf"
include { EXOMISER } from "./modules/exomiser.nf"
include { REFGENOME } from "./modules/get_ref_genome.nf"

workflow {
    PROBAND()
    MOTHER()
    FATHER()
    GLNEXUS(PROBAND.out.proband_deepvariant, MOTHER.out.mother_deepvariant, FATHER.out.father_deepvariant, params.familyID) 
    GLNEXUS2(GLNEXUS.out, params.familyID)
    EXOMISER(params.exomiserConfig, GLNEXUS2.out)
}

