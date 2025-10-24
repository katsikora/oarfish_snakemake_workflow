rule edgeR:
    input:
        meta_json_list = expand("oarfish_output/{sample}/aux_info/meta_info.json",sample=samples),
        pq_list = expand("oarfish_output/{sample}.infreps.pq",sample=samples),
        quant_list = expand("oarfish_output/{sample}/quant.sf",sample=samples),
        gtf_file = "/data/repository/organisms/GRCh38_gencode_40/gencode/release-40/genes.gtf",
        sampleSheet = config["sampleSheet"]
    output: "edgeR_output/report.html"
    params:
        input_dirs = expand(workflow.source_path("/oarfish_output/{sample}"),sample=samples)
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR.Rmd"
