rule edgeR_transcript:
    input:
        meta_json_list = expand("oarfish_output/{sample}/aux_info/meta_info.json",sample=samples),
        bt_list = expand("oarfish_output/{sample}/aux_info/bootstrap/bootstraps.gz",sample=samples),
        quant_list = expand("oarfish_output/{sample}/quant.sf",sample=samples),
        gtf_file = config["genes_gtf"],
        sampleSheet = config["sampleSheet"]
    output: "edgeR_transcript_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_transcript_output",
        correctRTA = config["correctRTA"]
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_transcript.Rmd"


rule edgeR_gene:
    input:
        meta_json_list = expand("oarfish_output/{sample}.meta_info.json",sample=samples),
        bt_list = expand("oarfish_output/{sample}.infreps.pq",sample=samples),
        quant_list = expand("oarfish_output/{sample}.quant",sample=samples),
        #gtf_file = config["genes_gtf"],
        t2g = config["t2g"],
        sampleSheet = config["sampleSheet"]
    output: "edgeR_gene_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_gene_output" #,
        #correctRTA = config["correctRTA"]
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_gene.Rmd"
