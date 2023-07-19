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
    ${params.java} -Xmx${task.memory} -jar /picard.jar MarkDuplicates \
	R=${params.refgenome} \
	I=$x \
	O=$y \
	REMOVE_DUPLICATES=false \
	M=${sampleID}.duplicateMetrics.txt
    samtools index $sampleID.dupremoved.sorted.bam 
    """
}
