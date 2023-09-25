<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	img.ex-regi,img.user-regi,img.shop-regi{

		cursor: pointer;
		margin-top: 12.5vh;
	}
	div.regibox h3{
		float: left;
		margin-top: 3.7vh;
	}
</style>
<script type="text/javascript">
	$(function(){
		
		$("img.user-regi").click(function(){
			
			location.href='index.jsp?main=userRegistration/userRForm.jsp';
		});
		
		$("img.ex-regi").click(function(){
			
			location.href='index.jsp?main=businessRegistration/expressRForm.jsp';
		});

		$("img.shop-regi").click(function(){
			
			location.href='index.jsp?main=businessRegistration/shopRForm.jsp';
		});
		
	});
</script>
</head>
<%
	String root = request.getContextPath();
%>
<body>
	<div style="width: 126.27vh; height: 62.5vh; border: 0.1vh solid gray; background-color: gold;" align="center" class="regibox">
			<img src="<%=root %>/image/usericon.png" style="width: 25vh;" class="user-regi">
			<img alt="" src="<%=root %>/image/expressicon.png" style="width: 25vh; margin-left: 10%;" class="ex-regi">
			<img alt="" src="<%=root %>/image/shopicon.png" style="width: 25vh; margin-left:10%;" class="shop-regi">
			
			<h3 style="margin-left: 11%; font-size: 3.5vh;">개인 회원가입</h3>
			<h3 style="margin-left: 13%; font-size: 3.5vh;">휴게소 사업자<br>회원가입</h3>
			<h3 style="margin-left: 13%; font-size: 3.5vh;">상가 회원가입</h3>
	</div>
</body>
</html>