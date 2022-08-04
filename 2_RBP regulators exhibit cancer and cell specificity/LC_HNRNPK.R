setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/LC/")
load("LC_PCA.RData")
library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)


pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)
###HNRNPK 
pdf("LC_Bcell_Cancer_mastcell_Fibroblast_Tcell_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "HNRNPK",reduction='tsne')
dev.off()

pdf("LC_Bcell_Cancer_mastcell_Fibroblast_Tcell_VlnPlot.pdf")
VlnPlot(pbmc,features = c("HNRNPK"))
dev.off()