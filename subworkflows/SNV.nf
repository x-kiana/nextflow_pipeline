#!/usr/bin/env nextflow

include { DEEPVARIANT } from "../modules/deepvariant.nf"
include { GLNEXUS } from "../modules/glnexus.nf"
include { GLNEXUS2 } from "../modules/glnexus_vcf.nf"
include { EXOMISER } from "../modules/exomiser.nf"
include { BCFNORM } from "../modules/bcftools_norm.nf"
include { IDX } from "../modules/tab_idx.nf"
include { IDX as IDX2} from "../modules/tab_idx.nf"
include { IDX as IDX3} from "../modules/tab_idx.nf"
include { BCFFILTER } from "../modules/bcftools_filter.nf"
include { NOREF } from "../modules/rm_refcalls.nf"
include { SLIVAR } from "../modules/slivar.nf"

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

    BCFNORM(GLNEXUS2.out.vcf, GLNEXUS2.out.fam)
    IDX(BCFNORM.out.vcf_norm)
    BCFFILTER(BCFNORM.out.vcf_norm, BCFNORM.out.fam)
    IDX2(BCFFILTER.out.vcf_filtered)
    NOREF(BCFFILTER.out.vcf_filtered, BCFFILTER.out.fam)
    IDX3(NOREF.out.vcf_no_ref)
    SLIVAR(NOREF.out.vcf_no_ref, NOREF.out.fam, family_ped)
}
