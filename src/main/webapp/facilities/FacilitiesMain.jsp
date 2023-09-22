<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Nanum+Pen+Script&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
</head>

<style>

html,body{min-height:100%; font-family: 'NanumSquare'; margin:0; padding:0; }
div,ul,li,dl,dt,dd,p,h2,h3,h4,a,span,form,input, select { margin:0; padding:0; }
ul,dl,ol { list-style:none; }
img { max-width:100%; border:0; vertical-align:top; -webkit-user-select:none; -moz-user-select:none; -ms-user-select:none; user-select: none; }
body { min-width:1024px; font:normal 14px 'NanumSquare',sans-serif; color:#555;}
table { width:100%; border-collapse:collapse; font:normal 14px 'NanumSquare',sans-serif; color:#333; }
input,select,textarea,button { font:normal 14px 'NanumSquare',sans-serif; color:#555; }

#container { padding-top:101px; position: relative; background-color: white; font-family:'NanumSquare';}
#container h2 { margin-bottom:58px; font-size:5vh; font-weight:700; color:#292c25; text-align:center; align-content: center; color: #66CC66;}

.backgroundImage { background-image: url("image/Facilities.jpg"); background-size: cover; height: 20vh; }
.backgroundImage > h2 { height: 25vh; padding-top: 23px;}

#contents { width:960px; padding:70px 0 100px; margin:0 auto; }

.article { margin-top:35px; }
.article .img { overflow:hidden; max-width: 100%}
.article .img p { width:475px; float:left; position:relative; }
.article .img p:first-child { margin-right:10px; }
.article .img p span { width:104px; position:absolute; left:0; top:0; font-size:13px;
 font-weight:500; line-height:38px; color:#fff; text-align:center; background:rgba(0,0,0,0.4); }
.article dl { margin-top:30px; }
.article dl dt { font-size:20px; font-weight:700; color:#292c25; }
.article dl dd { margin-top:12px; font-size:15px; line-height:150%; color:#666; }
.article dl dd.info { margin-top:12px; font-size:14px; color:#888; }


.left_right > ul > li { padding-top:50px; overflow:hidden; }
.left_right > ul > li:first-child { padding-top:0; }

.left_right > ul > li .txt { width:385px; height:260px; display:table; }
.left_right > ul > li .txt dl { display:table-cell; vertical-align:middle; }
.left_right > ul > li .txt dl dt { font-size:19px; font-weight:700; color:#292c25; }
.left_right > ul > li .txt dl dd { margin-top:12px; font-size:15px; line-height:150%; color:#666; }
.left_right > ul > li .txt dl dd.info { margin-top:5px; font-size:12px; color:#888; }
.left_right > ul > li .txt dl dd.link { margin-top:20px; }
.left_right > ul > li .txt dl dd.link a { display:inline-block; width:100px; border:1px solid #b2b2b2;
 font-size:13px; font-weight:500; line-height:34px; color:#56991f; text-align:center; }
.left_right > ul > li .txt dl dd.link a:hover { color:#fff; background:#56991f; }
.left_right > ul > li .img { width:520px; height: 260px;}
.left_right > ul > li.left .img { float:left; }
.left_right > ul > li.left .txt { float:right; padding-left:50px; }

.left_right > ul > li.right .img { float:right; }
.left_right > ul > li.right .txt { float:left; padding-right:55px; }


a { border:0; text-decoration:none; font:normal 14px 'NanumSquare',sans-serif; color:#333; cursor: pointer;}

/* modal Css */
#mapsLayerBackground { position: absolute; z-index: 1;}
#mapsLayerPoint { position: relative; z-index: 100; }
div.modal{font-family: 'NanumSquare';}
div.modal .show { position: relative; z-index: 1000; }
div.modal-dialog { position: relative; z-index: 2000; }
div.modal-content { position: relative; z-index: 3000; }
div.modal-footer { position: relative; z-index: 9999; }

.flicker{
   -webkit-animation: blink 0.5s ease-in-out infinite alternate; 
   -moz-animation: blink 0.5s ease-in-out infinite alternate;
   animation: blink 0.5s ease-in-out infinite alternate;
}

/* 웹키트 : 애플 브라우저(Mac 등의 ios기반) 에서 사용 */
 @-webkit-keyframes blink{
  0% {opacity: 0;}
  100% {opacity: 1;}
}
/* 모질라 : 파이어폭스 기반에서 사용 */
 @-moz-keyframes blink{
  0% {opacity: 0;}
  100% {opacity: 1;} 
} 
/* 웹페이지 요소 */
 @keyframes blink{
  0% {opacity: 0;}
  100% {opacity: 1;}
} 
/* modal Css */
</style>

<body>
	<div id="container">
		<div class="backgroundImage">
	        <h2>편의시설안내</h2>
	        <p></p>
	    </div>
        <div id="contents">
            <div id="sub_01" class="body">
                <div class="middle">
                    <div class="article">
                        <div class="img">
                            <p class="left"><img src="image/FacilitiesImage/parking_01_01.jpg" /><span class="nts">인천방향(상행)</span></p>
                            <p class="right"><img src="image/FacilitiesImage/parking_01_02.jpg" /><span class="nts">강릉방향(하행)</span></p>
                        </div>
                        <dl>
                            <dt>주차시설&nbsp;&nbsp;l&nbsp;&nbsp;Parking</dt>
                            <dd class="nts">덕평자연휴게소는 넓은 주차공간을 갖추고 있습니다. 인천방향(상행)은 551대, 강릉방향(하행)은 367대로 총 918대의 주차공간을 제공합니다. <br /><b>장시간 주차 시, 장기주차장을 이용해주시기 바랍니다.</b></dd>
                            <dd class="nts info">- 24시간 이상 주차 시, 고속도로 최장거리 이용요금이 부과됩니다. (도로공사에서 부과)</dd>
                        </dl>
                    </div>
                </div>
         		<div class="left_right">
                    <ul>
                        <li class="left">
                            <div class="img">
                                <div class="slider slider_02">
                                    <ul>
                                        <li><img src="image/FacilitiesImage/information_center_01_01.jpg"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>종합안내소&nbsp;&nbsp;l&nbsp;&nbsp;Information Center</dt>
                                    <dd class="nts">상, 하행 모두 이용할 수 있는 안내소. 비즈니스 <br>서비스(FAX, 인터넷, 문자), 하이패스 충전, <br>교통정보 이용안내, 길안내, 전국 관광명소  <br>안내를 받으실 수 있습니다.</dd>
                                    <dd class="link"><a id="linkA3" class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal1">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                        <li class="right">
                            <div class="img">
                                <div class="slider slider_03">
                                    <ul>
                                        <li><img src="image/FacilitiesImage/nursing_room_01_01.jpg"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>수유실&nbsp;&nbsp;l&nbsp;&nbsp;Nursing Room</dt>
                                    <dd class="nts">모던하고 환경친화적인 소재를 사용한 인테리어로 꾸며져 있습니다. <b>(수유공간 2곳, 편의시설 완비)</b></dd>
                                    <dd class="link" id="linkA4"><a class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal2">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                        
                        
                        
                        
                        <li class="left">
                            <div class="img">
                                <div class="slider slider_04">
                                    <ul>
                                        <li><img src="image/FacilitiesImage/drugstore_01_03.jpg"></li>
                                        <li><img src=""></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>약국&nbsp;&nbsp;l&nbsp;&nbsp;DrugStore</dt>
                                    <dd class="nts">휴게소 내부에는 24시간 약국이 있습니다.<br />약국에는 비상상비약이 준비되어 있습니다.</dd>
                                    <dd class="link"><a id="linkA5" class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal3">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                        <li class="right">
                            <div class="img">
                                <div class="slider slider_05">
                                    <ul>
                                        <li><img src="image/FacilitiesImage/store_01_01.jpg"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>편의점&nbsp;&nbsp;l&nbsp;&nbsp;Store</dt>
                                    <dd class="nts">휴게소 내부에는 24시간 편의점이 있습니다.<br /> 스낵류 뿐 아니라, 여행 관련 소품, 즉석 조리 식품, 선물용 음료 등을 구매하실 수 있습니다.</dd>
                                    <dd class="link"><a id="linkA6" class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal4">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                        
                        <li class="left">
                            <div class="img">
                                <div class="slider slider_06">
                                    <ul>
                                       <li><img src="image/FacilitiesImage/Restaurant_Area_01_01.jpg" style="height: 244px; width: 488px;"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>식당가&nbsp;&nbsp;l&nbsp;&nbsp;Restaurant Area</dt>
                                    <dd class="nts">식당가에는 다양한 메뉴가 준비되어 있습니다.<br />식당가에서 다양한 먹거리를 경험해보세요</dd>
                                    <dd class="link"><a id="linkA7" class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal5">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                        <li class="right">
                            <div class="img">
                                <div class="slider slider_07">
                                    <ul>
                                        <li><img src="image/FacilitiesImage/gas_station_01_01.jpg" style="height: 244px; width: 488px;"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>주유소&nbsp;&nbsp;l&nbsp;&nbsp;Gas Station</dt>
                            		<dd class="nts">고객 여러분을 위해 최상의 서비스를 제공하기 위해 노력하고 있습니다.<br />최고 품질의 연료와 친절한 서비스로 언제나 여러분을 기다리고 있습니다.</dd>
                                    <dd class="link"><a id="linkA8" class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal6">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                        
                        <li class="left">
                            <div class="img">
                                <div class="slider slider_06">
                                    <ul>
                                       <li><img src="image/FacilitiesImage/EV_charging_station.jpg" style="height: 244px; width: 488px;"></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="txt">
                                <dl>
                                    <dt>전기차 충전소&nbsp;&nbsp;l&nbsp;&nbsp;EV Charging Station</dt>
                                    <dd class="nts">덕평자연휴게소 주차장에는 총 4대의 전기차 <br>충전소가 있습니다.<br />인천방향(상행)은 1대, 강릉방향(하행)은 3대로 <br>총 4대입니다.</dd>
                                    <dd class="link"><a id="linkA7" class="btn_pop" data-bs-toggle="modal" data-bs-target="#myModal7">위치보기</a></dd>
                                </dl>
                            </div>
                        </li>
                    </ul> 
                </div>
	        </div>
	    </div>
	</div>
	
	
	
	 
	<div class="modal" id="myModal1">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>종합안내소 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div id="maps-point"  style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(-25px, 19px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>	
 	
	<div class="modal" id="myModal2">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>수유실 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div id="maps-point"  style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png"  style="transform: translate(-106px, -16px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>	
	
	<div class="modal" id="myModal3">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>약국 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div id="maps-point"  style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(6.5px, 46px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>
 	
 	<div class="modal" id="myModal4">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>편의점 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div id="maps-point" style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(-98px, 34px) scale(0.15);" class="flicker">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(-16px, -580px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>
 	
 	<div class="modal" id="myModal5">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>식당가 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div class="maps-point" style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(-58px, -7px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>
 	
 	<div class="modal" id="myModal6">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>주유소 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div class="maps-point" style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png"  style="transform: translate(-194px, 4px) scale(0.15);" class="flicker">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(-194px, -400px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>
 	
 	<div class="modal" id="myModal7">
	  	<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" style="text-align: center;"><b>전기차 충전소 위치 보기</b></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body" >
			      <div id="map">
				     	<div id="mapsLayerBackground" style="width: 450px; height: 400px;"><img src="image/FacilitiesImage/restarea_01_02.jpg"></div>	
						<div id="mapsLayerPoint">
							<div class="maps-point" style="height: 400px; width: 450px;">
								<img src="image/FacilitiesImage/Marker.png"  style="transform: translate(-1.5px, -177px) scale(0.15);" class="flicker">
								<img src="image/FacilitiesImage/Marker.png" style="transform: translate(58px, -374px) scale(0.15);" class="flicker">
							</div>
						</div>
		    	  </div>
			  </div>  
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
	  		</div>
		</div>
 	</div>
 	
 	
 	
</body>
</html>