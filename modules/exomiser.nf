#!/usr/bin/env nextflow

/* script to run the exomiser tool, requires PED & DeepVariant
 * @input: the exomiser config (*.yml) file
 * @input: the merged family vcf file from the glnexus
 * @output: output versions and directory specified in the config (.yml) file 
 */
// add --ped, --vcf 
process EXOMISER{
    input:
    path x
    path y
    path z
    val probandID
    val hg38

    script:
    """
    ${params.java} -Xmx4g -jar -Djava.io.tmpdir=$PWD ${params.exomiserDir}/${params.exomiser} \
        --analysis $x \
        --assembly $hg38 \
        --proband ${params.probandID} \
        --ped $y \
        --vcf $z \
        --spring.config.location=${params.exomiserDir} 
    """
}
