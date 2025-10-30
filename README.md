This is a snakemake workflow covering index generation as well as quantitation of ONT cDNA data with oarfish, as well as differential expression analysis with dowstream tools.
Inputs to index generation are a genome fasta file and an annotation gtf file. Inputs to oarfish quantification are the transcriptome index file, as well as fastq files.
For the allele-specific mode, input is a bam file and a phased vcf file.

To create the conda environment for running the workflow, run:
```
conda env create -f env.yaml
```

To run the workflow, run:
```
conda activate oarfish_snakemake_env
snakemake -j 1 --use-envmodules --use-conda

```

The workflow is currently configured to run locally.
