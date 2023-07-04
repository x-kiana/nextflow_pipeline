# nextflow_pipeline

This is a genetic analysis pipeline written in nextflow, to be eventually used in rare disease diagnosis.
In its current state, the pipeline is capable of mapping and analayzing a family's (currently set to mother, father, and proband) raw genetic data.
The process flow consists of the following:
* Mapping and converting
  * map raw data to create the .sam files
  * convert the .sam files to binary (.bam), sort (.sorted.bam), and index (.sorted.bam.bai)
* Variant calling
  * run deepvariant on each sample to create the vcf and gvcf files
  * run GLnexus for joint variant calling (i.e. to create merged vcf)
* Variant annotation
  * run exomiser on the result from GLnexus & using a pre-written PED file in the config (soon to be changed to create the PED file in the process)
