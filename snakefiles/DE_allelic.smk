rule edgeR_allele:
    input:
        meta_json_list = expand("oarfish_output/{sample}_{allele}/aux_info/meta_info.json",sample=samples,allele=alleles),
        bt_list = expand("oarfish_output/{sample}_{allele}/aux_info/bootstrap/bootstraps.gz",sample=samples,allele=alleles),
        quant_list = expand("oarfish_output/{sample}_{allele}/quant.sf",sample=samples,allele=alleles),
        gtf_file = "/data/repository/organisms/GRCh38_gencode_40/gencode/release-40/genes.gtf",
        sampleSheet = config["sampleSheet"]
    output: "edgeR_allelic_output/report.html"
    params:
        basedir = workflow.basedir,
        input_files = lambda wildcards,input: [os.path.join(workflow.basedir,x) for x in input.quant_list],
        outdir = "edgeR_allele_output"
    conda: "envs/R.yaml"
    script: "../rscripts/edgeR_allele.Rmd"


