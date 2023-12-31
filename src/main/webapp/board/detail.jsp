<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
	i.btnlike,i.btnunlike{
		cursor: pointer;
	}
	a.freeboard{
		text-decoration: none;
		color: black;
	}
	
	.btn.btn-outline-secondary.btn-ghost.btn-open-line {
		  
		  border: 1px solid white;
		  transition: 0.3s;
		
		  &::before,
		  &::after {
		    position: absolute;
		    content: "";
		    left: 0;
		    width: 100%;
		    height: 1px;
		    background: var(--btn-bg);
		    opacity: 1;
		    transform: scaleX(0);
		    transition: 0.4s ease-in-out;
		  }
		
		  &::before {
		    top: 0;
		  }
		
		  &::after {
		    bottom: 0;
		  }
		
		  &:hover {
		    letter-spacing: 5px;
		    color: var(--btn-bg);
		    background: transparent;
		    background-color: gold;
		
		    &::before,
		    &::after {
		      opacity: 1;
		      transform: scaleX(1.2);
		    }
		}
	}
</style>
<%
	String root = request.getContextPath();

	String num=request.getParameter("num");
	String currentPage=request.getParameter("currentPage");
	
	BoardDao dao=new BoardDao();
	BoardDto dto=dao.getData(num);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월 dd일");
	
	String id=(String)session.getAttribute("id");
	
	int note=dto.getNote();
%>
<script type="text/javascript">
	$(function(){
		
		$("i.btnlike").click(function(){
			
			var num=$(this).attr("num");
			
			$.ajax({
				
				type:"post",
				dataType:"json",
				url:"board/likeProc.jsp",
				data:{"num":num},
				success:function(data){
					
					location.reload();
				}
			});
		});
		
		
		$("i.btnunlike").click(function(){
			
			var num=$(this).attr("num");
			
			$.ajax({
				
				type:"post",
				dataType:"json",
				url:"board/unlikeProc.jsp",
				data:{"num":num},
				success:function(data){
					
					location.reload();
				}
			});
		});
	});
	
	function del(num,currentPage)
	{
		var check=confirm("삭제하시겠습니까?");
		
		if(check)
		{
			location.href="<%=root%>/board/deleteBoard.jsp?num="+num+"&currentPage="+currentPage;
		}
		else
		{
			alert("취소되었습니다");
			return false;
		}
	}
</script>
</head>
<body>
	<div>
		<form>
			<table class="table table-bordered" style="width: 100%; margin-left: 0.75vh;">
				<caption align="top"><a href="<%=root%>/subPage.jsp?main=board/freeBoard.jsp" class="freeboard"><span style="font-size: 4vh;"><b>자유게시판</b></span></a></caption>
				<tr>
					<td>
						<span style="font-size: 3vh;"><%=dto.getTitle() %></span><br>
						<%if(note==1)
						{%>
						<span style="font-size: 2vh;"><%=dto.getExpress() %></span>
						<%}
						if(note==0)
						{%>
						<span style="font-size: 2vh;"><%=dto.getWriter() %></span>
						<%} %>
						<span style="margin-left: 1.25vh; font-size: 2vh;"><%=sdf.format(dto.getWriteday()) %></span>
						
						<div style="float: right; font-size: 2vh;">
							<span>조회 <%=dto.getView() %></span>
							|
							<% if(note==0)
							{%>
							<span>추천 <%=dto.getLikes() %></span>
							|
							<%}%>
							<span>댓글 0</span>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="width: 100%; height: 62.5vh; font-size: 2vh;">
						<%=dto.getContent() %>
						
						<% if(note==0)
						{%>
							<div style="width: 100%; height: 62.5vh;" align="center">
								<div style="margin-top: 45vh; width: 37.5vh; height: 12.5vh; border: 1px solid black;" text-align="center">
									<div style="text-align: center; line-height: 12.5vh;">
										<span class="like"><%=dto.getLikes() %></span>
										
										<span><i class="bi bi-star-fill btnlike" style="font-size: 5vh; color: #FFCC00;" num="<%=dto.getNum()%>"></i>
										</span>
										
										<span style="font-size: 5vh;">
										|
										</span>
										
										<span><i class="bi bi-star btnunlike" style="font-size: 5vh;" num="<%=dto.getNum()%>"></i>
										</span>
										
										<span class="unlike"><%=dto.getUnlikes() %></span>
									</div>
								</div>
							</div>
						<%}%>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="width: 100%; height: 30vh; background-color: gray;">
							
						</div>
					</td>
				</tr>
			</table>
			
			<div>
				<button type="button" onclick="location.href='<%=root%>/subPage.jsp?main=board/freeBoard.jsp?currentPage=<%=currentPage %>'" class="btn btn-outline-secondary btn-ghost btn-open-line">전체글</button>
				
				<div style="float: right;">
					<%if(dto.getWriter().equals(id))
					{%>
					<button type="button" onclick="location.href='<%=root%>/subPage.jsp?main=board/updateBoard.jsp?num=<%=dto.getNum() %>&currentPage=<%=currentPage %>'" class="btn btn-outline-secondary btn-ghost btn-open-line">수정</button>
					<button type="button" onclick="del(<%=dto.getNum() %>,<%=currentPage %>)" class="btn btn-outline-secondary btn-ghost btn-open-line">삭제</button>
					<%}%>
					<button type="button" onclick="location.href='<%=root%>/subPage.jsp?main=board/insertFree.jsp'" class="btn btn-outline-secondary btn-ghost btn-open-line">글쓰기</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>