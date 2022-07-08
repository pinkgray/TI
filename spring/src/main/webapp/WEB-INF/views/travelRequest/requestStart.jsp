<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<title>Insert title here</title>
<style>
.input {
	width: 30% px !important;
}

textarea {
	width: 120%;
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

.controls {
	background-color: #fff;
	border-radius: 2px;
	border: 1px solid transparent;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	box-sizing: border-box;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	height: 29px;
	margin-left: 17px;
	margin-top: 10px;
	outline: none;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 400px;
}

.controls:focus {
	border-color: #4d90fe;
}

.title {
	font-weight: bold;
}

#infowindow-content {
	display: none;
}

#map #infowindow-content {
	display: inline;
}

#floating-panel {
	position: absolute;
	top: 10px;
	left: 25%;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
}
#loadTable {
	width:100% !important;
}

.hidden {
	display:none;
}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<form action="myRequestPlan.mr">
	<div class="columns">
		<div class="column">
			<section class="section" id="form">
			<!-- 구글 지도 위경도/지역명/주소 -->
			<textarea id="lat" name="PplaceLat" class="hidden"></textarea>
			<textarea id="lng" name="PplaceLng" class="hidden"></textarea>
			<textarea id="placeName" name="PplaceTitle" class="hidden"></textarea>
			<textarea id="placeAddress" name="PplaceAddress" class="hidden"></textarea>
			<input type="hidden" value="${ reqId }" name="requestId" id="reqId">
			<input type="hidden" value="${ loginUser.memberId }" name="memberId">
			<input type="hidden" value="${ loginUser.userName }" name="userName">
			<input type="hidden" value="${ userName }" id="userName">
				<h1 class="title">일정작성</h1>
				<hr>
				<div class="columns">
					<div class="column">
						<br>
						<div class="field">
							<a class="button is-primary"> Day1 </a> &nbsp;
							<input type="hidden" value="Day1" name="pDay">
							<!-- X버튼 -->
							<span data-balloon="size: 3x" data-balloon-pos="up"
								class="db color-inherit link hover-cyan removeBtn" > <svg
									aria-hidden="true" focusable="false" data-prefix="fas"
									data-icon="times-circle" role="img"
									xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
									class="svg-inline--fa fa-times-circle fa-w-16 fa-3x">
								<path fill="currentColor"
										d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z"
										class=""></path>
								</svg>
							</span>
							<!-- + 버튼 -->
							<span data-balloon="size: 3x" data-balloon-pos="up" class="db color-inherit link hover-indigo plusBtn">
								<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-plus-circle fa-w-16 fa-3x">
									<path fill="currentColor" 
										d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm144 276c0 6.6-5.4 12-12 12h-92v92c0 6.6-5.4 12-12 12h-56c-6.6 0-12-5.4-12-12v-92h-92c-6.6 0-12-5.4-12-12v-56c0-6.6 5.4-12 12-12h92v-92c0-6.6 5.4-12 12-12h56c6.6 0 12 5.4 12 12v92h92c6.6 0 12 5.4 12 12v56z" class="">
									</path>
								</svg>
							</span>
							<!-- <input class="input" type="text" placeholder="하루 일정을 입력해주세요(지역 - 지역 - 지역)" > -->
							<br><br>
							<p class="control">
								<textarea class="textarea " placeholder="일정 작성" name="pDayMemo"></textarea>
							</p>
						</div>
						<br>
						<hr>
						<br>
					</div>
					<div class="column map" style="width: 50%;">
						<!-- <div class="field is-grouped">
							<p class="control is-expanded">
								<input class="input" type="text" placeholder="장소 검색">
							</p>
							<p class="control">
								<a class="button is-info"> 검색 </a>
							</p>
						</div> -->
						<div class="card">
							<!-- <div> -->
							<div style="display: none">
								<input id="pac-input" class="controls" type="text"
									placeholder="지역명을 쓰세요">
							</div>
							<figure id="map" class="image is-4by3">
								<!-- <img src="https://source.unsplash.com/random/800x600"
										alt="Image"> -->
							</figure>
							<div id="infowindow-content">
								<span id="place-name" class="title"></span><br> <strong>Place
									ID:</strong> <span id="place-id"></span><br> <span
									id="place-address"></span>
							</div>

							<hr>
							<!-- </div> -->
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
										<a class="button is-primary" onclick="removeLine();"> 일정삭제 </a>
									</div>
								</div>
								<div class="content">
									<div class="card">
										<div class="card-content">
											<div class="content">
												<input class="input" type="text" placeholder="여행 제목 입력" name="planTitle">
												<hr>
												<textarea class="textarea" placeholder="여행 소개" name="planContent"></textarea>
											</div>
										</div>
										<footer class="card-footer">
											<a
												class="card-footer-item" onclick="back();">돌아가기</a> <a
												class="card-footer-item" data-target="#okModal"
												onclick="endSave();">최종 저장</a> <a
												class="card-footer-item"
												onclick="load();">불러오기</a>
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
															<td><textarea name="roomCharge" placeholder="비용을 입력하세요"></textarea></td>
															<td><textarea name="trafficCharge" placeholder="비용을 입력하세요"></textarea></td>
															<td><textarea name="etcCharge" placeholder="비용을 입력하세요"></textarea></td>
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

	<!-- 최종설계 모달 -->
	<div class="modal" id="okModal">
		<div class="modal-background"></div>
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">하이라이트 일정</p>
			</header>
			<section class="modal-card-body">
				<p id="choose"></p>
				<section class="section choose" id="table">
					<table class="table">
						<tbody id="chooseBody">
						</tbody>
					</table>
				</section>
			</section>
			<footer class="modal-card-foot">
				<button type="submit" class="button is-primary">확인</button>
				<button` class="button"onclick="cancel();">취소</button>
			</footer>
		</div>
	</div>
	</form>

	<!-- 불러오기 모달 -->
	<div class="modal" id="loadModal">
		<div class="modal-background"></div>
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">나의 일정</p>
			</header>
			<section class="modal-card-body">
				<section class="section" id="table">
					<table class="table" id="loadTable" align="center">
						<thead>
							<tr>
								<th></th>
								<th>일정번호</th>
								<th>제목</th>
								<th>여행 소개</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</section>
			</section>
			<footer class="modal-card-foot">
				<a class="button is-primary" onclick="return ok();">확인</a> <a
					class="button" onclick="cancel();">취소</a>
			</footer>
		</div>
	</div>
	<script>
	
	var count = 1;
	
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
		//+버튼
		
		$(".plusBtn").click(function(){
			count++;
			console.log(count);
			for(var i = 0; i < markers.length; i++) {
				console.log(markers[i].position.lat());
			}
			$(this).parent().append('<div class="field"><a class="button is-primary"> Day <p class="day">' + count +' </p> </a> &nbsp; <input type="hidden" value="Day' + count + '" name="pDay"><span data-balloon="size: 3x" data-balloon-pos="up" class="db color-inherit link hover-cyan"> <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-times-circle fa-w-16 fa-3x"> <path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z" class=""></path> </svg> </span><p class="control"><textarea class="textarea " placeholder="일정 작성" name="pDayMemo"></textarea></p></div>');
		});
	});
	
	//최종 저장
	function endSave(){
		var choose = Math.floor(count/3);
		console.log(choose);
		console.log(count);
		if(choose < 1) {
			$("#choose").append("1박 2일 일정은 하이라이트 일정 선택이 불가합니다.");
			$("#chooseBody").append("<tr id='chooseTr'>");
			for(var i = 1; i <= count; i++) {
				$("#chooseTr").append("<td><input type='checkbox' class='open' checked value='Y'>Day" + i + "<input type='hidden' name='openStatus' value='Y'></td>");
			}
			$("#chooseBody").append("</td>");
			$('#okModal').toggleClass('is-active');
		} else {
			$("#choose").append(choose + "개의 일정을 선택하세요");
			$("#chooseBody").append("<tr id='chooseTr'>");
			for(var i = 1; i <= count; i++) {
				$("#chooseTr").append("<td><input type='checkbox' class='open' onclick='choose();'>Day" + i + "<input type='hidden' name='openStatus' value='N'></td>");
			}
			$("#chooseBody").append("</td>");
			$('#okModal').toggleClass('is-active');
		}
	}
	
	//불러오기
	function load() {
		var memberId = ${ loginUser.memberId }
		console.log(memberId);
		$.ajax({
			url:"loadRequestPlanList.mr",
			data:{memberId:memberId},
			success:function(data) {
				console.log(data);
				$("#loadTable > tbody >tr").remove();
				
				for(var key in data) {
					var $tr = $("<tr class='load'>");
					var $check = $("<td><input type='checkbox' class='ok'></td>")
					var $planId = $("<td>").text(data[key].planId);
					var $planTitle = $("<td>").text(data[key].planTitle);
					var $planContent = $("<td>").text(data[key].planContent);
					var $enrollDate = $("<td>").text(data[key].enrollDate);
					
					$tr.append($check);
					$tr.append($planId);
					$tr.append($planTitle);
					$tr.append($planContent);
					$tr.append($enrollDate);
					
					$("#loadTable").append($tr);
				}
					$('#loadModal').toggleClass('is-active');
			},
			error:function() {
				alert("실패");
			}
		});
		
	}
	function choose() {
		console.log($(".open"));
		$(".open").each(function() {
			if($(this).is(":checked")) {
				$(this).next().val("Y");
				console.log($(this).next().val("Y"));
			} else {
				$(this).next().val("N");
				console.log($(this).next().val("N"));
			}		
		});
	}

	function back() {
		var reqId = $("#reqId").val();
		var userName = $("#userName").val();
		location = "requestDetail.tr?reqId=" + reqId + "&userName=" + userName;
	}
	
	function myRequestPlan() {
		location = "myRequestPlan.mr"
	}
	
	//불러올 일정 선택
	function ok() {
		var reqId = ${ reqId };
		console.log(reqId);
		var planId = new Array();
		$(".load").each(function() {
			if($(this).find(".ok").is(":checked")) {	
				console.log($(this).find("td").eq(1).text());
				planId.push($(this).find("td").eq(1).text());
			}
		});
		if(planId.length > 1) {
			alert("한개만 선택하세요");
			return false;
		}
		console.log(planId);
		location = "loadRequetPlan.mr?reqId=" + reqId + "&planId=" + planId;
	}
	
	//불러오기 취소
	function cancel() {
		location = location;
	}
	
	//구글 맵
    var ploy;
    var map;
    var markers = new Array();
      
   
	function initMap() {
	 /* var myLatlng = new google.maps.LatLng(-33.8688, 151.2195);
    	var myOptions = {
		zoom: 13,
    	center: myLatlng
		} */
    	map = new google.maps.Map(document.getElementById('map'), {
    	  	zoom: 13,
    	  	center : {lat : -33.93979965825738, lng : 151.1751365661621},
    	});
    	/* map = new google.maps.Map(document.getElementById('map'), myOptions); */
     	 	
    	//폴리라인 객체
    	poly = new google.maps.Polyline({
    	  	strokeColor: "#FF0000",
    	  	strokeWeight : 3
    	});
    	poly.setMap(map);
    	
    	//맵 클릭시 마커,폴리라인 생성
    	map.addListener('click', function(event) {
    		var path = poly.getPath();

	        // Because path is an MVCArray, we can simply append a new coordinate
	        // and it will automatically appear.
	        path.push(event.latLng);

	        // Add a new marker at the new plotted point on the polyline.
	        
	        marker = new google.maps.Marker({
	          position: event.latLng,
	          title: '#' + path.getLength(),
	          map: map
	        });
	        markers.push(marker);
	        
	        console.log(marker);
	        console.log("위도 : " + marker.position.lat());
	        console.log("경도 : " + marker.position.lng());
	        console.log("마커 순서 : " + marker.title);
	        console.log("마커 갯수 : " + markers.length);
	        $("#lat").append(marker.position.lat() + "#");
	        $("#lng").append(marker.position.lng() + "#");

	        
	        var request = {
	                placeId: event.placeId,
	                fields: ['name', 'formatted_address', 'geometry']
	        };
	        
	        var infowindow = new google.maps.InfoWindow();
	        var service = new google.maps.places.PlacesService(map);
	        
	        service.getDetails(request, function(place, status) {
	            if (status === google.maps.places.PlacesServiceStatus.OK) {
	              var marker = new google.maps.Marker({
	                map: map,
	                position: place.geometry.location
	              });
	              google.maps.event.addListener(marker, 'click', function() {
	                infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
	                  place.formatted_address + '</div>');
	                infowindow.open(map, this);
	              });
	              console.log("지역명 : " + place.name);
	              $("#placeName").append(place.name + "#");
	              console.log("주소명 : " + place.formatted_address);
	              $("#placeAddress").append(place.formatted_address + "#");
	              google.maps.event.addListener(marker, 'rightclick', function() {
	            	  clearMarkers();
	              });
	            }
	        console.log(event);
	      });
    	});
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

          marker = new google.maps.Marker({map: map});
			
          marker.addListener('click', function() {
            infowindow.open(map, marker);
          });

          autocomplete.addListener('place_changed', function() {
            infowindow.close();

            var place = autocomplete.getPlace();

            if (!place.geometry) {
              return;
            }

            if (place.geometry.viewport) {
              map.fitBounds(place.geometry.viewport);
            } else {
              map.setCenter(place.geometry.location);
              map.setZoom(17);
            }

            // Set the position of the marker using the place ID and location.
            marker.setPlace({
              placeId: place.place_id,
              location: place.geometry.location
            });
            console.log(place);
            console.log(place.formatted_address);
            

            marker.setVisible(false);

            infowindowContent.children['place-name'].textContent = place.name;
            infowindowContent.children['place-id'].textContent = place.place_id;
            infowindowContent.children['place-address'].textContent =
                place.formatted_address;
            infowindow.open(map, marker);
          });
        }
	function clearMarkers() {
        setMapOnAll(null);
        console.log(markers);
      }
	function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
      }


	$(document).on("click",".hover-cyan",function(){
		console.log($(this).parent());
		console.log($(".day").text());
		console.log($(this).parent().text().split(" ")[2]);
		var num = $(".day").text();
		console.log(num);
		var numArr= $(".day").text().split(" ");
		console.log(numArr);
		console.log(count);
		$(this).parent().remove();
		
		count = 2;
		$(".day").each(function() {
			$(this).text(count);
			count++;
		});
		count--;
	});
</script>
	<!-- <script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBHA8SfsYSWfcmA-kb6Y1Gf4ucjOrvfXZI&callback=initMap&libraries=places"
		async defer></script> -->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBHA8SfsYSWfcmA-kb6Y1Gf4ucjOrvfXZI&libraries=places&callback=initMap"
		async defer></script>
</body>
</html>