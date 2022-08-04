library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)

setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/OvC/")
#LOAD DATA
pbmc.counts <- Read10X(data.dir = "/bioXJ/zhouww/SCENIC/scRNA/4_cancer_jt/OvC/10x/")
#利用上一步数据生成Seurat数据
pbmc <- CreateSeuratObject(counts = pbmc.counts, project ="LC", names.delim = "-",names.field=3)
#pbmc.data[c("CD3D","TCL1A","MS4A1"),1:30]
###############################################################################选取特征
#MT开头的为线粒体gene，线粒体gene越多说明数据质量不好q()
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern ="^MT-")


##规范数据，即标准化
pbmc <- NormalizeData(pbmc, normalization.method ="LogNormalize", scale.factor =10000)
save.image("OVC_NormalizeData.RData")
#找特征并可视化
pbmc <- FindVariableFeatures(pbmc, selection.method ="vst", nfeatures =2000)


##################################################################缩放数据
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
#########################################################################PCA
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))


################验证数据维度方法JackStrawPlot，ElbowPlot(肘图)
pbmc <- JackStraw(pbmc, num.replicate =100)
pbmc <- ScoreJackStraw(pbmc, dims =1:30)
pdf("JackStraw.pdf")
JackStrawPlot(pbmc, dims =1:30)
dev.off()
pdf("Eblow.pdf")
ElbowPlot(pbmc)
dev.off()
