# 
# We require two different subsets of genes, one for all CP-associated 
# lcoi and another for all gene-trees that 
#

#to be used to isolate ortholog involved in subset
#where ortholog id's match that of file supplied
#are subsetted from full ortholog id file


ortho_long <- read.delim("ortho_long.tsv", header=FALSE, stringsAsFactors=FALSE)
pa <- read.delim("pa.scv", header=FALSE, stringsAsFactors=FALSE) #pa.csv
to_keep <- unique(pa$V1)
CP_orthos <- subset(all_orthos, V1 %in% to_keep)

subsetorthos <- subset_ortholog(ortho_long, "pa.csv")

write.table(CP_orthos, file = "subsetCP.tsv", row.names = FALSE, col.names = FALSE, quote = FALSE)


#this tsv then used to produce dNdS values

#########################################
# Probably move this to another script  #
#########################################

#Subsetting all orthologs for concatenate.py / making branch lengths
                          
files <- which(Ntip(<all trees read into R>) == 24) #total number of strains
filepaths <- all_filepath_trees[files]
og_nums_full <- str_extract(string = filepaths, pattern = "og_\\d+")

str_subset(ortho_long$V1, CPorthos[1])
ortho_full_rows <- lapply(og_nums_full, function(x) which(ortho_long$V1 == (x)))
rownums <- unlist(ortho_full_rows)
subsetorthos <- ortho_long[(rownums),]

full <- unique(subsetorthos$V1)
write.table(full, file = "subsetfull.tsv", row.names = FALSE, col.names = FALSE, quote = FALSE)

