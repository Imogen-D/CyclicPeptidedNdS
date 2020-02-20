#code to plot dNdS values
#dNdS made in ubuntu

dNdS <- read.csv("<dNdS.tsv>", header=FALSE, stringsAsFactors=FALSE)
dNdS <- dNdS[-1,]
colnames(dNdS) <- c("ortholog", "dNdS_values")

plot <- ggplot(dNdS, aes(dNdS_values, ortholog)) + geom_point(aes(), colour="black", pch=21)
plot

#plot produced of ortholog numbers and dNdSvalues
