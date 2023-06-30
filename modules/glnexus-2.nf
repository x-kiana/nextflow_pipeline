#!/usr/bin/env nextflow

/* 
 * @input: 
 * @output: 
 */

process GLNEXUS2 {
    input:
    path x
    val familyID

    output:
    path "${familyID}.merged.vcf.gz"
    
    script:
    """
    bcftools view $x | bgzip -c > ${familyID}.merged.vcf.gz
    """
}

