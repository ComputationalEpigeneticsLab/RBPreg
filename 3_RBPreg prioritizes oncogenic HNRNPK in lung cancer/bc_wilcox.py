from scipy.stats import mannwhitneyu
import numpy as np ,pandas as pd
bc=pd.read_csv(dir1+"BC_counts\\bc_matrix_org.txt",header=0,sep="\t",nrows=10)
bc_celltype=pd.read_csv(dir1+"BC_counts\\BC_metadata.csv",header=0)

bc_mannwhitneyu_re=pd.DataFrame()
genes=bc.index.tolist()
celltypes=list(set(bc_celltype["CellType"]))
bc_mannwhitneyu_re["gene"]=genes

for ct0 in celltypes:
    p_ct0=[]
    ct0_sy=bc_celltype[bc_celltype["CellType"]==ct0].Cell.tolist()
    ct0_other=bc_celltype[bc_celltype["CellType"]!=ct0].Cell.tolist()

    for g0 in genes:
        g0_ct0_exp=bc.loc[g0,ct0_sy].tolist()
        g0_ct0_exp_other=bc.loc[g0,ct0_other].tolist()
        U1, p = mannwhitneyu(g0_ct0_exp, g0_ct0_exp_other, alternative="greater")
        p_ct0.append(p)
    bc_mannwhitneyu_re[ct0+"_p"]=p_ct0
bc_mannwhitneyu_re.to_csv(dir+"bc_mannwhitneyu_re.txt",header=True,sep="\t",index=False)