library(Seurat)
load("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/BC/BC_PCA.RData")
pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)

regs=read.table("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/reg_infor/BC_regulon_all_u.txt",header=F,as.is=TRUE,comment.char = "!",check.names = F)$V1
for (i in 1:length(regs)){
pdf(paste0("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/bc_regs_feature/",regs[i],".pdf"))
FeaturePlot(pbmc, features = regs[i])
dev.off()
}
pdf("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/bc_regs_feature/bc_all.pdf")
FeaturePlot(pbmc, features = regs)
dev.off()

rm(list = ls())

load("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/CRC/CRC_PCA.RData")
pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)
regs=read.table("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/reg_infor/CRC_regulon_all_u.txt",header=F,as.is=TRUE,comment.char = "!",check.names = F)$V1

for (i in 1:length(regs)){
pdf(paste0("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/crc_regs_feature/",regs[i],".pdf"))
FeaturePlot(pbmc, features = regs[i])
dev.off()
}
pdf("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/crc_regs_feature/crc_all.pdf")
FeaturePlot(pbmc, features = regs)
dev.off()

rm(list = ls())


load("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/OvC/OvC_PCA.RData")
pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)
regs=read.table("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/reg_infor/OvC_regulon_all_u.txt",header=F,as.is=TRUE,comment.char = "!",check.names = F)$V1

for (i in 1:length(regs)){
pdf(paste0("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/ovc_regs_feature/",regs[i],".pdf"))
FeaturePlot(pbmc, features = regs[i])
dev.off()
}
pdf("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/ovc_regs_feature/ovc_all.pdf")
FeaturePlot(pbmc, features = regs)
dev.off()
rm(list = ls())

load("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/LC/LC_PCA.RData")
pbmc <- RunTSNE(pbmc,dims = 1:20,check_duplicates = FALSE)

regs=read.table("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/reg_infor/LC_regulon_all_u.txt",header=F,as.is=TRUE,comment.char = "!",check.names = F)$V1

for (i in 1:length(regs)){
pdf(paste0("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/lc_regs_feature/",regs[i],".pdf"))
FeaturePlot(pbmc, features = regs[i])
dev.off()
}
pdf("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/4_cancer_reg_featurePlot/lc_regs_feature/lc_all.pdf")
FeaturePlot(pbmc, features = regs)
dev.off()
rm(list = ls())
