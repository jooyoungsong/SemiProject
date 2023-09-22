<%@page import="java.util.List"%>
<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle&family=Gugi&family=Orbit&display=swap"
        rel="stylesheet"> -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
<link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">

	div.center{
		z-index: 900;
	}
	div.shopdiv{
		width: 200px;
		height: 250px;
		border: 1px solid gray;
		margin-left: 10px;
		margin-top: 10px;
		cursor: pointer;
		float: left;
		font-family: 'nanumsquareround',sans-serif;
	}
</style>
</head>
<%
ShopDao dao=new ShopDao();
String s_id=(String)session.getAttribute("inherence_HU");
System.out.println("bid="+s_id);
List<ShopDto> list=dao.getAllShops(s_id);
%>
<body>
	<div align="center" style="color: green; ">
	<h3 style="color: green; font-family: 'Jalnan'; margin-top:20px;">푸드코트</h3>
	<table style="width: 650px;">
	<tr>
	<%
	for(int i=0;i<list.size();i++){
			ShopDto dto=list.get(i);
	%>
			<td>
				<div style="background-color: white;" align="center" class="shopdiv" s_id="<%=dto.getS_id()%>">
					<img src="save/<%=dto.getS_image() %>" style="width: 186px; height: 186px;">
					<b style="font-size: 13px; background-color: white;"><%=dto.getShop_name() %></b>
				</div>
			</td>
		<%
		if(i%3==2){%>
			</tr>
			<tr>
	<%}
	}
%>
</tr>
</table>
</div>
		<script type="text/javascript">
			$("div.shopdiv").click(function(){
				var s_id=$(this).attr("s_id");
				//alert(s_id);
				
				window.open("shop/shopMenu.jsp?s_id="+s_id,"_blank","width=900, height=700, scrollbars=yes");
			});
		</script>

</body>
</html>