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

                          
branchtree <- read.tree(file = "<RAxML strain tree with branch lengths produced by concatenate.py>") #produced by concatenate.py
rooted_branchtree <- root(branchtree, "CCE27021")
droppedtip <- drop.tip(rooted_branchtree, "CCE27021")
plot(droppedtip)
axisPhylo() #observe tree


pa <- read.delim("<presence of orthologs files.csv>", header=FALSE, stringsAsFactors=FALSE) #pa.csv
#CSV describing presence of orthologs

paspread <- spread(pa, V1, V3)
rownames(paspread) <- paspread$V2
paspread$V2 <- NULL

og_<number> <- paspread[,'<ortholog of choice>', drop = FALSE] #test og
matrixog <- as.matrix(og_<number>)[,1]

chronos_relative <- makeChronosCalib(droppedtip, node = "root", age.min = 1, age.max = 1, interactive = FALSE, soft.bounds = FALSE) 
chronos_relative #pretending to add chronos / how to add to tree?

Q <- matrix( c(0,1,2,0) , nrow=2)
ancestral <- ace(matrixog, droppedtip, type = "discrete", model = Q)
#had to produce matrix for all rates different model manually as ARD had errors
margancesstates <- round(ancestral$lik.anc,2)

nodelabels(node=1:droppedtip$Nnode+Ntip(droppedtip), pie=ancestral$lik.anc,cex=0.5)

legend("bottomright", legend = c("Present", "Absent"), fill = c("Cyan", "Red"), cex = 0.75)
title(main = "Ancestral presence of cyclic peptide og_<number>", xlab = "Branchlength")
TF <- ancestral$lik.anc
TF <- as.data.frame(TF)

