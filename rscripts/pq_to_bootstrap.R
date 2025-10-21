library(arrow)
library(data.table)


pq_list <- snakemake@input[["pq_list"]]
woutdir <- snakemake@params[["woutdir"]]
#list files
#dir<-dir("/data/processing/bioinfo-core/oarfish_output",pattern="*.pq",full.names=TRUE)



pq_to_bp<-function(pq_file){
  sample<-gsub(".infreps.pq","",basename(pq_file))
  # Step 1: Read the Parquet file
  df <- as.data.table(t(read_parquet(pq_file)))
  
  outdir<-file.path(woutdir,sample,"aux_info/bootstrap")
  system(paste0('mkdir -p ',outdir))

  # Step 3: Write as tab-delimited file (no header, no row names)
  fwrite(df, file = file.path(outdir,"bootstraps.tsv"), sep = "\t", col.names = FALSE,row.names=FALSE)

  # Step 4: Compress to GZIP
  con <- gzfile(file.path(outdir,"bootstraps.gz"), "wb")
  on.exit(close(con))
  #flatten column-wise, default
  writeBin(as.vector(as.matrix(df)), con)
  #close(con)
  #system(paste0('gzip -c ',file.path(outdir,"bootstraps.tsv")," > ",file.path(outdir,"bootstraps.gz")))
  message(sprintf('Done sample %s',sample))
}

lapply(pq_list,pq_to_bp)

