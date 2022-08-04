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
<title>Job id judge</title>
</head>
<body>
<%
String task_id_user="";
task_id_user=request.getParameter("task_id");// id 文件名
//task_id_user="a";
//System.out.println(task_id_user);
Hashtable TaskID_value = new Hashtable();
String file_id_p = getServletContext().getRealPath("/base");
file_id_p=file_id_p.replaceAll("\\\\","/")+"/Job_ID.txt";
BufferedReader br = null;
br = new BufferedReader(new FileReader(file_id_p));
String text = null;
while ((text = br.readLine()) != null) {
	String [] arr=text.split("\t");
	TaskID_value.put(arr[0], arr[1]);
    
		 }
//System.out.println(TaskID_value);
br.close();
//////////使用XMLHttpRequest 输出数据
response.setContentType("text/html;charset=utf-8");
//获取PrintWriter
PrintWriter pw = response.getWriter();

//判断map中是否有key
if(!TaskID_value.containsKey(task_id_user)){
	//System.out.println("nokey");
	pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"No such job id, you can check your job id or submit a job first. "+'"'+"}");
}else{
	
	//System.out.println(TaskID_value.get(task_id_user));
	if (TaskID_value.get(task_id_user).equals("success")){//任务成功
		//System.out.println("success");
		pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"success"+'"'+"}");       
	}else if(TaskID_value.get(task_id_user).equals("run")){//任务正在进行
		pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"The job is in progress. Please wait patiently."+'"'+"}");
	}else if(TaskID_value.get(task_id_user).equals("dead")){//任务错误失败
		pw.println("{"+'"'+"error_attention"+'"'+":"+'"'+"The job is dead please check your upload file or parameter."+'"'+"}");
	}
}

//清空缓存
pw.flush();
//关闭
pw.close();
%>
</body>
</html>