##paths
workflow_rscripts=os.path.join(workflow.basedir, "rscripts")

##config
config: "configs/config.yaml"
print(config)
#org dict
org_dict = {
            "mm39": "organisms/mm39.yaml",
            "hg38": "organisms/hg38.yaml"
}
organism = config["organism"]

config: org_dict[organism]

#samples



##include rules
include: "snakefiles/make_index.smk"
include: "snakefiles/oarfish.smk"

if config["sampleSheet"]:
    include: "DE.smk"



#define outputs
req_files = ["index/spliced_index",
        expand("oarfish_output/{sample}.quant",sample=samples),
        expand("oarfish_output/{sample}.meta_info.json",sample=samples),
        expand("oarfish_output/{sample}.infreps.pq",sample=samples)]
if config["sampleSheet"]:
        req_files.append("edgeR_output/report.html")



rule all:
    input:
        req_files
