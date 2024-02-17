data=read.table("alpha-summary.tsv",sep="\t",head=T,row.names=1)
head(data)
data$group=c(rep("control",8),rep("model",8),
             rep("treat",8))
par(mar=c(3,3,2,2))
boxplot(faith_pd~group,data=data,col=rainbow(3))
legend("topright",c("control","model","treat"),fill=rainbow(3))

####################boxplot with significance level
library(ggplot2)
library(ggpubr)
data=read.table("alpha-summary.tsv",sep="\t",head=T,row.names=1)
data$group=c(rep("control",8),rep("model",8),
             rep("treat",8))

m<-ggplot(data,aes(x=group,y=faith_pd))
m=m+geom_boxplot(aes(col=factor(group)))+labs(col="Group",x="Group")+
  geom_point(aes(col=factor(group)))+geom_line(aes(col=factor(group)),linetype=2)

mycompare=list(c('model','control'),c('treat','model'),
               c('treat','control'))
#指定多重比较的分组对
m+stat_compare_means(comparisons=mycompare,label = "p.signif",
                     method = 'wilcox')
m+stat_compare_means(comparisons=mycompare,label = "p.format",
                     method = 'wilcox')
m+stat_compare_means(comparisons=mycompare,label = "p.format",
                     method = 'kruskal.test')
?stat_compare_means
