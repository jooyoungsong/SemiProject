<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.MenuDto"%>
<%@page import="data.dao.MenuDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.UserDto"%>
<%@page import="data.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://webfontworld.github.io/goodchoice/Jalnan.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Gaegu:wght@300&family=Nanum+Pen+Script&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->
<title>Insert title here</title>
<style type="text/css">
div.mt-3 {
	margin-left: -5px;
	margin-top: -110px;
	width: 450px;
}

div.menudiv {
	cursor: pointer;
	font-family: 'Jalnan';
}

div.new_menudiv {
	cursor: pointer;
}

#category {
	width: 700px;
	border: 1px solid lightgray;
	border-color: lightgray;
	margin-left: 90px;
	margin-top: 20px;
	padding-top: 15px;
	padding-bottom: 15px;
}
.nav-item{
	font-sizs:15px;
	font-family: 'NanumSquare', sans-serif;
}

.orderBtn {
	font-size: 30px;
	font-family: 'Dongle';
	margin-left: 450px;
	border: 1px solid white;
	width: 150px;
	height: 50px;
	background-color: orange;
	color: white;
}

.orderBtn:active {
	background-color: white;
	color: orange;
}

.orderBox {
	margin-top:50px;
	margin-left:50px;
	width: 350px;
	height: 600px;
	border: 3px solid black;
	border-radius: 30px 30px 30px 30px;
	padding: 30px 30px;
	font-sizs:15px;
	font-family: 'NanumSquare', sans-serif;
}
div.allBox{
	display: flex;
	margin-left: 30px;
}
.cart-table{
	width: 300px;
	font-size:12px;
}
.order-footer{
	font-family: 'NanumSquare', sans-serif;
	position: absolute;
	top: 640px;
	width:300px;
	vertical-align:middle;
	font-size: 12px;
}
.su{
	width: 30px;
	height: 30px;

}

.kakao{
  	width: 60px;
  	height: 50px;
}
.toss{
 	width: 60px;
  	height: 50px;
}
#name{
	font-family: 'Jalnan'; 
	font-size: '20px';
	margin-left: 650px;
	margin-top:10px;
}
</style>
<%
	
	String s_id = request.getParameter("s_id");
	String id = (String) session.getAttribute("id");

	MenuDao mdao = new MenuDao();

	List<MenuDto> list = mdao.selectMenu(s_id);

	List<String> categorylist = mdao.getCategory(s_id);

	UserDao udao = new UserDao();
	udao.getData(id);

	UserDto udto = new UserDto();
	udto = udao.getData(id);
	
	ShopDao sdao=new ShopDao();
	ShopDto sdto=sdao.getData(s_id);
	
	NumberFormat nf=NumberFormat.getCurrencyInstance();
