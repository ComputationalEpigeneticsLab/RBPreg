setwd("E:/0_test/scRNA_zww")

res_all <- as.matrix(read.table("res_all.txt",header = T,sep = "\t"))
res_all_new <- cbind(cbind(res_all_new,NA),NA)

res_diffexp <- as.matrix(read.table("E:/3_immReg/5_web/sigPairs/RBP_diffexp_all.txt",header = T,sep = "\t"))

genes_inter <- intersect(res_all[,1],res_diffexp[,3])

{ # BRCA
  res_diffexp_BRCA <- res_diffexp[which(res_diffexp[,1]=="BRCA"),]
  diff_BRCA <- res_diffexp_BRCA[which(res_diffexp_BRCA[,3]%in%genes_inter),]
  rownames(diff_BRCA) <- diff_BRCA[,3]
  ind_BRCA <- which((res_all[,1]%in%genes_inter)&(res_all[,2]=="BC")) ####### BC - BRCA
  res_all_new[ind_BRCA,(ncol(res_all)+1):(ncol(res_all)+2)] <- diff_BRCA[res_all_new[ind_BRCA,1],5:6]
}
{ # COAD
  res_diffexp_COAD <- res_diffexp[which(res_diffexp[,1]=="COAD"),]
  diff_COAD <- res_diffexp_COAD[which(res_diffexp_COAD[,3]%in%genes_inter),]
  rownames(diff_COAD) <- diff_COAD[,3]
  ind_COAD <- which((res_all[,1]%in%genes_inter)&(res_all[,2]=="CRC")) ####### CRC - COAD
  res_all_new[ind_COAD,(ncol(res_all)+1):(ncol(res_all)+2)] <- diff_COAD[res_all_new[ind_COAD,1],5:6]
}
{ # LC
  res_diffexp_LC <- res_diffexp[which(res_diffexp[,1] %in% c("LUAD","LUSC")),]
  diff_LC <- res_diffexp_LC[which(res_diffexp_LC[,3]%in%genes_inter),]
  diff_LC_new <- c()
  for (i in 1:length(unique(diff_LC[,3]))) {
    gene_i <- unique(diff_LC[,3])[i]
    diff_LC_i <- apply(diff_LC[which(diff_LC[,3]==gene_i),], 2, paste,collapse=",")
    diff_LC_new <- rbind(diff_LC_new,diff_LC_i)
  }
  rownames(diff_LC_new) <- unique(diff_LC[,3])
  ind_LC <- which((res_all[,1]%in%genes_inter)&(res_all[,2]=="LC")) ####### LC - LC
  res_all_new[ind_LC,(ncol(res_all)+1):(ncol(res_all)+2)] <- diff_LC_new[res_all_new[ind_LC,1],5:6]
}

{ # OvC - 0 diff result
  res_diffexp_OV <- res_diffexp[which(res_diffexp[,1]=="OV"),]
  diff_OV <- res_diffexp_OV[which(res_diffexp_OV[,3]%in%genes_inter),]
  rownames(diff_OV) <- diff_OV[,3]
  ind_OV <- which((res_all[,1]%in%genes_inter)&(res_all[,2]=="BC")) ####### BC - OV
  res_all_new[ind_OV,(ncol(res_all)+1):(ncol(res_all)+2)] <- diff_OV[res_all_new[ind_OV,1],5:6]
}

res_all_new_noNA <- res_all_new[which(!((is.na(res_all_new[,10]))|(is.na(res_all_new[,12])))),]
res_all_new_noNA_LC <- res_all_new_noNA[which(res_all_new_noNA[,2]=="LC"),]
res_all_new_noNA_other <- res_all_new_noNA[which(!(res_all_new_noNA[,2]=="LC")),]

