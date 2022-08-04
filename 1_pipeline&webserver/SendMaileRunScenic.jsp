<%@ page import="Util.*" import="java.sql.*" import="java.util.ArrayList" language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.io.*"%>
    <%@ page import="java.util.List" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>RUN SCENIC</title>
</head>
<body>
<!-- 获取参数 -->
<%
String UserUploadFileName=request.getParameter("UserUploadFileName");//文件名
String UserUploadFileNamePath=request.getParameter("UserUploadFileNamePath");//文件路径
String UserRandompathname=request.getParameter("UserRandompathname");//文件夹名

String MinCountsPerGene=request.getParameter("MinCountsPerGene");
String MinSamples=request.getParameter("MinSamples");
String email_address=request.getParameter("email_address");

System.out.println(UserUploadFileName);
System.out.println(UserUploadFileNamePath);
System.out.println(UserRandompathname);
System.out.println(MinCountsPerGene);
System.out.println(MinSamples);
System.out.println(email_address);
%>
</body>
</html>