<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String s_id=request.getParameter("s_id");
	session.setAttribute("modal", s_id);
	System.out.println(s_id);

%>