%>
<script type="text/javascript">
	$(function(){
		var i=1;
		$(".menudiv").click(function(){
			var sang_num=$(this).attr("sang_num");
			var price=$(this).children().eq(0).val();
			var name=$(this).children().eq(3).text();
			i=$("#idx").val();
			//alert("i="+i);
			for(var j=1;j<i;j++){
				var compSang=$(".td"+j+"first").attr("sang_num");

				if(sang_num==compSang){

					var plus=".plus"+j;
					
					$(".plusNum").val(plus);

					plusBtn();
					return;
					}
				}
			//alert(name);
				s="";
				s+="<tr><td class='td"+i+" td"+i+"first' style='width:130px;' id='td"+i+"' sang_num='"+sang_num+"'>"+name+"</td>";
				s+="<td class='td"+i+"' style='width:100px;'><button type='button' class='minus minus"+i+"'>-</button> <span class='td"+i+"su su' name='su"+i+"'>1</span> "; 
				s+="<button type='button' class='plus plus"+i+"'>+</button></td>";
				s+="<td class='td"+i+" price price"+i+"' style='width:100px; text-align:center;' value='"+price+"'>"+price+"</td>";
				s+="<td class='td"+i+" del'><button class='btn btn-danger sm del' style='font-size:5px;' td='td"+i+"'>x</button>";
				s+="</tr>"
			
				$(".cart-table").append(s);
				i++;
				$("#idx").val(i);
				totPrice();
		})
		
		$(document).on("click",".plus",function(){
			var su=$(this).parent().find(".su").text();
			su++;
			$(this).parent().find(".su").text(su);
			
			var price=$(this).parent().parent().find(".price").attr("value");
			var modPrice=price*su;
			$(this).parent().parent().find(".price").text(modPrice);
			
			totPrice();
		})
		
		$(document).on("click",".minus",function(){
			var su=$(this).parent().find(".su").text();
			if(su==1){
				return;
			}
			else{
				su--;
				$(this).parent().find(".su").text(su);
			
				var price=$(this).parent().parent().find(".price").attr("value");
				var modPrice=price*su;
				$(this).parent().parent().find(".price").text(modPrice);
			}
			totPrice();
		})
		
		$(document).on("click",".del",function(){
			var td=$(this).attr("td");
			$("."+td).remove();
			totPrice();
		})
		
		//버튼 클릭하면 결제 버튼 추가
		//결제 버튼 누를시
		$(".addOrder").click(function(){
			var idx=$("#idx").val();
			var selpay=$(this).attr("name");
			var content="";
			var totPrice=$("#total-price").text();
			var s_id=$("#s_id").val();
			var u_id='<%=id%>';
			for(var i=0;i<idx;i++){
				if($(".price"+i).text()==0){
					continue;
				}
				var sangName=$("#td"+i).text();
				var su=$(".td"+i+"su").text();
				content+=sangName+" : "+su+"<br>";
			}
			content+="총 금액 : "+totPrice;

			
			var today = new Date();
			var hours = today.getHours(); // 시
			var minutes = today.getMinutes();  // 분
			var seconds = today.getSeconds();  // 초
			var milliseconds = today.getMilliseconds();
			var makeMerchantUid = hours+""+minutes+""+seconds+""+milliseconds;
			var IMP = window.IMP;
			if(totPrice=='0'){
				alert("추가된 물품이 없습니다.");
				return;
			}
			if(selpay=='kakao'){
				var y=confirm("구매 하시겠습니까?");
			    if (y) { // 구매 클릭시 한번 더 확인하기
			       

			    IMP.init("imp27065454"); // 가맹점 식별코드
			    IMP.request_pay({
			        pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
			        pay_method: 'card', // 결제 방식
			        merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
			        name: '메가커피 주문', // 제품명
			        amount: totPrice, // 가격
			        //구매자 정보 ↓
			        //buyer_email: `${useremail}`,
			        //buyer_name: `${username}`,
			        // buyer_tel : '010-1234-5678',
			        // buyer_addr : '서울특별시 강남구 삼성동',
			        // buyer_postcode : '123-456'
			    }, async function (rsp) { // callback
			         if (rsp.success) { //결제 성공시
			        	console.log(rsp);
			            alert(rsp.imp_uid);
						$.ajax({
							type:"get",
							dataType:"html",
							url:"addOrder.jsp",
							data:{"receipt":content,"u_id":u_id,"s_id":s_id,"totPrice":totPrice,"num":rsp.imp_uid},
							success:function(data){
								alert("결제 완료되었습니다!\n 주문번호 : "+rsp.imp_uid);
								window.location.reload();
							}
						})

			        } else if (rsp.success == false) { // 결제 실패시
			        	alert(rsp.error_msg);
			        }
			 	});
			}
			else { // 비회원 결제 불가
			  	alert('취소하였습니다.');
			  	return false;
			}
		}else if(selpay=='toss'){
			if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
				IMP.init("imp27065454");
				IMP.request_pay({
			   		pg : 'tosspay',
			    	pay_method : 'card',
			    	merchant_uid: "IMP" + makeMerchantUid, //상점에서 생성한 고유 주문번호
			    	name : '메가커피 주문',   //필수 파라미터 입니다.
				   	amount : totPrice,
				    buyer_email : 'iamport@siot.do',
			    	buyer_name : '구매자이름',
			   		buyer_tel : '010-1234-5678',
			    	buyer_addr : '서울특별시 강남구 삼성동',
			   		buyer_postcode : '123-456',
			    	//m_redirect_url : '../order/orderCart.jsp' // 예: https://www.my-service.com/payments/complete 
				}, async function (rsp) { // callback
					if (rsp.success) { //결제 성공시
	                	
	                	$.ajax({
							type:"get",
							dataType:"html",
							url:"addOrder.jsp",
							data:{"receipt":content,"u_id":u_id,"s_id":s_id,"totPrice":totPrice,"num":rsp.imp_uid},
							success:function(data){
								alert("결제 완료되었습니다!\n 주문번호 : "+rsp.imp_uid);
								window.location.reload();
							}
						})

	               	} else if (rsp.success == false) { // 결제 실패시
	                   	alert(rsp.error_msg);
	               	}
				});
       		}
       		else { // 비회원 결제 불가
			  	alert('취소하였습니다.');
			  	return false;
       		}
		}
	})
		
		//전체 장바구니 삭제
		$("#alldel").click(function(){
			var idx=$("#idx").val();
			for(var i=0;i<idx;i++){
				$(".td"+i).remove();
			}
			totPrice();
		})
	})
	function plusBtn(){
		var plusNum=$(".plusNum").val();
		//alert(plusNum);
		$(plusNum).click();
	} 
	
	function totPrice(){
		var idx=$("#idx").val();
		var cnt=1;
		//alert(idx);
		var totPrice=0;
		var j=1;
		for(j=1;j<idx;j++){
			if($(".price"+j).text()==0){
				cnt++;
				continue;
			}
			var price=parseInt($(".price"+j).text());
			totPrice+=price;
			//alert(totPrice);
			$("#total-price").text(totPrice);
		}
		if(cnt==j){
			$("#total-price").text(0);
		}
	}
	
