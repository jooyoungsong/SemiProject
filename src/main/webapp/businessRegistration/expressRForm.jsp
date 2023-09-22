<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Diphylleia&family=Dokdo&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		
		// 사업자번호 중복체크
		$("#bnchk").click(function () {
		    var b_id1 = $("#b_number1").val();
		    var b_id2 = $("#b_number2").val();
		    var b_id3 = $("#b_number3").val();

		    // 숫자 이외의 입력을 제거
		    b_id1 = b_id1.replace(/[^0-9]/g, '');
		    b_id2 = b_id2.replace(/[^0-9]/g, '');
		    b_id3 = b_id3.replace(/[^0-9]/g, '');

		    // 입력 필드에 숫자만 표시
		    $("#b_number1").val(b_id1);
		    $("#b_number2").val(b_id2);
		    $("#b_number3").val(b_id3);

		    if (b_id1.length === 3 && b_id2.length === 2 && b_id3.length === 5) {
		        $.ajax({
		            type: "get",
		            dataType: "json",
		            url: "businessRegistration/b_idsearch.jsp",
		            data: { "b_id1": b_id1, "b_id2": b_id2, "b_id3": b_id3 },
		            success: function (data) {
		                if (data.check == 1) {
		                    $("#idprint").text("이미 사용중인 아이디입니다");
		                    $("#idprint").css("color", "red");
		                    $("#b_number1").val("");
		                    $("#b_number2").val("");
		                    $("#b_number3").val("");
		                    $("#b_number1").focus();
		                } else {
		                    $("#idprint").text("사용 가능한 아이디입니다");
		                    $("#idprint").css("color", "green");
		                }
		            }
		        });
		    }
		    else {
		        $("#idprint").text("번호를 확인해주세요");
		        $("#idprint").css("color", "red");
		        $("#b_number1").val("");
                $("#b_number2").val("");
                $("#b_number3").val("");
                $("#b_number1").focus();
		    }
		});
		
		
		
		$(".b_number1").keyup(function(){

            if($(this).val().length==3)
                $(".b_number2").focus();
        });
		
		$(".b_number2").keyup(function(){

            if($(this).val().length==2)
                $(".b_number3").focus();
        });
		
		$("#s_hp1").keyup(function(){

            if($(this).val().length==3)
                $("#s_hp2").focus();
        });
		
		$("#s_hp2").keyup(function(){

            if($(this).val().length==4)
                $("#s_hp3").focus();
        });
		
		$("#b_hp1").keyup(function(){

            if($(this).val().length==3)
                $("#b_hp2").focus();
        });
		
		$("#b_hp2").keyup(function(){

            if($(this).val().length==4)
                $("#b_hp3").focus();
        });
		
	});
	
	function checkpass(v)
	{
			/* ^: 입력 문자열의 시작을 나타냅니다.
			(?=.*[a-zA-Z]): 적어도 하나의 영문 대소문자 알파벳이 포함되어야 함을 나타냅니다.
			(?=.*\d): 적어도 하나의 숫자가 포함되어야 함을 나타냅니다.
			.{4,16}: 비밀번호는 최소 4자에서 16자 사이의 길이여야 함을 나타냅니다.
			$: 입력 문자열의 끝을 나타냅니다.
			/: 패턴의 시작과 끝 표시
			\d는 다음과 같은 패턴과 일치합니다:

			0, 1, 2, 3, 4, 5, 6, 7, 8, 9와 같은 숫자 문자.
			문자열 내에 숫자가 포함되어 있는지 확인하는 데 사용됩니다. */
			
			var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*\d).{4,16}$/;
			
			if(v.b_pass.value != v.b_pass1.value)
			{
				alert("비밀번호를 확인해주세요");
				v.b_pass.value="";
				v.b_pass1.value="";
				v.b_pass.focus();
				return false;
			}
			else if(!passwordRegex.test(v.b_pass.value))
			{
				alert("비밀번호는 영문 대소문자/숫자/특수문자(!@#$%^*+=-)를 포함하여 4자~16자로 입력해주세요");
				v.b_pass.value="";
				v.b_pass1.value="";
				v.b_pass.focus();
				return false;
			}
	}
	
	//주소
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
            }
        }).open();
    }
