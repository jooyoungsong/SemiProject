<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.UserDao"%>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Insert title here</title>
</head>
<style>
select.box{
	width: 100%;
	height: 35px;
	box-sizing: border-box;;
	margin-left: 5px;
	padding: 5px 0 5px 10px;
	border-radius: 4px;
	border: 1px solid #d9d6d6;
	color: #383838;
	background-color: #ffffff;
}

option{
	font-size: 16px;
}

.inputform{
	width: 125vh;
	height: 83vh; 
	border: 0.5vh solid gold; 
	background-color: white; 
	border-radius: 3vh; 
	margin-left: 0.75vh;
}

#topline{ 
	margin-left: 2vh;
	margin-top: 2vh;
	/* border: 2px solid red; */
}

#topDelIcon{
	/* border: 2px solid red; */
	float: right;
	margin-right: 20px;
	
}

</style>
<script type="text/javascript">
$(function(){
	
	//비밀번호 확인 일치여부
	$("#userpass2").blur(function () {
	    var password1 = $("#userpass1").val();
	    var password2 = $("#userpass2").val();

	    // 비밀번호 패턴 정의: 8자리 이상, 영문, 숫자, 특수문자 조합
	    var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&*!])[A-Za-z\d@#$%^&*!]{8,}$/;

	    if (password1 !== password2) {
	        if (password2 !== '') {
	            $("#userpass2").val('');
	            $("#userpass2").focus();
	            $("#pwConfirm").text("비밀번호가 다릅니다");
	            $("#pwConfirm").css("color", "red");
	            $("#userForm").preventDefualt();
	            alert("비밀번호가 일치하지 않아 수정되지 않습니다");
	            
	        }
	    } else if (!passwordPattern.test(password1)) {
	        $("#userpass1").val('');
	        $("#userpass2").val('');
	        $("#pwConfirm").text("영문+숫자+특수문자 조합, 8자리 이상 필요");
	        $("#pwConfirm").css("color", "red");
	        $("#userForm").preventDefualt();
	    } else {
	        $("#pwConfirm").text("사용가능한 비밀번호입니다");
	        $("#pwConfirm").css("color", "green");
	    }
	    
	});
	
	//마이페이지 x버튼 누르면 메인페이지로 이동
	$("#topDelIcon").click(function(){
		location.href="index.jsp";
	});
	
	
});

	//핸드폰번호
	// userpass1 입력 필드에서 자동으로 userpass2로 포커스 이동
	$("#userhp1").keyup(function () {
	    var hp1 = $(this).val();
	
	    // 자릿수가 3자리이면 userpass2로 포커스 이동
	    if (hp1.length === 3) {
	        $("#userhp2").focus();
	    }
	});
	
	// userpass2 입력 필드에서 자동으로 userpass3으로 포커스 이동
	$("#userhp2").keyup(function () {
	    var hp2 = $(this).val();
	
	    // 자릿수가 4자리이면 userpass3으로 포커스 이동
	    if (hp2.length === 4) {
	        $("#userhp3").focus();
	    }
	});
	

//이메일 직접선택 관련
//도메인 직접 입력 or domain option 선택
const domainListEl = document.querySelector('#domain-list')
const domainInputEl = document.querySelector('#domain-txt')
// select 옵션 변경 시
domainListEl.addEventListener('change', (event) => {
  // option에 있는 도메인 선택 시
  if(event.target.value !== "type") {
    // 선택한 도메인을 input에 입력하고 disabled
    domainInputEl.value = event.target.value
    domainInputEl.disabled = true
  } else { // 직접 입력 시
    // input 내용 초기화 & 입력 가능하도록 변경
    domainInputEl.value = ""
    domainInputEl.disabled = false
  }
  
});

//선택 이메일 주소 넣기, 혹은 직접입력
$("#domain-list").change(function(){
	
	if($(this).val()=='type'){
		$("#domain-txt").val("");
		$("#domain-txt").focus();
		
	} else{
			$(".emailbox1").val($(this).val());
			alert($(".emailbox1").val());
	}

});


</script>
<%
   String root=request.getContextPath();
   
   //dao_mypage 회원 num 가져오기
   String uid=(String)session.getAttribute("id");
   UserDao dao=new UserDao();
   UserDto dto=dao.getUserInfo(uid);
   
   //이메일,핸드폰 값은 split으로 나누기
   String uemail=dto.getU_email();
   String[] uemailSplit=uemail.split("@");
   String uemail1=uemailSplit[0];
   String uemail2=uemailSplit[1];
   
   //네이버 로그인 시, 핸드폰 번호 못 가져와서 마이페이지 안 들어가짐
   String uhp=dto.getU_hp();
   if(uhp.equals("")){
      uhp="none";
   }
   String[] uhpSplit=new String[3];
   System.out.println(uhp);
   String uhp1="",uhp2="",uhp3="";
   if(uhp!="none"){
      uhpSplit=uhp.split("-");
      uhp1=uhpSplit[0];
      uhp2=uhpSplit[1];
      uhp3=uhpSplit[2];
   }
