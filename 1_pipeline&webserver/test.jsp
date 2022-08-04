<%@ page import="Util.*" import="java.sql.*" import="java.util.ArrayList" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.io.*"%>
    <%@ page import="java.util.*" %>
    <%@ page import="java.sql.ResultSet" %>
	<%@ page import="java.sql.ResultSetMetaData" %>
	<%@ page import="org.rosuda.REngine.REXP"%>
	<%@ page import="org.rosuda.REngine.REXPMismatchException"%>
	<%@ page import="org.rosuda.REngine.Rserve.RConnection"%>
	<%@ page import="org.rosuda.REngine.Rserve.RserveException"%>
	<%@ page import="java.io.File"%>
	<%@ page import="java.io.FileWriter"%>
	<%@ page import="java.io.BufferedWriter"%>
	<%@ page import="java.io.FileReader"%>
	<%@ page import="java.io.BufferedReader"%>
	<%@ page import="java.io.IOException"%>
	<%@ page import="javax.servlet.http.HttpServletRequest" %>
	<%@ page import="javax.servlet.http.HttpSession" %>
	<%@ page import="java.io.*" import="java.text.DateFormat" import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Run method</title>

</head>
<body>
<%
String innerpath = getServletContext().getRealPath("/upload/8qe0msz5CNW3RzPaUldy_6666@qq.com");
innerpath=innerpath.replaceAll("\\\\","/");
String upload_path = getServletContext().getRealPath("/upload");
upload_path=upload_path.replaceAll("\\\\","/");
RConnection rc = new RConnection();
rc.assign("innerpath",innerpath);
rc.assign("upload_path",upload_path);
rc.eval("setwd(innerpath)");

 System.out.println(innerpath);
rc.eval("load('scenic_1.Rdata')");

rc.eval("library(SCENIC)");
rc.eval("library(doParallel)");
rc.eval("library(jsonlite)");
rc.eval("library(stringr)");
rc.eval("library(RcisTarget)");
rc.eval("library(AUCell)");
rc.eval("library(GENIE3)");
rc.eval("setwd(innerpath)");
//rc.eval("exprMat=exp_matrix_all;skipBinaryThresholds=FALSE ;skipHeatmap=FALSE ;skipTsne=FALSE ;nCores <- getSettings(scenicOptions, 'nCores')");

//rc.eval("regulons=loadInt(scenicOptions, 'regulons')");
//rc.eval(";if(length(regulons) <2)  stop('Not enough regulons with at least 10 genes.')");
//rc.eval("regulons <- setNames(lapply(names(regulons), function(tf) sort(unique(c(gsub('_extended', '', tf), regulons[[tf]])))), names(regulons));names(regulons) <- paste(names(regulons), ' (',lengths(regulons), 'g)', sep='');saveRDS(regulons, file=getIntName(scenicOptions, 'aucell_regulons'))");
//rc.eval("loadInt(scenicOptions, 'tfModules_asDF'");

//rc.eval("write.table(getwd(),paste0(upload_path,'/','test.txt'))");

rc.close();
%>
<p>hahah</p>
</body>
</html>