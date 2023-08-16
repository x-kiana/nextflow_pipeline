#!/usr/bin/env nextflow

/* Process to turn merged bcf file into a merged vcf
 * @input: merged family bcf file
 * @input: familyID
 * @output: merged family vcf file
 */

process GLNEXUS2 {
    input:
    tuple path(x), val(familyID)

    output:
    path "${familyID}.merged.vcf.gz", emit: vcf
    val familyID, emit: fam
    
    script:
    """
    bcftools view $x | bgzip -c > ${familyID}.merged.vcf.gz
    """
}

