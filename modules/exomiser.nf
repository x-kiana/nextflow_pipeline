#!/usr/bin/env nextflow

/* script to run the exomiser tool, requires PED & DeepVariant
 * @input: the exomiser config (*.yml) file
 * @input: the merged family vcf file from the glnexus
 * @output: no direct output
 */
// add --ped, --vcf 
process EXOMISER{
    input:
    path x
    path y

    """
    ${params.java} -Xmx4g -jar -Djava.io.tmpdir=$PWD ${params.exomiserDir}/${params.exomiser} \
        --analysis $x \
        --spring.config.location=${params.exomiserDir} 
    """
}
