<%@page import="data.dto.ExpressDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ExpressDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>HuGo</title>
 
<%
// 절대경로잡기
String root = request.getContextPath();

//휴게소 id값 받기
String inherence_HU=request.getParameter("id"); 
System.out.println("서브페이지쪽="+inherence_HU);

//mainPage 경로
String mainPage = "layout-subPage/main.jsp";

//세션에 고유휴게소값 저장
if(inherence_HU==null || inherence_HU.equals("null")){
	inherence_HU=(String)session.getAttribute("inherence_HU");
}
//main경로 수정


if (request.getParameter("main")!= null) {
   mainPage = request.getParameter("main");%>
   <script type="text/javascript">
	$(function(){
		$(".mainwhite").show();
	});
</script>
<%
}
else{%>
	 <script type="text/javascript">
	$(function(){
		$(".mainwhite").hide();
	});
</script>
<%}


ExpressDao dao=new ExpressDao();
ExpressDto dto=new ExpressDto();

List<ExpressDto> list=dao.getId(inherence_HU);
System.out.println(inherence_HU);
/*
세션 id 호출
if(b_id==null || b_id.equals("null")){
	b_id=(String)session.getAttribute("b_id");
}
*/
/*
String mainPage="layout-"+b_id+"/main.jsp"; //기본페이지
String header="layout-"+b_id+"/header.jsp";
String footer="layout-"+b_id+"/footer.jsp";
*/


String myimg=null;
for (int i = 0; i < list.size(); i++) {
dto = list.get(i);
myimg = dto.getImage();
}

%>
<style type="text/css">
	body{
   		background-image: url("save/<%=myimg%>");
     	background-size: 100% 100vh;
    	background-attachment: scroll;
   		background-repeat: no-repeat;
	}
	
	div.layout{
   		position: absolute;
	}

	
	div.header{
   		width: 100%;
   		height: 10vh;
  		text-align: center;
   		top: 10vh;
   		
	}

	div.main{
   		width: 70%;
   		height: 80vh;
   		font-size: 13pt;
   		margin-left: 15%;
   		top: 20vh;

	}

	div.info{
   		width:13%;
  		height:30%;
  		line-height: 10px;
  		border-radius: 3%;
  		right: 1%;
  		padding: 20px 10px;  
  		display: inline-block;   
  		position:fixed;
  		top:30%;
  		
  
	}
	div.title {
  	 width: 100%;
  	 height: 10vh;
  	 text-align: center;
  	 background-color:rgba(0,0,0,0.7);
	}
	div.mainwhite{
		top: 20vh;
		width:100%;
		height: 80vh;
		background-color:rgba(255,255,255,0.5);
	}
</style>
</head>
<body>
<div class="layout mainwhite">
</div>
<div class="layout title">
	<jsp:include page="layout-subPage/title.jsp"/>
</div>
<div class="layout main">
	<jsp:include page='<%=mainPage %>'/>
</div>
<div class="layout footer">
	<jsp:include page="layout-subPage/footer.jsp"/>
</div>
<div class="layout header">
	<jsp:include page="layout-subPage/header.jsp"/>
</div>
<div class="layout info"><jsp:include page="layout-subPage/info.jsp" /></div>
</body>
</html>