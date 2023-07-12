# nextflow_pipeline

This is a genetic analysis pipeline written in nextflow, to be eventually used in rare disease diagnosis. In its current state, the pipeline is capable of mapping and analayzing a family's (currently set to mother, father, and proband) raw genetic data.
The process flow consists of the following:
* Mapping and converting
  * map raw data to create the .sam files
  * convert the .sam files to binary (.bam), sort (.sorted.bam), and index (.sorted.bam.bai)
* Variant calling
  * run deepvariant on each sample to create the vcf and gvcf files
  * run GLnexus for joint variant calling (i.e. to create merged vcf)
* Variant annotation
  * run exomiser on the result from GLnexus & using a pre-written PED file in the config (soon to be changed to create the PED file in the process)

## Running on Test Data
Sample paired-end fastq files for father, mother, and proband are included in the example_data directory. You can use these to test your installation of the pipeline and tools. These files were created using various samtools command, using a script that can be found at misc/cut_region.sh.

To run the pipeline using the test files, follow the following steps:
* Unzip the files in the example_data directory using ```gunzip example_data/*```
* Open nextflow.config and edit all relevant paths to match the paths to tools and files on your environment. 
  * This is generally going to be the only part you might need to edit when you run the pipeline on other data (but it will be mostly automated in the future versions!)
* Open main.sh, and edit paths sourcing conda and nextflow, as well as the email address. 
  * If you are using a different scheduler than slurm, read the notes below to make the necessary changes before submitting the job. 
  * This is also where you can edit what options you would like to run nextflow with, or if you would like to edit any params at commandline (this can be helpful after all permanent paths are set, and you only need to change a few params)
* Submit the job to the scheduler! On slurm, this would be using ```sbatch main.sh```
* After the job has finished running (probably should take < 10 minutes), you can see the outputs from each process in the results directory. 
  * Additionally, you will see various reports produced by nextflow in your current directory. These can give you further insight on how much time and resources each process took, so that you can adjust them to the optimal level. The pipeline_flowchart.png is also a helpful resource in visualising the data flow in the pipeline.
* Now, the first step is to make sure all the processes have completed successfully 
  * On slurm, this is done by checking the .out file produced for the job which should get placed in the directory from which you submitted the job. An example is also included in the repo for reference.
* Next, to make sure you have the correct results, look at the exomiser.html file in the results directory. 
  * Since the test window provided is very small and around the variant of interest, you should see the gene ABCD1 listed as the top candidate, with the variant specifically at X-153736390-C-T. Other variants in genes ATP2B3 and PDZD4 will be listed, but these have very low scores and are only listed due to the very limited testing region.
* If all above steps work, you're ready to use this on your own data! Make sure to read the notes below before you move on.
*  If you ran into any problems, you can open an issue, and I'll do my best to help you debug. 
## Notes
* If you are using a different job scheduler than slurm, you would need to create a separate profile for it in the profiles section. You can find more info on this in the nextflow documentation.
* To run the pipeline on full genome data, remove the --regions tag in the modules/deepvariant.nf script. This will be determined using a conditional in later versions, but editing is necessary for current version (0.0.1)
* Various scripts in this repo are not included in the first release of the pipeline, as they are still under development and have not been tested.
## Future Plans
In future versions, the pipeline is going to include an install script that will help you install all the tools necessary. Additionally, more variant calling and annotating tools will be included, and submitting various workflows is going to become more automated and be done through reading a csv file. Additional profiles will be added to the pipeline to make it possible to segregate the initial testing process, as well as make it possible to use the pipeline through other schedulers.
