<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dao.UserDao"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
.detail{
	font-family: 'Jalnan';
	margin: 75px 50px;
	width: 720px;
}
.menu-img{
	width: 200px;
	height:250px;
	border: 1px solid
}
.explain{
	font-family: 'NanumSquare', sans-serif;
	font-size: 16px;
	padding: 20px 0px 10px 10px;
}
select::-ms-expand { 
	display: none;
}
.select{
  -o-appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}
.backword{
	font-family: 'Jalnan';
	top:50px;
	left:50px;
	position: absolute;
	top:25px;
	font-size:2.0em;
	cursor: pointer;
}
.content{
	font-family: 'NanumSquare', sans-serif;
	font-weight: bold;
}
</style>
<%	
	String sang_num=request.getParameter("sang_num");
	String loginok=(String)session.getAttribute("loginok");
	String id=(String)session.getAttribute("id");
	String s_id=request.getParameter("s_id");
	System.out.println(s_id);
	NumberFormat formatter=new DecimalFormat("0.##");
%>
<script type="text/javascript">
$(function(){
	
	list();
	
	$("#btnadd").click(function(){
		var content=$(".content").val();
		content=content.replace(/(?:\r\n|\r|\n)/g, '<br>');	
		//alert("["+content.trim()+"]");	
		if(content.trim()==null||content.trim()==""){
			alert("값을 입력하시오");
			return false;
		}
		var u_id=$("#u_id").attr("value");
		var starScore=$(".select").val();
		var sang_num=$("#sang_num").attr("value");
		//alert(u_id);
		//alert(starScore);
		//alert(content);
		$.ajax({
			type:"get",
			dataType:"html",
			url:"insertAnswer.jsp",
			data:{"content":content,"u_id":u_id,"starScore":starScore,"sang_num":sang_num},
			success:function(data){
				$(".content").val("");
				list();
			}
		})
	})
	
	$(".backword").click(function(){
		var s_id=$(".s_id").val();
		location.href="shopMenu.jsp?s_id="+s_id;
	})
	
})

function list(){
	var sang_num=$("#sang_num").attr("value");
	//alert(sang_num);
	
	$.ajax({
		type:"get",
		dataType:"json",
		url:"listAnswer.jsp",
		data:{"sang_num":sang_num},
		success:function(data){
			//댓글 갯수 입력
			$("b.acount>span").text(data.length);
			$(".ansCnt").text(data.length);
			var login="<%=loginok%>";
			var id="<%=id%>";
			//출력
			var s="";
			$.each(data,function(idx,item){
				if(item.menuScore%1==0){
					item.menuScore+=".0";
				}
				s+="<div class='textAnswer"+item.idx+" textAnswer'></div>"
				s+="<table class='answer"+item.idx+" answer' style='width:600px;'><tr><td>"+item.u_id+" ["+item.starScore+"]</td><td><span style='float:right'>";
				s+="<input type='hidden' class='hiddenStar"+item.idx+"' value='"+item.starScore+"'>"
				if(login!=null&&id==item.u_id){
					s+="<i style='color:green; cursor:pointer;' idx="+item.idx+" class='bi bi-pencil-square amod'></i>&nbsp";
					s+="<i style='color:red; cursor:pointer;' idx="+item.idx+" class='bi bi-trash adel'></i></span></td></tr>";
				}
				s+="<tr><td colspan=2 class='content"+item.idx+" content'>"+item.content.replace('\n','<br>')+"</td></tr>";
				s+="<tr><td colsapn=2><span style='color:gray; font-size:13px;'>"+item.writeday+"</span></td></tr>";
				s+="</table>";
				$(".mScore").text(item.menuScore);
				if(idx<(data.length-1)){
					s+="<hr style='width:600px;'>"
				}
				$(".textAnswer"+item.idx).hide();
			})

			$("div.alist").html(s);
		}
	})
}

