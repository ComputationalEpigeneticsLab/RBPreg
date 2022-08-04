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
library(tidyverse)

dir1="E:\\project\\singcells\\1_B_tsne\\pca\\"
dir_out="E:\\project\\singcells\\1_diff_exper_analysis\\4_cancer_gene_seurat\\4_cancer_Findallmarkers\\crc\\"
load(paste0(dir1,"CRC_TSNE.RData"))


crc_markers_all<- FindAllMarkers(pbmc,min.pct = 0.1, logfc.threshold = 0.25,only.pos=T)
write.table(crc_markers_all,paste0(dir_out,"crc_marker_all.txt"), sep='\t',row.names =T, col.names =T, quote =F)
crc_markers_all=read.table(paste0(dir_out,"crc_marker_all.txt"),header=TRUE,sep="\t",as.is=TRUE,row.names = 1)
marker_top20<-as.data.frame(crc_markers_all %>% group_by(cluster) %>% top_n(n =20, wt = avg_log2FC))
write.table(marker_top20,paste0(dir_out,"crc_marker_top20.txt"), sep='\t',row.names =T, col.names =T, quote =F)
min(marker_top20$avg_log2FC)
marker_top20_gene=unique(marker_top20$gene)

regs=marker_top20_gene

cellinfor=read.csv("E:\\project\\singcells\\scRNA_data\\jt_pan-cancer blueprint microenvironment single-cell profiling\\CRC_counts\\CRC_metadata.csv",header=T,sep=",",as.is=TRUE,comment.char = "!",row.names = 1,check.names = F)
cellinfor=cellinfor[sort(cellinfor$CellType,index.return=TRUE)$ix,]
cellinfor[1:3,]
exprMat_crc=as.matrix(pbmc[["RNA"]]@counts[regs,])
exprMat_crc=exprMat_crc[,paste0(gsub("_", "-", rownames(cellinfor)),"-",cellinfor$CellType)]

annotation_col=data.frame(CellType =cellinfor$CellType)

rownames(annotation_col) =colnames(exprMat_crc)

unique(annotation_col$CellType)

ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","Enteric_glia"="#aea9c7","Mast_cell"="#922e4b","Epithelial"="#e8d6bf")) 

ha1 = HeatmapAnnotation(df = annotation_col,
                        col = ann_colors,show_annotation_name = F)



save(exprMat_crc,ha1,annotation_col,file =paste0(dir_out,"crc_markerTop20_heatmap.Rdata"))

pdf(paste0(dir_out,"crc_noCluster_103.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_crc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F,
        #col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 5),
        # use_raster =F,
        top_annotation = ha1)

dev.off()
#######violin#####
##'B_cell'
B_cell_f=c('CD79A', 'IGLL5', 'JCHAIN', 'MS4A1')
ct0_df=crc_markers_all[which(crc_markers_all$cluster=="B_cell"),]
ct0_df[which(ct0_df$gene %in% B_cell_f ),]
VlnPlot(pbmc, B_cell_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none") 
##Cancer :KRT18
Cancer_f=c('EPCAM', 'ERBB2', 'KRT18', 'KRT19', 'MUC1')
ct0_df=crc_markers_all[which(crc_markers_all$cluster=="Cancer"),]
ct0_df[which(ct0_df$gene %in% Cancer_f ),]
VlnPlot(pbmc, Cancer_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##EC : PLVAP
EC_f=c('A2M', 'ENG', 'GNG11', 'PECAM1', 'PLVAP', 'VWF')
ct0_df=crc_markers_all[which(crc_markers_all$cluster=="EC"),]
ct0_df[which(ct0_df$gene %in% EC_f ),]
VlnPlot(pbmc, EC_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Enteric_glia no :S100B
crc_markers_all[which(crc_markers_all$cluster=="Enteric_glia"),]
Enteric_glia_f=crc_markers_all[which(crc_markers_all$cluster=="Enteric_glia"),]$gene[1:10]
VlnPlot(pbmc, Enteric_glia_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Epithelial :MUC1
Epithelial_f=c('ANPEP','CD24','CDH1','CEACAM1','DDR1','EPCAM','ITGA6','KRT18','KRT19','KRT8','MUC1','OCLN')
ct0_df=crc_markers_all[which(crc_markers_all$cluster=="Epithelial"),]
ct0_df[which(ct0_df$gene %in% Epithelial_f ),]
VlnPlot(pbmc, Epithelial_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Fibroblast:ACTA2
Fibroblast_f=c('ACTA2','CD81','IL1R1','ITGB1','LRP1','NT5E','PDGFRA','PDGFRB','THY1','VIM')
ct0_df=crc_markers_all[which(crc_markers_all$cluster=="Fibroblast"),]
ct0_df[which(ct0_df$gene %in% Fibroblast_f ),]
VlnPlot(pbmc, Fibroblast_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Mast_cell:TPSB2
Mast_cell_f=c('KIT', 'SLC18A2', 'TPSB2')
VlnPlot(pbmc, Mast_cell_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Myeloid :CD14
Myeloid_f=c('ANPEP', 'CD14', 'CD33', 'FCGR3A', 'ITGAM', 'ITGAX')
VlnPlot(pbmc, Myeloid_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##T_cell:CD2
T_cell_f=c('CD2', 'CD3E', 'CD69', 'CD7', 'GZMA', 'IL7R', 'PTPRC')
VlnPlot(pbmc, T_cell_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
###all
all=c('CD79A',"KRT18","PLVAP","S100B","MUC1","ACTA2","TPSB2","CD14","CD2")
VlnPlot(pbmc, all, stack = TRUE, sort = TRUE, flip = TRUE,
        cols = c("#aea9c7","#a7c5c4","#922e4b","#a74741","#ad805c","#eebd94","#ae5f63","#e8d6bf","#5a757b"))+
  theme(legend.position = "none")


ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","Enteric_glia"="#aea9c7","Mast_cell"="#922e4b","Epithelial"="#e8d6bf")) 
#####top1EE
VlnPlot(pbmc, features = regs[1:3],slot = "counts", log = TRUE)
features_1=as.data.frame(crc_markers_all %>% group_by(cluster) %>% top_n(n =1, wt = avg_log2FC))$gene

marker_top20[which(marker_top20$cluster=="Cancer"),]
features_1=c("PLVAP","CRYAB","ZG16","DCN","TPSB2","SPP1","CCL5","IGLC3","MMP7")
VlnPlot(pbmc, features_1, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none") 

VlnPlot(pbmc, features_1, stack = TRUE, sort = TRUE) +
  theme(legend.position = "none") + ggtitle("top1_fc")
