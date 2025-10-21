This is a snakemake workflow covering index generation as well as quantitation of ONT cDNA data with oarfish, as well as differential expression analysis with dowstream tools.
Inputs to index generation are a genome fasta file and an annotation gtf file. Inputs to oarfish quantification are the transcriptome index file, as well as fastq files.
For the allele-specific mode, inputs are an aligned bam file and a phased vcf or a haplotagged bam file.
