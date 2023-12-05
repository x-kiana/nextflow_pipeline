/*
 * @input:
 * @output
 */
  
process DUPREMOVED {
    input:
    tuple path(x), val(sampleID), val(familyID)
    tuple path(y), val(sampleID), val(familyID)
 
    output:
    tuple path("${familyID}_${sampleID}.dupremoved.sorted.bam"), val(sampleID), val(familyID), emit: dupremoved
    tuple path("${familyID}_${sampleID}.dupremoved.sorted.bam.bai"), val(sampleID), val(familyID), emit: dupremoved_indexed

    script:
    """
    source ~/.bashrc
    picard -Xmx64g MarkDuplicates \
	R=${params.refgenome} \
	I=$x \
	O="${familyID}_${sampleID}.dupremoved.sorted.bam" \
	REMOVE_DUPLICATES=false \
	M=${familyID}_${sampleID}.duplicateMetrics.txt
    samtools index ${familyID}_${sampleID}.dupremoved.sorted.bam 
    """
}
