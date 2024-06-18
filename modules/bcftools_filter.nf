#!/usr/bin/env nextflow

/* script to soft-filter normalized vcf (allele counts + depth)
 * TODO: do these cutoffs need to be changed?
 * @input: normalized joint vcf
 * @input: family ID
 * @output: normalized filtered joint vcf
 */

process BCFFILTER {
    input:
    path normVCF
    val familyID

    output:
    path "${familyID}_bcftoolsnorm.bcftoolsfilter.vcf.gz", emit: vcf_filtered
    val familyID, emit: fam
    
    script:
    """
    bcftools filter \
    --include 'FORMAT/AD[*:1] >= 5 && FORMAT/DP[*] < 600' \
    -m + \
    -s + \
    -O z \
    --output "${familyID}_bcftoolsnorm.bcftoolsfilter.vcf.gz" \
    $normVCF
    """
}
