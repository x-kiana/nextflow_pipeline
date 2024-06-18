#!/usr/bin/env nextflow

/* script to filter out common variants using slivar
 * @input: no refcall vcf 
 * @input: family ID
 * @output: slivar rare vcf
 */

process SLIVAR{
    input:
    path no_ref_vcf
    val familyID
    path familyPed
    
    output:
    path "${familyID}_bcftoolsnorm.bcftoolsfilter.NoRefCall.slivarrare.vcf.gz", emit: slivar_vcf
    val familyID, emit: fam

    shell:
    $/
    !{params.slivar_exe} expr \
    --vcf $no_ref_vcf \
    --ped $familyPed \
    --pass-only \
    -g !{params.slivar_gnomad} \
    --info "INFO.gnomad_popmax_af < !{params.af_cutoff} && INFO.gnomad_nhomalt < !{params.hom_alt_cutoff} && variant.FILTER == \"PASS\" && variant.ALT[0] != \"*\"" \
    --js !{params.slivar_js} \
    -o "!{familyID}_bcftoolsnorm.bcftoolsfilter.NoRefCall.slivarrare.vcf.gz" 
    /$
}
