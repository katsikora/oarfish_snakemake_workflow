rule edgeR_transcript_allele:
    input:
        meta_json_list = expand("oarfish_output/{sample}_{allele}/aux_info/meta_info.json",sample=samples,allele=alleles),
        bt_list = expand("oarfish_output/{sample}_{allele}/aux_info/bootstrap/bootstraps.gz",sample=samples,allele=alleles),
        quant_list = expand("oarfish_output/{sample}_{allele}/quant.sf",sample=samples,allele=alleles),
        gtf_file = config["genes_gtf"],
        sampleSheet = config["sampleSheet"]
    output: "edgeR_transcript_allele_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_transcript_allele_output",
        correctRTA = config["correctRTA"]
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_transcript_allele.Rmd"


rule edgeR_transcript_allele_condition:
    input:
        meta_json_list = expand("oarfish_output/{sample}_{allele}/aux_info/meta_info.json",sample=samples,allele=alleles),
        bt_list = expand("oarfish_output/{sample}_{allele}/aux_info/bootstrap/bootstraps.gz",sample=samples,allele=alleles),
        quant_list = expand("oarfish_output/{sample}_{allele}/quant.sf",sample=samples,allele=alleles),
        gtf_file = config["genes_gtf"],
        sampleSheet = config["sampleSheet"]
    output: "edgeR_transcript_allele_condition_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_transcript_allele_condition_output",
        correctRTA = config["correctRTA"]
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_transcript_allele_condition.Rmd"

rule edgeR_gene_allele:
    input:
        meta_json_list = expand("oarfish_output/{sample}_{allele}.meta_info.json",sample=samples,allele=alleles),
        bt_list = expand("oarfish_output/{sample}_{allele}.infreps.pq",sample=samples,allele=alleles),
        quant_list = expand("oarfish_output/{sample}_{allele}/quant.sf",sample=samples,allele=alleles),
        t2g = config["t2g"]
        sampleSheet = config["sampleSheet"]
    output: "edgeR_gene_allele_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_gene_allele_output"
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_gene_allele.Rmd"


rule edgeR_gene_allele_condition:
    input:
        meta_json_list = expand("oarfish_output/{sample}_{allele}.meta_info.json",sample=samples,allele=alleles),
        bt_list = expand("oarfish_output/{sample}_{allele}.infreps.pq",sample=samples,allele=alleles),
        quant_list = expand("oarfish_output/{sample}_{allele}.quant.sf",sample=samples,allele=alleles),
        t2g = config["t2g"],
        sampleSheet = config["sampleSheet"]
    output: "edgeR_gene_allele_condition_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_gene_allele_condition_output",
        correctRTA = config["correctRTA"]
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_gene_allele_condition.Rmd"