write.table(res_all_new_noNA,"E:/0_test/scRNA_zww/res_all_new_noNA.txt",row.names = F,col.names = T,sep = "\t",quote = F)
{ # other
  ind_other_sigUp_scRNA <- which((res_all_new_noNA_other[,9]=="DEg")&(res_all_new_noNA_other[,10]=="up"))
  ind_other_sigUp_TCGA <- which((as.numeric(res_all_new_noNA_other[,11])<0.05)&(as.numeric(res_all_new_noNA_other[,12])>0))
  ind_other_sigDw_scRNA <- which((res_all_new_noNA_other[,9]=="DEg")&(res_all_new_noNA_other[,10]=="down"))
  ind_other_sigDw_TCGA <- which((as.numeric(res_all_new_noNA_other[,11])<0.05)&(as.numeric(res_all_new_noNA_other[,12])<0))
  State_scRNA_other <- rep(NA,nrow(res_all_new_noNA_other))
  State_scRNA_other[ind_other_sigUp_scRNA] <- "sigUp"
  State_scRNA_other[ind_other_sigDw_scRNA] <- "sigDw"
  State_TCGA_other <- rep(NA,nrow(res_all_new_noNA_other))
  State_TCGA_other[ind_other_sigUp_TCGA] <- "sigUp"
  State_TCGA_other[ind_other_sigDw_TCGA] <- "sigDw"
  res_all_new_noNA_other[,11:12] <- cbind(State_scRNA_other,State_TCGA_other)
}
{ # LC
  ind_LC_sigUp_scRNA <- which((res_all_new_noNA_LC[,9]=="DEg")&(res_all_new_noNA_LC[,10]=="up"))
  ind_LC_sigDw_scRNA <- which((res_all_new_noNA_LC[,9]=="DEg")&(res_all_new_noNA_LC[,10]=="down"))
  FDR_split <- strsplit(res_all_new_noNA_LC[,11] ,",")
  logFC_split <- strsplit(res_all_new_noNA_LC[,12] ,",")
  ind_FDR_allSig <- sapply(FDR_split, function(x){
    return((as.numeric(x[1])<0.05)&(as.numeric(x[2])<0.05))
  })
  ind_logCF_UP_DW <- sapply(logFC_split, function(x){
    if((as.numeric(x[1])>0)&(as.numeric(x[2])>0)){
      res <- "up"
    }else{
      if((as.numeric(x[1])<0)&(as.numeric(x[2])<0)){
        res <- "dw"
      }else{ res <- "-"}
    } 
    return(res)
  })
  ind_LC_sigUp_TCGA <- which((ind_FDR_allSig)&(ind_logCF_UP_DW=="up"))
  ind_LC_sigDw_TCGA <- which((ind_FDR_allSig)&(ind_logCF_UP_DW=="dw"))
  State_scRNA_LC <- rep(NA,nrow(res_all_new_noNA_LC))
  State_scRNA_LC[ind_LC_sigUp_scRNA] <- "sigUp"
  State_scRNA_LC[ind_LC_sigDw_scRNA] <- "sigDw"
  State_TCGA_LC <- rep(NA,nrow(res_all_new_noNA_LC))
  State_TCGA_LC[ind_LC_sigUp_TCGA] <- "sigUp"
  State_TCGA_LC[ind_LC_sigDw_TCGA] <- "sigDw"
  res_all_new_noNA_LC[,11:12] <- cbind(State_scRNA_LC,State_TCGA_LC)
}

res_all_new_all <- rbind(res_all_new_noNA_other,res_all_new_noNA_LC)
colnames(res_all_new_all)[11:12] <- c("State_scRNA","State_TCGA")
write.table(res_all_new_all,"E:/0_test/scRNA_zww/res_with_TCGA_all.txt",quote = F,sep = "\t",row.names = F,col.names = T)
res_all_new_all <- read.table("E:/0_test/scRNA_zww/res_with_TCGA_all.txt",header = T,sep = "\t")
write.table(res_all_new_all,"E:/0_test/scRNA_zww/res_with_TCGA_all.txt",quote = F,sep = "\t",row.names = F,col.names = T)

ind_same <- apply(as.matrix(res_all_new_all[,11:12]), 1, function(x){x[1]==x[2]})
res_all_new_same <- res_all_new_all[which(ind_same),c(1:3,11:12)]
write.table(res_all_new_same,"E:/0_test/scRNA_zww/res_with_TCGA_same.txt",quote = F,sep = "\t",row.names = F,col.names = T)

save.image("E:/0_test/scRNA_zww/res.RData")
load("E:/0_test/scRNA_zww/res.RData")
