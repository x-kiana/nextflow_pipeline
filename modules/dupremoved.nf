/*
 * @input:
 * @output
 */
  
process DUPREMOVED {
    input:
    path x
    val sampleID
 
    output:
    path "${sampleID}.dupremoved.sorted.bam"
    path "${sampleID}.dupremoved.sorted.bam.bai"

    script:
    """
    source /cm/shared/BCCHR-apps/env_vars/unset_BCM.sh
    source /cvmfs/soft.computecanada.ca/config/profile/bash.sh
    module load picard
#//load picard from container in file:///mnt/common/SILENT/Act3/singularity/gatk4-4.2.0.sif
#"""
    ${params.java} -Xmx${task.memory} -jar $EBROOTPICARD/picard.jar MarkDuplicates \
	R=${params.refgenome} \
	I=$x \
	O=$y \
	REMOVE_DUPLICATES=false \
	M=${sampleID}.duplicateMetrics.txt
    #add indexing here
    #remove the non-dupremoved bam
    """
}