</script>
</head>
<body>
<h5 id="name"><%=udto.getU_name()%>님 반갑습니다!</h5>
	<input type="hidden" id="idx" value="1">
	<input type="hidden" class="plusNum" value="">
	<input type="hidden" id="s_id" value="<%=s_id%>">
	<div class="allBox">
		<div class="mt-3">
			<img src="../save/<%=sdto.getS_image() %>"
				style="width: 120px; height: 120px; margin-left: 20px;"> <br>
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li class="nav-item"><a class="nav-link active"
					data-bs-toggle="tab" href="#menu1">All</a></li>
				<%
				for (int i = 0; i < categorylist.size(); i++) {
				%>
				<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
					href="#menu<%=(i + 2)%>"><%=categorylist.get(i)%></a></li>
				<%
				}
				%>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<div id="menu1" class="container tab-pane active">
					<br>
					<table style="width: 400px;">
						<tr>
							<%
							for (int i = 0; i < list.size(); i++) {
								MenuDto dto = list.get(i);
							%>
							<td>
								<div align="center" class="menudiv"
									sang_num="<%=dto.getSang_num()%>">
									<input type="hidden" name="price" value="<%=dto.getPrice()%>">
									<img src="../save/<%=dto.getM_image()%>"
										style="width: 100px; height: 100px;"><br> <b style="font-size: 15px;"><%=dto.getMenu()%></b>
										<br><b>★<%=dto.getM_score()%></b>
								</div>
							</td>
							<%
							if (i % 3 == 2) {
							%>
						</tr>
						<tr>
							<%
							}
							}
							%>
						</tr>
					</table>
				</div>
				<%
				for (int i = 0; i < categorylist.size(); i++) {
					List<MenuDto> sepList = mdao.seperateCategory(categorylist.get(i));
				%>
				<div id="menu<%=(i + 2)%>" class="container tab-pane fade">
					<br>
					<table style="width: 400px;">
						<tr>
							<%
							for (int j = 0; j < sepList.size(); j++) {
								MenuDto dto = sepList.get(j);
							%>
							<td>
								<div align="center" class="menudiv"
									sang_num="<%=dto.getSang_num()%>">
									<input type="hidden" name="price" value="<%=dto.getPrice()%>">
									<img src="../save/<%=dto.getM_image()%>"
										style="width: 100px; height: 100px;"><br> <b style="font-size: 15px;"><%=dto.getMenu()%></b>
										<br><b>★<%=dto.getM_score()%></b>
								</div>
							</td>
							<%
							if (j % 3 == 2) {
							%>
						</tr>
						<tr>
							<%
							}
							}
							%>
						</tr>
					</table>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<div class="orderBox">
			<h5 class="order-h5">장바구니</h5>
			<hr style="border: 3px solid gray">
			<table class="cart-table">
				
			</table>
			<table class="order-footer">
				<tr valign="top" style="height: 50px;">
					<td style="width: 100px;">
						총금액 : <span id="total-price">0</span>
					</td>
					<td style="width: 70px;">
						<button type="button" id="alldel" class="btn btn-danger" style="width: 70px; font-size: 1vh;">전체삭제</button>
					</td>
					<td style="width: 130px;">
						<input type='image' class='addOrder kakao' src='../image/Kakaopay_Logo.png' name='kakao'>
						<input type='image' class='addOrder toss' src='../image/Toss_Logo_black.png' name='toss'>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>