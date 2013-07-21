<%@ page language="java" import="java.util.*,com.baidu.scan.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Folder>folders = (List<Folder>)request.getAttribute("folders");

int totalFolder = folders.size();
int currentPage = 1;
int totalPage = Math.round((totalFolder/12)+0.5f);
int scrollWidth = totalPage*880;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>相册</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<title></title>
<link href="../css/basic.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/header.css"/>
<style>

    #folder {
        width: 880px;
        height: 650px;
        margin: auto;
        margin-top: 50px;
        border: 2px solid gray;
        -moz-border-radius: 5px; /* Gecko browsers */
        -webkit-border-radius: 5px; /* Webkit browsers */
        border-radius: 5px; /* W3C syntax */
        box-shadow: 0 1px 3px #BBBBBB;
        background-color: white;
        position: relative;

    }

    #opertaion {
        width: 100%;
        height: 50px;
        padding-top: 20px;
    }

    #create {
        float: left;
        height: 32px;
        margin-left: 100px;
    }

    #create img {
        float: left;
        width: 32px;
        height: 32px;
    }

    #create span {
        float: left;
        line-height: 32px;
        font-weight: bold;
        height: 32px;
    }

    #upload {
        float: left;
        height: 32px;
        margin-left: 300px;
    }

    #upload img {
        float: left;
        height: 32px;
        width: 32px;
    }

    #upload span {
        float: left;
        line-height: 32px;
        font-weight: bold;
        height: 32px;
    }

    .lione {
        float: left;
        width: 170px;
        margin: 5px 25px 5px 25px;
    }

    .folder_img {
        width: 140px;
        height: 120px;
        margin: 2px 15px 0px 15px;
    }

    .folder_desc {
       font-weight:bold;
       font-size:13px;
    }
    
    .folder_desc .name
    {
    float:left;
    margin-left:25px;
    max-width:80px;
    overflow:hidden;
    } 
    
    .folder_input
    {
    float:left;
    margin-left:25px;
    width:80px;
    display:none;
    }
    
    .folder_desc .size
    {
    float:right;
    margin-right:25px;
    }

    .folder_column {
        list-style: none;

    }

    .folder_column li {
        height: 145px;
        margin-top: 10px;
        margin-bottom: 15px;
    }

    #scroll_div {
        width: 880px;
        height:520px;
        overflow:hidden;/*必须把html的overflow hidden 否则滚动条出现在窗口而不是div*/
       
    }

    #folder_ul_scroll {
        width: <%=scrollWidth%>px;
        list-style:none;
        
    }

    #nav {
        position: absolute;
        bottom: 0px;
        right: 10px;
    }

    #left {
    }

    #right {
    }

    #mask {
        position: absolute;
        width: 100%;
        height: 100%;
        overflow:hidden;
        z-index: 5;
        background-color: black; 
        filter: alpha(opacity = 0.3); /*IE*/
        opacity: 0.3; /*谷歌 火狐*/
        display: none;
    }

    #uploader {
        position: absolute;
        width: 800px;
        height: 530px;
        border: 2px solid gray;
        -moz-border-radius: 5px; /* Gecko browsers */
        -webkit-border-radius: 5px; /* Webkit browsers */
        border-radius: 5px; /* W3C syntax */
        filter: alpha(opacity = 1); /*IE*/
        opacity: 1; /*谷歌 火狐*/
        box-shadow: 0 1px 3px black;
        background: white;
        display: none;
        z-index: 6;
    }

    #close {
        float: right;
        padding: 1px;
    }

    #content {
        height: 450px;
        margin: auto;
        width: 100%;
        list-style:none;   
        padding-left:20px;
    }
    #content li
    {
    float : left;
    margin:15px 15px 15px 15px ;
    width:155px;
    height:210px;
     -moz-border-radius: 5px; /* Gecko browsers */
        -webkit-border-radius: 5px; /* Webkit browsers */
        border-radius: 5px; /* W3C syntax */
        box-shadow: 0 1px 3px black;
    }
    #content li img
    {
    width:155px;
    height:180px;
    margin:auto;
    }

    #button {
        width: 100%;
       overflow:hidden;
        height: 40px;
    }

    #button span {
        float: right;
    }

    #page {
        font-weight: bold;
    }
    #frame
    {
    margin-left:40px;
     margin-top:-5px;
       width:500px;
       height:40px;
       border:0px;
        overflow:hidden;
    }
    .markcontainer
    {
      float:left; 
      width:120px;
      height:25px;
      line-height:23px;
      text-align:center;
    }
    .mark
    {
       font-size:15px;
    }
    
    #saveas
    {
    margin-right:20px;
    margin-top:3px;
    width:180px;
     height:40px;
    float:right;
    }
    #as
    {
    width:120px;
    height:20px;
    }
    
    .markspan
    {
    float:left;
    width:120px;
      height:25px;
    }
    .marktext
    {
    float:left;
    display:none;
     width:120px;
      height:23px;
    }
    .radiomark
    {
     float:left;
        margin-left:5px;
        margin-top:4px;
    }
