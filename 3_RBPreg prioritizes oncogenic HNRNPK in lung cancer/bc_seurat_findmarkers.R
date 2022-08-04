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
dir_out="E:\\project\\singcells\\1_diff_exper_analysis\\4_cancer_gene_seurat\\4_cancer_Findallmarkers\\bc\\"
load(paste0(dir1,"BC_TSNE.RData"))
bc_markers_all<- FindAllMarkers(pbmc,min.pct = 0.1, logfc.threshold = 0.25,only.pos=T)
write.table(bc_markers_all,paste0(dir_out,"bc_marker_all.txt"), sep='\t',row.names =T, col.names =T, quote =F)
bc_markers_all=read.table(paste0(dir_out,"bc_marker_all.txt"),header=TRUE,sep="\t",as.is=TRUE,row.names = 1)

marker_top20<-as.data.frame(bc_markers_all %>% group_by(cluster) %>% top_n(n =20, wt = avg_log2FC))
min(marker_top20$avg_log2FC)
marker_top20_gene=unique(marker_top20$gene)
write.table(marker_top20,paste0(dir_out,"bc_marker_top20.txt"), sep='\t',row.names =T, col.names =T, quote =F)
regs=marker_top20_gene

cellinfor=read.csv("E:\\project\\singcells\\scRNA_data\\jt_pan-cancer blueprint microenvironment single-cell profiling\\BC_counts\\BC_metadata.csv",header=T,sep=",",as.is=TRUE,comment.char = "!",row.names = 1,check.names = F)
cellinfor=cellinfor[sort(cellinfor$CellType,index.return=TRUE)$ix,]
cellinfor[1:3,]
exprMat_bc=as.matrix(pbmc[["RNA"]]@counts[regs,])
exprMat_bc=exprMat_bc[,paste0(gsub("_", "-", rownames(cellinfor)),"-",cellinfor$CellType)]

annotation_col=data.frame(CellType =cellinfor$CellType)

rownames(annotation_col) =colnames(exprMat_bc)

unique(annotation_col$CellType)

ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","DC"="#89ac95","Mast"="#922e4b")) 

ha1 = HeatmapAnnotation(df = annotation_col,
                        col = ann_colors,show_annotation_name = F)



save(exprMat_bc,ha1,annotation_col,file =paste0(dir_out,"bc_markerTop20_heatmap.Rdata"))

