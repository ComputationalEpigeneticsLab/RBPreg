setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/BC/")
load("BC_PCA.RData")
library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)

pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)


pdf("VlnPlot.pdf"))
VlnPlot(pbmc_tsne, features = c("CXCL1"))
dev.off()

pdf("FeaturePlot.pdf"))
FeaturePlot(pbmc,features = "CXCL1",reduction='tsne')
dev.off()