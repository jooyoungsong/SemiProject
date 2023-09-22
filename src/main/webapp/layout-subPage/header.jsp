<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ExpressDto"%>
<%@page import="data.dao.ExpressDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/style-header-106-33-15937.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Nav Bar</title>
<style>
span * {
    font-family: 'nanumsquareround',sans-serif;
    font-style: normal;
}

.dv1{
	width: 100%;
	z-index:999;
	height: 0px;
}

#ttop {
   position:absolute;
   height: 10vh;
   width: 100%;
   margin-right: auto;
   margin-left: auto; 
   background-color:rgba(255,255,255,0.7);
 
}

.topmenu {
   text-decoration: none;
   color: #696969;
   display: block;
   font-size: 2.5vh;
   font-family: 'nanumsquareround', sans-serif;
   font-weight:bold;
   margin-top: 3vh;
}

.submenu a{
   text-decoration: none;
   color: #696969;
   display: block;
   font-size: 2.5vh;
   font-family: 'nanumsquareround', sans-serif;
   margin-top: 4vh;
}

.submenu a:hover{
   background-color: gray;
   color: white;
}
 
#ttop ul li {
   list-style: none;
   float: left;
   line-height: 4vh;
   vertical-align: middle;
   text-align: center;
   width:18vh; 
   position:relative;
}

.submenu{
   height: 0;
   overflow: hidden;
}

#ttop:hover .submenu {
  height: 38vh;
  transition-duration: 1s;
  }
  

h6 {
	z-index:1000;
	font-size:5vh;
	position:absolute;
	top:2vh; 
	left:4vh;
	color: green;
}
</style>
<%
//절대경로보기
String root = request.getContextPath();

String inherence_HU=request.getParameter("id");
String grade=(String)session.getAttribute("grade");
String loginok=(String)session.getAttribute("loginok");
String id=(String)session.getAttribute("id");
ShopDto sdto=new ShopDto();
ShopDao sdao=new ShopDao();
if(id!=null){
	sdto=sdao.getData(id);
}
//System.out.println("id="+id);
String b_id=sdto.getB_id();

if(b_id==null){
	b_id="";
}
System.out.println("b_id="+b_id);
if(grade==null){
	grade="";
}

if(inherence_HU==null){
	inherence_HU=(String)session.getAttribute("inherence_HU");
}
//System.out.println("aaaaaaa"+(String)session.getAttribute("inherence_HU"));

ExpressDao dao=new ExpressDao();
ExpressDto dto=new ExpressDto();

List<ExpressDto> list=dao.getId(inherence_HU);
//System.out.println(inherence_HU);



String myimg=null;
String mytitle=null;
String logoimg=null; 
for (int i = 0; i < list.size(); i++) {
	dto = list.get(i);
	myimg = dto.getImage();
	mytitle = dto.getB_name();
	logoimg = dto.getLogoimg();
}
%>
<script type="text/javascript">
$(function(){
	var b_id=$("#b_id").val();
	
	$.ajax({
	      type:"get",
	      url: "layout-subPage/sessionGet.jsp",
	      dataType:"html",
	      data: {"b_id":b_id},
	      success: function(data){
	         //alert("보내짐");
	      }
	   })
	//alert(s_id);
	
	  $("#ttop").mouseout(function(){
	         $(".dv1").css("height","0vh").css("background-color","white").css("transition","all 0.5s ease-in-out");
	      });
	      
	$("#ttop").mouseover(function(){
        $(".dv1").css("height","50vh").css("background-color","#F5F5F5").css("transition","all 0.5s ease-in-out");
     });
});

</script>
</head>
<body>
	<input type="hidden" id="b_id" value="<%=inherence_HU%>">
	

<div class="dv1">	
	<h6>
	<%
	if(logoimg == null || logoimg == ""){ %>
		<b3 style="margin-left: 5vh; cursor: pointer;" onclick="location.href='<%=root%>/subPage.jsp'"><%=mytitle %></b3>
		<% }else{ %>

		<b3 style="margin-left: 5vh; cursor: pointer;" onclick="location.href='<%=root%>/subPage.jsp'"> 
		<img style="width: 15vh;  background-size: cover;" src="save/<%=logoimg %>"> </b3>

		<%} %>
	</h6>
   <nav id="ttop" style="">
   <ul class="t1" >
      <%-- <li><img src="image/logo.png" style="margin-left: 40px; 
      cursor: pointer;" onclick="location.href='<%=root%>/subPage.jsp'"></li> --%>
      
      <!-- title 각휴게소 -->
      <%-- 
      <li>
      	<b3 style="margin-left: 40px; cursor: pointer;" onclick="location.href='<%=root%>/subPage.jsp'"><%=mytitle %></b3>
      </li> 
      --%>
      
      <!-- <li style="width: 150px; margin-left: 10vh;">menu 시설안내
      	 <a href="#" class="topmenu" style="width: 150px; margin-left: 10px;">시설안내</a> -->
      <li style="width: 25vh; margin-left: 40vh;"><!-- menu 시설안내 -->
      	 <a class="topmenu" style="width: 25vh;">시설안내</a>	 
         <ul class="submenu" style="margin-left: -4vh;">
         	<a href="<%=root %>/subPage.jsp?main=facilities/FacilitiesMain.jsp" style="font-size: 2vh;">편의시설</a>
         </ul>
      </li>
      
      <li style="width: 25vh;"><!-- menu 음식점-->
         <a class="topmenu" style="width: 25vh;">음식점</a>
         <ul class="submenu" style="margin-left: -4vh;">
         	<a href="<%=root%>/subPage.jsp?main=shop/shopList.jsp" style="font-size: 2vh;">음식점</a>
         <%if(id!=null){
        	 if(b_id.equals(sdto.getB_id())&&loginok!=null){
        	 %>
         <a href="<%=root%>/subPage.jsp?main=order/orderAddForm.jsp" style="font-size: 2vh;">음식추가</a>
         <%
        	 }
         }
         if(id!=null){
        	 if((b_id.equals(sdto.getB_id())||grade.equals("user"))&&loginok!=null){
        	 %>   
         <a href="<%=root%>/subPage.jsp?main=order/orderCheckPage.jsp" style="font-size: 2vh;">주문목록</a>
         <%
        	 }
         }
         %>
         </ul>
      </li>
      
      <li style="width: 25vh;"><!-- menu 이벤트 -->
         <a class="topmenu" style="width: 25vh;">이벤트</a>
         <ul class="submenu" style="margin-left: -4vh;">
         <a href="" style="font-size: 2vh;">진행중 이벤트</a>
         <a href="" style="font-size: 2vh;">종료 이벤트</a>
         </ul>
      </li>
      
      <li style="width: 25vh;"><!-- menu 자유게시판-->
      <a class="topmenu" style="width: 25vh;">게시판</a>
         <ul class="submenu" style="margin-left: -4vh;">
         <a href="" style="font-size: 2vh;">공지게시판</a>
         <a href="<%=root%>/subPage.jsp?main=board/freeBoard.jsp" style="font-size: 2vh;">자유게시판</a>
         </ul>
      </li> 
   </ul>
    
   </nav>
</div>
	
</body>
</html>
