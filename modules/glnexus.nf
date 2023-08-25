#!/usr/bin/env nextflow

/* GLnexus process to create merged family bcf file 
 * @input: Mother gvcf
 * @input: Father gvcf
 * @input: Proband gvcf
 * @input: familyID
 * @output: merged family bcf
 *#can add WGS/WES/unfiltered - fine for now
 */

process GLNEXUS {
    input:
    tuple path(x), val(familyID)

    output:
    tuple path("${familyID}.glnexus.merged.bcf"), val(familyID)
    
    script:
    """
    glnexus_cli -c DeepVariant_unfiltered \
        --threads ${task.cpus} \
        $x \
        > ${familyID}.glnexus.merged.bcf
    """
}

