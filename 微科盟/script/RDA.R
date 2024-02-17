#载入vegan包
library(vegan)
library(ggplot2)

#读取“样本-物种”文件
sp <- read.table("otu_table.Family.relative.txt",sep="\t",header=T,row.names=1)
sp=sp[,-ncol(sp)]
sp=t(sp)

#读取“样本-环境因子”文件
se <- read.table("mapping_file.txt",sep="\t",header=T,row.names=1)
se=se[,4:8]
sp=sp[match(row.names(se),row.names(sp)),]
#DCA分析确认选择用RDA还是CCA分析
decorana(sp) 
#根据看分析结果中Axis Lengths的第一轴的大小
#如果大于4.0,就应选CCA（基于单峰模型，典范对应分析）
#如果在3.0-4.0之间，选RDA和CCA均可
#如果小于3.0, RDA的结果会更合理（基于线性模型，冗余分析）
###RDA分析
sp1 <- rda(sp ~ ., se)  
color=c(rep("red",8),rep("green",8),rep("blue",8))
plot(sp1)
###图片美化
rda<-sp1$CCA
#提取并转换“样本”数据
samples<-data.frame(sample=row.names(rda$u),RDA1=rda$u[,1],RDA2=rda$u[,2])
samples$group=c(rep("control",8),rep("mode",8),rep("treat",8))
#提取并转换“物种”数据
species<-data.frame(species=row.names(rda$v),RDA1=rda$v[,1],RDA2=rda$v[,2])
#提取并转换“环境因子”数据
envi<-data.frame(en=row.names(rda$biplot),RDA1=rda$biplot[,1],RDA2=rda$biplot[,2])
#构建环境因子直线坐标
line_x = c(0,envi[1,2],0,envi[2,2],0,envi[3,2],0,envi[4,2],0,envi[5,2])
line_y = c(0,envi[1,3],0,envi[2,3],0,envi[3,3],0,envi[4,3],0,envi[5,3])
line_g = c("endotoxin","endotoxin","acetic_acid","acetic_acid","propionic_acid",
           "propionic_acid","butyrate","butyrate","NH3_N","NH3_N")
line_data = data.frame(x=line_x,y=line_y,group=line_g)
line_data
#载入ggplot2包
library(ggplot2)
#sample+envi
ggplot(data=samples,aes(RDA1,RDA2)) + geom_point(aes(color=group),size=2) + 
  #填充环境因子数据，直接展示
  geom_text(data=envi,aes(label=en)) +
  #添加0刻度纵横线
  geom_hline(yintercept=0,lty=2) + geom_vline(xintercept=0,lty=2)+
  #添加原点指向环境因子的直线
  geom_line(data=line_data,aes(x=x,y=y,group=group),color="purple") +
  #去除背景颜色及多余网格线
  theme_bw() + theme(panel.grid=element_blank())
#bacteria+envi
ggplot(data=species,aes(RDA1,RDA2)) + geom_point(color="red") + 
  #填充环境因子数据，直接展示
  geom_text(data=envi,aes(label=en)) +
  geom_text(data=species,aes(label=species),color="red") +
  #添加0刻度纵横线
  geom_hline(yintercept=0,lty=2) + geom_vline(xintercept=0,lty=2)+
  #添加原点指向环境因子的直线
  geom_line(data=line_data,aes(x=x,y=y,group=group),color="purple") +
  #去除背景颜色及多余网格线
  theme_bw() + theme(panel.grid=element_blank())
