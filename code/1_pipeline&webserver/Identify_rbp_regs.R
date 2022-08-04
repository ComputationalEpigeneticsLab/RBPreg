Identify_rbp_regs <- function(file_exp,ID_new,select_MinCountsPerGene,select_MinSamples,webPath,innerpath){
  library(SCENIC)
  library(doParallel)
  library(jsonlite)
  library(stringr)
  file_exp=file_exp
  ID_new=ID_new
  select_MinCountsPerGene=select_MinCountsPerGene
  select_MinSamples=select_MinSamples
  webPath=webPath
  innerpath=innerpath
  color_all=read.table(paste0(innerpath,"/color.txt"),as.is=TRUE,comment.char = "!",check.names = F)$V1
  color_all=c(color_all,color_all,color_all,color_all)###max 160
  ## updata Job_ID.txt, append a new job and state is run
  Task_ID <- as.matrix(read.table(paste0(innerpath,"/Job_ID.txt"),header = F,sep = "\t",check.names = F,fill = T))
  Task_ID_new <- rbind(Task_ID,c(ID_new,"run"))
  write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
  ###write base parameter
  basefolder=paste0("upload/",ID_new)
  base_parameter <- paste0("{","\n",
                           '"webPath" :','"',webPath,'",',"\n",
                           '"basefolder" :','"',basefolder,'",',"\n",
                           '"JobId" :','"',ID_new,'",',"\n",
                           '"UserUploadFileName" :','"',file_exp,'",',"\n",
                           '"select_MinCountsPerGene" :','"',select_MinCountsPerGene,'",',"\n",
                           '"select_MinSamples" :','"',select_MinSamples,'",',"\n",
                           '"JobId" :','"',ID_new,'",'
                           
  )
  write.table(base_parameter,paste0(webPath,"/","job_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
tryCatch({
  ##read file
  scRNA_exp <- as.matrix(read.table(paste0(webPath,"/",file_exp),header = T,sep = "\t",row.names = 1,check.names = F))
  ###记得加对文件的控制

  
  ###STRT SCENIC #####
  setwd(webPath)
  mydbs <- "hg19-500bp-upstream-7species.mc9nr.feather"
  names(mydbs) <- ID_new
  scenicOptions <- initializeScenic(org="hgnc", 
                                    nCores=1,
                                    dbDir=innerpath, 
                                    dbs = mydbs,
                                    datasetTitle = ID_new)  
  
  ####scenic part 1####
  genesKept <- geneFiltering(scRNA_exp, scenicOptions, 
                             minCountsPerGene = as.numeric(select_MinCountsPerGene) * ncol(scRNA_exp), 
                             minSamples = ncol(scRNA_exp) * as.numeric(select_MinSamples))
  exprMat_filtered <- scRNA_exp[genesKept, ]
  ###加上全删除完了的控制
  ###write pie keep,del
  parameter_right_pie=paste0(length(genesKept),",",dim(scRNA_exp)[1]-length(genesKept))
  parameter_right_pie_w<- paste0(
    '"parameter_right_pieGene" :','"',parameter_right_pie,'",'
  )
  write.table(parameter_right_pie_w,paste0(webPath,"/","job_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
  ####write end
  ###############计算相关性矩阵
  runCorrelation(exprMat_filtered, scenicOptions)
  ##RBP-Targets相关性回归分析####
  expr_filtered_log <- log2(exprMat_filtered+1)
  runGenie3(expr_filtered_log, scenicOptions, nParts =8)
  #####推断共表达模块
  runSCENIC_1_coexNetwork2modules(scenicOptions)
  ##Motif验证共表达模块推断转录调控网络（regulon
  runSCENIC_2_createRegulons(scenicOptions)
  ##Regulon活性评分与可视化
  exp_matrix_all <- log2(scRNA_exp+1)
  runSCENIC_3_scoreCells(scenicOptions, exprMat=exp_matrix_all)
  ####scenic end
  #write.table(1,paste0(webPath,"/","A1.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
  ### add result ###
  #scenicOptions@fileNames[["int"]]
  #scenicOptions@fileNames[["output"]]
  auc=readRDS("int/3.4_regulonAUC.Rds")
aucmat=as.matrix(auc@assays@data$AUC)
regulonTargetsInfo <- read.table("output/Step2_regulonTargetsInfo.tsv",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F)
colnames(regulonTargetsInfo)=c("RBP","gene","nMotifs","bestMotif","NES","highConfAnnot","CoexWeight")
corrMat=readRDS("int/1.2_corrMat.Rds")
###append spearCor
if (!is.null(corrMat)) {
  regulonTargetsInfo$spearCor <- NA_real_
  for (tf in unique(regulonTargetsInfo$RBP)) {
    regulonTargetsInfo[which(regulonTargetsInfo$RBP == tf), "spearCor"] <- corrMat[tf, unlist(regulonTargetsInfo[which(regulonTargetsInfo$RBP ==tf), "gene"])]
  }
}
###regnames
Regulons=auc@NAMES
regs=paste(Regulons,collapse=",")
### whole table
write.table(regulonTargetsInfo,paste0(webPath,"/RegulonInfo.txt"),row.names = F,col.names = T,sep = "\t",quote = F)##for download
#replace nan only col 9,10
regulonTargetsInfo[which(is.na(regulonTargetsInfo[,8])),8]=1
regulonTargetsInfo[which(is.na(regulonTargetsInfo[,7])),7]=1

regulonTargetsInfo_json <- toJSON(regulonTargetsInfo, pretty=TRUE)
cat(str_c('{\"data\": ',regulonTargetsInfo_json,'}'), file = paste0(webPath,"/","scenic_re_table.txt"), fill = FALSE, labels = NULL, append = FALSE)
ScenicReMainTable="scenic_re_table.txt"
ScenicReMainTable_download="RegulonInfo.txt"
#write.table(1,paste0(webPath,"/","A2.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
###violin####
##auc violin
auc_value=c()
regs_name=c()
for (i in 1: dim(aucmat)[1]){
  auc_value=c(auc_value,unname(aucmat[rownames(aucmat)[i],]))
  regs_name=c(regs_name,rep(rownames(aucmat)[i],dim(aucmat)[2]))
}
auc_violin=data.frame(auc_value,regs_name)
write.table(auc_violin,paste0(webPath,"/scenic_auc_violin.csv"),row.names = F,col.names = T,sep = ",",quote = F)##for violin

##exp
rbp_name=c()
for (i in 1:length(rownames(aucmat))){
  rbp_name=c(rbp_name,strsplit(rownames(aucmat)[i]," ")[[1]][1])
}
exprMat_rbp=scRNA_exp[rbp_name,]
exp=c()
RBP=c()
for (i in 1: dim(exprMat_rbp)[1]){
  exp=c(exp,unname(exprMat_rbp[rbp_name[i],]))
  RBP=c(RBP,rep(rbp_name[i],dim(exprMat_rbp)[2]))
}
exp_violin=data.frame(exp,RBP)
write.table(exp_violin,paste0(webPath,"/scenic_RBPexp_violin.csv"),row.names = F,col.names = T,sep = ",",quote = F)##for violin
Scenic_AUCviolin_file="scenic_auc_violin.csv"
Scenic_AUCviolin_regName=paste(rownames(aucmat),collapse=",")
Scenic_AUCviolin_regColor=paste(color_all[1:length(rownames(aucmat))],collapse=",")
Scenic_EXPviolin_file="scenic_RBPexp_violin.csv"
Scenic_EXPviolin_regName=paste(rbp_name,collapse=",")
Scenic_EXPviolin_regColor=paste(color_all[1:length(rbp_name)],collapse=",")
#write.table(1,paste0(webPath,"/","A3.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
####pathway enrich####

bg_num=19955
######scatter
###hallmark
hallmark_scatter_p_v_min="0"
hallmark_scatter_p_v_max="0"
hallmark_scatter_inter_v_min="0"
hallmark_scatter_inter_v_max="0"
hallmark_scatter_x_s_data="0"
hallmark_scatter_y_s_data="0"
hallmark_scatter_value_s_data="0"
pathwayname="cancerhallmark"
pathway_infor=read.table(paste0(innerpath,"/",pathwayname,".txt"),header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F)
re_cancerhallmark=RBP_pathway_enrich_fuction(pathway_infor,regulonTargetsInfo,bg_num)
#write.table(1,paste0(webPath,"/","A4.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
if(class(re_cancerhallmark)=="character"){
  hallmark_scatter="error"
}else{
  scatter_use=re_cancerhallmark[,c("Regulon","Pathway","P_value","intermarker_num","FDR_value")]
  scatter_use_f=scatter_use[which(scatter_use$FDR_value<0.01),]
  if (dim(scatter_use_f)[1]!=0){
    scatter_use=scatter_use_f
  }
  scatter_use$P_value=-log2(scatter_use$P_value)
  #write.table(1,paste0(webPath,"/","A5.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
  p_v_min=floor(min(scatter_use$P_value))
  p_v_max=ceiling(max(scatter_use$P_value))
  if(p_v_max==Inf){
    p_v_max=ceiling(sort(unique(scatter_use$P_value),decreasing =T)[2]+1)
  }
  inter_v_min=min(scatter_use$intermarker_num)
  inter_v_max=max(scatter_use$intermarker_num)
  x_s_data=paste0(as.character(unique(scatter_use$Regulon)),collapse = ",")
  y_s_data=paste0(as.character(unique(scatter_use$Pathway)),collapse = ",")
  value_s_data=c()
  for (s in 1:dim(scatter_use)[1]){
    v0=paste0(as.character(scatter_use[s,1]),",",as.character(scatter_use[s,2]),",",as.numeric(scatter_use[s,3]),",",as.numeric(scatter_use[s,4]),",",as.numeric(scatter_use[s,5]))
    value_s_data=c(value_s_data,v0)
  }
  value_s_data=paste0(value_s_data,collapse = ";")
  
  hallmark_scatter="success"
  hallmark_scatter_p_v_min=p_v_min
  hallmark_scatter_p_v_max=p_v_max
  hallmark_scatter_inter_v_min=inter_v_min
  hallmark_scatter_inter_v_max=inter_v_max
  hallmark_scatter_x_s_data=x_s_data
  hallmark_scatter_y_s_data=y_s_data
  hallmark_scatter_value_s_data=value_s_data
}
#write.table(1,paste0(webPath,"/","A6.txt"),quote = F,sep = "\t",row.names = F,col.names = F)

###imm
imm_scatter_p_v_min="0"
imm_scatter_p_v_max="0"
imm_scatter_inter_v_min="0"
imm_scatter_inter_v_max="0"
imm_scatter_x_s_data="0"
imm_scatter_y_s_data="0"
imm_scatter_value_s_data="0"
pathwayname="immue"
pathway_infor=read.table(paste0(innerpath,"/",pathwayname,".txt"),header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F)
re_immue=RBP_pathway_enrich_fuction(pathway_infor,regulonTargetsInfo,bg_num)
#write.table(1,paste0(webPath,"/","A7.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
if (class(re_immue)=="character"){
  imm_scatter="error"
}else{
  
  scatter_use=re_immue[,c("Regulon","Pathway","P_value","intermarker_num","FDR_value")]
  #scatter_use=scatter_use[which(scatter_use$FDR_value<0.01),]
  scatter_use$P_value=-log2(scatter_use$P_value)
  p_v_min=floor(min(scatter_use$P_value))
  p_v_max=ceiling(max(scatter_use$P_value))
  if(p_v_max==Inf){
    p_v_max=ceiling(sort(unique(scatter_use$P_value),decreasing =T)[2]+1)
  }
  inter_v_min=min(scatter_use$intermarker_num)
  inter_v_max=max(scatter_use$intermarker_num)
  x_s_data=paste0(as.character(unique(scatter_use$Regulon)),collapse = ",")
  y_s_data=paste0(as.character(unique(scatter_use$Pathway)),collapse = ",")
  value_s_data=c()
  for (s in 1:dim(scatter_use)[1]){
    v0=paste0(as.character(scatter_use[s,1]),",",as.character(scatter_use[s,2]),",",as.numeric(scatter_use[s,3]),",",as.numeric(scatter_use[s,4]),",",as.numeric(scatter_use[s,5]))
    value_s_data=c(value_s_data,v0)
  }
  value_s_data=paste0(value_s_data,collapse = ";")
  imm_scatter="success"
  imm_scatter_p_v_min=p_v_min
  imm_scatter_p_v_max=p_v_max
  imm_scatter_inter_v_min=inter_v_min
  imm_scatter_inter_v_max=inter_v_max
  imm_scatter_x_s_data=x_s_data
  imm_scatter_y_s_data=y_s_data
  imm_scatter_value_s_data=value_s_data
}
#write.table(1,paste0(webPath,"/","A8.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
###single result#####
###single files####
use_cols=c("RBP","gene","NES","spearCor","CoexWeight","bestMotif")
single_regTar=regulonTargetsInfo[,use_cols]
rbps=unique(single_regTar$RBP)
for (r0 in 1:length(rbps)){
  single_regTar0=single_regTar[which(single_regTar$RBP==rbps[r0]),]
  regulonTargetsInfo_json0 <- toJSON(single_regTar0, pretty=TRUE)
  cat(str_c('{\"data\": ',regulonTargetsInfo_json0,'}'), file = paste0(webPath,"/",rbps[r0],".txt"), fill = FALSE, labels = NULL, append = FALSE)
}
#write.table(1,paste0(webPath,"/","A9.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
###single circle####
for (i in 1:length(rbps)){
  rbp_one=regulonTargetsInfo[which(regulonTargetsInfo$RBP==rbps[i]),]
  ###node
  id=0:dim(rbp_one)[1]
  name=c(rbp_one$RBP[1],rbp_one$gene)
  symbolSize=c(20,-log2(rbp_one$CoexWeight))
  value=c("RBP",rbp_one$CoexWeight)
  category=c(0,rep(1,dim(rbp_one)[1]))
  node=data.frame(id=id,name=name,symbolSize=symbolSize,value=value,category=category)
  ###node colour
  
  ###link
  source=c()
  target=c()
  for (j in 2:length(id)){
    source=c(source,id[1])
    target=c(target,id[j])
  }
  links=data.frame(source=source,target=target)
  
  ###categories
  categories=c(name[1],"Target gene")
  categories=data.frame(name=categories)
  
  ###merge
  circos_data <- list(nodes = node,links = links,categories = categories)
  jsoncars_circos <- toJSON(circos_data, pretty=TRUE)
  cat(jsoncars_circos, file = paste0(webPath,"/",rbps[i],".json"), fill = FALSE, labels = NULL, append = FALSE)
  
}
#write.table(1,paste0(webPath,"/","A10.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
SingleRBP_circos_file=paste0(rbps[1],".json")
SingleRBP_circos_color="#FF3030,#8CC1D6"
###write job_re ####
result_w<- paste0(
  '"Regulons" :','"',regs,'",',"\n",
  '"ScenicReMainTable" :','"',ScenicReMainTable,'",',"\n",
  '"ScenicReMainTable_download" :','"',ScenicReMainTable_download,'",',"\n",
  '"Scenic_AUCviolin_file" :','"',Scenic_AUCviolin_file,'",',"\n",
  '"Scenic_AUCviolin_regName" :','"',Scenic_AUCviolin_regName,'",',"\n",
  '"Scenic_AUCviolin_regColor" :','"',Scenic_AUCviolin_regColor,'",',"\n",
  '"Scenic_EXPviolin_file" :','"',Scenic_EXPviolin_file,'",',"\n",
  '"Scenic_EXPviolin_regName" :','"',Scenic_EXPviolin_regName,'",',"\n",
  '"Scenic_EXPviolin_regColor" :','"',Scenic_EXPviolin_regColor,'",',"\n",
  '"hallmark_scatter" :','"',hallmark_scatter,'",',"\n",
  '"hallmark_scatter_p_v_min" :','"',hallmark_scatter_p_v_min,'",',"\n",
  '"hallmark_scatter_p_v_max" :','"',hallmark_scatter_p_v_max,'",',"\n",
  '"hallmark_scatter_inter_v_min" :','"',hallmark_scatter_inter_v_min,'",',"\n",
  '"hallmark_scatter_inter_v_max" :','"',hallmark_scatter_inter_v_max,'",',"\n",
  '"hallmark_scatter_x_s_data" :','"',hallmark_scatter_x_s_data,'",',"\n",
  '"hallmark_scatter_y_s_data" :','"',hallmark_scatter_y_s_data,'",',"\n",
  '"hallmark_scatter_value_s_data" :','"',hallmark_scatter_value_s_data,'",',"\n",
  '"imm_scatter" :','"',imm_scatter,'",',"\n",
  '"imm_scatter_p_v_min" :','"',imm_scatter_p_v_min,'",',"\n",
  '"imm_scatter_p_v_max" :','"',imm_scatter_p_v_max,'",',"\n",
  '"imm_scatter_inter_v_min" :','"',imm_scatter_inter_v_min,'",',"\n",
  '"imm_scatter_inter_v_max" :','"',imm_scatter_inter_v_max,'",',"\n",
  '"imm_scatter_x_s_data" :','"',imm_scatter_x_s_data,'",',"\n",
  '"imm_scatter_y_s_data" :','"',imm_scatter_y_s_data,'",',"\n",
  '"imm_scatter_value_s_data" :','"',imm_scatter_value_s_data,'",',"\n",
  '"SingleRBP_circos_file" :','"',SingleRBP_circos_file,'",',"\n",
  '"SingleRBP_circos_color" :','"',SingleRBP_circos_color,'"',"\n",
  '}'
)
  
  write.table(result_w,paste0(webPath,"/","job_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
  ####change job state success
  Task_ID <- as.matrix(read.table(paste0(innerpath,"/Job_ID.txt"),header = F,sep = "\t",check.names = F,fill = T))
  Task_ID_new <- Task_ID
  Task_ID_new[which(Task_ID_new[,1]==ID_new),2] <- "success"
  write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
  
  stopMessage<-"no"
result_message <- paste0("{",'"error_attention" :','"',stopMessage,'"}')
return(result_message)
}, error = function(e){
  Task_ID <- as.matrix(read.table(paste0(innerpath,"/Job_ID.txt"),header = F,sep = "\t",check.names = F,fill = T))
  Task_ID_new <- Task_ID
  Task_ID_new[which(Task_ID_new[,1]==ID_new),2] <- "dead"
  write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
  stopMessage<-"something wrong"
    result_message <- paste0("{",'"error_attention" :','"',stopMessage,'"}')
	return(result_message)
}
  )
  
}
###enrich method
RBP_pathway_enrich_fuction=function(pathway_infor,rbp_gene_mat,bg_num){
  pathway_infor=pathway_infor####pathway infor mat
  rbp_gene=rbp_gene_mat###rbp targene mat Step2_regulonTargetsInfo.tsv
  rbps=unique(rbp_gene$RBP)
  enrich_rbpName=c()
  enrich_pathway=c()
  enrich_pvalue=c()
  enrich_intermarker=c()
  enrich_intermarker_n=c()
  for (i in 1:length(rbps)){
    onerbp_tar=rbp_gene[which(rbp_gene$RBP==rbps[i]),]$gene
    for (j in 1: dim(pathway_infor)[1]){
      pa0=unlist(strsplit(pathway_infor[j,]$gene,","))
      x=length(intersect(pa0,onerbp_tar))
      if (x>=3){
        p0=1-phyper(x-1,length(onerbp_tar),bg_num-length(onerbp_tar),length(pa0))
        enrich_rbpName=c(enrich_rbpName,paste0(rbps[i]," (",length(onerbp_tar),"g)"))
        enrich_pathway=c(enrich_pathway,pathway_infor[j,1])
        enrich_pvalue=c(enrich_pvalue,p0)
        enrich_intermarker=c(enrich_intermarker,paste0(intersect(pa0,onerbp_tar),collapse = ","))
        enrich_intermarker_n=c(enrich_intermarker_n,x)
      }
    }
  }
  if (length(enrich_pvalue)==0){
    enrich_re_df="empty"
  }else{
    #enrich_re_df=data.frame(Celltype=enrich_ct,Pathway=enrich_pathway,P_value=-log2(enrich_pvalue))
    fdr_value=p.adjust(enrich_pvalue,method = "BH")
    enrich_re_df=data.frame(Regulon=enrich_rbpName,Pathway=enrich_pathway,P_value=enrich_pvalue,FDR_value=fdr_value,intermarker_num=enrich_intermarker_n,intermarker=enrich_intermarker)
  }
  return(enrich_re_df)
}