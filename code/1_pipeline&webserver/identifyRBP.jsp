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
String MinCountsPerGene="";
String MinSamples="";
String email_address="";
String UserUploadFileName="";
String UserUploadFileNamePath="";
String UserRandompathname="";
MinCountsPerGene=request.getParameter("MinCountsPerGene");
MinSamples=request.getParameter("MinSamples");
email_address=request.getParameter("email_address");
UserUploadFileName=request.getParameter("UserUploadFileName");//file name
UserUploadFileNamePath=request.getParameter("UserUploadFileNamePath");//webpath
UserRandompathname=request.getParameter("UserRandompathname");//id

// System.out.println(MinCountsPerGene);
// System.out.println(MinSamples);
// System.out.println(email_address);
// System.out.println(UserUploadFileName);
// System.out.println(UserUploadFileNamePath);
// System.out.println(UserRandompathname);
//R function 全路径
String innerpath = getServletContext().getRealPath("/base");
innerpath=innerpath.replaceAll("\\\\","/");
String Rfunction_path_all=innerpath+"/Identify_rbp_regs.R";



RConnection rc = new RConnection();
rc.assign("webPath",UserUploadFileNamePath);
rc.assign("innerpath",innerpath);
rc.assign("file_exp",UserUploadFileName);
rc.assign("ID_new",UserRandompathname);
rc.assign("select_MinCountsPerGene",MinCountsPerGene);
rc.assign("select_MinSamples",MinSamples);

rc.assign("Rfunction_path_all",Rfunction_path_all);
rc.eval("source(Rfunction_path_all)");
 //System.out.println("success");
REXP result = rc.eval("Identify_rbp_regs(file_exp,ID_new,select_MinCountsPerGene,select_MinSamples,webPath,innerpath)");

//System.out.println(result.asString());
//////////使用XMLHttpRequest 输出数据
response.setContentType("text/html;charset=utf-8");
//获取PrintWriter
PrintWriter pw = response.getWriter();
pw.println( result.asString());
//pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"no"+'"'+"}");
//清空缓存
pw.flush();
//关闭
pw.close();
rc.close();
//System.out.println("success");
%>
</body>
</html>