pdf(paste0(dir_out,"bc_noCluster_103.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_bc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F,
        #col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1)

dev.off()

pdf(paste0(dir_out,"bc_noCluster.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_bc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F, col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()

pdf(paste0(dir_out,"bc_rowCluster.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_bc+1),cluster_columns =F,cluster_rows =T,
        show_column_names =F, col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()

pdf(paste0(dir_out,"bc_colCluster.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_bc+1),cluster_columns =T,cluster_rows =F,
        show_column_names =F, col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()


pdf(paste0(dir_out,"bc_allCluster.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_bc+1),cluster_columns =T,cluster_rows =T,
        show_column_names =F, col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 6),
        # use_raster =F,
        top_annotation = ha1
)
dev.off()

#####violin####
##b MS4A1
b_f=c('ADAM28',
      'AFF3',
      'AIM2',
      'ANKRD13A',
      'ARHGAP24',
      'ATP2B1',
      'BACH2',
      'BANK1',
      'BCAS4',
      'BCL11A',
      'BIRC3',
      'BLK',
      'BLNK',
      'BTLA',
      'CCR6',
      'CD19',
      'CD22',
      'CD37',
      'CD38',
      'CD40',
      'CD52',
      'CD69',
      'CD74',
      'CD79A',
      'CD79B',
      'CD83',
      'CDCA7L',
      'COBLL1',
      'CPNE5',
      'CXCR4',
      'CXCR5',
      'CXXC5',
      'CYB561A3',
      'DAPP1',
      'DRAM2',
      'EBF1',
      'EEF1B2',
      'FAM129C',
      'FCER2',
      'FCGR2B',
      'FCMR',
      'FCRL1',
      'FCRL2',
      'FCRL5',
      'FCRLA',
      'GNG7',
      'GPR183',
      'HHEX',
      'HLA-DMA',
      'HLA-DMB',
      'HLA-DOB',
      'HLA-DPA1',
      'HLA-DPB1',
      'HLA-DQA1',
      'HLA-DQB1',
      'HLA-DRA',
      'HLA-DRB1',
      'HLA-DRB5',
      'HVCN1',
      'IFT57',
      'IGLL5',
      'IRF8',
      'ISG20',
      'JCHAIN',
      'LTB',
      'LY9',
      'MEF2C',
      'MICAL3',
      'MS4A1',
      'NCF1',
      'NFKBID',
      'ODC1',
      'ORAI2',
      'PARP1',
      'PAX5',
      'PHACTR1',
      'PKIG',
      'PLEKHF2',
      'PNOC',
      'POU2AF1',
      'POU2F2',
      'PPM1K',
      'QRSL1',
      'RAB30',
      'RALGPS2',
      'RASGRP3',
      'RCSD1',
      'RIC3',
      'RNASET2',
      'RPL22L1',
      'SCIMP',
      'SEL1L3',
      'SELL',
      'SMARCB1',
      'SMIM14',
      'SNX2',
      'SNX22',
      'SNX29',
      'SP110',
      'SP140',
      'SPIB',
      'ST6GAL1',
      'STAG3',
      'STAP1',
      'STRBP',
      'STX7',
      'SWAP70',
      'SYPL1',
      'TCF4',
      'TCL1A',
      'TFEB',
      'TLR10',
      'TMEM154',
      'TMEM243',
      'TNFRSF13B',
      'TNFRSF13C',
      'TPD52',
      'TSPAN13',
      'UVRAG',
      'VPREB3')

ct0_df=bc_markers_all[which(bc_markers_all$cluster=="B_cell"),]
ct0_df[which(ct0_df$gene %in% b_f ),]
b_f0=ct0_df[which(ct0_df$gene %in% b_f ),]$gene[1:10]
VlnPlot(pbmc, b_f0, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 

VlnPlot(pbmc, features = "JCHAIN",slot = "counts", log = F)
##cancer: KRT18
cacner_f=c('KRT18', 'KRT19')
VlnPlot(pbmc, cacner_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 

##DC : CD1C
DC_F=c('ADAM19', 'CD1A', 'CD1C', 'CD83', 'CD86', 'CLEC4C', 'IL3RA', 'ITGAX', 'THBD')

ct0_df=bc_markers_all[which(bc_markers_all$cluster=="DC"),]
ct0_df[which(ct0_df$gene %in% DC_F ),]

VlnPlot(pbmc, DC_F, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 
##EC :PLVAP 
EC_f=c('A2M', 'CD34', 'ENG', 'GNG11', 'PECAM1', 'PLVAP', 'VWF')
ct0_df=bc_markers_all[which(bc_markers_all$cluster=="EC"),]
ct0_df[which(ct0_df$gene %in% EC_f ),]
VlnPlot(pbmc, EC_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 


##Fibroblast :THY1
Fibroblast_f=c('ACTA2','CD81','IL1R1','ITGB1','LRP1','MME','NT5E','PDGFRA','PDGFRB','THY1','VIM')
ct0_df=bc_markers_all[which(bc_markers_all$cluster=="Fibroblast"),]
ct0_df[which(ct0_df$gene %in% Fibroblast_f ),]
VlnPlot(pbmc, Fibroblast_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 
##Mast :SLC18A2
mast_f=c('KIT', 'SLC18A2', 'TPSB2')
VlnPlot(pbmc, mast_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 
##Myeloid : CD14
Myeloid_f=c('CD14', 'FCGR3A')
ct0_df=bc_markers_all[which(bc_markers_all$cluster=="Myeloid"),]
ct0_df[which(ct0_df$gene %in% Myeloid_f ),]

VlnPlot(pbmc, Myeloid_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 
##T_cell :CD3E
T_f=c('CD2', 'CD3E', 'CD7', 'CD8A', 'GZMA', 'IL7R', 'PTPRC')
ct0_df=bc_markers_all[which(bc_markers_all$cluster=="T_cell"),]
ct0_df[which(ct0_df$gene %in% T_f ),]
VlnPlot(pbmc, T_f, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 
#all
all=c("MS4A1",'KRT18',"CD1C","PLVAP","THY1","SLC18A2","CD14","CD3E")
VlnPlot(pbmc, all, stack = TRUE, sort = TRUE, flip = TRUE,cols = c("#922e4b","#a74741","#ad805c","#eebd94","#5a757b","#ae5f63","#89ac95","#a7c5c4"))+
        theme(legend.position = "none") 


ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","DC"="#89ac95","Mast"="#922e4b")) 

###top1fc
features_1=as.data.frame(bc_markers_all %>% group_by(cluster) %>% top_n(n =1, wt = avg_log2FC))$gene

marker_top20[which(marker_top20$cluster=="Cancer"),]

VlnPlot(pbmc, features_1, stack = TRUE, sort = TRUE, flip = TRUE)+
        theme(legend.position = "none") 


VlnPlot(pbmc, features = "CPB1",slot = "counts", log = F)
