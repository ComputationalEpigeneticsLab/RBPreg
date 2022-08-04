library(pheatmap)
setwd("E:\\project\\singcells\\1_C_regulons\\BC\\")


data <- read.table("BC_cells_1on.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,row.names = 1)

cellsinfor=read.table("cells_infor_BC_order.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,row.names = 1)


annotation_col=data.frame(cellsinfor$CellType)
rownames(annotation_col) =rownames(cellsinfor)

pheatmap(data,cluster_cols =F,cluster_rows=F,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = F,
         show_colnames = F,
         annotation_col =annotation_col)



