<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MenuDao"%>
<%@page import="data.dto.MenuDto"%>
<%@page import="data.dao.MenuDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<title>Insert title here</title>
<style type="text/css">
	div.menudiv{
		cursor: pointer;
		font-family: 'Jalnan';
	}
	div.new_menudiv{
		font-family: 'Jalnan';
		cursor: pointer;
	}
	#category{
		font-family: 'NanumSquare';
		font-weight: bold;
		width: 700px;
		border: 1px solid lightgray;
		border-color: lightgray;
		margin-left: 90px;
		margin-top : 20px;
		padding-top: 15px;
		padding-bottom: 15px;
		
	}
	.orderBtn{
		font-size:20px;
		font-family: 'Jalnan';
		margin-left: 450px;
		border: 1px solid white;
		width: 150px;
		height: 50px;
		background-color: orange;
		color: white;	
	}
	.orderBtn:active{
		background-color: white;
		color: orange;
	}
	.name{
		font-family: 'Jalnan';
		position:absolute;
		top: 10px;
		left: 610px;
		margin-left: 200px;
	}
</style>
</head>
<%
String loginok=(String)session.getAttribute("loginok");
String id=(String)session.getAttribute("id");
String grade=(String)session.getAttribute("grade");
if(grade==null){
	grade="";
}
UserDao udao=new UserDao();

UserDto udto=udao.getData(id);

String s_id=request.getParameter("s_id");
MenuDao dao=new MenuDao();
List<MenuDto> list=dao.selectMenu(s_id);

List<String> categorylist=new ArrayList<String>();
categorylist=dao.getCategory(s_id);
%>
<body>
<script type="text/javascript">
	$(function(){
		$(".orderBtn").click(function(){
			var id=$("#id").val();
			var s_id=$("#s_id").val();
			var loginok=$("#loginok").val();
			if(loginok=='null'){
				$("#my-modal").click();
			}else{
				location.href="../order/orderCart.jsp?s_id="+s_id;
			}
		})
		$(".logoutBtn").click(function(){
			location.href="logoutAction.jsp";	
		})
	})

</script>
<input type="hidden" id="loginok" value="<%=loginok%>">
<input type="hidden" id="id" value="<%=id%>">
<input type="hidden" id="s_id" value="<%=s_id%>">
<%
		ShopDao sdao=new ShopDao();
		ShopDto sdto=sdao.getData(s_id);
		%>
			<img src="../save/<%=sdto.getS_image() %>" style="width: 186px; height: 186px; margin-left: 20px;">
			<%
			if(grade.equals("user")&&loginok!=null){ 
				%>
				<b class="name" style="margin-left: 50px;"><%=udto.getU_name() %>님 환영합니다!</b>
				<%
				}
			if(grade.equals("user")||grade.equals("")){
			%>
			<button class="orderBtn">주문하기</button>
			<%
			}%>
			<div id="category">
				<b style="margin-left: 20px;">분류보기</b>
				<hr width="660" style="margin-left: 20px;">
				
				<span style="margin-left: 20px;">
					<input type="radio" class="rbtn" name="category" value="All" checked="checked">All&nbsp;
					<%
					for(int j=0;j<categorylist.size();j++){
					%>
						<input type="radio" class="rbtn" name="category" value="<%=categorylist.get(j)%>"><%=categorylist.get(j)%>&nbsp;
					<%}
					%>
				</span>
			</div>
			<input type="hidden" class="s_id" value="<%=s_id%>">


<div align="center" style="margin-top: 5%; margin-bottom: 3%;" id="allbody">
	<table style="width: 800px;">
		<tr>
		<%
		for(int i=0;i<list.size();i++){
				MenuDto dto=list.get(i);
			%>
				<td>
					<div align="center" class="menudiv" sang_num="<%=dto.getSang_num()%>">
						<img src="../save/<%=dto.getM_image() %>" style="width: 250px; height: 250px;"><br>
						<b style="font-size: 15px;"><%=dto.getMenu() %><br>★<%=dto.getM_score() %></b>
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

<div align="center" style="margin-top: 5%; margin-bottom: 3%;" id="menubody">

</div>

	<script type="text/javascript">
		$("div.menudiv").click(function(){
			var sang_num=$(this).attr("sang_num");
			var s_id=$(".s_id").val();
				
			window.open("detailPage.jsp?sang_num="+sang_num+"&s_id="+s_id,"_self","width=900, height=700, scrollbars=yes");
		});
		
		$(document).on("click","div.new_menudiv",function(){
			var sang_num=$(this).attr("sang_num");
			var s_id=$(".s_id").val();
				
			window.open("detailPage.jsp?sang_num="+sang_num+"&s_id="+s_id,"_self","width=900, height=700, scrollbars=yes");
		});
		
		$(".rbtn").click(function(){
			var eng_category=$(this).val();
			if(eng_category=="All"){
				$("#allbody").show();
				$("#menubody").html("");
			}
			else{
				
				$.ajax({
					type: "get",
					url: "menuCategory.jsp",
					dataType: "json",
					data: {"eng_category":eng_category},
					success: function(data){

						var s="";
						$("#allbody").hide();
						
						s+="<div align='center' style='margin-top: 5%; margin-bottom: 3%;'>";
						s+="<table style='width: 800px;'>";
						s+="<tr>";
				         $.each(data,function(idx,item){
				        	 if(item.m_score%1==0){
									item.m_score+=".0";
							}
				        	 s+="<td>"
								s+="<div align='center' class='new_menudiv' sang_num='"+item.sang_num+"'>"
									s+="<img src='../save/"+item.m_image+"' style='width: 250px; height: 250px;'><br>"
									s+="<b style='font-size: 15px;'>"+item.menu+"<br>★"+item.m_score+"</b>"
								s+="</div>"
							s+="</td>"
							if(idx%3==2){
								s+="</tr><tr>"
							}
				         });
				         
				         s+="</tr></table></div>"
				         
				         $("#menubody").html(s);
					}
				});
			}
		});
	</script>
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal" style="display: none"
id="my-modal">
Open modal
</button>
	<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <jsp:include page="../userLogin/orderLoginForm.jsp"></jsp:include>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
	
</body>
</html>