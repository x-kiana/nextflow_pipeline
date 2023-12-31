#!/usr/bin/env nextflow

/* process to run the DeepVariant tool through a singularity container
 * use --regions to specify a certain region
 * @input: result of the samtools indexing process
           the input is a measure to make sure the files needed by the
           process are created before the process is run
 * @input: sample ID
 * @output: the sample vcf
 * @output: the sample gvcf
 * add WGS and WES to params
 */

process DEEPVARIANT{
    input:
    path x
    val sampleID
    
    output:
    path "${sampleID}_DeepVariant.vcf.gz"
    path "${sampleID}_DeepVariant.gvcf.gz", emit: gvcf 

    script:
    """
    /opt/deepvariant/bin/run_deepvariant \
      --intermediate_results_dir="${params.wd}/intermediate_results_dir/${sampleID}" \
    --model_type=WGS \
    --ref="${params.refgenome}" \
    --reads="${params.wd}/results/${sampleID}.sorted.bam" \
    --output_vcf="${sampleID}_DeepVariant.vcf.gz" \
    --output_gvcf="${sampleID}_DeepVariant.gvcf.gz" \
    --num_shards="${task.cpus}" \
    --regions "${params.region}" \
    --sample_name="${sampleID}"
    """
}

