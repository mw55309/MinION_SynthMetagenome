#!/usr/bin/env Rscript

# read in report
rare <- read.table("Rare5xi15FAA69863_pass.2D.report", header=FALSE, stringsAsFactors=FALSE, sep="\t")
rare.sp <- rare[grep("s__",rare$V1),]
rare.sp <- rare.sp[order(rare.sp$V2, decreasing=TRUE),]
rsplit <- strsplit(rare.sp$V1, split="\\|")

# sort out labels
labs <- vector(mode="character", length=nrow(rare.sp))
for (i in 1:nrow(rare.sp)) {
	labs[i] <- rsplit[[i]][length(rsplit[[i]])]
}
labs <- gsub("s__", "", labs)

# create colours; grey as default
library(RColorBrewer)
cols <- rep("grey", nrow(rare.sp))
rcols <- brewer.pal(4, "Set2")

cols[labs=="Pseudomonas_fluorescens"] <- rcols[1]
cols[labs=="Synechococcus_elongatus"] <- rcols[2]
cols[labs=="Escherichia_coli"] <- rcols[3]
cols[labs=="Microcystis_aeruginosa"] <- rcols[4]

# output plot
png("Synthetic_metagenome_abundance_rare.png", width=1200, height=800)
par(mar=c(15,4,4,2))
barplot(rare.sp$V2, names=labs, col=cols, las=2, xaxt="n", main="Synthetic metagenome abundance: rare")

# add axes and labels
axis(1, at=seq(0.7, 14.4, by=1.2), labels=FALSE)
text(x=seq(0.7, 14.4, by=1.2), y=-10,
labels=labs, srt=45, adj=1, xpd=TRUE)
dev.off()


# read in report
equal <- read.table("Equal3xi15FAA72444_pass.2D.report", header=FALSE, stringsAsFactors=FALSE, sep="\t")
equal.sp <- equal[grep("s__",equal$V1),]
equal.sp <- equal.sp[order(equal.sp$V2, decreasing=TRUE),]
rsplit <- strsplit(equal.sp$V1, split="\\|")

# sort out labels
labs <- vector(mode="character", length=nrow(equal.sp))
for (i in 1:nrow(equal.sp)) {
	labs[i] <- rsplit[[i]][length(rsplit[[i]])]
}
labs <- gsub("s__", "", labs)

# create colours; grey as default
library(RColorBrewer)
cols <- rep("grey", nrow(rare.sp))
rcols <- brewer.pal(4, "Set2")
cols[labs=="Pseudomonas_fluorescens"] <- rcols[1]
cols[labs=="Synechococcus_elongatus"] <- rcols[2]
cols[labs=="Escherichia_coli"] <- rcols[3]
cols[labs=="Microcystis_aeruginosa"] <- rcols[4]

# output plot
png("Synthetic_metagenome_abundance_equal.png", width=1800, height=800)
par(mar=c(15,4,4,2))
barplot(equal.sp$V2, names=labs, col=cols, las=2, xaxt="n", main="Synthetic metagenome abundance: equal")

# add axes and labels
axis(1, at=seq(0.7, 30, by=1.2), labels=FALSE)
text(x=seq(0.7, 30, by=1.2), y=-10,
labels=labs, srt=45, adj=1, xpd=TRUE)
dev.off()
