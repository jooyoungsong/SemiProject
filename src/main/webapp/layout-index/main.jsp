<%@page import="data.dto.ExpressDto"%>
<%@page import="data.dao.ExpressDao"%>
<%@page import="java.util.ArrayList"%>
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
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1ddc717c4e4cd5fed053858415435334&libraries=services"></script>

<title>Insert title here</title>
<style type="text/css">
/*///////////////////////////////////////////////////////////////////////*/
/*맵 css*/
#map{

   position: absolute;
    border-radius:40px;
   margin-left:23%;
   
      width: 50%;
      height: 90%;
 
   }
   

#map.input{
   align-self: center;
   
}
/*///////////////////////////////////////////////////////////////////////*/
/*맵 검색 리스트 css */
#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 20%;
   height: 90%;
   margin: 10px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: rgba(255, 255, 255, 0.7);
   z-index: 1;
   font-size: 14pt;
   border-radius: 10px;
   font-family:Dongle;
   }
   #keyword{
      background-color: #fff;
      padding: 3px;
      border-radius: 25px 0 0 25px;
      
   }
   #searchbtn2{
   
   background-color: orange;
   padding: 3px;
   border-radius: 0 25px 25px 0;
   color:#fff;
   margin-left: -6px;
   }
   .mapbtn_x{
      border-radius: 100px;
   }
/*///////////////////////////////////////////////////////////////////////*/   
/*메인 휴게소찾기버튼 css */
form.box{

   width: 500px;
   position:absolute;
   top:40%;
   left:50%;
   transform:translate(-50%,-50%);
   color: #fff;
   text-align: center;
}

form.box h1{
   font-weight:normal;
}

form.box input{
   border:none;
}

.searchbtn{
   width:13vh;
   height:5vh;
   background-color: orange;
   padding: 1vh;
   border-radius: 2.5vh;
   color:#fff;
   margin-left: -6px;
}
.mapbtn_x{
   border-radius: 3px;
}
/*///////////////////////////////////////////////////////////////////////*/
   
   
</style>
<script type="text/javascript">
   
$(function(){
    $(".map_wrap").hide();
    
    /* $(function setmap(){
       $("#map").show();
    }); */
 });

 
 function setmap(){
    $(".map_wrap").show('slow');
    $(".box").hide();
    
    
 }
 
 function mapout(){
       $(".map_wrap").hide('slow');
       $(".box").show();
       
       
    }


</script>
</head>
<% 


String root=request.getContextPath();

request.setCharacterEncoding("UTF-8");

ExpressDao dao=new ExpressDao();
ExpressDto dto=new ExpressDto();

// String aaa=null;
ArrayList<ExpressDto> list=dao.getIdyo();
// List<TestAddrDto> list2=dao.getname();
%>
<body>

   <form class="box" style="align: center;">
         <h1>What are you looking for?</h1><br>
         <input type="button" class="searchbtn" value="휴게소찾기" onclick="setmap()"><br>
         
   </form>
   <div class="map_wrap" id="map_wrap">
   <div id="map"></div>
   <div id="menu_wrap" class="bg_white">
      <div class="option">
         <input type="text" placeholder="검색 할 휴게소 입력" id="keyword"
            name="hugesoname" size="20">
         <button id="searchbtn2" type="button" onclick="qwer()">검색하기</button>
         <button class="btn btn-danger" id="mapbtn_x" onclick="mapout()">X</button>
         <br>
         <b>검색결과</b>
      </div>
      <hr>

      <div class="alist">
         <table>
         </table>
      </div>

      
      
      
   </div>
   
</div>

<script>


//$(".map_wrap").hide();//맵숨기기


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
center : new kakao.maps.LatLng(36.41960, 127.84205), // 지도의 중심좌표
level : 13,      // 지도의 확대 레벨

disableDoubleClickZoom: true  //지도더블클릭확대 막기

};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();



// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
//map.setDraggable(false);      

// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
map.setZoomable(false);



<%
String sr=null;
for (int i = 0; i < list.size(); i++) {
dto = list.get(i);
sr = dto.getAddr();
%>
geocoder.addressSearch('<%=sr%>', function(result, status) {

 // 정상적으로 검색이 완료됐으면 
  if (status === kakao.maps.services.Status.OK) {

     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

     // 결과값으로 받은 위치를 마커로 표시합니다
     var marker = new kakao.maps.Marker({
         map: map,
         position: coords
     });

     var myimage='<%=dto.getImage()%>';
     var mycontent ='<div style="width:150px;text-align:center;padding:6px 0;">';
        mycontent += '<b><%=dto.getB_name()%></b>';
        mycontent += '<br>';
        mycontent += '<img src="save/<%=dto.getImage()%>" style="width:100%; height:70px">';
        mycontent += '<b><%=dto.getB_hp()%></b>';
        mycontent += '<br>';
        mycontent += '<b><%=dto.getS_hp()%></b>';
        mycontent += '</div>';
     // 인포윈도우로 장소에 대한 설명을 표시합니다
     var infowindow = new kakao.maps.InfoWindow({
         content: mycontent
     });
     //infowindow.open(map, marker);

     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    // map.setCenter(coords);
     
     kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
     kakao.maps.event.addListener(marker, 'click', function () {       
           //map.setLevel(4, {anchor: this.getPosition()});
             document.getElementById('maplevel');//맵 레벨 읽어오기
           //alert(map.getLevel());
           var ml=map.getLevel();//선언 안하면 데이터 타입 알수없어 if문 작동안함
           if(ml=='4'){
               var myid = '<%=dto.getB_id()%>';
                    //alert("if문 성공");
                 //location.href='index.jsp?main =board/supage.jsp';

              location.href= '<%=root%>/subPage.jsp?id='+myid;

              
          }
           
           map.setLevel(4);
           
         map.panTo(this.getPosition()); 
      });
 } 
});

<%}%>


