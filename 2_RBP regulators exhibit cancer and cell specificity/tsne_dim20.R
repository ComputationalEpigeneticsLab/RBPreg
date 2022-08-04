setwd("/bioXJ/zhouww/SCENIC/scRNA/1_B_tsne/BC/")
load("BC_PCA.RData")
library(Rtsne)
library(dplyr)
library(patchwork)
library(Seurat)
pbmc_claf <- FindNeighbors(pbmc, dims = 1:10)
pbmc_clus <- FindClusters(pbmc_claf, resolution = 0.5) 

pbmc <- RunTSNE(pbmc_clus,dims = 1:20,check_duplicates = FALSE)
pdf(paste0("tSNE",20,".pdf"))
DimPlot(pbmc, reduction ="tsne",label = T)
dev.off()

#library(tidyverse)
#tsne = pbmc@reductions$tsne@cell.embeddings %>% 
  #    as.data.frame() %>% cbind(tx = pbmc@meta.data$seurat_clusters)



#pdf(paste0("tSNE_dim",20,".pdf"))
#ggplot(tsne, aes(x = tSNE_1, y = tSNE_2, color = tx)) + 
#      geom_point(size = 0.2, alpha = 1) + 
#      scale_color_manual(values=c("B_cell" = "#d98d2c", "Cancer" = "#bca131", "DC" = "#8ca326", "EC" = "#58a84b", "Fibroblast" = "#539dd1", "Mast" = "#7f88c2","Myeloid"="#a176b0","T_cell"="#e26fa2"))

#dev.off()


#pdf(paste0("tSNE_dim_num",20,".pdf"))
#ggplot(tsne, aes(x = tSNE_1, y = tSNE_2, color = tx)) + 
#      geom_point(size = 0.2, alpha = 1) + 
#      scale_color_manual(values=c("1" = "#d98d2c", "2" = "#bca131", "3" = "#8ca326", "4" = "#58a84b", "5" = "#539dd1", "6" = "#7f88c2","7"="#a176b0","8"="#e26fa2"))

#dev.off()