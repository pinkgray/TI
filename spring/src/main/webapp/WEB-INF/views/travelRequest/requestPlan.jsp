<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
.input {
	width: 30% px !important;
}

textarea {
	width: 100%;
	resize: none !important;
	border: none;
	text-align: center;
}

.introduce {
	height: 100px !important;
}

.hover-indigo {
	margin-left: 65%;
}

.db {
	cursor: pointer;
}

#okModal td {
	border: 1px solid black !important;
}

th, td {
	text-align: center !important;
}

.more {
	margin-left: auto;
	margin-right: auto;
}

.modal-card {
	width: 400px !important;
	height: 800px !important;
}
.card-image {
	background: lightgray;
}
.hidden {
	display:none;
}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<div class="columns">
		<div class="column">
		<textarea id="lat" name="PplaceLat" class="hidden"></textarea>
		<textarea id="lng" name="PplaceLng" class="hidden"></textarea>
		<textarea id="placeName" name="PplaceTitle" class="hidden"></textarea>
		<textarea id="placeAddress" name="PplaceAddress" class="hidden"></textarea>
		<%-- <input type="hidden" value="${ code }" id="code">
		<input type="hidden" value="${ uPoint }" id="uPoint">
		<input type="hidden" value="${ useType }" id="useType">
		<input type="hidden" value="${ reqId }" id="reqId">
		<input type="hidden" value="${ userName }" id="userName">
		<input type="hidden" value="${ loginUser.memberId }" id="memberId"> --%>
			<section class="section" id="form">
				<h1 class="title">일정</h1>
				<hr>
				<div class="columns">
					<div class="column">
						<br>
						<div class="field">
						<c:forEach var="day" items="${ trp.get(0).dayList }" varStatus="number">
							<a class="button is-primary">Day${ number.count }</a>
							<p class="control">
								<textarea class="textarea" readonly>${ day.getpDayMemo() }</textarea>
							</p>
						</c:forEach>
						</div>
						<br>
						<hr>
						<br>
						<c:if test="${ trp.get(0).getChooseStatus() == 'N'}">
							<div class="buttons">
								<a class="button is-primary is-rounded more" onclick="more();">일정 더 보기</a>
							</div>
						</c:if>
					</div>
					<div class="column map" style="width: 50%;">
						<div class="card">
							<div class="card-image">
								<c:if test="${ loginUser.memberId ne 1 }">
									<c:if test="${ trp.get(0).getChooseStatus() == 'N'}">
										<figure id="map" class="image is-4by3">
											<h1 align="center" id="before">채택하셔야 경로가 보여집니다.</h1>
										</figure>
									</c:if>
									<c:if test="${ trp.get(0).getChooseStatus() == 'Y'}">
										<figure id="map" class="image is-4by3">
										</figure>
									</c:if>
								</c:if>
								<c:if test="${ loginUser.memberId eq 1 }">
									<figure id="map" class="image is-4by3">
									</figure>
								</c:if>
							</div>
							<div class="card-content">
								<div class="media">
									<div class="media-left">
										<!-- <figure class="image" style="height: 40px; width: 40px;">
											<img src="https://source.unsplash.com/random/96x96"
												alt="Image">
										</figure> -->
									</div>
									<div class="media-content">
										<p class="title is-4">지역명</p>
									</div>
								</div>
								<div class="content">
									<div class="card">
										<div class="card-content">
											<div class="content">
												<textarea class="textarea" type="text"
													style="height: 50px; min-height: 50px;" readonly>${ trp.get(0).getPlanTitle() }</textarea>
												<hr>
												<textarea class="textarea" readonly>${ trp.get(0).getPlanContent() }</textarea>
											</div>
										</div>
										<footer class="card-footer">
											<c:if test="${ loginUser.memberId ne 1 }">
												<a class="card-footer-item" onclick="back();">돌아가기</a> <a
													class="card-footer-item" onclick="return ok();">채택하기</a> <a
													class="card-footer-item"
													onclick="$('#reportModal').toggleClass('is-active')">신고하기</a>
											</c:if>
											<c:if test="${ loginUser.memberId eq 1 }">
												<a class="card-footer-item" onclick="adminBack();">돌아가기</a>
											</c:if>
										</footer>
									</div>
								</div>
							</div>
						</div>
						<section class="section" id="box">
							<h1 class="title">가계부</h1>
							<hr>
							<div class="box">
								<article class="media">
									<div class="media-content">
										<div class="content">
											<section class="section" id="table">
												<table class="table">
													<thead>
														<tr>
															<th>숙박</th>
															<th>경비</th>
															<th>기타</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><textarea readonly><fmt:formatNumber value="${ trp.get(0).getRoomCharge() }" groupingUsed="true"/>원</textarea></td>
															<td><textarea readonly><fmt:formatNumber value="${ trp.get(0).getTrafficCharge() }" groupingUsed="true"/>원</textarea></td>
															<td><textarea readonly><fmt:formatNumber value="${ trp.get(0).getEtcCharge() }" groupingUsed="true"/>원</textarea></td>					
													</tbody>
												</table>
											</section>
										</div>
									</div>
								</article>
							</div>
						</section>
					</div>
				</div>
			</section>
		</div>
	</div>
	<!-- 설계자 신고하기 -->
	<form action="insertPanelty.pe" method="post" enctype="multipart/form-data">
	<div class="modal" id="reportModal">
		<div class="modal-background"></div>
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">신고하기</p>
			</header>
			<section class="modal-card-body">
			<input type="hidden" value="${ loginUser.memberId }" name="complainantId">
				<div class="column">
					<h1>신고 종류</h1>
					<hr>
					<div class="field">
						<p class="control">
							<span class="select"> <select name="penaltyId">
									<option value="11">부적절 게시물</option>
									<option value="12">욕설 및 비방</option>
									<option value="13">저작권 침해 및 명의 도용</option>
									<option value="30">기타</option>
							</select>
							</span>
						</p>
					</div>
				</div>
				<section class="section" id="box">
					<h1>신고사유</h1>
					<textarea name="list" readonly>설계글</textarea>
					<textarea id="panelty" name="listType" readonly>${ trp.get(0).planId }</textarea>
					<hr>
					<div class="box">
						<article class="media">
							<div class="media-content">
								<div class="content">
									<textarea placeholder="신고사유를 입력하세요" rows="5" name="penaltyContent"></textarea>
								</div>
							</div>
						</article>
					</div>
					<h1>첨부파일</h1>
					<hr>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
				</section>
			</section>
			<footer class="modal-card-foot">
				<button type="submit" class="button is-primary">신고</a>
				<button class="button" onclick="cancel();">취소</a>
			</footer>
		</div>
	</div>
	</form>