%>
<body>
<div class="inputform" style="width:1000px; height: 450px;">
	<form action="<%=root %>/mypage/mypageAction.jsp" method="post" id="userForm">
	<input type="hidden" name="uid" value="<%=uid%>">
		<table class="table table-bordered" style="width: 130vh; margin-top: 2vh; margin-left: 2vh;">
		<div id="topline">
			<span align="top" id="topfont"><b>개인정보 수정</b></span><span id="topDelIcon"><i class="bi bi-x-circle" style="font-size: 1.3em; color: gray; cursor: pointer;"></i></span>
		</div>
		<hr style="color: gold; border: 0.2vh solid gold; width: 130vh; margin-left: 2vh;">
			<tr>
				<td class="formlist" style="width: 150px; background-color: #FFFF99;"><b>아이디<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="text" class="userId" name="userId" placeholder="아이디" required="required" value="<%=uid%>" readonly>
					
					<span class="idsuccess"></span>	
				</td>
			</tr>
			
			<!--네이버로그인_마이페이지 비밀번호 tr(행) 안 보이게_uid 가져와서 naver.com로 된 아이디면 안되게...-->
			<%	System.out.println("pass=["+dto.getU_pass()+"]");
				if(dto.getU_pass()!=null){%>
					
			<tr>
				<td class="formlist" style="width:150px; background-color: #FFFF99;"><b>비밀번호<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input class="" type="password" id="userpass1" name="userpass1" placeholder="비밀번호" required="required" value="">
					<input type="password" id="userpass2" name="userpass2" placeholder="비밀번호 확인" required="required" value="">
					<span id="pwConfirm"></span>
				</td>
			</tr>
					
			<%}else{//네이버 로그인한 고객인경우%>
				<input type="hidden" name="userpass2" value="<%=dto.getU_pass()%>">
			<%}
			%> 
			<tr>
				<td class="formlist" style="width:150px; background-color: #FFFF99;"><b>이메일<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="text" id="useremail1" name="useremail1" placeholder="이메일" required="required" value="<%=uemail1%>">&nbsp;@
					<input type="text" class="box emailbox1"  placeholder="선택하기"  name="useremail2" value="<%=uemail2%>">
					<select class="box" id="domain-list" style="width: 200px;">
						<option value="type">직접입력</option>
						<option value="naver.com">네이버</option>			
						<option value="google.com">구글</option>
						<option value="daum.net">다음</option>
						<option value="hanmail.com">한메일</option>
						<option value="nate.com">네이트</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="formlist" style="width: 150px; background-color: #FFFF99;"><b>이름<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="text" id="username" name="username" placeholder="이름" required="required" value="<%=dto.getU_name()%>" readonly>
				</td>
			</tr>
			<!--네이버로그인_마이페이지 생년월일...-->
			<%//일반회원인 경우 생년월일 변경불가 readonly
				if(dto.getU_pass()!=null){%>
					
			<tr>
				<td class="formlist" style="width: 150px; background-color: #FFFF99;"><b>생년월일<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="date" name="userbirth" id="userbirth" value="<%=dto.getU_birth()%>" readonly>
				</td>
			</tr>
					
			<%}else{//네이버 로그인한 고객인경우 생년월일 변경가능%>
			<tr>
				<td class="formlist" style="width: 150px; background-color: #FFFF99;"><b>생년월일<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="date" name="userbirth" id="userbirth" value="">
				</td>
			</tr>
			<%}
			%> 
			<tr valign="middle">
					<td style="width: 250px; background-color: #FFFF99;"><b>휴대전화<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
					<td>
						<input type="text" style="width: 100px;" maxlength="3" required="required" name="userhp1" id="userhp1" value="<%=uhp1%>">&nbsp;-
						<input type="text" style="width: 100px;" maxlength="4" required="required" name="userhp2" id="userhp2" value="<%=uhp2%>">&nbsp;-
						<input type="text" style="width: 100px;" minlength="4" maxlength="4" required="required" name="userhp3" id="userhp3" value="<%=uhp3%>">
					</td>
				</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" class="btn btn-outline-warning" value="정보수정">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>