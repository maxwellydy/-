data=read.csv("per-sample-fastq-counts.csv",head=T)
jpeg("hist.jpeg")
hist(data$Sequence.count,xlab="Number of sequences",
     col="lightblue",border = "NA",las=2,
     main="Distribution of sequence counts")
box()
dev.off()

pdf("hist.pdf")
hist(data$Sequence.count,xlab="Number of sequences",
     col="lightblue",border = "NA",las=2,
     main="Distribution of sequence counts")
box()
dev.off()

