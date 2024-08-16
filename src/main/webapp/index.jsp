<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&family=Gaegu:wght@300&family=Noto+Serif+KR:wght@200&family=Single+Day&display=swap"
   rel="stylesheet">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
   rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>HyuGo</title>
<style type="text/css">

body{
   background-image: url("image/hgsimage.jpg") ;
   background-size :100% 100vh;
   background-attachment: scroll;
   background-repeat: no-repeat;
}

div.bcblack{
   width: 100%;
   height: 100vh;
   left:0;
   top:0;
   background-color:rgba(0,0,0,0.7);
}

div.layout {
   position: absolute;
   
}

div.title {
   width: 100%;
   height: 15%;
   text-align: center;
}

div.main {
   width: 70%;
   height: 84%;
   font-size: 2vh;
   margin-left: 15%;
   top: 15%;  
}

div.info {
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

div.hgintroduce{
   width: 100%;
   height: 100%;
   top: 100%;
   background-image:url("image/yellowbackground.jpg");
   background-size :100% 100vh;
   background-attachment: scroll;
   background-repeat: no-repeat;
}


</style>
</head>
<%
// 절대경로잡기
String root = request.getContextPath();
String mainPage = "layout-index/main.jsp";

if (request.getParameter("main")!= null) {
   mainPage = request.getParameter("main");
}

%>
<body>
      <div class="layout bcblack"></div>
      <div class="layout title"><jsp:include page="layout-index/title.jsp" /></div>
      <div class="layout main"><jsp:include page="<%=mainPage%>" /></div>
      <div class="layout hgintroduce"><jsp:include page="layout-index/hgintroduce.jsp" /></div>
      <div class="layout info"><jsp:include page="layout-index/maininfo.jsp" /></div>
      <%
      String name=(String)session.getAttribute("ssss");
      System.out.println("나오는 session="+name); 
      %>
</body>
</html>