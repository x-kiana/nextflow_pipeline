#!/usr/bin/env nextflow

/* 
 * @input: 
 * @input:
 * @output: 
 */
process CREATE_PED {
    input:
    path x
    path y
    
    output:
    path "PedSampleSheet.tsv"
    path "*.ped", emit: family_ped

    script:
    """
    cut $x -f1-7 > PedSampleSheet.tsv
    awk -f $y PedSampleSheet.tsv
    """
}
