#生成桑基图的边，N1存储源节点，N2存储目的节点，Value存储边的值
setwd("E:\\project\\singcells\\3_function_analyse\\")
edges_t1=read.table("data_riverplot.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,stringsAsFactors = F)

edges_t = data.frame(N1 = c("cancer","cancer","cancer","rbp1","rbp2","rbp3"),  
                   N2 = c("rbp1","rbp2","rbp3","pathway1","pathway2","pathway3"),  
                   Value = c(28,32,18,4,0,40),  
                   stringsAsFactors = F) 
#生成桑基图的点集（即edges出现过的所有点）
nodes = data.frame(ID = unique(c(edges_t1$N1, edges_t1$N2)), stringsAsFactors = FALSE)  
#节点所在桑基图的层级
nodes$x = rep(c(1,2,3,4),c(1,9,4,37))
#节点所在层的排列位置
nodes$y = c(0,c(0:8),c(0:3),c(0:36)) 
rownames(nodes) = nodes$ID  
head(nodes)                     
palette = rep(c("green","green","green","green","green"),50)
# 对每个节点生成相应的列表格式，颜色col，线条类型lty，文字颜色textcol
styles = lapply(nodes$y, function(n) {  
  list(col = palette[n+1], lty = 0, textcol = "black")  
})  
names(styles) = nodes$ID  


# 将点、单和样式合并为List，构建riverplot对象  
rp <- list(nodes = nodes, edges = edges_t1, styles = styles)  
# 添加对你属性包括riverplot
class(rp) <- c(class(rp), "riverplot")
# 绘制桑基图，plot_area设置绘图面积，yscale设置Y轴方向缩放
plot(rp, plot_area = 0.95, yscale=0.06)
plot(rp)
