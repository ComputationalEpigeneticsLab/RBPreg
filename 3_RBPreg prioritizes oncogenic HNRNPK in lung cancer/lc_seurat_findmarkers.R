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
dir_out="E:\\project\\singcells\\1_diff_exper_analysis\\4_cancer_gene_seurat\\4_cancer_Findallmarkers\\lc\\"
load(paste0(dir1,"lc_pbmc.Rdata"))


lc_markers_all<- FindAllMarkers(pbmc,min.pct = 0.1, logfc.threshold = 0.25,only.pos=T)
write.table(lc_markers_all,paste0(dir_out,"lc_marker_all.txt"), sep='\t',row.names =T, col.names =T, quote =F)
lc_markers_all=read.table(paste0(dir_out,"lc_marker_all1.txt"),header=TRUE,sep="\t",as.is=TRUE,row.names = 1)
marker_top20<-as.data.frame(lc_markers_all %>% group_by(cluster) %>% top_n(n =20, wt = avg_log2FC))
write.table(marker_top20,paste0(dir_out,"lc_marker_top20.txt"), sep='\t',row.names =T, col.names =T, quote =F)
min(marker_top20$avg_log2FC)
marker_top20_gene=unique(marker_top20$gene)

regs=marker_top20_gene

cellinfor=read.csv("E:\\project\\singcells\\scRNA_data\\jt_pan-cancer blueprint microenvironment single-cell profiling\\LC_counts\\LC_metadata.csv",header=T,sep=",",as.is=TRUE,comment.char = "!",row.names = 1,check.names = F)
cellinfor=cellinfor[sort(cellinfor$CellType,index.return=TRUE)$ix,]
cellinfor[1:3,]
exprMat_Lc=as.matrix(pbmc[["RNA"]]@counts[regs,])
exprMat_Lc=exprMat_Lc[,paste0(gsub("_", "-", rownames(cellinfor)),"-",cellinfor$CellType)]

annotation_col=data.frame(CellType =cellinfor$CellType)

rownames(annotation_col) =colnames(exprMat_Lc)

unique(annotation_col$CellType)

ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63","Alveolar"="#b1aa9b",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","Erythroblast"="#dabb70","Mast_cell"="#922e4b","Epithelial"="#e8d6bf")) 
ha1 = HeatmapAnnotation(df = annotation_col,
                        col = ann_colors,show_annotation_name = F)



save(exprMat_Lc,ha1,annotation_col,file =paste0(dir_out,"crc_markerTop20_heatmap.Rdata"))

pdf(paste0(dir_out,"lc_noCluster_103.pdf"),width = 15,height = 12)
Heatmap(log2(exprMat_Lc+1),cluster_columns =F,cluster_rows =F,
        show_column_names =F,
        #col=colorRampPalette(colors = c("#7498A0", "#E2C45D"))(100),
        col = colorRamp2(c(0.1,5,10), c("white","#EE5C42","#FF0000")),
        column_split = annotation_col$CellType,
        show_heatmap_legend = T,
        row_names_gp = gpar(fontsize = 5),
        # use_raster =F,
        top_annotation = ha1)

dev.off()
###########VlnPlot#########
##Alveolar no :SFTPA2
Alveolar_f=lc_markers_all[which(lc_markers_all$cluster=="Alveolar"),]$gene[1:10]
VlnPlot(pbmc, Alveolar_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##B_cell:CD79A
B_cell_f=c('BANK1', 'CD79A', 'CD79B', 'IGLL5', 'JCHAIN', 'MS4A1', 'VPREB3')
VlnPlot(pbmc, B_cell_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Cancer :ERBB2
Cancer_f=c('EPCAM', 'ERBB2', 'KRT18', 'KRT19', 'MUC1', 'MUC16', 'NPEPPS')
ct0_df=lc_markers_all[which(lc_markers_all$cluster=="Cancer"),]
ct0_df[which(ct0_df$gene %in% Cancer_f ),]
VlnPlot(pbmc, Cancer_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##EC VWF
EC_f=c('GNG11', 'VWF')
VlnPlot(pbmc, EC_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Epithelial :DDR1
Epithelial_f=c('CD24','CDH1','CTNNB1','DDR1','EPCAM','FOLR1','IL1R1','ITGB4','KRT18','KRT19','KRT8','MUC1','PROM1')
ct0_df=lc_markers_all[which(lc_markers_all$cluster=="Epithelial"),]
ct0_df[which(ct0_df$gene %in% Epithelial_f ),]

VlnPlot(pbmc, Epithelial_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Erythroblast  'AHSP'
VlnPlot(pbmc, features = "AHSP",slot = "counts", log = F)
###Fibroblast 'ACTA2'
##Mast_cell SLC18A2
Mast_cell_f=c('KIT', 'SLC18A2', 'TPSB2')
VlnPlot(pbmc, Mast_cell_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##Myeloid :CD14
Myeloid_f=c('ANPEP', 'CD14', 'CD33', 'FCGR3A', 'IL3RA', 'ITGAM', 'ITGAX')
VlnPlot(pbmc, Myeloid_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
##T_cell
T_cell_f=c('CD2', 'CD3E', 'CD7', 'GZMA')
VlnPlot(pbmc, T_cell_f, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none")
####all
all=c("SFTPA2","CD79A","ERBB2","VWF","DDR1","AHSP","ACTA2","SLC18A2","CD14","CD2")
VlnPlot(pbmc, all, stack = TRUE, sort = TRUE, flip = TRUE,
        cols = c("#922e4b","#b1aa9b","#5a757b","#e8d6bf","#ae5f63","#eebd94","#a7c5c4","#dabb70","#a74741","#ad805c"))+
  theme(legend.position = "none")

ann_colors = list(CellType = c('Cancer'= "#5a757b", 'T_cell' = "#ad805c","Fibroblast"="#ae5f63","Alveolar"="#b1aa9b",
                               "Myeloid"="#a7c5c4","EC"="#eebd94","B_cell"="#a74741","Erythroblast"="#dabb70","Mast_cell"="#922e4b","Epithelial"="#e8d6bf")) 
####top1
VlnPlot(pbmc, features = regs[1:3],slot = "counts", log = TRUE)
features_1=as.data.frame(lc_markers_all %>% group_by(cluster) %>% top_n(n =1, wt = avg_log2FC))$gene

marker_top20[which(marker_top20$cluster=="Cancer"),]

VlnPlot(pbmc, features_1, stack = TRUE, sort = TRUE, flip = TRUE)+
  theme(legend.position = "none") 

VlnPlot(pbmc, features_1, stack = TRUE, sort = TRUE) +
  theme(legend.position = "none") + ggtitle("top1_fc")
######HNRNPK
VlnPlot(pbmc, features = "HNRNPK",slot = "counts", log = TRUE,pt.size = 0,
        cols = c("#b1aa9b","#a74741","#5a757b","#eebd94","#e8d6bf","#dabb70","#ae5f63","#922e4b","#a7c5c4","#ad805c"))



exp_hnrnpk=pbmc[["RNA"]]@counts["HNRNPK",]
group=c()
for (i in 1:length(names(exp_hnrnpk))){
  group=c(group,strsplit(names(exp_hnrnpk)[i],"-")[[1]][3])
}
group
exp_hnrnpk_exp=unname(exp_hnrnpk)
hnrnpk_kw<-data.frame(exp_hnrnpk_exp=exp_hnrnpk_exp,group=group)
kruskal.test(exp_hnrnpk_exp~group,data=hnrnpk_kw)
#p<2.2e-16


