library(reshape2)
p=read.table("fdr_adjusted_p_value_matrix.txt",sep="\t",head=T)
p$sp1=row.names(p)
p=melt(p,id.vars = "sp1")
colnames(p)=c("sp1","sp2","p")

cor=read.table("spearman_rank_correlation_matrix.txt",sep="\t",head=T,row.names=1)
cor$scor1=row.names(cor)
cor=melt(cor,id.vars = "scor1")
colnames(cor)=c("sp1","sp2","cor")
cor$p=p$p
cor=cor[cor$sp1!=cor$sp2,]
cor=subset(cor,p<0.05 & abs(cor)>0.5)

cor$interaction="spearman"

write.table(cor,"correlation.txt",sep="\t",quote=F,row.names=F)

