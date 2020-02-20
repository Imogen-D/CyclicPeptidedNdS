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
