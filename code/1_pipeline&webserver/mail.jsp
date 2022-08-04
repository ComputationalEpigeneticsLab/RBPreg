<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<button style="height:100px;width:100px" onclick="SendMail()">send mail</button>
</body>
<script type="text/javascript">
function SendMail(){
/////1.创建异步对象
	var xmlHttp=new XMLHttpRequest();
/////2.绑定事件
	xmlHttp.onreadystatechange =function(){
		//处理返回的数据，更新当前页面
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			alert("success");
			//var returnData=xmlHttp.responseText;
				}
			}			
/////3.初始请求数据
	var RecipientAddress="878168465@qq.com";
	var mailContent="hhhh  your job has been finished,you can go https://www.baidu.com/ to see the result "
	var param="RecipientAddress="+RecipientAddress+"&mailContent="+mailContent;
	xmlHttp.open("get","MainSendMail?"+param,true);
	//文件用 post 传参
/////4.发起请求
	xmlHttp.send();
}
</script>
</html>