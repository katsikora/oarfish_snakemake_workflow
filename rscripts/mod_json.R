library(jsonlite)

meta_json_list<-snakemake@input[["meta_json_list"]]
exons_fasta<-snakemake@input[["exons_fasta"]]
woutdir<-snakemake@params[["woutdir"]]

#list files
#dirs<-dir("/data/processing/bioinfo-core/oarfish_output",pattern="*.meta_info.json",full.names=TRUE)

nt<-as.numeric(system(paste0('grep -c \'>\' ',exons_fasta),intern=TRUE))

mod_json<-function(j_file){
  sample<-gsub(".meta_info.json","",basename(j_file))
  meta<-jsonlite::fromJSON(j_file)
  meta$num_targets<-nt
  meta$samp_type<-"bootstrap"
  outdir<-file.path(woutdir,sample,"aux_info")
  system(paste0('mkdir -p ',outdir))
  write_json(meta,file.path(outdir,"meta_info.json"), pretty = TRUE)
  message(sprintf('Done sample %s',sample))
}


lapply(meta_json_list,mod_json)