</script>
</head>
<body>
<%
	UserDao udao=new UserDao();
	
	int idchk=udao.isUserIdCheck(id);
	System.out.println("idchk="+idchk);
	String root=request.getContextPath();
	
	MenuDao mdao=new MenuDao();
	List<MenuDto>list=mdao.selectMenu(s_id);
	
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	
	%>
	<i class="bi bi-arrow-left backword"></i>
	<input type="hidden" class="s_id" value="<%=s_id%>">
	<%
	for(int i=0;i<list.size();i++){
		MenuDto dto=list.get(i);
		if(dto.getSang_num().equals(sang_num)){
		%>
		<table class="detail">
			<tr>
				<th style="width: 220px;">
					<img class="img-thumbnail menu-img" alt="" src="<%=root %>/save/<%=dto.getM_image()%>">
				</th>
				<td rowspan="2">
				<div class="explain">
					<%=dto.getContent().replace("\n","<br>") %><br><br>
					가격 : <%=nf.format(dto.getPrice()) %>
				</div>
				</td>
			</tr>
			<tr align="center">
			 <th>
			 	<b><%=dto.getMenu() %></b><br><b>★</b><b class="mScore"><%=dto.getM_score() %></b><b>(<span class="ansCnt"></span>명)</b>
			 </th>
			</tr>
			<tr>
        		<td colspan="2">
        			<br><hr style='width:650px; border:2px solid gray; left:20px;'>
        			<b class="acount" id="alist" style="margin-top: 10px; margin-left:10px;">댓글 <span>0</span></b><br>
        			<input type="hidden" name="sang_num" id="sang_num" value="<%=sang_num %>">
         			<input type="hidden" name="u_id" id="u_id" value="<%=id%>">
         			<%
					if(idchk==1){
					%>
        				<select style="width: 95px; margin-top: 10px; margin-left:10px;" class="select">
        					<option name="starScore" value="1">★
        					<option name="starScore" value="2">★★
        					<option name="starScore" value="3">★★★
        					<option name="starScore" value="4">★★★★
        					<option name="starScore" value="5" selected>★★★★★
        				</select>
        			<div class="aform input-group" style="margin-top: 10px; margin-left:10px;">
        				<textarea name="content" class="content" style="width: 550px;" class="form-control" required="required"
        				placeholder="댓글 입력"></textarea>
        				<button type="button" id="btnadd" class="btn btn-outline-info">저장</button>
        			</div>
        			<%
					}
        			%>
        			<div class="alist" style="margin-top: 10px; margin-left:10px;">
        				댓글목록
        			</div>
        		</td>
        	</tr>
		</table>
		<%
		}
	}
	%>
<script type="text/javascript">
	$(document).on("click",".amod",function(){
		$(".answer").show();
		var idx=$(this).attr("idx");
		$(".textAnswer").html("");
		var cont=$(".content"+idx).html();
		var content=cont.replace("<br>","\n");
		var sang_num=$
		
		var star=$(".hiddenStar"+idx).val();
		//alert(star);
			
		s="";
		//alert(idx);
		s+="<table class='uanswer"+idx+" uanswer' style='width:600px;'>";
		s+="<input type='hidden' class='hiddenSang' value='"+sang_num+"'>";
		s+="<select style='width: 95px; margin-top: 10px;' class='select ustarScore'>";
		s+="<option name='ustarScore' value='1' "+(star=='★'?'selected':'')+" >★";
		s+="<option name='ustarScore' value='2' "+(star=='★★'?'selected':'')+" >★★";
		s+="<option name='ustarScore' value='3' "+(star=='★★★'?'selected':'')+" >★★★";
		s+="<option name='ustarScore' value='4' "+(star=='★★★★'?'selected':'')+" >★★★★";
		s+="<option name='ustarScore' value='5' "+(star=='★★★★★'?'selected':'')+" >★★★★★";
		s+="</select>";
		s+="<div style='margin-top: 10px;'>"
		s+="<tr><td>";
		s+="<textarea name='content' class='content' style='width: 530px;' class='form-control' required='required'";
		s+="placeholder='댓글 수정'>"+content+"</textarea></td></tr>";
		s+="<tr><td><button type='button' idx='"+idx+"' class='btn btn-outline-info btnUpdate' style='margin-right:10px;'>수정</button>";
		s+="<button type='button' id='btnClose' idx='"+idx+"' class='btn btn-outline-danger btnClose'>닫기</button></td></tr>"
		s+="</div>"
		s+="</table>";
		$(".textAnswer"+idx).show();
		$(".answer"+idx).hide();
		$(".textAnswer"+idx).html(s);
	})
	
	$(document).on("click",".btnClose",function(){
		//alert("클릭함");
		var idx=$(this).attr("idx");
		$(".textAnswer").html("");
		$(".answer"+idx).show();
	})
	
	$(document).on("click",".btnUpdate",function(){
		//alert("클릭했음");
		var idx=$(this).attr("idx");
		var content=$(this).parent().parent().parent().find(".content").val();
		var starScore=$(".ustarScore").val();
		var sang_num=$("#sang_num").attr("value");
		//alert(sang_num);
		//alert(idx);
		//alert(content);
		//alert(starScore);
		$.ajax({
			type:"get",
			dataType:"html",
			url:"updateAnswer.jsp",
			data:{"content":content,"idx":idx,"starScore":starScore,"sang_num":sang_num},
			success:function(data){
				list();
			}
		})
	})
	
	$(document).on("click",".adel",function(){
		
		var idx=$(this).attr("idx");
		var sang_num=$("#sang_num").attr("value");
		//alert("클릭함, 상넘="+sang_num+"idx = "+idx);
		var s=confirm("삭제하시겠습니까?");
		
		if(s){
			$.ajax({
				type:"get",
				dataType:"html",
				url:"deleteAnswer.jsp",
				data:{"idx":idx,"sang_num":sang_num},
				success:function(data){
					list();
					alert("삭제되었습니다.");
				}
			})
		}else{
			alert("취소하였습니다.");
		}
	})

</script>
</body>
</html>