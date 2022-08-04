import pandas as pd
import os
import math
dir="/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/LC/AUC_activate_cell/"
Alveolar=pd.read_csv(dir+"LC_Alveolar_1on.txt",header=0,index_col=0,sep="\t")
B_cell=pd.read_csv(dir+"LC_B_cell_1on.txt",header=0,index_col=0,sep="\t")
Cancer=pd.read_csv(dir+"LC_Cancer_1on.txt",header=0,index_col=0,sep="\t")
EC=pd.read_csv(dir+"LC_EC_1on.txt",header=0,index_col=0,sep="\t")
Epithelial=pd.read_csv(dir+"LC_Epithelial_1on.txt",header=0,index_col=0,sep="\t")
Fibroblast=pd.read_csv(dir+"LC_Fibroblast_1on.txt",header=0,index_col=0,sep="\t")
Mast=pd.read_csv(dir+"LC_Mast_cell_1on.txt",header=0,index_col=0,sep="\t")
Myeloid=pd.read_csv(dir+"LC_Myeloid_1on.txt",header=0,index_col=0,sep="\t")
T_cell=pd.read_csv(dir+"LC_T_cell_1on.txt",header=0,index_col=0,sep="\t")
col_name=Alveolar.columns.tolist()+B_cell.columns.tolist()+Cancer.columns.tolist()+Epithelial.columns.tolist()+EC.columns.tolist()+Fibroblast.columns.tolist()+Mast.columns.tolist()+Myeloid.columns.tolist()+T_cell.columns.tolist()
bc_cells_all=pd.DataFrame(columns=col_name)
### Alveolar
for ind,row in Alveolar.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Alveolar.columns:
            r0.append(int(Alveolar.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0 
###B_cell
bc_cells_all1=pd.DataFrame(columns=col_name)
for ind,row in B_cell.iterrows():
    r0=[]
    for ww in col_name:
        if ww in B_cell.columns:
            r0.append(int(B_cell.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all1.loc[ind]=r0
###Cancer
bc_cells_all2=pd.DataFrame(columns=col_name)
for ind,row in Cancer.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Cancer.columns:
            r0.append(int(Cancer.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all2.loc[ind]=r0
### Epithelial
bc_cells_all3=pd.DataFrame(columns=col_name)
for ind,row in Epithelial.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Epithelial.columns:
            r0.append(int(Epithelial.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all3.loc[ind]=r0   
###EC
bc_cells_all4=pd.DataFrame(columns=col_name)
for ind,row in EC.iterrows():
    r0=[]
    for ww in col_name:
        if ww in EC.columns:
            r0.append(int(EC.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all4.loc[ind]=r0    
###Fibroblast
bc_cells_all5=pd.DataFrame(columns=col_name)
for ind,row in Fibroblast.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Fibroblast.columns:
            r0.append(int(Fibroblast.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all5.loc[ind]=r0    

###Mast
bc_cells_all6=pd.DataFrame(columns=col_name)
for ind,row in Mast.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Mast.columns:
            r0.append(int(Mast.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all6.loc[ind]=r0    

###Myeloid
bc_cells_all7=pd.DataFrame(columns=col_name)
for ind,row in Myeloid.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Myeloid.columns:
            r0.append(int(Myeloid.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all7.loc[ind]=r0    

###T_cell
bc_cells_all8=pd.DataFrame(columns=col_name)
for ind,row in T_cell.iterrows():
    r0=[]
    for ww in col_name:
        if ww in T_cell.columns:
            r0.append(int(T_cell.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all8.loc[ind]=r0
bc_cells_all=bc_cells_all.append(bc_cells_all1).append(bc_cells_all2).append(bc_cells_all3).append(bc_cells_all4).append(bc_cells_all5).append(bc_cells_all6).append(bc_cells_all7).append(bc_cells_all8)
dir3="/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/LC/"
bc_cells_all.to_csv(dir3+"LC_cells_1on.txt",header=True,index=True,index_label="regulons",sep="\t")