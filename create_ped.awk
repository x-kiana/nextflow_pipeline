NR == 1 {
    header = $0
    next
}

{
    outfile = $1 ".ped"
    if (!seen[$1]++) {
        print "#" header > outfile
    }
    print > outfile
}
