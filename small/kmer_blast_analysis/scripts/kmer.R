#!/usr/bin/env Rscript

# read in equal kmer data frame 
d <- as.data.frame(t(read.table("Equal3xi15FAA72444_pass.2D.kmer5", sep="\t", header=FALSE, row.names=1, stringsAsFactors=FALSE)), stringsAsFactors=FALSE)
d$kmer <- paste("r",d$kmer, sep=".")
rownames(d) <- 1:nrow(d)
d$order <- 1:nrow(d)
d[d==""] <- 0

# read in BLAST hits
h <- read.table("blast_hits.txt", sep="\t", header=FALSE, stringsAsFactors=FALSE)[,1:3]
h$V1 <- paste("r",h$V1, sep=".")
h[h==""] <- "none"

# merge kmer counts and blast hits
merg.d <- merge(d, h, all.x=TRUE, by.x="kmer", by.y="V1", sort=FALSE)

# create colours
library(RColorBrewer)
rcols <- brewer.pal(4, "Set1")
merg.d$col = rep("grey", nrow(merg.d))
merg.d$col[merg.d$V3=="Synechococcus elongatus PCC 7942 chromosome, complete genome"] <- rcols[2]
merg.d$col[merg.d$V3=="Pseudomonas fluorescens A506 chromosome, complete genome"] <- rcols[1]
merg.d$col[merg.d$V3=="Microcystis aeruginosa NIES-843 chromosome, complete genome"] <- rcols[4]
merg.d$col[merg.d$V3=="Escherichia coli UTI89 chromosome, complete genome"] <- rcols[3]
merg.d$col[merg.d$V3=="none"] <- "black"

# summarise and count
counts <-  aggregate(merg.d$V3, by=list(species=merg.d$V3), length)

# write table of counts
write.table(counts, "equal_blast_counts.txt", row.names=FALSE, col.names=TRUE, sep="\t")

# convert columns to numeric
td <- as.matrix(merg.d[,2:1025])
nd <- matrix(rep(0, nrow(td)*ncol(td)), ncol=ncol(td))
for (i in 1:ncol(nd)) {
	nd[,i] <- as.numeric(td[,i])
}

# calculate row sums
rs <- rowSums(nd)

# convert counts to proportions
for (i in 1:nrow(nd)) {
	nd[i,] <- nd[i,] / rs[i]
}

# PCA
pca <- prcomp(nd)

# draw plot
png("equal_pca.png", height=800, width=1200)
par(mar=c(5,5,4,2))
plot(pca$x[,1], pca$x[,2], col="white", xlab="PC1", ylab="PC2",  xlim=c(-0.027, 0.02), main="PCA: Equal synthetic metagenome",  cex.lab=2, cex.axis=2, cex.main=3)

# add points
points(pca$x[merg.d$col=="grey",1], pca$x[merg.d$col=="grey",2], col="grey", cex=1.5)
points(pca$x[merg.d$col=="black",1], pca$x[merg.d$col=="black",2], col="black", cex=1.5)
points(pca$x[merg.d$col!="grey"&merg.d$col!="black",1], pca$x[merg.d$col!="grey"&merg.d$col!="black",2], col=merg.d$col[merg.d$col!="grey"&merg.d$col!="black"], pch=16, cex=1.5)

# add legend
legend(-0.027, -0.005, legend=c("Synechococcus elongatus PCC 7942",
				"Pseudomonas fluorescens A506",
				"Microcystis aeruginosa NIES-843",
				"Escherichia coli UTI89",
				"none", "other"), fill=c(rcols[c(2,1,4,3)], "black", "grey"), cex=1.5)
dev.off()







# read in equal rare data frame
d <- as.data.frame(t(read.table("Rare5xi15FAA69863_pass.2D.kmer5", sep="\t", header=FALSE, row.names=1, stringsAsFactors=FALSE)), stringsAsFactors=FALSE)
d$kmer <- paste("r",d$kmer, sep=".")
rownames(d) <- 1:nrow(d)
d$order <- 1:nrow(d)
d[d==""] <- 0

# read in blast hits
h <- read.table("blast_hits.txt", sep="\t", header=FALSE, stringsAsFactors=FALSE)[,1:3]
h$V1 <- paste("r",h$V1, sep=".")
h[h==""] <- "none"

# merge kmer counts and blast hits
merg.d <- merge(d, h, all.x=TRUE, by.x="kmer", by.y="V1", sort=FALSE)

# create colours
library(RColorBrewer)
rcols <- brewer.pal(4, "Set1")
merg.d$col = rep("grey", nrow(merg.d))
merg.d$col[merg.d$V3=="Synechococcus elongatus PCC 7942 chromosome, complete genome"] <- rcols[2]
merg.d$col[merg.d$V3=="Pseudomonas fluorescens A506 chromosome, complete genome"] <- rcols[1]
merg.d$col[merg.d$V3=="Microcystis aeruginosa NIES-843 chromosome, complete genome"] <- rcols[4]
merg.d$col[merg.d$V3=="Escherichia coli UTI89 chromosome, complete genome"] <- rcols[3]
merg.d$col[merg.d$V3=="none"] <- "black"

# summarise and count
counts <-  aggregate(merg.d$V3, by=list(species=merg.d$V3), length)

# write counts table
write.table(counts, "rare_blast_counts.txt", row.names=FALSE, col.names=TRUE, sep="\t")

# convert columns to numeric
td <- as.matrix(merg.d[,2:1025])
nd <- matrix(rep(0, nrow(td)*ncol(td)), ncol=ncol(td))
for (i in 1:ncol(nd)) {
	nd[,i] <- as.numeric(td[,i])
}

# calculate row sums
rs <- rowSums(nd)

# convert counts to proportions
for (i in 1:nrow(nd)) {
	nd[i,] <- nd[i,] / rs[i]
}

# PCA
pca <- prcomp(nd)

# draw plot
png("rare_pca.png", height=800, width=1200)
par(mar=c(5,5,4,2))
plot(pca$x[,1], pca$x[,2], col="white", xlab="PC1", ylab="PC2",  xlim=c(-0.015, 0.015), main="PCA: Rare synthetic genome",  cex.lab=2, cex.axis=2, cex.main=3)

# add points
points(pca$x[merg.d$col=="grey",1], pca$x[merg.d$col=="grey",2], col="grey", cex=1.5)
points(pca$x[merg.d$col=="black",1], pca$x[merg.d$col=="black",2], col="black", cex=1.5)
points(pca$x[merg.d$col!="grey"&merg.d$col!="black",1], pca$x[merg.d$col!="grey"&merg.d$col!="black",2], col=merg.d$col[merg.d$col!="grey"&merg.d$col!="black"], pch=16, cex=1.5)

# add legend
legend(-0.015, 0.015, legend=c("Synechococcus elongatus PCC 7942",
				"Pseudomonas fluorescens A506",
				"Microcystis aeruginosa NIES-843",
				"Escherichia coli UTI89",
				"none", "other"), fill=c(rcols[c(2,1,4,3)], "black", "grey"), cex=1.5)
dev.off()



