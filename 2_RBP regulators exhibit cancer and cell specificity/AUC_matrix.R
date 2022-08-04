setwd("E:\\project\\singcells\\1_C_regulons\\BC\\")

regulons=readRDS("BC_T_cell_3.4_regulonAUC.Rds")
test_AUC <- regulons@assays@data@listData$AUC
write.table(test_AUC, file = "AUC_value_matrix\\BC_T_cell_AUC.txt",row.names = T,col.names = T,quote = F,sep = "\t")