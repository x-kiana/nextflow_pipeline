#!/usr/bin/env nextflow

include { EXPANSION } from "../modules/expansion_hunter.nf"

workflow SV {
    take:
    dupremoved
    indexed 

    main:
    EXPANSION(dupremoved, indexed)
}
