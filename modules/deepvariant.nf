#!/usr/bin/env nextflow

/* process to run the DeepVariant tool through a singularity container
 * @input: takes the result of the samtools indexing process as input
           the input is a measure to make sure the files needed by the
           process are created before the process is run
 * @output: no direct output, instead specified by the --output_vcf tag
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
    --sample_name="${sampleID}"
    """
}