</body>
<script>
	$(function() {
		
		
		$('.modal-background, .modal-close').click(function() {
	   		$('html').removeClass('is-clipped');
	    	$(this).parent().removeClass('is-active');
	  	});
	  	$('.theme-switcher').change(function(e) {
	    	if (e.target.value) {
		      window.location.href = '/bulmaswatch/' + e.target.value;
		    }
		  });
	
		  // Get all "navbar-burger" elements
		  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
	
		  // Check if there are any nav burgers
		  if ($navbarBurgers.length > 0) {
	
		    // Add a click event on each of them
		    $navbarBurgers.forEach(function ($el) {
		      $el.addEventListener('click', () => {
	
		        // Get the target from the "data-target" attribute
		        var target = $el.dataset.target;
		        var $target = document.getElementById(target);
	
		        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
		        $el.classList.toggle('is-active');
		        $target.classList.toggle('is-active');
		      });
		   });
		}
	});
	
	//일반유저 뒤로가기
	function back() {
		var reqId= $("#reqId").val();
		var userName = $("#userName").val();
		location = "requestDetail.tr?reqId=" + reqId + "&userName=" + userName;
	}
	
	//관리자 뒤로가기
	function adminBack() {
		location = "planTotalList.ad";
	}
	function more() {
		<c:if test="${ loginUser.memberId ne 1 }">
			<c:if test="${ trp.get(0).getChooseStatus() == 'N'}">
				alert("채택해야 상세보기가 가능합니다.");
			</c:if>
		</c:if>
	}
	function ok() {
		<c:if test="${ loginUser.userPoint < trp.get(0).reqList.get(0).requestPrice }">
			alert("내 포인트 : " + '${ loginUser.userPoint }원' + 
				  "\n의뢰가격 : " + '${ trp.get(0).reqList.get(0).requestPrice }원' + 
				  "\n보유 포인트가 부족합니다.");
			return false;
		</c:if>
		<c:if test="${ trp.get(0).getChooseStatus() == 'N' }">
		var result = confirm("정말로 채택하시겠습니까?");
		console.log(result);
		if(result == true) {
			var memberId = "${ loginUser.memberId }";
			var code = "${ trp.get(0).reqList.get(0).requestId }";
			var planId = "${ trp.get(0).planId }";
			var useType = 20;
			var uPoint = "${ trp.get(0).reqList.get(0).requestPrice }";
			console.log("의뢰자 번호 : " + memberId);
			console.log("의뢰번호 : " + code);
			console.log("설계번호 : " + planId);
			console.log("사용 타입 : " + useType);
			console.log("의뢰 가격 : " + uPoint)
			
			//memberId : 유저번호(로그인유저), planId : 설계번호, code : 의뢰번호, useType : 20 uPoint : 의뢰 가격
			location = "updateRequest.mr?memberId=" + memberId + "&planId=" + planId + "&code=" + code + "&useType=" + useType + "&uPoint=" + uPoint;
		} else {
			location = location;
		}
		</c:if>
		<c:if test="${ trp.get(0).getChooseStatus() == 'Y' }">
			alert("이미 채택하셨습니다.");
		</c:if>
	}
	function cancel() {
		location = location;
	}
	function report() {
		location = "paneltyList.pe";
	}
	
	//구글 맵
    var ploy;	//폴리라인
    var map;	//맵
    var markers = new Array();	//마커들
    var pTitle = new Array();	//일정 장소명들
    var pAddress = new Array();	//각 장소명의 주소
    var pLat = new Array();		//각 장소의 위도
    var pLng = new Array();		//각 장소의 경도
    
    
    /* <c:forEach var="place" items="${ trp.get(0).dayList }" varStatus="st">
		<c:if test="${ st.last }">
		<!-- get(0).getPplaceTitle() -->
			pTitle.push("${ place.getPlaceList().get(0).getPplaceTitle() }");
			pAddress.push("${ place.getPlaceList().get(0).getPplaceAddress() }");
			pLat.push("${ place.getPlaceList().get(0).getPplaceLat() }");
			pLng.push("${ place.getPlaceList().get(0).getPplaceLng() }");
		</c:if>
	</c:forEach> */
	
	<c:if test="${ trp.get(0).getChooseStatus() == 'Y'}">
		<c:forEach var="place" items="${ trp.get(0).dayList }" varStatus="st">
		<c:if test="${ st.last }">
			<c:forEach var="count" begin="0" end="${ st.index }" step="1">
				pTitle.push("${ place.getPlaceList().get(count).getPplaceTitle() }");
				pAddress.push("${ place.getPlaceList().get(count).getPplaceAddress() }");
				pLat.push("${ place.getPlaceList().get(count).getPplaceLat() }");
				pLng.push("${ place.getPlaceList().get(count).getPplaceLng() }");
			</c:forEach>
		</c:if>
		</c:forEach>
	</c:if>
    /* <c:forEach var="latList" items="${ trp }" varStatus="st">
    if("${ latList.getDayList().get(0).getPlaceList().get(0).getPplaceTitle() }" != "") {
    	pTitle.push("${ latList.getDayList().get(0).getPlaceList().get(0).getPplaceTitle() }");
    	pAddress.push("${ latList.getDayList().get(0).getPlaceList().get(0).getPplaceAddress() }");
    	pLat.push("${ latList.getDayList().get(0).getPlaceList().get(0).getPplaceLat() }");
    	pLng.push("${ latList.getDayList().get(0).getPlaceList().get(0).getPplaceLng() }");
    }
    </c:forEach> */
    /* ${ day.dayList.get(0).placeList.get(0).getPplaceTitle() } */
    console.log("장소명 : " + pTitle);
    console.log("일정들 장소 수 : " + pTitle.length);
    console.log("각 장소 주소 : " + pAddress);
    console.log("각 장소 위도 : " + pLat);
    console.log("각 장소 경도 : " + pLng);
    console.log(pLat[0]);
    console.log(pLng[0]);
    
    <c:if test="${ loginUser.memberId ne 1 }">
		<c:if test="${ trp.get(0).getChooseStatus() == 'Y' }">
	    function initMap() {
			var first = new google.maps.LatLng(pLat[0], pLng[0]);
			var destinations = new Array();
			var contentString = pTitle[0];
			var content = new Array();
	    	map = new google.maps.Map(document.getElementById('map'), {
	    	  	zoom: 13,
	    	  	center : first
	    	});
	    	
	    	for(var i = 0; i < pTitle.length; i++) {
	    		if(i == 0) {
	    			marker = new google.maps.Marker({
	    	    	    position: new google.maps.LatLng(pLat[0], pLng[0]),
	    	    	    map: map
	    	    	});
	    			$("#lat").append(marker.position.lat() + "#");
	    		    $("#lng").append(marker.position.lng() + "#");
	    			destinations.push(new google.maps.LatLng(pLat[0], pLng[0]));
	    		} else {
		    		var marker = new google.maps.Marker({
		        	    position: new google.maps.LatLng(pLat[i], pLng[i]),
		        	    map: map
		        	});
		    		$("#lat").append(marker.position.lat() + "#");
	    		    $("#lng").append(marker.position.lng() + "#");
		    		destinations.push(new google.maps.LatLng(pLat[i], pLng[i]));
	    		}
	    		
	    		markers.push(marker);
	    	}
	    	console.log(markers);
	    	$.each(markers, function(index, item) {
		    	google.maps.event.addListener(markers[index], 'click', function() {
		            infowindow.setContent('<div><strong>' + pTitle[index] + '</strong><br>' +
		            pAddress[index] + '</div>');
		            infowindow.open(map, this);
		        });
		    	$("#placeName").append(pTitle[index] + "#");
		    	$("#placeAddress").append(pAddress[index] + "#");
	    	});
	    	
	    	/* map = new google.maps.Map(document.getElementById('map'), myOptions); */
	    	//폴리라인 객체
	    	poly = new google.maps.Polyline({
	    		path: destinations,
	    	  	strokeColor: "#FF0000",
	    	  	strokeWeight : 3
	    	});
	    	poly.setMap(map);
	
	    	//지역 검색
	        var input = document.getElementById('pac-input');
	
	        var autocomplete = new google.maps.places.Autocomplete(input);
	        autocomplete.bindTo('bounds', map);
	
	        // Specify just the place data fields that you need.
	        autocomplete.setFields(['place_id', 'geometry', 'name']);
	
	        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	
	        var infowindow = new google.maps.InfoWindow();
	        var infowindowContent = document.getElementById('infowindow-content');
	        infowindow.setContent(infowindowContent);
	    }
    	</c:if>
    </c:if>
    
    <c:if test="${ loginUser.memberId eq 1 }">
    function initMap() {
		var first = new google.maps.LatLng(pLat[0], pLng[0]);
		var destinations = new Array();
		var contentString = pTitle[0];
		var content = new Array();
    	map = new google.maps.Map(document.getElementById('map'), {
    	  	zoom: 13,
    	  	center : first
    	});
    	
    	for(var i = 0; i < pTitle.length; i++) {
    		if(i == 0) {
    			marker = new google.maps.Marker({
    	    	    position: new google.maps.LatLng(pLat[0], pLng[0]),
    	    	    map: map
    	    	});
    			$("#lat").append(marker.position.lat() + "#");
    		    $("#lng").append(marker.position.lng() + "#");
    			destinations.push(new google.maps.LatLng(pLat[0], pLng[0]));
    		} else {
	    		var marker = new google.maps.Marker({
	        	    position: new google.maps.LatLng(pLat[i], pLng[i]),
	        	    map: map
	        	});
	    		$("#lat").append(marker.position.lat() + "#");
    		    $("#lng").append(marker.position.lng() + "#");
	    		destinations.push(new google.maps.LatLng(pLat[i], pLng[i]));
    		}
    		
    		markers.push(marker);
    	}
    	console.log(markers);
    	$.each(markers, function(index, item) {
	    	google.maps.event.addListener(markers[index], 'click', function() {
	            infowindow.setContent('<div><strong>' + pTitle[index] + '</strong><br>' +
	            pAddress[index] + '</div>');
	            infowindow.open(map, this);
	        });
	    	$("#placeName").append(pTitle[index] + "#");
	    	$("#placeAddress").append(pAddress[index] + "#");
    	});
    	
    	/* map = new google.maps.Map(document.getElementById('map'), myOptions); */
    	//폴리라인 객체
    	poly = new google.maps.Polyline({
    		path: destinations,
    	  	strokeColor: "#FF0000",
    	  	strokeWeight : 3
    	});
    	poly.setMap(map);

    	//지역 검색
        var input = document.getElementById('pac-input');

        var autocomplete = new google.maps.places.Autocomplete(input);
        autocomplete.bindTo('bounds', map);

        // Specify just the place data fields that you need.
        autocomplete.setFields(['place_id', 'geometry', 'name']);

        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        var infowindow = new google.maps.InfoWindow();
        var infowindowContent = document.getElementById('infowindow-content');
        infowindow.setContent(infowindowContent);
    }
    </c:if>
    
    
	function cancel() {
		location = location;
	}
	function report() {
		location = "paneltyList.pe";
	}
</script>
<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBHA8SfsYSWfcmA-kb6Y1Gf4ucjOrvfXZI&libraries=places&callback=initMap"
		async defer></script>
</html>