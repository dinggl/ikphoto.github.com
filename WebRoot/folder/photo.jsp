<%@ page language="java" import="java.util.*,com.baidu.scan.model.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<String> marks = (List<String>)request.getAttribute("marks");
List<Folder>folders = (List<Folder>)request.getAttribute("folders");
String folderid = request.getParameter("folderid");
String search = (String)request.getAttribute("search");
if(search!=null)
search =  URLDecoder.decode(search,"UTF-8");
System.out.println(search);
if(folderid==null||folderid.equals(""))
	folderid = "-1";

int sliders = 1;
int stuff = 0;
if(folders!=null)
{
	stuff = 6-folders.size()%6;
	if(folders.size()%6==0)
		sliders = folders.size()/6;
	else
	    sliders = Math.round(folders.size()/6+0.5f);
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>图片广场</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<link href="../css/basic.css" rel="stylesheet" type="text/css">
<link href="../css/loading.css" rel="stylesheet" type="text/css">
    <style>
        .div_column
        {
            float: right;
            margin: 5px 5px 15px 5px;
            padding: 0px;
            list-style: none;
            top: 0px;
            height: 30px;
            width: 800px;
        }
        .column {
            float: left;
            margin: 5px 5px 15px 5px;
            padding: 0px;
            list-style: none;
            top: 0px;
            width: 238px;
        }

        .column_li {
            width: 100%;
            border-left: medium none;
            box-shadow: 0 1px 3px #BBBBBB;
            margin-top: 8px;
        }

        .div_photo {
            padding: 5px;
            background-color: white;
            position: relative;/*方便子元素相对于它绝对定位*/
        }

        .main {
            width: 1243px;
            margin: auto;
            height: 100%;
        }

        .photo {
            width: 1240px;
            margin-left: 3px;
        }

        .img_div
        {
            width: 100%;
            position: relative;
        }
        .img_highlight
        {
            position: absolute;
            width: 100%;
            height: 100%;
            filter:alpha(opacity=0);/*IE*/
            opacity: 0;/*谷歌 火狐*/
            top:0px;
            z-index: 10;
            background-color: white;
        }
        .img
        {
            width: 100%;
            filter:alpha(opacity=0);/*IE*/
            opacity: 0;/*谷歌 火狐*/
        }

        .label
        {
            padding-top: 10px;
            padding-left: 5px;
            padding-right: 5px;
            height: 15px;
            font-family: Arial;
            font-size:	12px;
            font-weight:400;
            font-style:normal;
            font-size-adjust:none;
            color:#222222;
            text-decoration:none;
            line-height:14px;
            vertical-align:baseline;
        }
        .label_folder
        {
            padding: 0px;
            float: left;
            height:15px;
            min-width:140px;
        }
        
        .label_input
        {
            padding: 0px;
            float: left;
            display:none;
        }
        .label_size
        {
            color: #888888;
            float: right;
        }

        .label_ul
        {
            padding: 0px;
            list-style: none;
        }
       .label_ul li
        {
            float: left;
            margin: 0 8px 8px 0;
        }
        .label_ul li span
        {
            border: 1px solid #dedede;
            -moz-border-radius: 5px;      /* Gecko browsers */
            -webkit-border-radius: 5px;   /* Webkit browsers */
            border-radius:5px;            /* W3C syntax */
            box-shadow: 1 1px 1px #BBBBBB;
            text-align: center;
            line-height: 22px;
            padding: 2px 3px 2px 3px;
            
            color:#2B2E35;
            font-weight:bold;
            font-size:15px; 

        }

        .corner
        {
            position: absolute;
            bottom: -2px;
            height: 21px;
            position: absolute;
            right: -2px ;
            width: 21px;
            background-image: url(../images/corner.png);
        }

        .menu-filter
        {
            list-style: none;
            float: left;
            padding: 15px  0px  0px 5px;
        }
        .menu-filter li
        {
            float: left;
        }

        .size-selector
        {
            float: right;
            right: 15px;
        }

        #banner_div
        {
            width: 100%;
            padding: 15px 0px 0px 0px;
            background-color: #2B2E35;
            height: 193px;
        }
        #banner
        {
            width: 1164px;
            margin: auto;
            position: relative;
            height: 162px;
        }

        #folders
        {
            width:1044px;
            height: 162px;
            margin: auto;
            list-style: none;
            overflow: hidden;
            /*overflow-x:scroll;*/
        }
        #folders_ul
        {
            width: <%=sliders*1044+sliders*12%>px;
        }
        #folders li
        {
            border: 1px solid #1F1F1F;
            cursor: pointer;
            display: inline-block;
            float: left;
            height: 162px;
            margin-right: 12px;
            position: relative;
            white-space: normal;
            width: 162px;

        }
        .folder_div
        {
           position: absolute;
            width: 162px;
            height: 30px;
            bottom: 0px;
            left: 0px;
            z-index: 5;
            background-image: url(../images/bottom.png);
            color: #FFFFFF;
            font-size: 12px;
            font-weight: bold;
            line-height: 30px;
            letter-spacing: 1px;
        }
         .highlight
         {
             position: absolute;
             width: 100%;
             height: 100%;
             filter:alpha(opacity=0);/*IE*/
             opacity: 0;/*谷歌 火狐*/
             top:0px;
             z-index: 10;
             background-color: white;
         }
        .folder_name
        {
            position: relative;
            float: left;
            height: 30px;;
            margin-left: 10px;
        }

        .folder_size
        {
            height: 30px;
            position: relative;
            float: right;;
            margin-right: 10px;
        }

        #folders li img
        {
            width: 162px;
            height: 162px;
            -moz-border-radius: 5px;      /* Gecko browsers */
            -webkit-border-radius: 5px;   /* Webkit browsers */
            border-radius:5px;            /* W3C syntax */
        }
        #nav
        {
            width: 100%;
            position: absolute;
            top: 60px;
            height: 50px;
            z-index: 5;
        }
        .arrow_left
        {
            float:left;
            top: 0px;
            margin-left: 3px;
            background-image: url("../images/slider.png") ;
            background-position: 0px 0px;
            width: 50px;
            height: 50px;
        }
        .arrow_right
        {
            float:right;
            top:0px;
            margin-right: 3px;
            background-image: url("../images/slider.png") ;
            background-position: 50px 0px;
            width: 50px;
            height: 50px;
        }
        #slider
        {
            width: 1164px;
            height: 29px;
            margin: auto;
            text-align: center;
            font-size: 10px;
            line-height: 27px;
            letter-spacing:3px;
        }

        #slider a
        {
            text-decoration:none;
            color: black;
        }
        .loading
        {
            width: 80px;
            height: 80px;
            position: absolute;
            left: 50%;
            margin-left: -40px;
            top: 50%;
            margin-top: -50px;
            z-index: 5;
        }

        .detail
        {
            width: 35px;
            height: 20px;
            left: 10px;
            top: 10px;
            position: absolute;
            z-index: 6;
        }

        .download
        {
            width: 35px;
            height: 20px;
            right: 10px;
            top: 10px;
            position: absolute;
            z-index: 6;
            display:none;
        }

    .mask
    {
        position: absolute;
        width: 100%;
        height: 100%;
        background-color: #f5deb3;
    }

    #float
    {
        position: absolute;
        display: none;

    }
    .menu-filter
    {
    list-style:none;
    letter-spacing:2px;
    font-size:15px;
    }
    .menu-filter li 
    {
    margin-right:10px;
    list-style:none;
    font-weight:bold;
    color:#BBBBBB;
    }

    </style>
<link rel="stylesheet" type="text/css" href="../css/header.css" />
</head>
<body style="background-color:#F0F1F4;">
<div id="loading-mask" style=""></div>
<div id="loading">
    <div class="loading-indicator"><img src="../images/loading.gif" width="32" height="32" style="margin-right:8px;float:left;vertical-align:top;"/></div>
</div>
 <script type="text/javascript" src="../lib/jquery-1.10.2.min.js"></script>
<script type="text/javascript">

    $().ready(
            function()
            {
            	
            	
            	$(".menu-filter li").click(function(){
            		var span = $($(this).css("background","black").children().eq(0));
            		var columns =$(".column");
            		if(span.html()=="大图")
            		{
            			var el = $(columns.eq(0)).children().eq(0);
            			columns.html("");
            			util.size = 3;
            			
            			$(".div").css("width","500px");
            			columns.css("width","397px");
            			$(columns.eq(0)).append(el);
            			init();
            			
            		}
            		else
            		{
            			var el = $(columns.eq(0)).children().eq(0);
            			columns.html("");
            			util.size = 5;
            			
            			$(".div").css("width","800px");
            			columns.css("width","238px");
            			$(columns.eq(0)).append(el);
            			init();
            			
            		}
            	}).mouseover(function(){
            		$(this).css("background","black");
            	}).mouseout(function(){
            		$(this).css("background","none");
            	});
            	var util = {sliders:<%=sliders%>,
            			size:5,
            			direction:'right',
            			currentSlider:1,
            			right:function(){
            				var sliders= this.currentSlider+1;
            				var folders = $('#folders');
            				if(sliders<=this.sliders)
            				{
            					this.currentSlider = sliders;
            					folders.animate({
                                    scrollLeft:(util.currentSlider-1)*(1044+12)
                                }, 1500 );
            					var on = $(".on");
            					$(on.eq(this.currentSlider-1)).css("color","white");
            					on.not(on.eq(this.currentSlider-1)).css("color","black");
            				}
            			},
            			left:function(){
            				var sliders= this.currentSlider-1;
            				if(sliders>0)
            				{
            					this.currentSlider = sliders;
            					 var folders = $('#folders');
            					folders.animate({
                                    scrollLeft:(util.currentSlider-1)*(1044+12)
                                }, 1500 );
            					var on = $(".on");
            					$(on.eq(this.currentSlider-1)).css("color","white");
            					on.not(on.eq(this.currentSlider-1)).css("color","black");
            				}
            			}};
            	function img_highlight_over()
            	{
            		var _this = $(this);
            		$(_this.parent().parent().children().eq(1)).show();
            		_this.animate({opacity:0.3},300);
            	}
            	function img_highlight_out()
            	{
            		var _this = $(this);
            		$(_this.parent().parent().children().eq(1)).hide();
            		_this.animate({opacity:0},300);
            	}
            	
            	function init()
            	{
            		util.currentIndex = 0;
            		var columns = $(".column");
            		for(var index=0;index<util.array.length;index++)
            		{
            			var columnIndex=0;
            			var minY = -100;
            			for(var ci = 0;ci<util.size;ci++)
            			{
            				var column = $(columns.eq(ci));
            				var value = column.offset().top+column.height();
            				if(minY<0)
            				{
            					minY = value;
            					columnIndex = ci;
            				}
            				else if(minY>value)
            				{
            					minY = value;
            					columnIndex = ci;
            				}
            			}
            			util.currentIndex = index+1;
            			util.currentMinY = minY;
            			if(minY>=990)
            			{
            				break;
            			}
            			else
            			{
            				console.log("currentIndex:"+util.currentIndex+"  minY:"+util.currentMinY);
            			$(columns.eq(columnIndex)).append(li(util.array[index]));
            			}
            		}
            		$(".img_highlight").each(function(index,el)
            				{
            			       var _el = $(el).prev();
            			       _el.attr("src",_el.attr("xsrc")).animate({opacity:1},300);
            			       $(_el.parent().parent().children().eq(0)).animate({opacity:0},300);
            				}).mouseenter(img_highlight_over).mouseleave(img_highlight_out).click(function(){
            					window.location.href = "folder_download?photoname="+$(this).attr("photoname");}).attr("name","bind");
            		
            		$(".label_folder").click(label_folder_click).attr("name","bind");
            		$(".label_input").blur(label_input_blur).attr("name","bind");
            		
            		//$(".download").click(function(){console.log(1);}).attr("name","bind");
            	}
            	
        
            	function label_folder_click()
            	{
            		var _this =$(this);
            		var value = _this.html();
            		_this.hide();
            		$(_this.parent().children().eq(1)).show().val(value).focus();
            	}
            	function label_input_blur()
            	{
            		var temp = $(this);
                	var value = temp.val();
                	$.ajax({
              		  type: "POST",
              		  url: "folder_updatePhotoMark",
              		  data:{newMark:value,photoid:temp.attr("photoid")}
              		}).done(function( msg ) {temp.css("display","none");	
                	temp.parent().children().eq(0).html(value).css("display","block");});
            	}
            	$.ajax({
            		  type: "POST",
            		  url: "folder_listPhotos?search="+encodeURI(encodeURI('<%=search%>')),
            		  data:{folderid:<%=folderid%>}}).done(function( msg ) {
            			util.array = msg;
            			init();
            		});
            	
            	$(".label_ul li span").click(function(){
            		window.location.href = "folder_photo?search="+encodeURI(encodeURI($(this).html()));
            	}).mouseover(function(){
            		$(this).css("background-color","#ee99ee");
            	}).mouseout(function(){$(this).css("background-color","white");});
                $(".arrow_right").click(function(evt)
                {
                   util.right();
                    
                }).mouseover(function()
                        {
                            $(this).css("background-position","50px 50px");
                        }).mouseout(function()
                        {
                            $(this).css("background-position","50px 0px");
                        });

                $(".arrow_left").click(function(evt)
                {
                	util.left();
                }).mouseover(function()
                        {
                	       
                            $(this).css("background-position","0px 50px");
                        }).mouseout(function()
                        {
                            $(this).css("background-position","0px 0px");
                        });

                $(".highlight").mouseover(function()
                {
                    $(this).animate({opacity:0.3},300);
                }).mouseout(function(){
                            $(this).animate({opacity:0},300);
                        }).click(function()
                        		{
                        	window.location.href = "folder_photo?folderid="+$(this).attr("folderid");
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

                function wait_load()
                {
                	
                    var top =  parseFloat($(window).scrollTop());
                    //console.log(top+","+$(window).height()+","+$(document).height());
                    if(top==0)
                    {
                        $("#float").hide();
                    }
                    else
                    {
                        $("#float").show().css("top",top+"px");
                    }
                    if(top+$(window).height()>= $(document).height()-150)
                    {
                    	if(util.array)
                    	{
                    	var columns = $(".column");
                		for(var index=util.currentIndex;index<util.array.length;index++)
                		{
                			var columnIndex=0;
                			var minY = -100;
                			for(var ci = 0;ci<util.size;ci++)
                			{
                				var column = $(columns.eq(ci));
                				var value = column.offset().top+column.height();
                				if(minY<0)
                				{
                					minY = value;
                					columnIndex = ci;
                				}
                				else if(minY>value)
                				{
                					minY = value;
                					columnIndex = ci;
                				}
                			}
                			util.currentIndex = index+1;
            				util.currentMinY = minY;
                			if(minY>=util.currentMinY+900)
                			{
                				break;
                			}
                			else
                			{
                				console.log("currentIndex:"+util.currentIndex+"  minY:"+util.currentMinY);
                			$(columns.eq(columnIndex)).append(li(util.array[index]));
                			}
                			util.currentIndex = index+1;
                		}
                		$(".img_highlight").filter(function (index) {
                            return $(this).attr("name") == "unbind";
                        }).each(function(index,el)
                				{
         			       var _el = $(el).prev();
         			       _el.attr("src",_el.attr("xsrc")).animate({opacity:1},300);
         			       $(_el.parent().parent().children().eq(0)).animate({opacity:0},300);
         				}).mouseover(img_highlight_over).mouseout(img_highlight_out).click(function(){
        					window.location.href = "folder_download?photoname="+$(this).attr("photoname");}).attr("name","bind");
                    	}
                    	$(".label_folder").filter(function (index) {
                            return $(this).attr("name") == "unbind";
                        }).click(label_folder_click).attr("name","bind");
                		$(".label_input").filter(function (index) {
                            return $(this).attr("name") == "unbind";
                        }).blur(label_input_blur).attr("name","bind");
                    }
                }
                $(window).resize(wait_load);
                $(window).scroll(wait_load);
                
                function sliding()
                {
                	if(util.direction=="right")
                	{
                		if(util.currentSlider<util.sliders)
                		{
                			util.right();
                		}
                		else
                		{
                			util.direction="left";
                			util.left();
                		}
                	}
                	else
                	{
                		if(util.currentSlider>1)
                		{
                			util.left();
                		}
                		else
                		{
                			util.direction="right";
                			util.right();
                		}
                	}
                }
                
                setInterval(sliding,5000);
                
               
                function li(obj)
                {
                	   return '<li class="column_li" >'+
                       '<div class="div_photo">'+
                           '<img src="../images/loadingPD.gif" class="loading" />'+
                           /*'<img src="../images/arrow.png" class="detail" />'+*/
                           '<img src="../images/download.png" name="unbind" class="download" />'+
                           '<div class="img_div">'+
                           '<img class="img" src="../images/wait_load.jpg" xsrc="../xiaoming/'+obj.name+'"/>'+
                           '<div class="img_highlight" name="unbind" photoname="'+obj.name+'" ></div>'+
                           '</div>'+
                           '<div class="label">'+
                               '<div><div class="label_folder" name="unbind"  >'+obj.description+'</div><input name="unbind" type="text" photoid="'+obj.id+'" class="label_input" ></input><div class="label_size">'+obj.size+'</div>'+
                                   '<div style="clear: both"></div>'+
                               '</div>'+
                           '</div>'+
                       '</div>'+
                   '</li>';
                }
                setTimeout(function(){
                	$("#loading-mask").animate({opacity:0},1000).hide();
                    $("#loading").hide();
                },500);
                
            }
    );

</script>       

<div class="header" id="float">
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
        <div class="member">移动版本下载
        <ul class="member_ul">
			<li>IPhone版</li>
			<li>IPad版</li>
		</ul>
        </div>
    </div>
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
        <div class="member">移动版本下载
            <ul class="member_ul">
			<li>IPhone版</li>
			<li>IPad版</li>
		</ul>
        </div>
    </div>
</div>
<div id="banner_div">
    <div id="banner">
        <div id="folders">
            <ul id="folders_ul" >
            <%if(folders!=null)
              {
                  for(Folder folder : folders)
                  {
            %>
            <li><img src="../xiaoming/<%=folder.getFengmian().getName()%>" /><div class="folder_div"><span class="folder_name"><%=folder.getName() %></span><span class="folder_size" ><%=folder.getSize() %>张</span></div>
                <div class="highlight" folderid="<%=folder.getId()%>"></div></li>
            <%
                  }
                  int size = folders.size();
                  int findex = 0;
                  for(int index=0 ;index<stuff;index++)
                  {
                	  if(findex>=folders.size())
                		  findex=0;
                	  if(findex<folders.size())
                	  {
                	  Folder folder = folders.get(findex);
                	  findex++;
            %>
            <li><img src="../xiaoming/<%=folder.getFengmian().getName()%>" /><div class="folder_div"><span class="folder_name"><%=folder.getName() %></span><span class="folder_size" ><%=folder.getSize() %>张</span></div>
                <div class="highlight" folderid="<%=folder.getId()%>"></div></li>
            <%
                	  }
                  }
                  
              }
            %>
            </ul>
        </div>
        <div id="nav">
            <span  class="arrow_left" ></span>
            <span  class="arrow_right" ></span>
        </div>
    </div>
    <div id="slider">
            <%
            if(sliders>1)
            {
            for(int index=0;index<sliders;index++)
            {
            %>
            <a class="on" href="javascript:void(0);" style="color:<%if(index==0)out.print("white");else out.print("black");%>;" >●</a>
            <%
             }
            }
            %>
    </div>
    </div>

<div class="main">
    <div class="photo">
        <ul class="column">
            <li class="column_li">
                <div class="div_photo" >
                    <ul class="label_ul">
                    <%if(marks!=null)
                      {
                    	 for(String mark : marks)
                    	 {
                    %>
                        <li >
                           <span><%=mark %></span>
                        </li>
                    <%  		 
                    	 }
                      }
                    %>
                        
                    </ul>

                    <div style="clear: both"></div>
                    <div class="corner"></div>
                </div>
            </li>
            
        </ul>
        <div class="div_column">
            <ul class="menu-filter">
                <li class="first on">
                    <a class="on" label="0" hidefocus="hidefocus" href="#1"></a>
                </li>
                <li class="last">
                    <a class="" label="1" hidefocus="hidefocus" href="#2"></a>
                </li>
            </ul>
            <div class="size-selector">

                <ul class="menu-filter">
                    <li class="first">
                        <a label="1" hidefocus="hidefocus" href="#3">
                            <span class="l-size-ico"></span>
                        </a>
                    </li>
                    <li class="first">
                            <span class="l-size-ico">大图</span>
                    </li>
                    
                    <li class="last on">
                            <span class="m-size-ico">中图</span>
                    </li>
                </ul>
                </div>
        </div>
        <ul class="column">
        </ul>
        <ul class="column">
        </ul>
        <ul class="column">
        </ul>
        <ul class="column">
        </ul>
        <div style="clear: both"></div>
    </div>

</div>
</html>
