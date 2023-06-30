#!/usr/bin/env nextflow

include { PROBAND } from "./subworkflows/proband.nf"
include { MOTHER } from "./subworkflows/mother.nf"
include { FATHER } from "./subworkflows/father.nf"
include { GLNEXUS } from "./modules/glnexus.nf"
include { EXOMISER } from "./modules/exomiser.nf"
include { REFGENOME } from "./modules/get_ref_genome.nf"

workflow {
    REFGENOME(params.refgenomeDir, params.refgenomeLink)
    PROBAND()
    MOTHER()
    FATHER()
    GLNEXUS(PROBAND.out.proband_deepvariant, MOTHER.out.mother_deepvariant, FATHER.out.father_deepvariant, params.familyID) 
    EXOMISER(params.exomiserConfig, GLNEXUS.out)
}