function setback() {
     $("#map").empty();//맵 정보 날리기
    //$("#map_wrap").html('<div id="map"></div>');
    
  //맵 정보 다시 적용 
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
 center : new kakao.maps.LatLng(36.41960, 127.84205), // 지도의 중심좌표
 level : 13,      // 지도의 확대 레벨

 disableDoubleClickZoom: true  //지도더블클릭확대 막기
 
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();


    
 // var moveLatLon = new kakao.maps.LatLng(36.41960, 127.84205);
 // map.setLevel(13);
  

  //map.panTo(moveLatLon);
}

/* function setmap(){
    $(".map_wrap").toggle();
    $(".box").hide();
 } */
function setgido() {
  var moveLatLon = new kakao.maps.LatLng(36.41960, 127.84205);
  map.setLevel(4);

  map.panTo(moveLatLon);
}

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
  return function() {
     infowindow.open(map, marker);
  };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
  return function() {
     infowindow.close();
  };
}
function qwer(){    
    $("#map").empty();//맵 정보 날리기
    //$("#map_wrap").html('<div id="map"></div>');
    
 //맵 정보 다시 적용 
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
center : new kakao.maps.LatLng(36.41960, 127.84205), // 지도의 중심좌표
level : 13,      // 지도의 확대 레벨

disableDoubleClickZoom: true  //지도더블클릭확대 막기

};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();



// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
//map.setDraggable(false);      

// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
map.setZoomable(false);
  
     $.ajax({
        type:"post",
        url:"main/seachproc.jsp",
        dataType:"json",
        data:{"myname":$("#keyword").val()},
         success:function(res){
        	

          
            var s = "";
           $.each(res,function(idx,item){

        	   var cilckgy = "location.href='subPage.jsp?id="+item.b_id+"'";
        	   s+="<table style='width:25vh; cursor:pointer;' onclick="+cilckgy+">";
               s+="<tr style=' border: 2px solid black;'><td style='font-size: 2vh;'>"+item.b_name+"<br>"+item.addr+"<br>s_HP:"+item.s_hp;
               s+="</td>";
               s+="</tr>";
               s+="</table>";
                  //주소로 마커찍기
                  geocoder.addressSearch("'"+item.addr+"'", function(result, status) {
                     
                      // 정상적으로 검색이 완료됐으면 
                       if (status === kakao.maps.services.Status.OK) {
                    	   
                    	   

                          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                          // 결과값으로 받은 위치를 마커로 표시합니다
                          marker = new kakao.maps.Marker({
                              map: map,
                              position: coords
                          });

                          var myimage=item.image;
                          var mycontent ='<div style="width:150px;text-align:center;padding:6px 0;">';
                             mycontent += '<b>'+item.b_name+'</b>';
                             mycontent += '<br>';
                             mycontent += '<img src="save/'+myimage+'" style="width:100%; height:70px">';
                             mycontent += '<b>'+item.b_hp+'</b>';
                             mycontent += '<br>';
                             mycontent += '<b>'+item.s_hp+'</b>';
                             mycontent += '</div>';
                          // 인포윈도우로 장소에 대한 설명을 표시합니다
                          var infowindow = new kakao.maps.InfoWindow({
                              content: mycontent
                          });
                          //infowindow.open(map, marker);

                          // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                         // map.setCenter(coords);
                          
                          kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                          //kakao.maps.event.addListener($("#"), 'mouseover', makeOverListener(map, marker, infowindow));
                          kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                          kakao.maps.event.addListener(marker, 'click', function () {
                             //map.setLevel(4, {anchor: this.getPosition()});
                               document.getElementById('maplevel');//맵 레벨 읽어오기
                             //alert(map.getLevel());
                             var ml=map.getLevel();//선언 안하면 데이터 타입 알수없어 if문 작동안함
                             if(ml=='4'){
                                 var myid = item.b_id;
                                       
                                 location.href = '<%=root%>/subPage.jsp?id=' + myid;
               					
                               }
                             map.setLevel(4);

                             map.panTo(this.getPosition());
                  
                        });
                          var moveLatLon = new kakao.maps.LatLng(36.41960, 127.84205);
                          map.setLevel(13);

                          map.panTo(moveLatLon);
                  
                       }
                  });
                  
                  $("div.alist").html(s);
           });
         
     }
   });
}
   </script>
</body>
</html>