import pandas as pd
import os
import math
dir="/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/CRC/AUC_activate_cell/"
B_cell=pd.read_csv(dir+"CRC_B_cell_1on.txt",header=0,index_col=0,sep="\t")
Cancer=pd.read_csv(dir+"CRC_Cancer_1on.txt",header=0,index_col=0,sep="\t")
EC=pd.read_csv(dir+"CRC_EC_1on.txt",header=0,index_col=0,sep="\t")
Enteric_glia=pd.read_csv(dir+"CRC_Enteric_glia_1on.txt",header=0,index_col=0,sep="\t")
Epithelial=pd.read_csv(dir+"CRC_Epithelial_1on.txt",header=0,index_col=0,sep="\t")
Fibroblast=pd.read_csv(dir+"CRC_Fibroblast_1on.txt",header=0,index_col=0,sep="\t")
Mast=pd.read_csv(dir+"CRC_Mast_cell_1on.txt",header=0,index_col=0,sep="\t")
Myeloid=pd.read_csv(dir+"CRC_Myeloid_1on.txt",header=0,index_col=0,sep="\t")
T_cell=pd.read_csv(dir+"CRC_T_cell_1on.txt",header=0,index_col=0,sep="\t")
col_name=B_cell.columns.tolist()+Cancer.columns.tolist()+Enteric_glia.columns.tolist()+Epithelial.columns.tolist()+EC.columns.tolist()+Fibroblast.columns.tolist()+Mast.columns.tolist()+Myeloid.columns.tolist()+T_cell.columns.tolist()
bc_cells_all=pd.DataFrame(columns=col_name)
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
### Enteric_glia
for ind,row in Enteric_glia.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Enteric_glia.columns:
            r0.append(int(Enteric_glia.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0    
### Epithelial
for ind,row in Epithelial.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Epithelial.columns:
            r0.append(int(Epithelial.loc[ind][ww]))
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

###B CELL
for ind,row in B_cell.iterrows():
    r0=[]
    for ww in col_name:
        if ww in B_cell.columns:
            r0.append(int(B_cell.loc[ind][ww]))
        else:
            r0.append(int(0))
    
    bc_cells_all.loc[ind]=r0    

###Mast
for ind,row in Mast.iterrows():
    r0=[]
    for ww in col_name:
        if ww in Mast.columns:
            r0.append(int(Mast.loc[ind][ww]))
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
dir3="/bioXJ/zhouww/SCENIC/scRNA/1_C_regulons/CRC/"
bc_cells_all.to_csv(dir3+"CRC_cells_1on.txt",header=True,index=True,index_label="regulons",sep="\t")