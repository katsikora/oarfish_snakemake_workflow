import os
import yaml
#from snakemake.utils import glob_wildcards

##paths

workflow_rscripts=os.path.join(workflow.basedir, "rscripts")

##config
# 1. Load your initial static config into a temporary Python variable.
with open("configs/config.yaml", "r") as f:
    main_config = yaml.safe_load(f)
#2. Use the temporary variable to dynamically determine the path of the second config.
organism_config_path = os.path.join("organisms", f"{main_config['organism']}.yaml")
#3. Load the second config file into another temporary variable.
with open(organism_config_path, "r") as f:
    organism_config = yaml.safe_load(f)
# 4. Merge the second config into the first, using the temporary variables.
main_config.update(organism_config)
# 5. Assign the final, merged dictionary to the global `config` object.
config = main_config
print("Full merged config:", config)
#samples
# --- Read input path from config ---
# # Use the config variable to build the glob pattern
input_path = os.path.join(config['input_dir'], "{sample}_fastq.gz")
samples = glob_wildcards(input_path).sample
#
# # Print the extracted sample names to confirm it works
print("Found sample names:", samples)


##include rules
include: "snakefiles/make_index.smk"
include: "snakefiles/oarfish.smk"

if config["sampleSheet"]:
    include: "snakefiles/DE.smk"



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
