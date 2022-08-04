library(ComplexHeatmap)
library(circlize)
library(Seurat)
library(patchwork)
library(ggplot2)
library(devtools)
library(cowplot)
library(dplyr)
library(grid)
library(gridExtra)
library(openxlsx)
library(tidyverse)
dir1="E:\\project\\singcells\\1_B_tsne\\pca\\"
dir_out="E:\\project\\singcells\\1_diff_exper_analysis\\4_cancer_gene_seurat\\4_cancer_Findallmarkers\\ovc\\"
####ovc#######
load(paste0(dir1,"OvC_TSNE.RData"))

ovc_markers_all<- FindAllMarkers(pbmc,min.pct = 0.1, logfc.threshold = 0.25,only.pos=T)
write.table(ovc_markers_all,paste0(dir_out,"ovc_marker_all.txt"), sep='\t',row.names =T, col.names =T, quote =F)
ovc_markers_all=read.table(paste0(dir_out,"ovc_marker_all.txt"),header=TRUE,sep="\t",as.is=TRUE,row.names = 1)
###every cluster top20gene rank by fc
marker_top20<-as.data.frame(ovc_markers_all %>% group_by(cluster) %>% top_n(n =20, wt = avg_log2FC))
write.table(marker_top20,paste0(dir_out,"ovc_marker_top20.txt"), sep='\t',row.names =T, col.names =T, quote =F)
marker_top20_gene=unique(marker_top20$gene)

regs=marker_top20_gene

cellinfor=read.csv("E:\\project\\singcells\\scRNA_data\\jt_pan-cancer blueprint microenvironment single-cell profiling\\OvC_counts\\OvC_metadata.csv",header=T,sep=",",as.is=TRUE,comment.char = "!",row.names = 1,check.names = F)
cellinfor=cellinfor[sort(cellinfor$CellType,index.return=TRUE)$ix,]
cellinfor[1:3,]
exprMat_ovc=as.matrix(pbmc[["RNA"]]@counts[regs,])

exprMat_ovc=exprMat_ovc[,paste0(gsub("_", "-", rownames(cellinfor)),"-",cellinfor$CellType)]
saveRDS(exprMat_ovc,paste0(dir_out,"exprMat_ovc_markerTop20.Rds"))

annotation_col=data.frame(CellType =cellinfor$CellType)

rownames(annotation_col) =colnames(exprMat_ovc)

unique(cellinfor$CellType)

ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","DC"="#89ac95","Mast"="#922e4b")) 


ha1 = HeatmapAnnotation(df = annotation_col,
                        col = ann_colors,show_annotation_name = F)

pdf(paste0(dir_out,"ovc_noCluster_103.pdf"),width = 14,height = 10)
Heatmap(log2(exprMat_ovc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F,
        #col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1)

dev.off()
save(exprMat_ovc,ha1,annotation_col,file =paste0(dir_out,"ovc_markerTop20_heatmap.Rdata"))

pdf(paste0(dir_out,"ovc_noCluster_71.pdf"),width = 14,height = 10)
Heatmap(log2(exprMat_ovc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F,
        col=colorRampPalette(colors = c("white","#EE4000"))(255),
        #col = colorRamp2(c(0.1,5,10), c("#0099ff", "white","#EE4000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1)

dev.off()
Heatmap(log2(exprMat_ovc+1),cluster_columns =F,cluster_rows =T,
        show_column_names =F, col=colorRampPalette(colors = c("white","red"))(100),
        #col = colorRamp2(c(0.1,1,i), c("#7498A0", "#E2C45D","#EEEE00")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)

pdf(paste0(dir_out,"ovc_noCluster.pdf"),width = 14,height = 10)
Heatmap(log2(exprMat_ovc+1),cluster_columns =F,cluster_rows =T,
        show_column_names =F, col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        #col = colorRamp2(c(0.1,1,i), c("#7498A0", "#E2C45D","#EEEE00")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()


pdf(paste0(dir_out,"ovc_noCluster.pdf"),width = 14,height = 10)
Heatmap(log2(exprMat_ovc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F, col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        #col = colorRamp2(c(0.1,1,i), c("#7498A0", "#E2C45D","#EEEE00")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()


pdf(paste0(dir_out,"ovc_colCluster.pdf"),width = 14,height = 10)
Heatmap(log2(exprMat_ovc+1),cluster_columns =T,cluster_rows =F,
        show_column_names =F, col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        #col = colorRamp2(c(0.1,1,i), c("#7498A0", "#E2C45D","#EEEE00")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()


pdf(paste0(dir_out,"ovc_allCluster.pdf"),width = 14,height = 10)
Heatmap(log2(exprMat_ovc+1),cluster_columns =T,cluster_rows =T,
        show_column_names =F, col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        #col = colorRamp2(c(0.1,1,i), c("#7498A0", "#E2C45D","#EEEE00")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()

#######violin#####3
##b: JCHAIN

b_f=c('CD37','CD79A','JCHAIN','MS4A1')
ct0_df=marker_top20[which(marker_top20$cluster=="B_cell"),]
ct0_df[which(ct0_df$gene %in% b_f ),]

VlnPlot(pbmc, b_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 

##cancer :KRT18
VlnPlot(pbmc, features = "KRT18",slot = "counts", log = TRUE)

##EC : VWF
EC_f=c('A2M', 'GNG11', 'PECAM1', 'PLVAP', 'VWF')

ct0_df=marker_top20[which(marker_top20$cluster=="EC"),]
ct0_df[which(ct0_df$gene %in% EC_f ),]

VlnPlot(pbmc, EC_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 

#Fibroblast : ACTA2

Fibroblast_f=c('ACTA2','LRP1','PDGFRA','NT5E','IL1R1','PDGFRB','VIM','ENG','THY1','CD34')

ct0_df=ovc_markers_all[which(ovc_markers_all$cluster=="Fibroblast"),]
ct0_df[which(ct0_df$gene %in% Fibroblast_f ),]
Fibroblast_f0=c('ACTA2','ENG','PDGFRA','CD34')
VlnPlot(pbmc, Fibroblast_f0, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 


## Myeloid : CD14
VlnPlot(pbmc, features = "CD14",slot = "counts", log = TRUE)

## T_cell :GZMA
T_f=c('CD2', 'CD3E', 'CD69', 'CD7', 'GZMA', 'IL7R')
ct0_df=marker_top20[which(marker_top20$cluster=="T_cell"),]
ct0_df[which(ct0_df$gene %in% T_f ),]

VlnPlot(pbmc, T_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 

#all 
all_gene=c("JCHAIN","KRT18","VWF","ACTA2","CD14","GZMA")
VlnPlot(pbmc, all_gene, stack = TRUE, sort = TRUE, flip = TRUE,cols = c("#a74741","#ad805c","#a7c5c4","#5a757b","#ae5f63","#eebd94"))+
        theme(legend.position = "none") 


