rule split_bam:
    input:
        haplotagged_bam = os.path.join(config["input_dir"], "{sample}.bam"),
        hap_list = os.path.join(config["input_dir"], "{sample}_haplotype_list.tsv")
    output:
        allelic_bams = expand("allelic_bams/{{sample}}_{allele}.bam",allele=alleles)
    params:
        h1 = "allelic_bams/{sample}_h1.bam",
        h2 = "allelic_bams/{sample}_h2.bam"
    shell: """
        whatshap split  --output-h1 {params.h1} --output-h2 {params.h2} {input.haplotagged_bam} {input.hap_list}
        """

rule namesort_bam:
    input:
        allelic_bam = "allelic_bams/{sample}_{allele}.bam"
    output:
        namesorted_bam = temp("namesorted_bams/{sample}_{allele}.bam")
    threads: 4
    shell: """
        samtools sort -n {input.allelic_bam} -o {output.namesorted_bam} -@ {threads} -m 2G
        """

rule make_reads:
    input:
        namesorted_bam = "namesorted_bams/{sample}_{allele}.bam",
    output:
        reads = "allelic_reads/{sample}_{allele}.fastq.gz"
    threads: 4
    shell: """
        samtools fastq -n -@ {threads} -0 /dev/null {input.namesorted_bam} > {output.reads}
        """
