if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DEsingle")
library(DEsingle)
library(Seurat)

########### test method - useless #############################
data(TestData)
group <- factor(c(rep(1,50), rep(2,100)))
results <- DEsingle(counts = counts, group = group)
results.classified <- DEtype(results = results, threshold = 0.05)

########### scRNA data #############################
setwd("E:/3_immReg/6_merge/3_immCell/A_scImmCell")

BC<- Read10X(data.dir = "pancancer/BC_counts/")
pbmc_BC <- CreateSeuratObject(counts = BC, project ="pbmc3k", min.cells =3, min.features =200)
BC_sample <- as.matrix(read.table("pancancer/BC_counts/BC_metadata.csv",header = T,quote = "",sep = ","))

CRC<- Read10X(data.dir = "pancancer/CRC_counts/")
pbmc_CRC <- CreateSeuratObject(counts = CRC, project ="pbmc3k", min.cells =3, min.features =200)
CRC_sample <- as.matrix(read.table("pancancer/CRC_counts/CRC_metadata.csv",header = T,quote = "",sep = ","))

LC<- Read10X(data.dir = "pancancer/LC_counts/")
pbmc_LC <- CreateSeuratObject(counts = LC, project ="pbmc3k", min.cells =3, min.features =200)
LC_sample <- as.matrix(read.table("pancancer/LC_counts/LC_metadata.csv",header = T,quote = "",sep = ","))

OvC<- Read10X(data.dir = "pancancer/OvC_counts/")
pbmc_OvC <- CreateSeuratObject(counts = OvC, project ="pbmc3k", min.cells =3, min.features =200)
OvC_sample <- as.matrix(read.table("pancancer/OvC_counts/OvC_metadata.csv",header = T,quote = "",sep = ","))

########### RBP DEG in 4 cancer #############################

setwd("E:/0_test/scRNA_zww")
regulons_all_ori <- as.matrix(read.table("4_cancer_cancer_cell_regulons.txt",header = T,sep = "\t",quote = ""))
BC_genes <- as.matrix(read.table("4_cancer_expermat/BC_genes.txt",header = F,sep = "\t",quote = ""))
CRC_genes <- as.matrix(read.table("4_cancer_expermat/CRC_genes.txt",header = F,sep = "\t",quote = ""))
LC_genes <- as.matrix(read.table("4_cancer_expermat/LC_genes.txt",header = F,sep = "\t",quote = ""))
OvC_genes <- as.matrix(read.table("4_cancer_expermat/OvC_genes.txt",header = F,sep = "\t",quote = ""))

BC_use <- BC[which(rownames(BC)%in%BC_genes),] ; rm(BC)
BC_use=as.data.frame(BC_use)
CRC_use <- CRC[which(rownames(CRC)%in%CRC_genes),] ; rm(CRC)
CRC_use=as.data.frame(CRC_use)
LC_use <- LC[which(rownames(LC)%in%LC_genes),] ; rm(LC)
LC_use=as.data.frame(LC_use)
OvC_use <- OvC[which(rownames(OvC)%in%OvC_genes),] ; rm(OvC)
OvC_use=as.data.frame(OvC_use)

########################## BC ##########################
regulons_BC_ori <- regulons_all_ori[which(regulons_all_ori[,2]=="BC"),]
cellType_BC <- unique(regulons_BC_ori[,3])
cellType_BC[which(cellType_BC=="Mast_cell")] <- "Mast"
for (i in 4:length(cellType_BC)) {
  cellType_BC_i <- cellType_BC[i]
  samples_cellType_BC_i <- BC_sample[which(BC_sample[,8]==cellType_BC_i),1]
  samples_cellType_BC_other <- BC_sample[!(BC_sample[,8]==cellType_BC_i),1]
  counts_i <- BC_use[,c(samples_cellType_BC_i,samples_cellType_BC_other)]
  ind_col_sum0 <- (colSums(counts_i)==0)
  counts_i_no0 <- counts_i[,!ind_col_sum0]
  group_i <- factor(c(rep("cellType_i",length(intersect(samples_cellType_BC_i,names(which(!ind_col_sum0))))), 
                      rep("other",length(intersect(samples_cellType_BC_other,names(which(!ind_col_sum0)))))))
  
  results_i <- DEsingle(counts = counts_i_no0, group = group_i)
  results.classified <- DEtype(results = results_i, threshold = 0.05)
  write.table(results.classified,paste0("result_DE/BC-",cellType_BC_i,"-res.txt"),quote = F,sep = "\t",row.names = T,col.names = T)
}

########################## CRC ##########################
regulons_CRC_ori <- regulons_all_ori[which(regulons_all_ori[,2]=="CRC"),]
cellType_CRC <- unique(regulons_CRC_ori[,3])
#cellType_CRC[which(cellType_CRC=="Mast_cell")] <- "Mast"
cellType_CRC_use <- intersect(cellType_CRC,unique(CRC_sample[,8]))
for (i in 2:length(cellType_CRC_use)) {
  cellType_CRC_use_i <- cellType_CRC_use[i]
  samples_cellType_CRC_use_i <- CRC_sample[which(CRC_sample[,8]==cellType_CRC_use_i),1]
  samples_cellType_CRC_use_other <- CRC_sample[!(CRC_sample[,8]==cellType_CRC_use_i),1]
  counts_i <- CRC_use[,c(samples_cellType_CRC_use_i,samples_cellType_CRC_use_other)]
  ind_col_sum0 <- (colSums(counts_i)==0)
  counts_i_no0 <- counts_i[,!ind_col_sum0]
  group_i <- factor(c(rep("cellType_i",length(intersect(samples_cellType_CRC_use_i,names(which(!ind_col_sum0))))), 
                      rep("other",length(intersect(samples_cellType_CRC_use_other,names(which(!ind_col_sum0)))))))
  
  results_i <- DEsingle(counts = counts_i_no0, group = group_i)
  results.classified <- DEtype(results = results_i, threshold = 0.05)
  write.table(results.classified,paste0("result_DE/CRC-",cellType_CRC_use_i,"-res.txt"),quote = F,sep = "\t",row.names = T,col.names = T)
}

