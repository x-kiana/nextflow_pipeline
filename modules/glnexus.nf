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
    path x
    path y
    path z
    val familyID

    output:
    path "${familyID}.glnexus.merged.bcf"
    
    script:
    """
    /mnt/common/Precision/GLNexus/glnexus_cli -c DeepVariant_unfiltered \
        --threads ${task.cpus} \
        $x $y $z \
        > ${familyID}.glnexus.merged.bcf
    """
}

