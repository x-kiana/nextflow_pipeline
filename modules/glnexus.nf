#!/usr/bin/env nextflow

/* 
 * @input: 
 * @output: 
 */

process GLNEXUS {
    input:
    path x
    path y
    path z
    val familyID

    output:
    path "${familyID}.merged.vcf.gz"
    
    script:
    """
    /mnt/common/Precision/GLNexus/glnexus_cli -c DeepVariantWGS \
        --threads ${task.cpus} \
        *gvcf.gz \
        > ${familyID}.glnexus.merged.bcf

    bcftools view ${familyID}.glnexus.merged.bcf | bgzip -c > ${familyID}.merged.vcf.gz
    """
}

