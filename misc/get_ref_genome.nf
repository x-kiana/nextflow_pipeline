/*
 * @input:
 * @output:
 */

process REFGENOME {
    
    input:
    path x
    val y
    
   // output:
    
    script:
    """
    wget -p $x $y
    gunzip -c Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz > GRCh38-lite.fa
    
    samtools faidx GRCh38-lite.fa
    bwa index GRCh38-lite.fa
    """
}

//workflow {
//    REFGENOME(refgenomeDir, refgenomeLink)
//}
