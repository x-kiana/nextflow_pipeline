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

    ${params.java} -Xmx40G -jar $EBROOTPICARD/picard.jar MarkDuplicates \
	R=${params.refgenome} \
	I=$x \
	O=$y \
	REMOVE_DUPLICATES=false \
	M=${sampleID}.duplicateMetrics.txt
    """
}
