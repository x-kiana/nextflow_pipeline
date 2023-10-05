cut DH5759.tsv -f1-7 > PedSampleSheet.tsv
awk -f create_ped.awk PedSampleSheet.tsv
