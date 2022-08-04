setwd("E:\\project\\singcells\\3_function_analyse\\")
library(ggalluvial)
data=read.table("ggalluvial_data.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,stringsAsFactors = F)
data_new=data[,c("cancers","regulons","genes","imm_p","values","color_fill")]
titanic_long <- to_lodes(data.frame(data_new),
                         key = "Demographic",
                         axes = 1:4)
color=c("#e96965","#70a128","#00abb7","#9f7ab4")
head(titanic_long)
ggplot(data = titanic_long,
       aes(x = Demographic, stratum = stratum, alluvium = alluvium,
           weight = values, label = stratum)) +
  geom_alluvium(aes(fill = color_fill)) +
 # geom_stratum(color="black",show.legend = F) + geom_text(stat = "stratum") +
  geom_stratum(width=1/3,linetype=1,size=0.2,alpha=0.5,color="black",show.legend = F) + geom_text(stat = "stratum") +
  theme_minimal()+
  theme_bw() +
  stat_flow() +
  theme(plot.title = element_text(hjust = 0.5))+
  theme(legend.position="none",
        axis.title=element_blank(),
        axis.text.y=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border=element_blank())+
 # scale_fill_manual(values=color)+
  theme(legend.position = "none")

ggplot(data = titanic_long,
       aes(x = Demographic, stratum = stratum, alluvium = alluvium,
           weight = values, label = stratum)) +
  geom_alluvium(aes(fill = color_fill)) +
  geom_stratum() + geom_text(stat = "stratum") +
  scale_fill_manual(values=color)+
  theme_minimal()+
  theme_bw() +
  stat_flow() +
  theme(plot.title = element_text(hjust = 0.5))+
  theme(legend.position="none",
        axis.title=element_blank(),
        axis.text.y=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border=element_blank())+
  # scale_fill_manual(values=color)+
  theme(legend.position = "none")
