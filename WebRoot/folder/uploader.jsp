<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String uuid = (String)request.getAttribute("uuid");
if(uuid==null)
	uuid = "0";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>文件上传</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
 
  <style>
  html, body {
    overflow:hidden;
}
body{
	
   form
   {
   margin:0px;
   }
   
  </style>
  <script type="text/javascript" src="../lib/jquery-1.10.2.min.js"></script>
  <script type="text/javascript">
  function add()
  {
	  document.getElementById('file_form').submit();
  }
  $().ready(function(){
	  $(window.parent.document.getElementById("communicate")).trigger("click");
  });
  </script>
  <body>
  <form action="folder_upload"  method="post" enctype="multipart/form-data"  uuid="<%=uuid%>" id="file_form">
    <input type="file" id="file" name="image" />
    <input type="button" onclick="add()" value="上传" id="submitter" />
    </form>
  </body>
</html>
