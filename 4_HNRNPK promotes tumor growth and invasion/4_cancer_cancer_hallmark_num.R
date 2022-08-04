setwd("E:\\project\\singcells\\3_function_analyse\\cancer_hallmark_function_analyse\\")
cancerhallmark=read.table("sts_rbp_cancer_hallmark_hypergeom_on_sig(fdr0.001)_2patheway_infor.txt",header=TRUE,sep="\t",as.is=TRUE)
cancers=c("LC","CRC","BC","OvC")
NUM=c(sum(cancerhallmark$lc_regnum),sum(cancerhallmark$crc_regnum),sum(cancerhallmark$bc_regnum),sum(cancerhallmark$ovc_regnum))
df=data.frame(cancers,NUM)
library(ggplot2)
colnames(df)=c("Cancer","Regulon_Number")
ggplot(df,aes(Cancer,Regulon_Number)) + 
  geom_bar(stat='identity',fill=c("#d36868", "#e3cb67","#80bdb2", "#b3aed6"))+
  scale_x_discrete(limits=cancers)+
  theme_bw()+theme(panel.grid=element_blank())

####cancer hallmark####
bc=read.table(paste0("barplot_4_cacner_cancerhallmark/","bc_barplot.txt"),header=TRUE,sep="\t",as.is=TRUE)
ggplot(bc,aes(cancer_hallmark ,bc_regnum)) + 
  geom_bar(stat='identity',fill=c("#80bdb2"))+
  scale_x_discrete(limits=bc$cancer_hallmark)+
  theme_bw()+theme(panel.grid=element_blank())+theme(axis.text.x=element_text(angle=60,hjust=1))
###lc
lc=read.table(paste0("barplot_4_cacner_cancerhallmark/","lc_barplot.txt"),header=TRUE,sep="\t",as.is=TRUE)
ggplot(lc,aes(cancer_hallmark ,lc_regnum)) + 
  geom_bar(stat='identity',fill=c("#d36868"))+
  scale_x_discrete(limits=lc$cancer_hallmark)+
  theme_bw()+theme(panel.grid=element_blank())+theme(axis.text.x=element_text(angle=60,hjust=1))
###crc
crc=read.table(paste0("barplot_4_cacner_cancerhallmark/","crc_barplot.txt"),header=TRUE,sep="\t",as.is=TRUE)
ggplot(crc,aes(cancer_hallmark ,crc_regnum)) + 
  geom_bar(stat='identity',fill=c("#e3cb67"))+
  scale_x_discrete(limits=crc$cancer_hallmark)+
  theme_bw()+theme(panel.grid=element_blank())+theme(axis.text.x=element_text(angle=60,hjust=1))
###ovc
ovc=read.table(paste0("barplot_4_cacner_cancerhallmark/","ovc_barplot.txt"),header=TRUE,sep="\t",as.is=TRUE)
ggplot(ovc,aes(cancer_hallmark ,ovc_regnum)) + 
  geom_bar(stat='identity',fill=c("#b3aed6"))+
  scale_x_discrete(limits=ovc$cancer_hallmark)+
  theme_bw()+theme(panel.grid=element_blank())+theme(axis.text.x=element_text(angle=60,hjust=1))
