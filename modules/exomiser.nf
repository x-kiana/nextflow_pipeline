#!/usr/bin/env nextflow

/* script to run the exomiser tool, requires PED & DeepVariant
 * @input: the exomiser config (*.yml) file
 * @input: family id from glnexus
 * @output: output versions and directory specified in the config (.yml) file 
 */
process EXOMISER{
    input:
    path x
    val familyID
    
    script:
    """
    PROBAND="\$(awk 'NR==2' ${params.wd}/${familyID}.ped | cut -f2)"
    HPO="\$(awk 'NR==2' ${params.wd}/${familyID}.ped | cut -f7)"

    sed -i "s|hpo_ids|\${HPO}|g" $x
    sed -i "s|proband_id|\${PROBAND}|g" $x
    sed -i 's|input_ped|${params.wd}/${familyID}.ped|g' $x
    sed -i 's|assembly|hg38|g' $x
    sed -i 's|input_vcf|${params.wd}/results/${familyID}.merged.vcf.gz|g' $x
    sed -i 's|output_prefix|${params.wd}/results/${familyID}_exomiser|g' $x
    ${params.java} -Xmx4g -jar -Djava.io.tmpdir=$PWD ${params.exomiserDir}/${params.exomiser} \
        --analysis $x \
        --spring.config.location=${params.exomiserDir} 
    """
}
