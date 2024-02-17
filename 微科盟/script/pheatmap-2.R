library(pheatmap)
data=read.table("bray_curtis_matrix.txt",head=T)
pheatmap(data,border_color = "NA")
