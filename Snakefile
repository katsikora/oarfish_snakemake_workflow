##paths
workflow_rscripts=os.path.join(workflow.basedir, "rscripts")

##config
config: "configs/config.yaml"

#org dict
org_dict = {
            "mm10" = "",
            "hg38" = ""
}

config: org_dict[config["organism"]]

##include
include: "snakefiles/make_index.smk"
include: "snakefiles/oarfish.smk"

if config["sampleSheet"]:
    include: "DE.smk"
