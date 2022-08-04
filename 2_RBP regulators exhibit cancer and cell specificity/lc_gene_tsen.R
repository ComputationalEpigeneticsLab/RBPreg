setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/LC/")
load("LC_PCA.RData")
library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)

pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)
###NONO
pdf("LC_Cancer_NONO_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "NONO",reduction='tsne')
dev.off()

pdf("LC_Cancer_NONO_VlnPlot.pdf")
VlnPlot(pbmc,features = c("NONO"))
dev.off()



###PUM1
pdf("LC_Cancer_PUM1_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "PUM1",reduction='tsne')
dev.off()

pdf("LC_Cancer_PUM1_VlnPlot.pdf")
VlnPlot(pbmc,features = c("PUM1"))
dev.off()

###TRA2B
pdf("LC_Cancer_TRA2B_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "TRA2B",reduction='tsne')
dev.off()

pdf("LC_Cancer_TRA2B_VlnPlot.pdf")
VlnPlot(pbmc,features = c("TRA2B"))
dev.off()