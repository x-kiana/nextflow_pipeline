#!/usr/bin/env nextflow

/* script to normalize and separate multiallelic variants
 * TODO: is this needed in the singleton case? 
 * @input: merged vcf
 * @input: familyID
 * @output: bcftools normalized vcf
 */

process IDX {
    input:
    path x

    output:
    path "*.vcf.gz.tbi", emit: indexed
    
    script:
    """
    tabix -f $x
    """
}
