rule exon_fasta:
    input:
        genome_fasta = config["genome_fasta"],
        genes_gtf = config["genes_gtf"]
    output: "index/spliced.fa"
    envmodules: "gffread/0.12.7"
    shell: """
          gffread -w {output} -g {input.genome_fasta} {input.genes_gtf}
          """

rule index_fasta:
    input: "index/spliced.fa"
    output: "index/spliced_index"
    envmodules: "oarfish/0.9.0"
    threads: 16
    shell: """
        oarfish --seq-tech ont-cdna --only-index --index-out {output} --annotated {input} -j {threads}
           """
