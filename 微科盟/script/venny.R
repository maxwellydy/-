#install.packages("VennDiagram")
library(VennDiagram)
data=read.table("otu_table.Family.absolute.txt",head=T,row.names=1)
data=data[,-ncol(data)]
control=row.names(data)[rowSums(data[,1:8])>0]
model=row.names(data)[rowSums(data[,9:16])>0]
treat=row.names(data)[rowSums(data[,17:24])>0]
data=list(control=control,model=model,treat=treat)
venn.diagram(data,fill=rainbow(3),
  alpha=c(0.5,0.5,0.5), filename="venn1.png")
venn.diagram(data,fill=rainbow(3),alpha=c(1,1,1),
             filename="venn2.png")
