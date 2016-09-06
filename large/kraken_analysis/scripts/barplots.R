#!/usr/bin/env Rscript

# open kraken report
mock <- read.table("MockRare.pass.2d.report", header=FALSE, stringsAsFactors=FALSE, sep="\t")
mock.sp <- mock[grep("s__",mock$V1),]
mock.sp <- mock.sp[order(mock.sp$V2, decreasing=TRUE),]
rsplit <- strsplit(mock.sp$V1, split="\\|")

# sort out labels
labs <- vector(mode="character", length=nrow(mock.sp))
for (i in 1:nrow(mock.sp)) {
	labs[i] <- rsplit[[i]][length(rsplit[[i]])]
}
labs <- gsub("s__", "", labs)
mock.sp$V1 <- labs

# species list
species <- c('Acinetobacter_baumannii',
'Actinomyces_odontolyticus',
'Bacillus_cereus',
'Bacteroides_vulgatus',
'Clostridium_beijerinckii',
'Deinococcus_radiodurans',
'Enterococcus_faecalis',
'Escherichia_coli',
'Helicobacter_pylori',
'Lactobacillus_gasseri',
'Listeria_monocytogenes',
'Neisseria_meningitidis',
'Propionibacterium_acnes',
'Pseudomonas_aeruginosa',
'Rhodobacter_sphaeroides',
'Staphylococcus_aureus',
'Staphylococcus_epidermidis',
'Streptococcus_agalactiae',
'Streptococcus_mutans',
'Streptococcus_pneumoniae')

# create temp data frams
tempdf <- data.frame(sp=species, temp=1:length(species))

# merge
mock.m <- merge(mock.sp, tempdf, by.x="V1", by.y="sp", all.x=TRUE, sort=FALSE)

# default colour is grey
mock.m$col <- rep("grey", nrow(mock.m))

# get pretty colours
library(RColorBrewer)
rcols <- colorRampPalette(brewer.pal(17, "Set2"))(17)
mock.m$temp[!is.na(mock.m$temp)] <- 1:17
mock.m$col[!is.na(mock.m$temp)] <- rcols[mock.m$temp[!is.na(mock.m$temp)]]


# output barplot and log barplot
png("MockReare.pass.2D.png", width=1200, height=800)
par(mar=c(15,4,4,2))
bx <- barplot(mock.m$V2, names=mock.m$V1, col=mock.m$col, las=2, xaxt="n", main="Mock rare community pass 2D: abundance")

axis(1, at=bx[,1], labels=FALSE)
text(x=bx[,1], y=-75, labels=mock.m$V1, srt=45, adj=1, xpd=TRUE)
dev.off()

png("MockReare.pass.log.2D.png", width=1200, height=800)
par(mar=c(15,4,4,2))
bx <- barplot(log10(mock.m$V2), names=mock.m$V1, col=mock.m$col, las=2, xaxt="n", main="Mock rare community pass 2D: log abundance")

axis(1, at=bx[,1], labels=FALSE)
text(x=bx[,1], y=-0.1, labels=mock.m$V1, srt=45, adj=1, xpd=TRUE)
dev.off()

# find missing species
missing <- species[!species %in% mock.m$V1[!is.na(mock.m$temp)]]



