setwd("E:\\project\\singcells\\7_Correlation\\HNRNPK\\SC_cancer\\")
lc<- Read10X(data.dir = "E:\\project\\singcells\\scRNA_data\\jt_pan-cancer blueprint microenvironment single-cell profiling\\LC_counts\\lc_10x\\")
lc <- CreateSeuratObject(counts = lc, project ="pbmc3k", min.cells =3, min.features =200)
cancer_cell=as.matrix(read.table("E:\\project\\singcells\\scRNA_data\\jt_pan-cancer blueprint microenvironment single-cell profiling\\LC_counts\\by_cell\\Cancer.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F))
cancer_cell_name=cancer_cell[,1]
lc_cancer_exp_matrix=as.matrix(lc[["RNA"]]@counts[,which(colnames(lc[["RNA"]]@counts) %in% cancer_cell_name)])
write.table(lc_cancer_exp_matrix,"lc_cancer_exp_matrix.txt",sep = "\t",col.names = T,row.names = T,quote=F)
