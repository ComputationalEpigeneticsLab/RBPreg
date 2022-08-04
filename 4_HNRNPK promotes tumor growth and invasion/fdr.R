setwd("E:\\project\\singcells\\3_function_analyse\\cancer_hallmark_function_analyse\\")
data <- read.table("rbp_cancer_hallmark_hypergeom_on.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F)
p=as.numeric(data$p_value)
dfr=p.adjust(p,method = "BH",n = length(p))
data$"fdr"=dfr
data[1:3,]
write.table(data,"rbp_cancer_hallmark_hypergeom_on_fdr.txt",sep = "\t",col.names = T,row.names = F,quote=F)
