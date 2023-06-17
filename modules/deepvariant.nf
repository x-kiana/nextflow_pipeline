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
    
    script:
    """
    /opt/deepvariant/bin/run_deepvariant \
      --intermediate_results_dir="${params.wd}/intermediate_results_dir" \
    --model_type=WGS \
    --ref="${params.refgenome}" \
    --reads="${params.wd}/results/${params.sampleID}.sorted.bam" \
    --output_vcf="${params.wd}/${params.sampleID}_DeepVariant.vcf.gz" \
    --regions "${params.regions}" \
    --num_shards="${task.cpus}"
    """
}

