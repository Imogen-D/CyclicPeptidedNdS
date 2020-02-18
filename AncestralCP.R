#code to produce tree with ancestral state
#of cyclic peptide gene og_10573; can be used for other orthologs
#produce different input file

#had to produce branch lengths for this to work to use ace

library(ggplot2)
library(ggtree)
library(ape)
library(phangorn)
library(rgl)
library(caTools)
library(stringr)
library(tidyr)
library(XML)
library("rentrez")
library(RColorBrewer)
library(magick)

ortho_long <- read.delim("~/CoxExtension/ortho_long.tsv", header=FALSE, stringsAsFactors=FALSE)
CPTrueFalse <- read.delim("~/CoxExtension/CPTrueFalse.csv", header=FALSE, stringsAsFactors=FALSE)
CPorthos <- unique(CPTrueFalse$V1)

ortho_long_rows <- lapply(CPorthos, function(x) which(ortho_long$V1 == (x)))
rownums <- unlist(ortho_long_rows)
subsetorthos <- ortho_long[(rownums),]

write.table(subsetorthos, file = "subsetCP.tsv", row.names = FALSE, col.names = FALSE, quote = FALSE)


#dNdS made in ubuntu
dNdS <- read.csv("~/CoxExtension/dNdS.csv", header=FALSE, stringsAsFactors=FALSE)
dNdS <- dNdS[-1,]
colnames(dNdS) <- c("ortholog", "dNdS_values")

plot <- ggplot(dNdS, aes(dNdS_values, ortholog)) + geom_point(aes(), colour="black", pch=21)
plot
#plot produced of ortholog and 




branchtree <- read.tree(file = "~/Shared Folder/RAxML_result.fullbranchlengthstree")
rooted_branchtree <- root(branchtree, "CCE27021")
droppedtip <- drop.tip(rooted_branchtree, "CCE27021")
plot(droppedtip)
axisPhylo()


pa <- read.delim("./CoxExtension/pa.csv", header=FALSE, stringsAsFactors=FALSE)
#CSV describing presence of orthologs

paspread <- spread(pa, V1, V3)
rownames(paspread) <- paspread$V2
paspread$V2 <- NULL

og_10573 <- paspread[,'og_10573', drop = FALSE] #test og
matrixog <- as.matrix(og_10573)[,1]

chronos_relative <- makeChronosCalib(droppedtip, node = "root", age.min = 1, age.max = 1, interactive = FALSE, soft.bounds = FALSE) 
chronos_relative #pretending to add chronos / how to add to tree?

Q <- matrix( c(0,1,2,0) , nrow=2)
ancestral <- ace(matrixog, droppedtip, type = "discrete", model = Q)  #currently ASTRAL no branch lengths so doing concantenation first
margancesstates <- round(ancestral$lik.anc,2)

nodelabels(node=1:droppedtip$Nnode+Ntip(droppedtip), pie=ancestral$lik.anc,cex=0.5)

legend("bottomright", legend = c("Present", "Absent"), fill = c("Cyan", "Red"), cex = 0.75)
title(main = "Ancestral presence of cyclic peptide og_10573", xlab = "Branchlength")
TF <- ancestral$lik.anc
TF <- as.data.frame(TF)

