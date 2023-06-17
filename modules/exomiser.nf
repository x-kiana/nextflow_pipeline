#!/usr/bin/env nextflow

/* script to run the exomiser tool, requires PED & DeepVariant
 * @input: the exomiser config (*.yml) file
 * @output: no direct output
 */
 
process EXOMISER{
    input:
    path x

    """
    ${params.java} -Xmx4g -jar -Djava.io.tmpdir=$PWD ${params.exomiserDir}/${params.exomiser} \
        --analysis $x \
        --spring.config.location=${params.exomiserDir} 
    """
}

workflow {
    results_ch = EXOMISER(params.config)
}
