#!/usr/bin/env nextflow

/* script to normalize and separate multiallelic variants
 * TODO: is this needed in the singleton case? 
 * @input: merged vcf
 * @input: familyID
 * @output: bcftools normalized vcf
 */

process BCFNORM{
    input:
    path x
    val familyID

    output:
    path "${familyID}_bcftoolsnorm.vcf.gz", emit: vcf_norm 
    val familyID, emit: fam
    
    script:
    """
    bcftools norm \
    -f ${params.refgenome} \
    --threads 8 \
    -m - \
    -O z \
    --output "${familyID}_bcftoolsnorm.vcf.gz" \
    $x
    """
}
