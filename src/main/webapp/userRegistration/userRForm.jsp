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
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Audiowide&family=Hi+Melody&family=Itim&family=Nanum+Pen+Script&family=Rock+Salt&family=Wallpoet&display=swap" rel="stylesheet">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1ddc717c4e4cd5fed053858415435334"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>User Registraion</title>
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

#topfont{ 
	margin-left: 2vh;
	margin-top: 2vh;
}
</style>
<script type="text/javascript">

$(function(){
	
	//아이디 중복체크
	$(".userId").on("blur",function(){
		
		//id 읽기
		var userId=$(".userId").val();
		//alert(userId);
		
		//한글이면 제거하는 변수 만들기(유효성 검사)
		 var cleanedUserId = userId.replace(/[ㄱ-ㅎ가-힣]/g, '');
		
		// 한글 입력 검사
                var regex = /[ㄱ-ㅎ가-힣]/;
                if (regex.test(userId)) {
                    $("span.idsuccess").text("아이디에 한글을 포함할 수 없습니다.");
                    $("#userId").val(cleanedUserId);  //한글 제거하는 기능 넣기
                    $("span.idsuccess").css("color", "red");
                    return;
                }

                // 길이 검사
                if (userId.length < 6) {
                    $("span.idsuccess").text("아이디는 6자리 이상이어야 합니다.");
                    $("span.idsuccess").css("color", "red");
                    return false;
                }
                
       //ajax
		$.ajax({
			
			type:"get",
			url:"userRegistration/userIdSearch.jsp",
			dataType:"json",
			data:{"userId":userId},
			success:function(data){
				
				if(data.count==0){
					$("span.idsuccess").text("사용가능한 아이디입니다");
					$("span.idsuccess").css("color","green");
				} else{
					$("span.idsuccess").text("사용할 수 없는 아이디입니다.\n다시 입력해주세요");
					$("span.idsuccess").css("color","red");
				}
				
				/* //alert(data.count);
				if(data.count==1 && userId.length < 6){
				
					$("span.idsuccess").text("사용할 수 없는 아이디입니다.\n다시 입력해주세요");
					$("span.idsuccess").css("color","red");
					//alert("아이디를 다시 입력해주세요")
					
				}else{
					
					$("span.idsuccess").text("사용가능한 아이디입니다");
					$("span.idsuccess").css("color","green");
				}  */
			}			
		});
		
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
		        }
		    } else if (!passwordPattern.test(password1)) {
		        $("#userpass1").val('');
		        $("#userpass2").val('');
		        $("#pwConfirm").text("영문+숫자+특수문자 조합, 8자리 이상 필요");
		        $("#pwConfirm").css("color", "red");
		    } else {
		        $("#pwConfirm").text("사용가능한 비밀번호입니다");
		        $("#pwConfirm").css("color", "green");
		    }
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
			/* 	alert($(".emailbox1").val()); */
		}
		
	});
	
	//생년월일 현재날짜 이후 선택 비활성화
	
	 // 현재 날짜 가져오기
        var currentDate = new Date();

        // 날짜 입력 요소 가져오기
        var dateInput = document.getElementById("userbirth");

        // 현재 날짜 이후의 날짜를 선택할 수 없도록 비활성화
        dateInput.max = currentDate.toISOString().split('T')[0];
	
});

</script>
<%
	String root=request.getContextPath();
%>
</head>
<body>
<div class="inputform"> <!--style="width:1000px;"  -->
	<form action="<%=root %>/userRegistration/userRAction.jsp" method="post">
		<table class="table table-bordered" style="width: 120vh; margin-top: 2vh; margin-left: 2vh;">
		<div align="top" id="topfont"><b>개인 회원가입</b></div>
		<hr style="color: gold; border: 0.2vh solid gold; width: 120vh; margin-left: 2vh;">
			<tr>
				<td style="width: 150px; background-color: #FFFF99;"><b>아이디<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="text" class="userId" name="userId" placeholder="아이디" required="required">
					
					<span class="idsuccess"></span>	
				</td>
			</tr>
			<tr>
				<td style="width:150px; background-color: #FFFF99;"><b>비밀번호<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="password" id="userpass1" name="userpass1" placeholder="비밀번호" required="required" value="">
					<input type="password" id="userpass2" name="userpass2" placeholder="비밀번호 확인" required="required" value="">
					<span id="pwConfirm"></span>
				</td>
			</tr>
			<tr>
				<td style="width:150px; background-color: #FFFF99;"><b>이메일<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="text" id="useremail1" name="useremail1" placeholder="이메일" required="required">&nbsp;@
					<input type="text" class="box emailbox1"  placeholder="선택하기"  name="useremail2" value="">
					<select class="box" id="domain-list" style="width: 200px;">
						<option value="type">직접입력</option>
						<option value="naver.com">네이버</option>			
						<option value="gmail.com">구글</option>
						<option value="daum.net">다음</option>
						<option value="hanmail.com">한메일</option>
						<option value="nate.com">네이트</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 150px; background-color: #FFFF99;"><b>이름<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="text" id="username" name="username" placeholder="이름" required="required">
				</td>
			</tr>
			<tr>
				<td style="width: 150px; background-color: #FFFF99;"><b>생년월일<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
				<td>
					<input type="date" name="userbirth" id="userbirth">
				</td>
			</tr>
			<tr valign="middle">
					<td style="width: 250px; background-color: #FFFF99;"><b>휴대전화<span style="margin-left: 10px; color: #FF3333">*</span></b></td>
					<td>
						<input type="text" style="width: 100px;" maxlength="3" required="required" name="userhp1" id="userhp1">&nbsp;-
						<input type="text" style="width: 100px;" maxlength="4" required="required" name="userhp2" id="userhp2">&nbsp;-
						<input type="text" style="width: 100px;" minlength="4" maxlength="4" required="required" name="userhp3" id="userhp3">
					</td>
				</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" class="btn btn-outline-warning" value="회원가입">
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>