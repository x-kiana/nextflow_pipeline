#!/usr/bin/env nextflow

include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { GLNEXUS } from "../modules/glnexus.nf"
include { GLNEXUS2 } from "../modules/glnexus_vcf.nf"
include { EXOMISER } from "../modules/exomiser.nf"

workflow SNV {
    take:
    dupremoved
    family_ped

    main:
    DEEPVARIANT(dupremoved)

    family_deepvariant = DEEPVARIANT.out.gvcf.groupTuple(by: 1)

    GLNEXUS(family_deepvariant) 
    GLNEXUS2(GLNEXUS.out)
    EXOMISER(params.exomiserTestConfig, GLNEXUS2.out.fam, family_ped)
}
