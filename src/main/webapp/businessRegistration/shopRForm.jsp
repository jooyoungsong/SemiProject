<%@page import="data.dto.ExpressDto"%>
<%@page import="data.dao.ExpressDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Diphylleia&family=Dokdo&family=Nanum+Brush+Script&family=Nanum+Gothic+Coding&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		
		$("#expressName").change(function(){
			
			var name=$("select[id=expressName] option:selected").text();
			$("#expressName3").val(name);
			$("#expressName2").text(name);
			alert($("#expressName3").val());
			$("#returnBid").val($(this).val());
		});
		
		$("#s_number1").keyup(function(){

            if($(this).val().length==3)
                $("#s_number2").focus();
        });
		
		$("#s_number2").keyup(function(){

            if($(this).val().length==2)
                $("#s_number3").focus();
        });
		
		$("#shop_hp1").keyup(function(){

            if($(this).val().length==3)
                $("#shop_hp2").focus();
        });
		
		$("#shop_hp2").keyup(function(){

            if($(this).val().length==3)
                $("#shop_hp3").focus();
        });
		
		$("#s_phone1").keyup(function(){

            if($(this).val().length==3)
                $("#s_phone2").focus();
        });
		
		$("#s_phone2").keyup(function(){

            if($(this).val().length==4)
                $("#s_phone3").focus();
        });
		
		// 사업자번호 중복체크
		$("#bnchk").click(function () {
		    var s_id1 = $("#s_number1").val();
		    var s_id2 = $("#s_number2").val();
		    var s_id3 = $("#s_number3").val();

		    // 숫자 이외의 입력을 제거
		    s_id1 = s_id1.replace(/[^0-9]/g, '');
		    s_id2 = s_id2.replace(/[^0-9]/g, '');
		    s_id3 = s_id3.replace(/[^0-9]/g, '');

		    // 입력 필드에 숫자만 표시
		    $("#s_number1").val(s_id1);
		    $("#s_number2").val(s_id2);
		    $("#s_number3").val(s_id3);

		    if (s_id1.length === 3 && s_id2.length === 2 && s_id3.length === 5) {
		        $.ajax({
		            type: "get",
		            dataType: "json",
		            url: "businessRegistration/s_idsearch.jsp",
		            data: { "s_id1": s_id1, "s_id2": s_id2, "s_id3": s_id3 },
		            success: function (data) {
		                if (data.check == 1) {
		                    $("#idprint").text("이미 사용중인 아이디입니다");
		                    $("#idprint").css("color", "red");
		                    $("#s_number1").val("");
		                    $("#s_number2").val("");
		                    $("#s_number3").val("");
		                    $("#s_number1").focus();
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
		        $("#s_number1").val("");
                $("#s_number2").val("");
                $("#s_number3").val("");
                $("#s_number1").focus();
		    }
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
			
			if(v.s_pass.value != v.s_pass1.value)
			{
				alert("비밀번호를 확인해주세요");
				v.s_pass.value="";
				v.s_pass1.value="";
				v.s_pass.focus();
				return false;
			}
			else if(!passwordRegex.test(v.s_pass.value))
			{
				alert("비밀번호는 영문 대소문자/숫자/특수문자(!@#$%^*+=-)를 포함하여 4자~16자로 입력해주세요");
				v.s_pass.value="";
				v.s_pass1.value="";
				v.s_pass.focus();
				return false;
			}
	}
</script>
</head>
<%	
	ExpressDao dao=new ExpressDao();
	List<ExpressDto>list=dao.getIdyo();

%>
<body>
	<div style="width: 125vh; height: 83vh; border: 0.5vh solid gold; background-color: white; border-radius: 3vh; margin-left: 0.75vh;">
		<span style="font-size: 3vh; margin-left: 2vh;"><b>상가 회원가입</b></span>
		<hr style="color: gold; border: 0.2vh solid gold; width: 120vh; margin-left: 2vh;">
		<form action="businessRegistration/shopRProc.jsp" method="post" enctype="multipart/form-data" onsubmit="return checkpass(this)">
			<table class="table table-bordered form-group" style="width: 120vh; margin-top: 2vh; margin-left: 2vh;">
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">휴게소선택<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<select id="expressName" name="b_name">
						<%
							String firstName="";
							String firstB_id="";
							for(int i=0;i<list.size();i++){
								ExpressDto dto=list.get(i);
								if(i==0){
									firstName=dto.getB_name();
									firstB_id=dto.getB_id();
								}
								%>
								<option value="<%=dto.getB_id()%>"><%=dto.getB_name()%></option>
								<%
							}
							%>
						</select>
						<input type="hidden" name="b_id" id="returnBid" value="<%=firstB_id%>">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">매장 사업자번호(상가 아이디)<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td class="form-group" style="width: 93.75vh;">
						<input type="text" style="width: 8.75vh;"
						required="required" maxlength="3" class="s_number1" id="s_number1" name="s_id1">
						-
						<input type="text" style="width: 7.5vh;"
						required="required" maxlength="2" class="s_number2" id="s_number2" name="s_id2">
						-
						<input type="text" style="width: 10vh;"
						required="required" maxlength="5" class="s_number3" id="s_number3" name="s_id3">
						
						<button style="margin-left: 1.25vh; border: 1px solid gray; border-radius: 0.625vh;" id="bnchk">사업자 번호 확인</button><br>
						<span style="color: #999999; font-size: 2vh;">(사업자번호 10자리)</span>
						<span id="idprint"></span>
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">비밀번호<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td class="form-group">
						<input type="password" style="width: 25vh;" min="4" maxlength="16" required="required" name="s_pass"><br>
						<span style="color: #999999; font-size: 2vh;">(영문 대소문자/숫자/특수문자(!@#$%^*+=-) 4자~16자)</span>
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">비밀번호 확인<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="password" style="width: 25vh;" min="4" maxlength="16" required="required" name="s_pass1">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">이름<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" style="width: 25vh;" min="4" maxlength="16" required="required" name="s_name">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">상호명<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td class="form-group">
						<span id="expressName2"><%=firstName %></span>
						<input type="hidden" id="expressName3" name="shop_name1" value="<%=firstName%>">
						<input type="text" style="width: 25vh;" name="shop_name2">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">휴게소 상호 번호<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<select name="shop_addr">
							<option value="1번 매장">1번 매장</option>
							<option value="2번 매장">2번 매장</option>
							<option value="3번 매장">3번 매장</option>
							<option value="4번 매장">4번 매장</option>
							<option value="5번 매장">5번 매장</option>
							<option value="6번 매장">6번 매장</option>
						</select>
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">일반전화<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" style="width: 100px;" maxlength="3" required="required" name="shop_hp1" id="shop_hp1">
						-
						<input type="text" style="width: 100px;" maxlength="3" required="required" name="shop_hp2" id="shop_hp2">
						-
						<input type="text" style="width: 100px;" maxlength="4" required="required" name="shop_hp3" id="shop_hp3">
					</td>
				</tr>
				<tr valign="middle">
					<td style="width: 31.25vh; background-color: #FFFF99;">휴대전화<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="text" style="width: 100px;" maxlength="3" required="required" name="s_phone1" id="s_phone1">
						-
						<input type="text" style="width: 100px;" maxlength="4" required="required" name="s_phone2" id="s_phone2">
						-
						<input type="text" style="width: 100px;" maxlength="4" required="required" name="s_phone3" id="s_phone3">
					</td>
				</tr>
				<tr>
					<td style="width: 31.25vh; background-color: #FFFF99;">가게 로고<span style="margin-left: 1.25vh; color: #FF3333">*</span></td>
					<td>
						<input type="file" required="required" name="s_image">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit" class="btn btn-outline-warning" style="width: 12.5vh; height: 5vh; font-size: 2vh;" id="btnSRegi">회원가입</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>