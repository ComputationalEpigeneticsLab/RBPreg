import pandas as pd
import os
import math
dir="/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/OvC/AUC_activate_cell/"

B_cell=pd.read_csv(dir+"OvC_B_cell_1on.txt",header=0,index_col=0,sep="\t")
Cancer=pd.read_csv(dir+"OvC_Cancer_1on.txt",header=0,index_col=0,sep="\t")
EC=pd.read_csv(dir+"OvC_EC_1on.txt",header=0,index_col=0,sep="\t")
Fibroblast=pd.read_csv(dir+"OvC_Fibroblast_1on.txt",header=0,index_col=0,sep="\t")
Myeloid=pd.read_csv(dir+"OvC_Myeloid_1on.txt",header=0,index_col=0,sep="\t")
T_cell=pd.read_csv(dir+"OvC_T_cell_1on.txt",header=0,index_col=0,sep="\t")
col_name=B_cell.columns.tolist()+Cancer.columns.tolist()+EC.columns.tolist()+Fibroblast.columns.tolist()+Myeloid.columns.tolist()+T_cell.columns.tolist()
bc_cells_all=pd.DataFrame(columns=col_name)

###B_cell
for ind,row in B_cell.iterrows():
    r0=[]
    for ww in col_name:
        if ww in B_cell.columns:
            r0.append(int(B_cell.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0
###Cancer
for ind,row in Cancer.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Cancer.columns:
            r0.append(int(Cancer.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0

###EC
for ind,row in EC.iterrows():
    r0=[]
    for ww in col_name:
        if ww in EC.columns:
            r0.append(int(EC.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0    
###Fibroblast
for ind,row in Fibroblast.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Fibroblast.columns:
            r0.append(int(Fibroblast.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0    


###Myeloid
for ind,row in Myeloid.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Myeloid.columns:
            r0.append(int(Myeloid.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0    

###T_cell
for ind,row in T_cell.iterrows():
    r0=[]
    for ww in col_name:
        if ww in T_cell.columns:
            r0.append(int(T_cell.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0
dir3="/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/OvC/"
bc_cells_all.to_csv(dir3+"OvC_cells_1on.txt",header=True,index=True,index_label="regulons",sep="\t")