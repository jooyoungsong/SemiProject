<%@page import="java.util.ArrayList"%>
<%@page import="data.dto.ExpressDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
   a.title{
      text-decoration: none;
      color: black;
   }
   a.notetitle{
      text-decoration: none;
      color: red;
   }
   
   .pop span{
      font-weight: bold;
      color: blue;
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
	String cnt=(String)session.getAttribute("cnt");

	if(cnt==null)
	{
		cnt="5";
	}
%>
<script type="text/javascript">
   $(function(){
      
      $("a.title").click(function(){
         
         var num=$(this).attr("num");
         
         $.ajax({
            
            type:"post",
            dataType:"json",
            url:"board/viewProc.jsp",
            data:{"num":num},
            success:function(data){
               
            }
         });
      });
      
      $("select.listcnt").change(function(){
          
          var cnt=$(this).val();
          
          $.ajax({
         	
         	 type:"get",
         	 dataType:"html",
         	 url:"board/popListCntChange.jsp",
         	 data:{"cnt":cnt},
         	 success:function(){
         		 
         		 location.reload();
         	 }
          });
       });
   });
</script>
</head>
<%
   String root = request.getContextPath();
   BoardDao dao=new BoardDao();

   int totalCount=dao.getPopTotalCount(); 
   int totalPage; 
   int startPage; 
   int endPage; 
   int startNum; 
   int perPage=Integer.parseInt(cnt); 
   int perBlock=5;
   int currentPage;
   int no;
   
   if(request.getParameter("currentPage")==null||request.getParameter("currentPage").equals("null"))
      currentPage=1;
   else
      currentPage=Integer.parseInt(request.getParameter("currentPage"));
   
      totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
   
      startPage=(currentPage-1)/perBlock*perBlock+1;
    
      endPage=startPage+perBlock-1;
   
   if(endPage>totalPage)
      endPage=totalPage;

   startNum=(currentPage-1)*perPage;
   
   no=totalCount-(currentPage-1)*perPage;
   
   List<BoardDto> noList=dao.getnoteList();
   List<BoardDto> popList=dao.getPopList(startNum, perPage);
%>
<body>
<div>
   <span align="top" style="font-size: 4vh; line-height: 5vh; margin-left: 1vh;"><b>인기글</b></span><br>
   <table class="table table-striped" style="width: 100%;">
	   <div style="float: left;">
	   	  <button type="button" class="btn btn-outline-secondary btn-ghost btn-open-line" onclick="location.href='subPage.jsp?main=board/freeBoard.jsp'">전체글</button>
	      <button type="button" class="btn btn-outline-secondary btn-ghost btn-open-line" onclick="location.href='subPage.jsp?main=board/popBoard.jsp'">인기글</button>
	   </div>
	   <div style="float: right;">
	      <select name="listcnt" style="margin-right: 1.25vh;" class="listcnt">
	         <option value="5" <%=cnt.equals("5")?"selected":"" %>>5개</option>
	         <option value="10" <%=cnt.equals("10")?"selected":"" %>>10개</option>
	         <option value="20" <%=cnt.equals("20")?"selected":"" %>>20개</option>
	      </select>
	      <button type="button" class="btn btn-outline-secondary btn-ghost btn-open-line" onclick="location.href='subPage.jsp?main=board/insertFree.jsp'">작성하기</button>
	   </div>
      <tr align="center">
         <th style="width: 10vh; background-color: #;">
         <span style="float: left; margin-left: 6.25vh; font-size: 2.25vh;">번호</span>
         <span style="float: left; margin-left: 25vh; font-size: 2.25vh;">제목</span>
         
         
         <span style="float: right; margin-right: 6.25vh; font-size: 2.25vh;">추천</span>
         <span style="float: right; margin-right: 5vh; font-size: 2.25vh;">조회</span>
         <span style="float: right; margin-right: 11.25vh; font-size: 2.25vh;">작성일</span>
         <span style="float: right; margin-right: 13.5vh; font-size: 2.25vh;">작성자</span>
         </th>
      </tr>
      
      <%
         
         
         SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
         
         if(popList.size()==0&&noList.size()==0)
         {
            %>
            <tr>
               <td>
                  <span align="center" style="font-size: 4vh;">게시물이 없습니다</span>
               </td>
            </tr>
         <%}
         else
         {   
            for(BoardDto dto:noList)
            {   
               int note=dto.getNote();
               
               if(note==1)
               {%>
               
               <tr>
                  <td style="color: red;">
                     <b>
                     <span style="float: left; margin-left: 5.625vh; font-size: 2.25vh;">[공지]</span>
                     
                     <a href="<%=root%>/subPage.jsp?main=board/detail.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage %>" class="notetitle" num="<%=dto.getNum()%>">
                     <span style="float: left; margin-left: 5vh; font-size: 2.25vh;">[<%=dto.getExpress() %>]</span>
                     <span style="float: left; margin-left: 1.25vh; font-size: 2.25vh;"><%=dto.getTitle() %></span>
                     </a>
            
                     <span style="float: right; margin-right: 7.5vh; font-size: 2.25vh;">-</span>
                     <span style="float: right; margin-right: 7.5vh; font-size: 2.25vh;"><%=dto.getView() %></span>
                     <span style="float: right; margin-right: 9.375vh; font-size: 2.25vh;"><%=sdf.format(dto.getWriteday()) %></span>
                     <span style="float: right; margin-right: 9.375vh; font-size: 2.25vh;">관리자</span>
                     </b>
                  </td>
               </tr>
               <%
               }
            }
            
            for(BoardDto dto:popList)
            {
               int note=dto.getNote();
               
               int likes=dto.getLikes();
               int unlikes=dto.getUnlikes();
               
               int pop=(likes-unlikes);
               
               if(note==0)
               {
               %>
               <tr class="<%=pop>=10?"pop":""%>">
                  <td>
                     <span style="float: left; margin-left: 7.5vh; font-size: 2.25vh;"><%=no--%></span>
                     
                     <a href="<%=root%>/subPage.jsp?main=board/detail.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage %>"
                     	class="title" num="<%=dto.getNum()%>">
                     <span style="float: left; margin-left: 7.5vh; font-size: 2.25vh;">
                        <%=pop>=10?"<img src='image/star.png' style='width: 2.5vh;'>":""%>
                        [<%=dto.getExpress() %>]
                     </span>
                     <span style="float: left; margin-left: 1.25vh; font-size: 2.25vh;"><%=dto.getTitle() %></span>
                     </a>
            
                     <span style="float: right; margin-right: 7.25vh; font-size: 2.25vh;"><%=dto.getLikes() %></span>
                     <input type="hidden" class="pop" value="<%=pop%>">
                     <span style="float: right; margin-right: 7.5vh; font-size: 2.25vh;"><%=dto.getView() %></span>
                     <span style="float: right; margin-right: 10vh; font-size: 2.25vh;"><%=sdf.format(dto.getWriteday()) %></span>
                     <span style="float: right; margin-right: 8.125vh; font-size: 2.25vh;"><%=dto.getWriter() %></span>
                  </td>
               </tr>
               <%}
            }
         }
      %>
   </table>
   
       <%-- 페이지번호 출력 --%>
      <div>
         <ul class="pagination justify-content-center">
            <%
               //이전버튼
               if(startPage>1)
               {%>
                  <li class="page-item">
                        <a class="page-link" href="<%=root %>/subPage.jsp?main=board/popBoard.jsp&currentPage=<%=startPage-1 %>" tabindex="-1" aria-disabled="true"><</a>
                     </li>
               <%}
            
               for(int pp=startPage;pp<=endPage;pp++)
               {
                  //현재페이지에 css추가를 위한 조건
                  if(pp==currentPage)
                  {%>
                     <li class="page-item active">
                        <a class="page-link" href="<%=root %>/subPage.jsp?main=board/popBoard.jsp&currentPage=<%=pp%>"><%=pp %></a>
                     </li>
                  <%}
                  else //선택 안한 페이지는 색이 다른 색이기 때문에 똑같이 적어도 괜찮다
                  {%>
                     <li class="page-item">
                        <a class="page-link" href="<%=root %>/subPage.jsp?main=board/popBoard.jsp&currentPage=<%=pp%>"><%=pp %></a>
                     </li>
                  <%}
               }
               
               //다음버튼
               if(endPage<totalPage)
               {%>
                  <li class="page-item">
                       <a class="page-link" href="<%=root %>/subPage.jsp?main=board/popBoard.jsp&currentPage=<%=endPage+1%>">></a>
                   </li>
               <%}
            %>
         </ul>
      </div>
</div>
</body>
</html>