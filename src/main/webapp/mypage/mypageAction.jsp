<%@page import="data.dao.UserDao"%>
<%@page import="data.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
   href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&family=Gaegu:wght@300&family=Noto+Serif+KR:wght@200&family=Single+Day&display=swap"
   rel="stylesheet">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
   rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	UserDto dto=new UserDto();
	String num=request.getParameter("num");
	
	String userid=request.getParameter("userId");
	String userpass=request.getParameter("userpass2");
	String useremail=request.getParameter("useremail1")+"@"+request.getParameter("useremail2");
	String userhp=request.getParameter("userhp1")+"-"+request.getParameter("userhp2")+"-"+request.getParameter("userhp3");
	String userbirth = request.getParameter("userbirth");
	
	dto.setNum(num);
	dto.setU_id(userid);
	dto.setU_pass(userpass);
	dto.setU_email(useremail);
	dto.setU_hp(userhp);
	dto.setU_birth(userbirth);
	
	UserDao dao=new UserDao();
	dao.updateUserInfo(dto);
	
	response.sendRedirect("../index.jsp");
%>
</body>
</html>