########################## LC ##########################
regulons_LC_ori <- regulons_all_ori[which(regulons_all_ori[,2]=="LC"),]
cellType_LC <- unique(regulons_LC_ori[,3])
#cellType_LC[which(cellType_LC=="Mast_cell")] <- "Mast"
cellType_LC_use <- intersect(cellType_LC,unique(LC_sample[,8]))
for (i in 1:length(cellType_LC_use)) {
  cellType_LC_use_i <- cellType_LC_use[i]
  samples_cellType_LC_use_i <- LC_sample[which(LC_sample[,8]==cellType_LC_use_i),1]
  samples_cellType_LC_use_other <- LC_sample[!(LC_sample[,8]==cellType_LC_use_i),1]
  counts_i <- LC_use[,c(samples_cellType_LC_use_i,samples_cellType_LC_use_other)]
  ind_col_sum0 <- (colSums(counts_i)==0)
  counts_i_no0 <- counts_i[,!ind_col_sum0]
  group_i <- factor(c(rep("cellType_i",length(intersect(samples_cellType_LC_use_i,names(which(!ind_col_sum0))))), 
                      rep("other",length(intersect(samples_cellType_LC_use_other,names(which(!ind_col_sum0)))))))
  
  results_i <- DEsingle(counts = counts_i_no0, group = group_i)
  results.classified <- DEtype(results = results_i, threshold = 0.05)
  write.table(results.classified,paste0("result_DE/LC-",cellType_LC_use_i,"-res.txt"),quote = F,sep = "\t",row.names = T,col.names = T)
}

########################## OvC ##########################
regulons_OvC_ori <- regulons_all_ori[which(regulons_all_ori[,2]=="OvC"),]
cellType_OvC <- unique(regulons_OvC_ori[,3])
#cellType_OvC[which(cellType_OvC=="Mast_cell")] <- "Mast"
cellType_OvC_use <- intersect(cellType_OvC,unique(OvC_sample[,8]))
for (i in 1:length(cellType_OvC_use)) {
  cellType_OvC_use_i <- cellType_OvC_use[i]
  samples_cellType_OvC_use_i <- OvC_sample[which(OvC_sample[,8]==cellType_OvC_use_i),1]
  samples_cellType_OvC_use_other <- OvC_sample[!(OvC_sample[,8]==cellType_OvC_use_i),1]
  counts_i <- OvC_use[,c(samples_cellType_OvC_use_i,samples_cellType_OvC_use_other)]
  ind_col_sum0 <- (colSums(counts_i)==0)
  counts_i_no0 <- counts_i[,!ind_col_sum0]
  group_i <- factor(c(rep("cellType_i",length(intersect(samples_cellType_OvC_use_i,names(which(!ind_col_sum0))))), 
                      rep("other",length(intersect(samples_cellType_OvC_use_other,names(which(!ind_col_sum0)))))))
  
  results_i <- DEsingle(counts = counts_i_no0, group = group_i)
  results.classified <- DEtype(results = results_i, threshold = 0.05)
  write.table(results.classified,paste0("result_DE/OvC-",cellType_OvC_use_i,"-res.txt"),quote = F,sep = "\t",row.names = T,col.names = T)
}

############################ deal result files ##########################
setwd("E:/0_test/scRNA_zww")
regulons_all_ori <- as.matrix(read.table("4_cancer_cancer_cell_regulons.txt",header = T,sep = "\t",quote = ""))

files_res <- list.files("E:/0_test/scRNA_zww/result_DE")
res_all <- c()
for (i in 1:length(files_res)) {
  cancer_i <- unlist(strsplit(files_res[i],"-"))[1]
  cell_i <- unlist(strsplit(files_res[i],"-"))[2]
  regulons_i_psaste <- regulons_all_ori[which((regulons_all_ori[,2]==cancer_i)&(regulons_all_ori[,3]==cell_i)),5]
  regulons_i_split <- stringr::str_split(regulons_i_psaste,"[ ,]")
  regulons_i <- unlist(regulons_i_split)[c(TRUE,FALSE)]
  
  res_i_ori <- read.table(paste0("E:/0_test/scRNA_zww/result_DE/",files_res[i]),sep = "\t")
  res_i_use <- res_i_ori[intersect(regulons_i,rownames(res_i_ori)),
                         c("total_mean_1","total_mean_2","foldChange","pvalue","pvalue.adj.FDR","Type","State")]
  res_i_use <- cbind(rownames(res_i_use),cancer_i,cell_i,res_i_use)
  res_all <- rbind(res_all,res_i_use)
}

write.table(res_all,"res_all.txt",row.names = F,col.names = T,sep = "\t",quote = F)

###################### analyze result #########################################
res_all_RBP <- unique(as.character(res_all[,1]))
res_all_RBP_table <- by(res_all$State,res_all$`rownames(res_i_use)`,table) 