</style>
<script type="text/javascript" src="../lib/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
    var util = {currentPage:<%=currentPage%>,
    totalPage:<%=totalPage%>,
    totalFolder:<%=totalFolder%>,
    setCurrentPage:function(currentPage)
    {
    	this.currentPage = currentPage;
    	var scroll = $("#scroll_div");
    	scroll.animate({scrollLeft:(this.currentPage-1)*880}, 1000);
    	$("#page").html(this.currentPage+"/"+this.totalPage);
    },
    setTotalPage:function(totalPage)
    {
    	this.totalPage = totalPage;
    	$("#page").html(this.currentPage+"/"+this.totalPage);
    },
    left:function()
    {
    	if(this.currentPage>1)
    	{
    	this.currentPage = this.currentPage-1;
    	var scroll = $("#scroll_div");
    	scroll.animate({scrollLeft:(this.currentPage-1)*880}, 1000);
    	$("#page").html(this.currentPage+"/"+this.totalPage);
    	}
    },
    right:function()
    {
    	if(this.currentPage<this.totalPage)
    	{
    		this.currentPage = this.currentPage+1;
    		var scroll = $("#scroll_div");
        	scroll.animate({scrollLeft:(this.currentPage-1)*880}, 1000);
        	$("#page").html(this.currentPage+"/"+this.totalPage);
    	}
    }};
    util.setCurrentPage(<%=currentPage%>);
    $().ready(function () {

    	
        function getFolderCell(msg)
        {
            return '<li>'+
                   '<div class="img_container"><img  folderID="'+msg.id
                   +'"class="folder_img" name="unbind" src="../images/folder-gray.png"></div>'+
                   '<div class="folder_desc"><span class="name" name="unbind" >'+msg.name+'</span><input class="folder_input" name="unbind" type="text"><span class="size" >'+msg.size+'张</span></div>'+
                   '</li>';
        }
        function getFolderColumn(msg)
        {
            return '<li class="lione">'+
                    '<ul class="folder_column">'+
                    getFolderCell(msg)+
                    '</ul>'+
                    '</li>';
        }
        function folder_img_mouseover() {
            var temp = $(this);
            temp.attr("src", "../images/folder-open.png");
            temp.parent().parent().css("background", "#F0F1F4").css("border", "1px solid black");
        }
        function folder_img_mouseout()
        {
            var temp = $(this);
            temp.attr("src", "../images/folder-gray.png");
            temp.parent().parent().css("background", "white").css("border", "0px");
        }
        function folder_img_click()
        {
            window.location.href = "folder_photo?folderid="+$(this).attr("folderid");
        }
        function folder_name_click()
        {
        	var temp = $(this);
        	temp.css("display","none");
        	var value = temp.html();
        	temp.parent().children().eq(1).val(value).css("display","block").focus();
        }
        function folder_input_blur()
        {
        	var temp = $(this);
        	var value = temp.val();
        	$.ajax({
      		  type: "POST",
      		  url: "folder_updateFolderName",
      		  data:{newName:value,folderid:temp.parent().parent().children().eq(0).children().attr("folderid")}
      		}).done(function( msg ) {temp.css("display","none");	
        	temp.parent().children().eq(0).html(value).css("display","block");});
        }
        function markspan_click()
        {
        	var temp = $(this);
        	temp.css("display","none");
        	var value = temp.html();
        	temp.parent().children().eq(1).val(value).css("display","block").focus();
        }
        function marktext_blur()
        {
        	var temp = $(this);
        	temp.css("display","none");
        	var value = temp.val();
        	temp.parent().children().eq(0).html(value).css("display","block");
        }
        function radiocheck()
    	{
    	    var _this = $(this);
    	    if(_this.is(":checked"))
    	    {
    	    	$(".radiomark").not(this).attr("checked",false); 
    	    }
    	}
        $(".folder_img").filter(function (index) {
            return $(this).attr("name") == "unbind";
        }).mouseover(folder_img_mouseover).mouseout(folder_img_mouseout).click(folder_img_click).attr("name","bind");
        $(".name").filter(function (index) {
            return $(this).attr("name") == "unbind";
        }).click(folder_name_click).attr("name","bind");
        $(".folder_input").filter(function (index) {
            return $(this).attr("name") == "unbind";
        }).blur(folder_input_blur).attr("name","bind");
        $("#left").click(function () {
            util.left();
        }).mouseover(function () {
                    $(this).css("background-color", "#F0F1F4").css("border", "1px solid black");
                }).mouseout(function () {
                    $(this).css("background-color", "white").css("border", "0px");
                });

        $("#right").click(function () {
            util.right();
        }).mouseover(function () {
                    $(this).css("background-color", "#F0F1F4").css("border", "1px solid black");
                }).mouseout(function () {
                    $(this).css("background-color", "white").css("border", "0px");
                });

        $("#create").mouseover(function () {
                    $(this).css("background-color", "#F0F1F4").css("border", "1px solid black");
                }).mouseout(function () {
                    $(this).css("background-color", "white").css("border", "0px");
                });
        $("#upload").mouseover(function () {
            $(this).css("background-color", "#F0F1F4").css("border", "1px solid black");
        }).mouseout(function () {
        	
                    $(this).css("background-color", "white").css("border", "0px");
                });

        $("#upload").click(function () {
        	$("#mask").css("height",$(document).height());
            $("#mask").show();
        	$.ajax({
        		  type: "POST",
        		  url: "folder_listFolders"
        		}).done(function( msg ) {
        			var as = $("#as");
        			as.html("");
        			for(var index = 0;index<msg.length;index++)
        			{
        				var item = msg[index];
        			    as.append('<OPTION VALUE="'+item.id+'">'+item.name);
        			}
        		});
            
            var temp = $("#uploader");
            temp.css("top",((parseInt($(window).height())-500)/2)+"px").css("left",((parseInt($(window).width())-700)/2)+"px").show();
        });

        $("#uploader").mousedown(function(e){
        	util.x = e.clientX;
        	util.y = e.clientY;
        	util.drag = true;
            }).mousemove(function(e){
            	
            	if(util.drag)
            	{
            		var _this = $(this);
            		var left = parseInt(_this.css("left"))+e.clientX-util.x;
                    if(left+700<$(document).width()-10&&left>10)
                    {
                    	_this.css("left",left+"px");
                    	util.x = e.clientX;
                    }
                    
                    var top = parseInt(_this.css("top"))+e.clientY-util.y;
                    if(top+500<$(document).height()-10&&top>50)
                    {
                    	_this.css("top",top+"px");
                    	util.y = e.clientY;
                    }
            	}
            }).mouseup(function()
            		{
            	util.drag = false;
            		}).mouseout(function(){util.drag = false;});
        $("#create").click(function () {

		$.ajax({
		  type: "POST",
		  url: "folder_createNewFolder"
		}).done(function( msg ) {
			if(!msg.id)
				{
				alert("数据库连接太不给力了!");
				return;
				}
		   var totalFolder = util.totalFolder+1;
             var totalPage = Math.ceil(totalFolder / 12);
             var folder_ul_scroll =   $("#folder_ul_scroll");
             if(totalPage > util.totalPage)
             {
                 folder_ul_scroll.css("width",totalPage*880);
                 util.setCurrentPage(totalPage);
                 
             }
            var liindex = Math.ceil(totalFolder/3);
            var children =   folder_ul_scroll.children();
            if(liindex <= children.length)
            {
                   //在最后一个li上加
                var li = children.eq(-1);
                var content =  getFolderCell(msg);
                li.children().append(content);
            }
            else
            {
                    //创建新的li，并在它上面加
                var  content = getFolderColumn(msg);
                folder_ul_scroll.append(content);
            }
            util.setTotalPage(totalPage);
            
            util.totalFolder = totalFolder;
            $(".folder_img").filter(function (index) {
                return $(this).attr("name") == "unbind";
            }).mouseover(folder_img_mouseover).mouseout(folder_img_mouseout).click(folder_img_click).attr("name","bind");
            $(".name").filter(function (index) {
                return $(this).attr("name") == "unbind";
            }).click(folder_name_click).attr("name","bind");
            $(".folder_input").filter(function (index) {
                return $(this).attr("name") == "unbind";
            }).blur(folder_input_blur).attr("name","bind");
		});
        });

        $("#close").click(function () {
            $("#mask").hide();
            $("#uploader").hide();
        });
        
        $("#communicate").click(function(){	
        	var frame = document.getElementById('frame').contentWindow.document;
        	var uuid = $(frame.getElementById("file_form")).attr("uuid");
        	if($("#content").children().length>=8)
        	{
        		alert("一次最多保存8张照片，以后会改进的哦！");
        		return ;
        	}
            if(uuid!=0)
            {
        	var content = '<li uuid="'+uuid+'" ><img src="../cache/'+uuid+'" /><div class="mark"><input type="checkbox" class="radiomark" name="unbind" ><span class="markcontainer"><span class="markspan" name="unbind"></span><input class="marktext" name="unbind" type="text" ></span></div></li>';
        	$("#content").append(content);
        	$(".radiomark").filter(function (index) {
                return $(this).attr("name") == "unbind";
            }).click(radiocheck).attr("name","bind");
        	$(".markspan").filter(function (index) {
                return $(this).attr("name") == "unbind";
            }).click(markspan_click).attr("name","bind");
        	$(".marktext").filter(function (index) {
                return $(this).attr("name") == "unbind";
            }).blur(marktext_blur).attr("name","bind");
        	}
        });
        
        $("#save").click(function()
        {
           var folderid = $("#as option:selected").val();
           if(folderid==null||folderid=="")
           {
        	   alert("请先选择目录文件!");
        	   return;
           }
           var array = []; 
        	$("#content").children().each(function(index,el){
        		var li = $(el);
        		var div =$(li.children().eq(1));
        		var markradio = div.children();
        		array.push({uuid:li.attr("uuid"),radio:$(markradio.eq(0)).is(":checked"),mark:$($(markradio.eq(1)).children().eq(0)).html()});
        	});
        	$.ajax({
        		  type: "POST",
        		  url: "folder_saveImages",
        		  data:{jsonString:JSON.stringify(array),folderid:folderid}
        		}).done(function( msg ) {
        			
        			$("#content").html("");
        			$("#mask").hide();
                    $("#uploader").hide();
                    alert("上传成功！");
        		}).fail(function(){$("#content").html("");
    			$("#mask").hide();
                $("#uploader").hide();
                alert("上传成功！");});
        	
        });
        
        $('.member').hover(function () {
            var _this = $(this);
            _this.css('background', 'url(../images/down.png) no-repeat 130px center').css("overflow","visible");
            
            $(_this.children().eq(0)).show().animate({
                    opacity : 100,
                    height : 50
            });
        }, function () {
            var _this = $(this);
            _this.css('background', 'url(../images/up.png) no-repeat 130px center');
            var ul = $(_this.children().eq(0));
            ul.animate(
                {
                    opacity : 0,
                    height : 0
                },
                function () {
                    ul.hide();
                }
            );
        });
    });
