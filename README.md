## Simple Nextflow script to extracted mapped reads from a bam file ##

procedure:  

* extract mapped reads into derivative bam file

usage example:
```
nextflow run nf-pipelines/nf-extractmapped/main.nf -with-docker [nextflow-image] --bam [path or s3 folder uri] --outdir [path to folder or s3 folder uri]
```

