<%@ page language="java" import="java.net.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RBPreg</title>
</head>
<body>
<%
    //如果是从前台传过来的参数就这样写
    String filePath = "/"+request.getParameter("path");//前面红字标识的“//”不能没有   
    //out.println("yes");
    String fileName = request.getParameter("name");  
    //out.println("yes");
    response.setContentType("application/x-download");//设置为下载application/x-download
    String filenamedownload = filePath;//即将下载的文件的相对路径
    String filenamedisplay = fileName;//下载文件时显示的文件保存名称
    filenamedisplay = URLEncoder.encode(filenamedisplay,"UTF-8");
    response.addHeader("Content-Disposition","attachment;filename=" + filenamedisplay);    
    try
    {
        RequestDispatcher dispatcher = application.getRequestDispatcher(filenamedownload);
        if(dispatcher != null)
        {
            dispatcher.forward(request,response);
        }
        response.flushBuffer();
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }  
    out.clear();
    out = pageContext.pushBody();
%>
</body>
</html>