library("fgsea")
pathway<-gmtPathways("E:/project/singcells/3_function_analyse/immu_pathway.gmt")
setwd("E:\\project\\singcells\\3_function_analyse\\RBP_activate_cells_rank\\")
data <- read.table("BC_RBP_rank.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F)
ranks=as.numeric(data$target_gene_num)
names(ranks)=data$ID
fgseaRes<-fgsea(pathway,ranks,minSize=1, maxSize=5000, nperm=1000)
sum(fgseaRes[, padj < 0.01])
