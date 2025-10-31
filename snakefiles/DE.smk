rule edgeR:
    input:
        meta_json_list = expand("oarfish_output/{sample}/aux_info/meta_info.json",sample=samples),
        bt_list = expand("oarfish_output/{sample}/aux_info/bootstrap/bootstraps.gz",sample=samples),
        quant_list = expand("oarfish_output/{sample}/quant.sf",sample=samples),
        gtf_file = "/data/repository/organisms/GRCh38_gencode_40/gencode/release-40/genes.gtf",
        sampleSheet = config["sampleSheet"]
    output: "edgeR_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_output",
        correctRTA = config["correctRTA"]
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR.Rmd"
