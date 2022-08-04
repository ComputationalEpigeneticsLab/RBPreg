setwd("E:\\project\\singcells\\6_survival\\LUAD_HNRNPK\\")
library("survival")
#if(!require(devtools)) install.packages("devtools")
#devtools::install_github("kassambara/survminer")
#install.packages("survminer")
library("survminer")
library("ggplot2")
#install.packages("ggpubr")
library("ggpubr")
library("magrittr")
exp<-read.table("LUAD_HNRNPK_survival.txt",header=T,row.names = 1,sep = "\t")
exp_30<-exp[which(exp$os>=30),]
fit <- survfit(Surv(os, event) ~ stage, data = exp_30)
ggsurvplot(fit,
           pval = TRUE, conf.int = TRUE,
           risk.table = TRUE, 
           risk.table.col = "strata",
           linetype = "strata", 
           surv.median.line = "hv",
           ggtheme = theme_bw(), 
           palette = c("#E7B800", "#2E9FDF")
)


cox<-coxph(Surv(os, event) ~ stage, data = exp_30)
cox_sum<-summary(cox)
p_cox=cox_sum$coefficients[5]
beta<-cox$coefficients
