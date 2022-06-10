#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/*  Process an input file
 *  usage example:
 *    nextflow run nf-pipelines/nf-extractmapped/main.nf -with-docker [nextflow-image] --bam [path or s3 folder uri] --outdir [path to folder or s3 folder uri]
 *        
 */ 

params.bam = ''
params.outdir = 'results'

process extract_mapped {
    container '829680141244.dkr.ecr.us-west-1.amazonaws.com/artemys-biocontainers/sarekbase'
    publishDir "$params.outdir"  
    
    input:
      path bamfile

    output:
      path "${bamfile.baseName}_mapped.bam"

    script:
      println "processing bamfile: " + bamfile
      """
      samtools view -b -F4 $bamfile > "${bamfile.baseName}_mapped.bam"
      """
}

process printpassed {
    container '829680141244.dkr.ecr.us-west-1.amazonaws.com/artemys-biocontainers/sarekbase'
    
    input:
      path inputfile

    script:
      println "path passed: " + inputfile
      """
      echo "done"
      """
}

workflow {
    bamfile = channel.from(params.bam)
    extract_mapped(bamfile)
    extract_mapped.out.view{ it }
    printpassed(extract_mapped.out.collect())
}
