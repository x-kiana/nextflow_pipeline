/*
 * @input:
 * @output
 */
  
process DUPREMOVED {
    input:
    path x
    val sampleID
    val familyID
 
    output:
    path "${sampleID}.dupremoved.sorted.bam", emit: dupremoved
    path "${sampleID}.dupremoved.sorted.bam.bai"

    script:
    """
    picard -Xmx64g MarkDuplicates \
	R=${params.refgenome} \
	I=$x \
	O="${sampleID}.dupremoved.sorted.bam" \
	REMOVE_DUPLICATES=false \
	M=${familyID}_${sampleID}.duplicateMetrics.txt
    samtools index ${familyID}_${sampleID}.dupremoved.sorted.bam 
    """
}
