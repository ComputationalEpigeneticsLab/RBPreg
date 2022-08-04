library(riverplot)
setwd("E:\\work\\scRNA\\3-function-analyse\\")
edges_4=read.table("data_4_unique.txt",header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F,stringsAsFactors = F)

nodes = data.frame(ID = unique(c(edges_4$N1, edges_4$N2)), stringsAsFactors = FALSE)  
nodes
nodes_col=nodes
nodes_col$col=c(0:171)
#节点所在桑基图的层级
nodes$x = rep(c(1,2,3,4),c(4,42,8,118))
#节点所在层的排列位置
#nodes$y = c(c(70,158,282,415),seq(34,44*10+4,10),seq(52,468-52,52),seq(0,117*4,4)) 
nodes$y = c(c(0,156,312,468),seq(0,468,468/41),seq(0,468,468/7),seq(0,117*4,4)) 

#nodes$col = c(rep("#2CA6E0",4),rep("#BFBFBF",18),rep("#FF83FA",150))

rownames(nodes) = nodes$ID  

#rp <- makeRiver(nodes,edges_4)
#plot(rp, plot_area = 1, yscale=1)
#plot(rp, plot_area = 0.95, yscale=0.6)

head(nodes)                     
palette = c(c("#e96965","#70a128","#00abb7","#9f7ab4"),rep(c("#e96965","#70a128","#00abb7","#9f7ab4"),c(9,7,18,8)),rep(c("#99ffff","#99ffff"),550))
#palette = rep(c("#e96965","#70a128","#00abb7","#9f7ab4"),c(9,7,18,8))

styles = lapply(nodes_col$col, function(n) {  
  list(col = palette[n+1], lty = 0, textcol = "black",srt=0)  
})  
names(styles) = nodes$ID  


# 将点、单和样式合并为List，构建riverplot对象  
rp <- list(nodes = nodes, edges = edges_4, styles = styles)  
# 添加对你属性包括riverplot
class(rp) <- c(class(rp), "riverplot")
# 绘制桑基图，plot_area设置绘图面积，yscale设置Y轴方向缩放
plot(rp, plot_area = 0.95, yscale=0.06)

