library(pheatmap)
data=read.table("otu_table.Family.relative.txt",head=T,row.names=1)
data=data[1:20,]
data=data[,-ncol(data)]
data=as.matrix(data)
data=data*100
pheatmap(data)

