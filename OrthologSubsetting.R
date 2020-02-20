#to be used to isolate ortholog involved in subset
#where ortholog id's match that of file supplied
#are subsetted from full ortholog id file

ortho_long <- read.delim("<ortho_long.tsv>", header=FALSE, stringsAsFactors=FALSE)
pa <- read.delim("<presence of ortholog files.csv", header=FALSE, stringsAsFactors=FALSE) #pa.csv
CPorthos <- unique(pa$V1)

ortho_long_rows <- lapply(CPorthos, function(x) which(ortho_long$V1 == (x)))
rownums <- unlist(ortho_long_rows)
subsetorthos <- ortho_long[(rownums),]

write.table(subsetorthos, file = "subsetCP.tsv", row.names = FALSE, col.names = FALSE, quote = FALSE)


#this tsv then used to produce dNdS values
