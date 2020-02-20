#to be used to isolate ortholog involved in subset
#where ortholog id's match that of file supplied
#are subsetted from full ortholog id file

ortho_long <- read.delim("<ortho_long.tsv>", header=FALSE, stringsAsFactors=FALSE)
pa <- read.delim("<presence of ortholog files.csv>", header=FALSE, stringsAsFactors=FALSE) #pa.csv
CPorthos <- unique(pa$V1)

ortho_long_rows <- lapply(CPorthos, function(x) which(ortho_long$V1 == (x)))
rownums <- unlist(ortho_long_rows)
subsetorthos <- ortho_long[(rownums),]

write.table(subsetorthos, file = "subsetCP.tsv", row.names = FALSE, col.names = FALSE, quote = FALSE)


#this tsv then used to produce dNdS values


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

