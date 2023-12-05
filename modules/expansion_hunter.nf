#!/usr/bin/env nextflow

/* process to run expansion hunter on sorted indexed bam files 
 * @input: result of the dupremoved process
 * @input: sample ID
 * @output: the sample vcf
 */

process EXPANSION{
    input:
    tuple path(x), val(sampleID), val(familyID)
    tuple path(y), val(sampleID), val(familyID)
    
    script:
    """
    ${params.expansion_hunter} --reads $x \
                               --reference ${params.refgenome} \
                               --variant-catalog ${params.variant_catalog} \
                               --output-prefix ${params.wd}/results/${familyID}_${sampleID}_ExpansionHunter
    """
}

