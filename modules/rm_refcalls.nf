#!/usr/bin/env nextflow

/* script to remove refcalls from vcf 
 * TODO: would it be better to do this first? 
 * @input: normalized filtered joint vcf
 * @input: family ID
 * @output: no refcall vcf
 */

process NOREF {
    input:
    path vcf
    val familyID

    output:
    path "${familyID}_bcftoolsnorm.bcftoolsfilter.NoRefCall.vcf.gz", emit: vcf_no_ref
    val familyID, emit: fam
    
    script:
    """
    zgrep -v "RefCall" $vcf | bgzip -c > ${familyID}_bcftoolsnorm.bcftoolsfilter.NoRefCall.vcf.gz
    """
}
