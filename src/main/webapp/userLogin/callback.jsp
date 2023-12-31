<%@page import="java.util.List"%>
<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300;400;700&family=Gaegu:wght@300&family=Noto+Serif+KR:wght@200&family=Single+Day&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<title>Insert title here</title>
</head>
<%
//절대경로잡기
String root = request.getContextPath();
String modal=(String)session.getAttribute("modal");
System.out.println("modal="+modal);

session.removeAttribute("modal");
UserDao dao=new UserDao();
List<String>list=dao.selectId();
%>
<body>
<input type="hidden" id="modalS_id"value="<%=modal%>">
<!-- 네이버아디디로로그인 Callback페이지 처리 Script -->
<script type="text/javascript">
  var naver_id_login = new naver_id_login("mxqUPyw1CadFAnqmOC_4", "http://localhost:8080/SemiProject/userLogin/callback.jsp");
  // 접근 토큰 값 출력
  // alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {

    /* alert(naver_id_login.getProfileData('email'));
    alert(naver_id_login.getProfileData('name'));
    alert(naver_id_login.getProfileData('email')); */
    var modal=$("#modalS_id").val();
    var N_token= naver_id_login.oauthParams.access_token;
   	var N_email=naver_id_login.getProfileData('email');
   	var N_name=naver_id_login.getProfileData('name');
   	var returnNum=0;
	<%
	for(int i=0;i<list.size();i++){
		String name=list.get(i);
	%>
   		if(N_email=="<%=name%>"){
   			//alert("일치");
   			returnNum=1;
   			//alert(returnNum);
   			$.ajax({
   				
   				type:"get",
   				dataType:"json",
   				url:"../userLogin/naverLoginAction.jsp",
   				data:{"u_id":N_email},
   				success:function(data){
   					if(data.loginok==null){
   						location.href="../userLogin/naverHumanPage.jsp?userId="+data.userId+"&modal="+modal;
   					}else{
   						location.href="../userLogin/naverHumanLoginAction.jsp?userId="+data.userId+"&modal="+modal;
   					}
   				}
   				
   			})
   			
   		}
   	<%
	}
	
	%>
	if(returnNum==0){
		alert("아이디가 존재하지 않습니다. 회원가입 합니다.");
		$.ajax({
		
			type:"get",
			dataType:"html",
			url:"../userRegistration/naverRAction.jsp",
			data:{"u_name":N_name,"u_id":N_email,"u_email":N_email},
			success:function(){
				alert("회원가입 완료!");
				location.href="../userLogin/naverHumanLoginAction.jsp?userId="+N_email+"&modal="+modal;
			}
		
		})
	}
}
</script>
</body>
</html>