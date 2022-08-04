setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/OvC/")
load("OVC_NormalizeData.RData")
library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)
pbmc <- FindVariableFeatures(pbmc, selection.method ="vst", nfeatures =2000)



all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
#########################################################################PCA
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))
save.image("OvC_PCA.RData")


pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)
###NOVA1
pdf("OvC_Cancer_NOVA1_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "NOVA1",reduction='tsne')
dev.off()

pdf("OvC_Cancer_NOVA1_VlnPlot.pdf")
VlnPlot(pbmc,features = c("NOVA1"))
dev.off()

###PCBP2
pdf("OvC_Cancer_PCBP2_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "PCBP2",reduction='tsne')
dev.off()

pdf("OvC_Cancer_PCBP2_VlnPlot.pdf")
VlnPlot(pbmc,features = c("PCBP2"))
dev.off()


###SFPQ
pdf("OvC_Cancer_SFPQ_FeaturePlot.pdf")
FeaturePlot(pbmc,features = "SFPQ",reduction='tsne')
dev.off()

pdf("OvC_Cancer_SFPQ_VlnPlot.pdf")
VlnPlot(pbmc,features = c("SFPQ"))
dev.off()



