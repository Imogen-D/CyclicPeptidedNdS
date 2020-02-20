# 
# We require two different subsets of genes, one for all CP-associated 
# lcoi and another for all gene-trees that 
#

#to be used to isolate ortholog involved in subset
#where ortholog id's match that of file supplied
#are subsetted from full ortholog id file


ortho_long <- read.delim("ortho_long.tsv", header=FALSE, stringsAsFactors=FALSE)
pa <- read.delim("pa.csv", header=FALSE, stringsAsFactors=FALSE) #pa.csv
to_keep <- unique(pa$V1)
CP_orthos <- subset(ortho_long, V1 %in% to_keep)
write.table(CP_orthos, file = "subsetCP.tsv", row.names = FALSE, col.names = FALSE, quote = FALSE)


#this tsv then used to produce dNdS values
