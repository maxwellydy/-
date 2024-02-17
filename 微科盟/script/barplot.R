library(RColorBrewer)
otu <- read.table("results/feature_table_relative/feature-table_relative.txt", header=T, sep="\t",row.names=1)
otu=otu[order(otu$H1,decreasing = T),]
otu<-as.matrix(otu[,-ncol(otu)])
otu=otu*100
col=c(brewer.pal(12,name="Set3"),brewer.pal(12,name="Paired"))
par(mar=c(3,3,3,8))
n=nrow(otu)
barplot(otu,col=col,las=2)
legend(ncol(otu)+5,100, row.names(otu), bty="n",
       fill=col,xpd=T,cex=0.8)

otu <- read.table("otu_table.Species.relative.txt", header=T, sep="\t",row.names=1)
otu<-otu[,-ncol(otu)]
otu=otu*100
n=nrow(otu)
otu$mean_A=rowMeans(otu[,1:8])
otu$mean_B=rowMeans(otu[,9:16])
otu$mean_c=rowMeans(otu[,17:24])
otu_mean=as.matrix(otu[,25:27])
col=c(brewer.pal(12,name="Set3"),brewer.pal(12,name="Paired"))
barplot(otu_mean,col=col,names=c("control","mode","treat"))
legend(3.8,100,row.names(otu), bty="n",
       fill=col,xpd=T,cex=0.8)