</script>
<%
	String root = request.getContextPath();
%>
</head>
<body>
	<div style="width: 125vh; height: 80vh; border: 0.5vh solid gold; background-color: white; border-radius: 3vh; margin-left: 0.75vh;">
		<span style="font-size: 3vh; margin-left: 2vh;"><b>사업자 회원가입(휴게소)</b></span>
		<hr style="color: gold; border: 0.2vh solid gold; width: 120vh; margin-left: 2vh;">
		<form action="businessRegistration/expressRProc.jsp" method="post" enctype="multipart/form-data" onsubmit="return checkpass(this)">
			<table class="table table-bordered form-group" style="width: 120vh; margin-top: 2vh; margin-left: 2vh;">
				<tr valign="middle">
					<td style="width: 31.25vh; font-size: 2vh; background-color: #FFFF99;">사업자번호(사업자 아이디)<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td class="form-group" style="width: 93.75vh;">
						<input type="text" style="width: 8.75vh;"
						required="required" maxlength="3" class="b_number1" id="b_number1" name="b_id1">
						-
						<input type="text" style="width: 7.5vh;"
						required="required" maxlength="2" class="b_number2" id="b_number2" name="b_id2">
						- 
						<input type="text" style="width: 10vh;"
						required="required" maxlength="5" class="b_number3" id="b_number3" name="b_id3">
						
						<button style="margin-left: 1.25vh; border: 0.2vh solid gray; border-radius: 0.5vh;" id="bnchk">사업자 번호 확인</button><br>
						<span style="color: #999999; font-size: 2vh;">(사업자번호 10자리)</span>
						<span id="idprint"></span>
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">비밀번호<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td class="form-group">
						<input type="password" style="width: 25vh;" min="4" maxlength="16" required="required" name="b_pass"><br>
						<span style="color: #999999; font-size: 2vh;">(영문 대소문자/숫자/특수문자(!@#$%^*+=-) 4자~16자)</span>
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">비밀번호 확인<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="password" style="width: 25vh;" min="4" maxlength="16" required="required" name="b_pass1">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">휴게소이름<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" style="width: 25vh;" min="4" maxlength="16" required="required" name="b_name">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">주소<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" id="sample6_postcode" placeholder="우편번호" required="required">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="margin-bottom: 1.25vh; border: 0.2vh solid gray; border-radius: 0.5vh;"><br>
						<input type="text" id="sample6_address" placeholder="주소" name="addr" style="width: 46.75vh; margin-bottom: 1.25vh;" required="required"><br>
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">일반전화<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" style="width: 12.5vh;" maxlength="3" required="required" name="s_hp1" id="s_hp1">
						-
						<input type="text" style="width: 12.5vh;" maxlength="4" required="required" name="s_hp2" id="s_hp2">
						-
						<input type="text" style="width: 12.5vh;" maxlength="4" required="required" name="s_hp3" id="s_hp3">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">휴대전화<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" style="width: 12.5vh;" maxlength="3" required="required" name="b_hp1" id="b_hp1">
						-
						<input type="text" style="width: 12.5vh;" maxlength="4" required="required" name="b_hp2" id="b_hp2">
						-
						<input type="text" style="width: 12.5vh;" maxlength="4" required="required" name="b_hp3" id="b_hp3">
					</td>
				</tr>
				<tr>
					<td style="width: 31.25vh; background-color: #FFFF99;">휴게소 이미지<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="file" required="required" name="image">
					</td>
				</tr>
				<tr>
					<td style="width: 31.25vh; background-color: #FFFF99;">휴게소 로고 이미지<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="file" name="logoimg">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit" class="btn btn-outline-warning" style="width: 12.5vh; height: 5vh; font-size: 2vh;">회원가입</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>