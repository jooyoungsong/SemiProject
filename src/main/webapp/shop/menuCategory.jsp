<%@page import="org.json.simple.JSONArray"%>
<%@page import="data.dto.MenuDto"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MenuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String eng_category=request.getParameter("eng_category");
	
	MenuDao dao=new MenuDao();
	List<MenuDto> list=dao.seperateCategory(eng_category);
	
	JSONArray arr=new JSONArray();

	for(int i=0;i<list.size();i++){
		MenuDto dto=list.get(i);
		JSONObject ob=new JSONObject();
		
		ob.put("m_image", dto.getM_image());
		ob.put("menu", dto.getMenu());
		ob.put("sang_num", dto.getSang_num());
		ob.put("m_score",dto.getM_score());
		arr.add(ob);
	}
%>
<%=arr.toString()%>