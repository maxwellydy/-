#####otu.bc
#####otu.bc
#####otu.bc
library(ape) # 用于pcoa分析
library(scatterplot3d)
library(ggplot2)

otu.bc=read.table("bray_curtis_matrix.txt",head=T)
group=c(rep("control",8),rep("mode",8),rep("treat",8))
PCOA <- pcoa(otu.bc, correction="none", rn=NULL) #利用PCOA()指令做pcoa分析  
#####各维度占比
result <-PCOA$values[,"Relative_eig"]  
pro1 = as.numeric(sprintf("%.3f",result[1]))*100  
pro2 = as.numeric(sprintf("%.3f",result[2]))*100  
pro3 = as.numeric(sprintf("%.3f",result[3]))*100  
x = PCOA$vectors  
#####各样本在各维度上的系数
pc = as.data.frame(PCOA$vectors)  
sample_names = rownames(x)  
pc$names = sample_names  
write.table(pc,"16s_Bray-Curtis_pcoa.xls",sep="\t",quote=F)
#####group信息
pc$group = group  

xlab=paste("PCOA1(",pro1,"%)",sep="")   
ylab=paste("PCOA2(",pro2,"%)",sep="")  
zlab=paste("PCOA3(",pro3,"%)",sep="")  
###2D
ggplot(pc,aes(Axis.1,Axis.2)) +
  geom_point(size=3,aes(color=group)) + 
  geom_text(aes(label=names),size=3,vjust=-1) + 
  labs(x=xlab,y=ylab,color="Group",
       title="bray_curtis")+ stat_ellipse(aes(color=group))

###3D
color <- c(rep("red",8),rep("green",8),rep("blue",8)) #定义点颜色
p3d=scatterplot3d(pc[,1],pc[,2],pc[,3],color=color,xlab=xlab,
                  ylab=ylab,zlab=zlab,pch=19,lty.hplot=2,type="h")
legend(-5.2,8.5,c("control","mode","treat"),
       col=c("red","green","blue"),pch=19,xpd=T)

p3d.coords <- p3d$xyz.convert(pc[,1],pc[,2],pc[,3])
text(p3d.coords$x, p3d.coords$y, 
     labels=sample_names,
     pos=4, cex=.5) 

