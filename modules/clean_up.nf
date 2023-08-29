#!/usr/bin/env nextflow

/* remove given file (for removing unsorted, raw, etc. files)  
 * @input: file to be removed
 * @output: no output
 */

process CLEANUP{
   input:
   path x

   """
   rm x
   """
}

