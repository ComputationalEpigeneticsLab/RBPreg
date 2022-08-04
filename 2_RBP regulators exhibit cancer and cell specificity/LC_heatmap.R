library(pheatmap)
setwd("/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/LC/")

data <- read.table("LC_cells_1on_merge_same_regulos_one_cell_on_regulon_no0.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,row.names = 1)

cellsinfor=read.table("cells_infor_LC_order_one_cell_on.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,row.names = 1)


annotation_col=data.frame(CellType =cellsinfor$CellType)
rownames(annotation_col) =rownames(cellsinfor)
#treeheight_col=0,treeheight_row=0,
#setwd("/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/CRC/heatmap_notree/")

ann_colors = list(CellType = c('B_cell'= "#d98d2c",'Alveolar'= "#e07468", 'Cancer' = "#bca131","Mast_cell"="#7f88c2","T_cell"="#e26fa2","EC"="#58a84b","Fibroblast"="#539dd1","Myeloid"="#a176b0","Epithelial"="#40aa9b"))  


pdf("LC_activate_col_row_cluster.pdf")
pheatmap(data,cluster_cols =T,cluster_rows=T,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()
pdf("LC_activate_col_row_cluster_notreee.pdf")
pheatmap(data,cluster_cols =T,cluster_rows=T,treeheight_col=0,treeheight_row=0,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()

pdf("LC_activate_col_cluster_notreee.pdf")
pheatmap(data,cluster_cols =T,cluster_rows=F,treeheight_col=0,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()
pdf("LC_activate_col_cluster.pdf")
pheatmap(data,cluster_cols =T,cluster_rows=F,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()

pdf("LC_activate_row_cluster_notreee.pdf")
pheatmap(data,cluster_cols =F,cluster_rows=T,treeheight_row=0,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()
pdf("LC_activate_row_cluster.pdf")
pheatmap(data,cluster_cols =F,cluster_rows=T,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()

pdf("LC_activate_no_cluster.pdf")
pheatmap(data,cluster_cols =F,cluster_rows=F,
         color  = colorRampPalette(colors = c("white","black"))(100),
         show_rownames = T,
         show_colnames = F,
         annotation_col=annotation_col,annotation_colors = ann_colors
         
)

dev.off()

save.image("LC_heatmap.RData")