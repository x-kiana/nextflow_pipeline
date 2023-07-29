#!/usr/bin/env nextflow

/* GLnexus process to create merged family bcf file 
 * @input: Mother gvcf
 * @input: Father gvcf
 * @input: Proband gvcf
 * @input: familyID
 * @output: merged family bcf
 */

process GLNEXUS {
    input:
    tuple path(x), val(familyID)

    output:
    tuple path("${familyID}.glnexus.merged.bcf"), val(familyID)
    
    script:
    """
#can add WGS/WES/unfiltered - fine for now
    /mnt/common/Precision/GLNexus/glnexus_cli -c DeepVariant_unfiltered \
        --threads ${task.cpus} \
        $x \
        > ${familyID}.glnexus.merged.bcf
    """
}

