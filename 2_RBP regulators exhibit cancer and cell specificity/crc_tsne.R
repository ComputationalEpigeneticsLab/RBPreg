library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)

setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/CRC/")
#LOAD DATA
pbmc.counts <- Read10X(data.dir = "/bioXJ/zhouww/SCENIC/scRNA/4_cancer_jt/CRC/10x/")
#利用上一步数据生成Seurat数据
pbmc <- CreateSeuratObject(counts = pbmc.counts, project ="LC", names.delim = "-",names.field=3)
#pbmc.data[c("CD3D","TCL1A","MS4A1"),1:30]
###############################################################################选取特征
#MT开头的为线粒体gene，线粒体gene越多说明数据质量不好q()
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern ="^MT-")
#查看特征分布
pdf("1feature.pdf")
VlnPlot(pbmc, features =c("nFeature_RNA","nCount_RNA","percent.mt"), ncol =3)
dev.off()
#两个特征之间的相关性，person相关
plot1 <- FeatureScatter(pbmc, feature1 ="nCount_RNA", feature2 ="percent.mt")
plot2 <- FeatureScatter(pbmc, feature1 ="nCount_RNA", feature2 ="nFeature_RNA")
pdf("2MT_nFeature.pdf")
CombinePlots(plots = list(plot1, plot2))
dev.off()

##规范数据，即标准化
pbmc <- NormalizeData(pbmc, normalization.method ="LogNormalize", scale.factor =10000)
save.image("CRC_NormalizeData.RData")
#找特征并可视化
pbmc <- FindVariableFeatures(pbmc, selection.method ="vst", nfeatures =2000)
top10 <- head(VariableFeatures(pbmc),10)
plot1 <- VariableFeaturePlot(pbmc)

plot2 <- LabelPoints(plot = plot1, points = top10, repel =TRUE)
pdf("3Top10.pdf",width=15)
CombinePlots(plots = list(plot1, plot2))#top10基因
dev.off()

##################################################################缩放数据
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)
#########################################################################PCA
pbmc <- RunPCA(pbmc, features = VariableFeatures(object = pbmc))

save.image("CRC_PCA.RData")
dim_n <- 30#维度

pdf("4heatmap.pdf")
DimHeatmap(pbmc, dims =1:dim_n, cells = 500,balanced =TRUE)
dev.off()
################验证数据维度方法JackStrawPlot，ElbowPlot(肘图)
pbmc <- JackStraw(pbmc, num.replicate =100)
pbmc <- ScoreJackStraw(pbmc, dims =1:20)
pdf("5JackStraw.pdf")
JackStrawPlot(pbmc, dims =1:20)
dev.off()
pdf("6Eblow.pdf")
ElbowPlot(pbmc)
dev.off()
#######################################################################


pbmc <- RunTSNE(pbmc,dims = 1:5,check_duplicates = FALSE)
pdf(paste0("8tSNE",5,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:6,check_duplicates = FALSE)
pdf(paste0("8tSNE",6,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:7,check_duplicates = FALSE)
pdf(paste0("8tSNE",7,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:8,check_duplicates = FALSE)
pdf(paste0("8tSNE",8,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:9,check_duplicates = FALSE)
pdf(paste0("8tSNE",9,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:10,check_duplicates = FALSE)
pdf(paste0("8tSNE",10,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:11,check_duplicates = FALSE)
pdf(paste0("8tSNE",11,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:12,check_duplicates = FALSE)
pdf(paste0("8tSNE",12,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:13,check_duplicates = FALSE)
pdf(paste0("8tSNE",13,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:14,check_duplicates = FALSE)
pdf(paste0("8tSNE",14,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:15,check_duplicates = FALSE)
pdf(paste0("8tSNE",15,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:16,check_duplicates = FALSE)
pdf(paste0("8tSNE",16,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:17,check_duplicates = FALSE)
pdf(paste0("8tSNE",17,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:18,check_duplicates = FALSE)
pdf(paste0("8tSNE",18,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:19,check_duplicates = FALSE)
pdf(paste0("8tSNE",19,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)
pdf(paste0("8tSNE",20,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:21,check_duplicates = FALSE)
pdf(paste0("8tSNE",21,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:22,check_duplicates = FALSE)
pdf(paste0("8tSNE",22,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:23,check_duplicates = FALSE)
pdf(paste0("8tSNE",23,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:24,check_duplicates = FALSE)
pdf(paste0("8tSNE",24,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:25,check_duplicates = FALSE)
pdf(paste0("8tSNE",25,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:26,check_duplicates = FALSE)
pdf(paste0("8tSNE",26,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:27,check_duplicates = FALSE)
pdf(paste0("8tSNE",27,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:28,check_duplicates = FALSE)
pdf(paste0("8tSNE",28,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:29,check_duplicates = FALSE)
pdf(paste0("8tSNE",29,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

pbmc <- RunTSNE(pbmc,dims = 1:30,check_duplicates = FALSE)
pdf(paste0("8tSNE",30,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()