</script>
</head>
<body>
<div id="mask">

</div>
<div id="uploader">
    <img id="close" src="../images/close.png">

    <div style="clear: both"></div>

    <ul id="content"></ul>

    <div id="button"><iframe id="frame" name="frame" src="uploader.jsp"></iframe><input type="button" id="communicate" style="display:none;">
    <div id="saveas"><select id="as"></select><input type="button" value="保存" id="save"></div></div>
</div>
<div class="header">
    <div class="header_container">
        <img src="../images/logo.png" class="header_logo"/>
        <ul class="header-nav">
            <li>
                <a class="nav-item yahei " href="folder_folders">我的相册</a>
            </li>
            <li>
                <a class="nav-item yahei " href="folder_photo">图片广场</a>
            </li>
        </ul>
        <div class="member">传说中的小明
            <ul class="member_ul">
                <li>设置</li>
                <li>帮助</li>
            </ul>
        </div>
    </div>
</div>

<div id="folder">
    <div id="opertaion">
        <div id="create"><img src="../images/create.png"><span>创建相册</span></div>
        <div id="upload"><img src="../images/upload.png"><span >上传照片</span></div>
    </div>
    <div id="scroll_div">
        <ul id="folder_ul_scroll">
        <%int count = 0;
          for(Folder folder : folders)
          {
        	  if(count==0)
        	  {
        %>
         <li class="lione">
                <ul class="folder_column">
        <%    }
        	  
        %>
                    <li>
                        <div class="img_container"><img class="folder_img" folderid="<%=folder.getId() %>"  name="unbind" src="../images/folder-gray.png"></div>
                        <div class="folder_desc"><span class="name" name="unbind" ><%=folder.getName() %></span><input class="folder_input" name="unbind" type="text"><span class="size"><%=folder.getSize() %>张</span> </div>
                    </li>
        <% 	  
              count++;
              if(count==3)
              {
        %>        
                </ul>
            </li>
        <% 		  
        	  }
              count = count%3;
          }
        %>
           
        </ul>
    </div>
    <div id="nav"><img id="left" src="../images/arrow-left.png"> <img id="right" src="../images/arrow-right.png"><span
            id="page"><%=currentPage %>/<%=totalPage %></span></div>
</div>
</html>
