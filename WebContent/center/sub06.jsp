<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3a07ba5db08482d0228bcb3e748368df"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<link map/https://map.kakao.com/link/map/우리회사,37.402056,127.108212>
<script>


</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/center/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<img src="../images/center/left_title.gif" alt="센터소개 Center Introduction" class="left_title" />
				<%@ include file="../include/center_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/center/sub07_title.gif" alt="오시는길" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;센터소개&nbsp;>&nbsp;오시는길<p>
				</div>
				<div class="con_box">
					<p class="con_tit"><img src="../images/center/sub07_tit01.gif" alt="오시는길" /></p>
					<div id="map" style="width:600px;height:400px;"></div>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = { 
						        center: new kakao.maps.LatLng(37.59894880509089, 126.7705718426906), // 지도의 중심좌표
						        level: 3 // 지도의 확대 레벨
						    };
						
						var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
						// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
						var mapTypeControl = new kakao.maps.MapTypeControl();
						
						// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
						// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
						map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
						
						// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
						var zoomControl = new kakao.maps.ZoomControl();
						map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
						var markerPosition  = new kakao.maps.LatLng(37.59894880509089, 126.7705718426906); 

						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});

						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);

						var iwContent = '<div style="padding:5px;">고촌집 <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다

						// 인포윈도우를 생성합니다
						var infowindow = new kakao.maps.InfoWindow({
						    position : iwPosition, 
						    content : iwContent 
						});
						  
						// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
						infowindow.open(map, marker); 
						</script>
					<!-- <img src="../images/center/sub07_img01.gif" class="con_img"/> -->
					<p class="con_tit"><img src="../images/center/sub07_tit02.gif" alt="자가용 오시는길" /></p>
					<div class="in_box">
						<p class="dot_tit">강북 방향</p>
						<p style="margin-bottom:15px;">강변북로 진입 후 월드컵 경기장 방면으로 우측방향 → 난지도길 가양대교 방향으로 좌회전 → 상암동길 상암초교 방면으로 우회전 </p>
						<p class="dot_tit">일산 방향</p>
						<p style="margin-bottom:15px;">강변북로 수색/가양대교 방향으로 우측방향, 강변북로 수색역/월드컵경기장 방면으로 좌측방향 → 월드컵 경기장 방면으로 우측방향 → 상암동길 상암초교 방면으로 좌회전  </p>
					</div>
					<p class="con_tit"><img src="../images/center/sub07_tit03.gif" alt="대중교통 이용시" /></p>
					<div class="in_box">
						<p class="dot_tit">버스</p>
						<p style="margin-bottom:15px;">172번, 271번, 470번, 6715번, 7011번, 7013번, 7016번, 7019번, 7715번 월드컵3단지 정문 앞 하차  </p>
						<p class="dot_tit">지하철</p>
						<p style="margin-bottom:15px;">2호선, 6호선 합정역 2번출구에서 271번 환승 후 월드컵파크 3단지 정문 앞 하차<br />6호선 마포구청역 1번출구에서 271번 환승 후 월드컵파크 3단지 정문 앞 하차 </p>
						<p class="dot_tit">마을버스</p>
						<p>마포8번, 마포15번</p>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
