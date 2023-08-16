#!/usr/bin/env nextflow

/* script to run the exomiser tool, requires PED & DeepVariant
 * @input: the exomiser config (*.yml) file
 * @input: the merged family vcf file from the glnexus
 * @output: output versions and directory specified in the config (.yml) file 
 */
// add --ped, --vcf 
//    val probandID
//    val hpoIds
/*  
 * #  sed -i "11i proband: ${probandID}"
 * #  sed -i "12i hpoIds: ${hpoIds}"
 *   sed -i "13i genomeAssembly: hg38" $x
 *   sed -i "14i vcf: ${params.wd}/results/${familyID}.merged.vcf.gz" $x
 */
process EXOMISER{
    input:
    path x
    path y
    val familyID
    
    script:
    """
    
    sed -i "10i\ \ \ \ ped: ${params.wd}/${familyID}.ped" $x
    sed -i "8i\ \ \ \ genomeAssembly: hg38" $x
    sed -i "9i\ \ \ \ vcf: ${params.wd}/results/${familyID}.merged.vcf.gz" $x
    sed -i "140i\ \ \ \ outputPrefix: ${params.wd}/${familyID}_" $x
    ${params.java} -Xmx4g -jar -Djava.io.tmpdir=$PWD ${params.exomiserDir}/${params.exomiser} \
        --analysis $x \
        --spring.config.location=${params.exomiserDir} 
    """
}
