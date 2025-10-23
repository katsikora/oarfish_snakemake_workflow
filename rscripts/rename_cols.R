library(data.table)


quant_list <- snakemake@input[["quant_list"]]
woutdir <- snakemake@params[["woutdir"]]
#list files
#dirs<-dir("/data/processing/bioinfo-core/oarfish_output",pattern="*.quant",full.names=TRUE)

rename_quant_cols<-function(quant_file){
  sample<-gsub(".quant","",basename(quant_file))
  tab<-fread(quant_file)
  colnames(tab)<-c("Name","EffectiveLength","NumReads")
  tab$Length<-tab$EffectiveLength
  tab$TPM<-tab$NumReads
  tab<-tab[,c("Name","Length","EffectiveLength","TPM","NumReads")]
  outdir<-file.path(woutdir,sample)
  system(paste0('mkdir -p ',outdir))
  fwrite(tab, file = file.path(outdir,"quant.sf"), sep = "\t")
  message(sprintf('Num rows %d',nrow(tab)))
  message(sprintf('Done sample %s',sample))
}

lapply(quant_list,rename_quant_cols)
