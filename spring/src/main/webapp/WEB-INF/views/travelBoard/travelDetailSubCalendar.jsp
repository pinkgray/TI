<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
   .tabs.is-fullwidth {
      margin-bottom: 0.5em;
   }
   
   #calendar{
      display: inline-block;
      width: 35%;
      height: 400px;
      border: 1px solid black;
      margin-right: 2%;
      overflow: scroll;
      overflow-x:hidden;
      float: left;
   }
   #calendarArea {
      text-align: left;
      width: 100%;
      white-space:nowrap; 
      overflow:auto; 
   }
   .calendarTable {
      width: 100%;
   }
   .calendarTable th {
      text-align: center;
   }
   .calendarTable td {
      text-align: center;
   }
   
   #mapArea{
      display: inline-block;
      width: 62%;
      height: 400px;
      border: 1px solid black;
      overflow: scroll;
      float: right;
      z-index: 3;
      position: relative;
   }
   #mapInfo {
      margin-left: 1px;
  	  float: left;
      z-index: 2;
      position: absolute;
      background: white;
      display: inline-block;
      left: 0px;
      overflow-y: scroll;
      width: 250px;
      height: 385px;
      overflow-x: hidden;
   }
   #map {
      width:100%;
      height: 100%;
      z-index: 1;
      position: absolute;
      border: 1px solid black;
   }
   #mapDaySelect {
      float: left;
      margin: 0.87em;
      z-index: 2;
      position: absolute;
      padding: 0.7em;
      left: 250px;
      width: 250px;
   }
   .placeShow:hover {
		margin-left: 0.5em;
	}
</style>
<body>
   <!-- 결제여부에 따른 출력될 일수 설정하기 -->
   <fmt:parseDate var="startDate" value="${ detailTb.startDate }" pattern="yyyy-MM-dd" />
   <fmt:parseNumber value="${ startDate.time / (1000*60*60*24) }" integerOnly="true" var="startDay" />
   <fmt:parseDate var="endDate" value="${ detailTb.endDate }" pattern="yyyy-MM-dd" />
   <fmt:parseNumber value="${ endDate.time / (1000*60*60*24) }" integerOnly="true" var="endDay" />
   
   <c:choose>
      <c:when test="${ (!empty loginUser && detailTb.buyStatus eq 'Y') || loginUser.memberId eq detailTb.memberId }">
         <fmt:parseNumber var="showDays" integerOnly="true" value="${ endDay - startDay + 1 }"/>
      </c:when>
      <c:otherwise>
         <fmt:parseNumber var="showDays" integerOnly="true" value="${ (endDay - startDay + 1) / 3 }" />
      </c:otherwise>
   </c:choose>
   <fmt:parseNumber var="totalDays" integerOnly="true" value="${ (endDay - startDay + 1) }" />
   
   <input type="number" style="display: none;" id="totalDays" value="${ endDay - startDay + 1 }">
   <input type="number" style="display: none;" id="showDays" value="${ showDays }">

   <!-- 서브메뉴 본문(일정표) -->
   <section class="section" id="detailSub">
      <div id="detailSubContent" align="center">
         <div id="calendar">
               <div class="calendarArea">
                  
                  <c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
                     <!-- 글 하나 -->
                    <div class="tabs is-fullwidth" style="display: none;" id="day${ st.count }">
                    
                       <!-- day 넘기는 화살표 -->
                       <ul>
                          <li>
                             <a onclick="nextDays('${ st.count }', 'left')">
                                    <span id="left" class="icon"><i class="fa fa-angle-left"></i></span>
                                       </a>
                          </li>
                          <li>
                             <span style="font-weight: 1px;"><strong>DAY ${ st.count }</strong></span>
                          </li>
                          <li>
                             <a onclick="nextDays('${ st.count }', 'right')">
                                      <span id="right" class="icon"><i class="fa fa-angle-right"></i></span>
                                   </a>
                          </li>
                       </ul>
                    </div>
                  </c:forEach>
                  
                    <!-- 시간표시 여부 -->
                    <div align="right" style="border-bottom: 1px solid lightgray; padding-bottom: 0.3em;">
                       <input type="checkbox" id="timeCheck">
                     <label for="timeCheck">시간 표시</label>
                  </div>
                  
                  <!-- 상세보기 -->
                  
                  <c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
                  <c:choose>
                  
                     <c:when test="${ st.count <= showDays }">
                        <c:set var="check" value="false" />
                        <c:forEach var="j" begin="0" end="${ totalDays }" step="1">
                        <c:if test="${ st.count == detailDay[j].dayNumber }">
                              <%-- <p>DAY ${ st.count } 결제 안해도 볼 수 있음(정보 있음)</p> --%>
                              <div class="calendarTable" style="padding: 10.5px 0; display: none;" id="calendarTable-day${ st.count }">
                                 <nav class="panel costPanel">
                                    <div class="panel-heading" align="center" style="background: whitesmoke; color: black; height: 30px">
                                       <p class="help">${ detailDay[j].dayDate }</p>
                                    </div>
                                    <div class="panel-heading" align="center" style="margin: 0">
                                       <div class="media-left" style="display: inline-block; width: 70%;">
                                          <c:if test="${ !empty detailDay[j].dayMemo }">
                                             <span style="display: inherit; white-space: pre-line; font-weight: bold; vertical-align: middle">${ detailDay[j].dayMemo }</span>&nbsp;
                                          </c:if>
                                          <c:if test="${ empty detailDay[j].dayMemo }">
                                             <span style="color: gray; display: inherit; white-space: pre-line; vertical-align: middle">(제목없음)</span>&nbsp;
                                          </c:if>
                                        </div>
                                        <div class="media-right" style="display: inline-block; margin-left: 0;">
                                          <!-- 날씨 아이콘 -->
                                          <c:choose>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'SUN' }">
                                                <a class="button is-danger weatherBtn" id="SUN" data-tooltip="맑음" style="vertical-align: middle;">
                                                <i class="fas fa-sun"></i>
                                                </a>
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'CLOUD' }">
                                                <a class="button is-dark  weatherBtn" id="CLOUD" data-tooltip="흐림" style="vertical-align: middle;">
                                                <span class="icon"><i class="fas fa-cloud"></i></span>
                                                </a>
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'RAIN' }">
                                                <a class="button is-info weatherBtn" id="RAIN" data-tooltip="비" style="vertical-align: middle;">
                                                <span class="icon"><i class="fas fa-umbrella"></i></span>
                                                </a>   
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'SNOW' }">
                                                <a class="button is-primary weatherBtn" id="SNOW" data-tooltip="눈" style="vertical-align: middle;">
                                                <span class="icon"><i class="far fa-snowflake"></i></span>
                                                </a>
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'LIGHTNING' }">
                                                <a class="button is-warning weatherBtn" id="LIGHTNING" data-tooltip="번개" style="vertical-align: middle;">
                                                <span class="icon"><i class="fas fa-bolt"></i></span>
                                                </a>
                                             </c:when>
                                          </c:choose>
                                          <!-- 날씨 아이콘 끝 -->
                                       
                                       </div> 
                                    </div>
                                    <ul>
                                       <c:if test="${ fn:length(detailDay[j].trvSchedule) > 0 && detailDay[j].trvSchedule[0].schId ne 0 }">
                                       <c:forEach var="days" items="${ detailDay[j].trvSchedule }" varStatus="st" >
                                          <li class="panel-block">
                                             <div class="ui label" style="background: #209cee;">${ st.count }</div>&nbsp;&nbsp;
                                             <c:if test="${ !empty days.schTitle }">
                                                <strong>${ days.schTitle }</strong>
                                             </c:if>
                                             <c:if test="${ empty days.schTitle }">
                                                <span style="color: gray;">일정 제목 없음</span>
                                             </c:if>
                                          </li>
                                          <li class="panel-block">
                                             <div class="media-left times" style="width: 30%; display: none;">
                                                <c:choose>
                                                   <c:when test="${ days.isTimeset eq 'Y' }">
                                                      <span><i class="far fa-clock"></i>&nbsp; ${ days.startTime } ~
                                                      <br>${ days.endTime }</span>
                                                   </c:when>
                                                   <c:otherwise>
                                                      <span><i class="far fa-clock"></i>&nbsp; 시간정보없음</span>
                                                   </c:otherwise>
                                                </c:choose>
                                             </div>
                                             <div class="media-content" style="width: 70%;">
                                                <div class="content" style="display: inline-block;">
                                                   <c:if test="${ !empty days.plcName }">
                                                      <span style="white-space: pre-line; cursor: pointer;" id="day${ detailDay[j].dayNumber }Place" class="placeShow day${ detailDay[j].dayNumber }Place"><input type="text" value="${ days.plcName }" name="plcName" class = "plcName" style="display: none;"><input type="text" value="${ days.plcId }" name="plcId" class = "plcId" style="display: none;"><strong class="costAmount"><i class="fas fa-map-marker-alt" style="color: #8e44ad;"></i>&nbsp;${ days.plcName }</strong>
                                                         <small class="costCurrency"></small>
                                                      </span>
                                                   </c:if>
                                                   <c:if test="${ empty days.plcName }">
                                                      <span style="white-space: pre-line;">
                                                         <span class="costAmount" style="color: gray;">장소명 없음</span>
                                                         <small class="costCurrency"></small>
                                                      </span>
                                                   </c:if>
                                                   <c:if test="${ !empty days.schTransp }">
                                                      <span><i class="fas fa fa-taxi"></i> ${ days.schTransp }</span>
                                                   </c:if>
                                                   
                                                </div>
                                             </div>
                                          </li>
                                       </c:forEach>
                                       </c:if>
                                       <c:if test="${ detailDay[j].trvSchedule[0].schId eq 0 }">
                                          <li class="panel-block" style="justify-content: center; border: none;">
                                             <p style="color: gray; margin: 2em;">상세정보없음</p>
                                          </li>
                                       </c:if>
                                    </ul>
                                 </nav>
                              </div>
                              
                              <!--  -->
                              <c:set var="check" value="true" />
                        </c:if>
                        </c:forEach>
                        
                     </c:when>
                     
                     <c:otherwise>
                     
                        <c:set var="check" value="false" />
                        <c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
                        <c:if test="${ st.count == detailDay[j].dayNumber && fn:length(detailDay[j].trvSchedule) > 0}">
                              <%-- <p>DAY ${ st.count } 결제 안해도 볼 수 있음(정보 있음)</p> --%>
                              
                              <div class="calendarTable" style="padding: 10.5px 0; display: none;" id="calendarTable-day${ st.count }">
                                 <nav class="panel costPanel">
                                    <div class="panel-heading" align="center"
                                       style="background: whitesmoke; color: black; height: 30px">
                                       <p class="help">${ detailDay[j].dayDate }</p>
                                    </div>
                                    <div class="panel-heading" align="center" style="margin: 0">
                                       <div style="display: table-cell;">
                                          <c:if test="${ !empty detailDay[j].dayMemo }">
                                             <span style="vertical-align: middle; white-space: pre-line;">${ detailDay[j].dayMemo }</span>&nbsp;
                                          </c:if>
                                          <c:if test="${ empty detailDay[j].dayMemo }">
                                             <span style="vertical-align: middle; color: gray; white-space: pre-line;">(제목없음)</span>&nbsp;
                                          </c:if>
                                          <!-- 날씨 아이콘 -->
                                          <c:choose>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'SUN' }">
                                                <a class="button is-danger weatherBtn" id="SUN" data-tooltip="맑음" style="vertical-align: middle;">
                                                <i class="fas fa-sun"></i>
                                                </a>
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'CLOUD' }">
                                                <a class="button is-dark  weatherBtn" id="CLOUD" data-tooltip="흐림" style="vertical-align: middle;">
                                                <span class="icon"><i class="fas fa-cloud"></i></span>
                                                </a>
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'RAIN' }">
                                                <a class="button is-info weatherBtn" id="RAIN" data-tooltip="비" style="vertical-align: middle;">
                                                <span class="icon"><i class="fas fa-umbrella"></i></span>
                                                </a>   
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'SNOW' }">
                                                <a class="button is-primary weatherBtn" id="SNOW" data-tooltip="눈" style="vertical-align: middle;">
                                                <span class="icon"><i class="far fa-snowflake"></i></span>
                                                </a>
                                             </c:when>
                                             <c:when test="${ detailDay[st.count-1].dayWeather eq 'LIGHTNING' }">
                                                <a class="button is-danger is-outlined weatherBtn" id="LIGHTNING" data-tooltip="번개" style="vertical-align: middle;">
                                                <span class="icon"><i class="fas fa-bolt"></i></span>
                                                </a>
                                             </c:when>
                                          </c:choose>
                                          <!-- 날씨 아이콘 끝 -->
                                       
                                       </div> 
                                    </div>
                                    
                                    <ul>
                                    <c:if test="${ fn:length(detailDay[j].trvSchedule) > 0 && detailDay[j].trvSchedule[0].schId ne 0 }">
                                       <li class="panel-block" onclick="buyInfo()" data-tooltip="상세보기를 원하시면 결제가 필요합니다." style="cursor: pointer; justify-content: center; border: none;">
											<p style="color: gray; margin: 2em;"><i class="fas fa-exclamation-circle"></i> 미리보기 종료<br><br>
												해당 날짜의 상세일정 정보는<br>
												해당 일정을 구매하셔야 볼 수 있습니다.
											</p>
                                          </li>
                                       </c:if>
                                       <c:if test="${ detailDay[j].trvSchedule[0].schId eq 0 }">
                                       <li class="panel-block" style="justify-content: center; border: none;">
                                          <p style="color: gray; margin: 2em;"><i class="fas fa-exclamation-circle"></i> 미리보기 종료<br><br>
											해당 날짜의 상세일정 정보가 없습니다.</p>
                                       </li>
                                    </c:if>
                                    </ul>
                                 </nav>
                              </div>
                              
                              <!--  -->
                              <c:set var="check" value="true" />
                        </c:if>
                        </c:forEach>
                        
                     </c:otherwise>
                     
                  </c:choose>
               </c:forEach>
                  
                  <!-- 상세보기 끝 -->
            </div>
         </div>
         
         <div id="mapArea">
         	<div id="mapInfo" style="display: none;">
         	
         		<div id="mapInfoArea">
         			<div id="infoTitle" class="panel-heading media" style="background: #8e44ad;">
         				<div class="media-left">
         					<img id="placeIcon" style="width: 20px; color: white;" src="">
         				</div>
         				<div class="media-content">
         					<span class="title is-5" style="color: white; white-space: pre-line;" id="placeName"><strong></strong></span>
         				</div><div class="media-right">
         					<button class="delete" id="infoDelete"></button>
         				</div>
         			</div>
      				<img id="placePhoto" src="" style="width: 100%; max-width: 250px;">
      				<br>
      				<div class="card-content">
      					<p id="placeAdd" style="white-space: pre-line;"></p>
      					<p id="placePhone" style="white-space: pre-line;"></p>
      					<p id="placeRating" style="white-space: pre-line;"></p>
      				</div>
      				<hr style="border: 0.5px solid gray; margin-top: 5px;">
      				
      				<p class="title is-5">리뷰</p>
      				<div class="card-content" id="placeReview">
      					
      				</div>
         		</div>
         	
         	</div>
        <select id="mapDaySelect">
			<option value="all">전체보기</option>
			
			<c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
				<c:choose>
				
					<c:when test="${ st.count <= showDays }">
						<c:set var="check" value="false" />
						<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
							<c:if test="${ st.count == detailDay[j].dayNumber }">
								<option value="${ st.count }">DAY ${ st.count }</option>
								<c:set var="check" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${ check == false }">
							<option value="${ st.count }" disabled="disabled">DAY ${ st.count } (일정정보없음)</option>
						</c:if>
					</c:when>
					
					<c:otherwise>
						<c:set var="check" value="false" />
						<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
							<c:if test="${ st.count == detailDay[j].dayNumber }">
								<option value="${ st.count }" disabled="disabled">DAY ${ st.count } 미리보기 종료(일정정보있음)</option>
								<c:set var="check" value="true" />
							</c:if>
						</c:forEach>
						<c:if test="${ check == false }">
							<option value="${ st.count }" disabled="disabled">DAY ${ st.count } 미리보기 종료(일정정보없음)</option>
						</c:if>
					</c:otherwise>
				
				</c:choose>
			</c:forEach>
		</select>   

            <div id="map"></div>
         </div>
      </div>
   </section>
   
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD19cUtWTevnQL9Nh6Nd8BMgPoQs6OWyX0&libraries=places&photo&callback=initMap" async defer></script>
         
      <script>
         
      //지도보기
      var map;
      var service;
      var infowindow;
      var markers = [];
      var placeIds = [];
      var placeNames = [];
      var dayPath;
      
      function initMap() {
         
         /* 첫번째 도시로 맵 초반 로딩 */
         var sydney = new google.maps.LatLng(-33.867, 151.195);
         infowindow = new google.maps.InfoWindow();
         map = new google.maps.Map(document.getElementById('map'), {zoom:13, center:sydney});
         service = new google.maps.places.PlacesService(map);
         
         var bounds = new google.maps.LatLngBounds();
         var coords = new google.maps.MVCArray();
         
         var selectValue = $("#mapDaySelect option:selected").val();
         
         if(selectValue == 'all') {
    		 placeIds = [];
             placeNames = [];
             
             /* 일정의 모든 도시 정보 가져오기 */
             $(".plcName").each(function() {
                placeNames.push($(this).val());
             });
             
             $(".plcId").each(function() {
                placeIds.push($(this).val());
             });
    	 }
         
         //첫째날 장소 위치가 있으면 장소위치로, 없으면 첫번째 도시로 지도 로드
         if(placeNames[0] != null) {
            
            var request = {
                query: placeNames[0],
                fields: ['name', 'geometry', 'photos'],
            };
            
            service.findPlaceFromQuery(request, function(results, status) {
               if(status === google.maps.places.PlacesServiceStatus.OK) {
                  map.setCenter(results[0].geometry.location);
               }
            });
            
         }else {
            
            var cityRequest = { 
               query:"${ detailTb.trvCities[0].cityNameEn }",
               fields:['geometry']
            };
            
            service.findPlaceFromQuery(cityRequest, function(results, status) {
               if(status === google.maps.places.PlacesServiceStatus.OK) {
                  map.setCenter(results[0].geometry.location);
               }
            });
            
         }
         
         placeIds.forEach(function(p, index) {
            
            var request = {
                  placeId:p,
                  fiels:['geometry', 'name']
            };
            
            service.getDetails(request, function(place, status) {
                  
                  var m = new google.maps.Marker({
                     map:map,
                     label: {
                        fontSize:'20px',
                        text:index + 1 + "",
                        color:'#fff'
                     },
                     animation: google.maps.Animation.DROP,
                     title: place.name,
                     position: place.geometry.location
                  });
                  
                  markers.push(m);
                  coords.push(place.geometry.location);
                  
                  dayPath = new google.maps.Polyline({
                      path:coords,
                      geodesic: true,
                      strokeColor: '#FB0303',
                      strokeOpacity: 1.0,
                      strokeWeight: 2
                  });
                  
                  dayPath.setMap(map);
                  
                  if(place.geometry.viewport) {
                     bounds.union(place.geometry.viewport);
                  }else { 
                     bounds.extend(m.position);
                  }
                  
                  if(index == 0) {
                     map.setCenter(m.position);
                  }
                  
                  google.maps.event.addListener(m, 'click', function() {
                	  
                	  	map.setCenter(place.geometry.location);
				                	  
						$("#placeIcon").attr('src', place.icon);
           				$("#placeName").html(place.name);
           				$("#placePhoto").attr('src', place.photos[0].getUrl());
           				$("#placeAdd").html(place.adr_address);
           				$("#placePhone").html(place.formatted_phone_number);
           				var star = "";
           				for(var i = 1; i < 6; i++) {
    						if(i <= place.rating) {
    							star += '<a class="starImg" style="cursor: default;"><i class="fas fa-star"></i></a>';
    						}else {
    							star += '<a class="starImg" style="cursor: default;"><i class="far fa-star"></i></a>';
    						}
    					}
           				$("#placeRating").html(star);
           				
           				var review = "";
           				for(var i = 0; i < 3; i++) {
           					review += '<div align="left"><div class="ui label" style="background: #2dc3c3; display: inline-block;">' + (i+1) + '</div>&nbsp;&nbsp;' 
           								+ place.reviews[i].author_name +'</div><p style="white-space: pre-line; text-align: left;">' + place.reviews[i].text + '&nbsp;&nbsp;(' + place.reviews[i].relative_time_description + ')</p>';
           				}
           				
           				$("#placeReview").html(review);
           				
           				$("#mapInfo").show();
           				
                  });
                  
            });
         });
      }
   
   //상세 스케쥴 시간보기 체크
   $("#timeCheck").change(function() {
      if($(this).prop("checked")) {
         $(".times").removeAttr("style");
      }else {
         $(".times").css("display","none");
      }
   });
   
   $(document).ready(function() {
      $("#day1").removeAttr("style");
      $("#calendarTable-day1").removeAttr("style");
   })
   
   //상세 스케쥴 보기
   function nextDays(day, text) {
      
      var nextDay = 0;
      var totalDay = $("#totalDays").val();
      var showDay = $("#showDays").val();
      
      if(text == 'left') {
         nextDay = Number(Number(day) - 1);
      }else {
         nextDay = Number(Number(day) + 1);
      }
      
      if(nextDay != 0 && nextDay <= totalDay) {
         $(".is-fullwidth").css("display","none");
         $("#day" + nextDay).removeAttr("style");
         
         $(".calendarTable").css("display","none");
         $("#calendarTable-day" + nextDay).removeAttr("style");
         
         dayMap(map, nextDay);
         $("#mapDaySelect").val(nextDay).prop("selected", true);
      }
   }
   
   //장소 정보창끄기
   $("#infoDelete").click(function() {
	   $("#mapInfo").hide();
   });
   
   //상세일정에서 장소 클릭하면 맵에 표시하기
	$(".placeShow").click(function() {
		var plcId = $(this).children("input[name=plcId]").val();
		var plcName = $(this).children("input[name=plcName]").val();
		
		showMap(plcId, map);
	});
	
	function showMap(plcId, map) {
		var request = {
			placeId:plcId,
			fiels:['geometry', 'name']
		};
		
		service.getDetails(request, function(place, status) {
			map.setCenter(place.geometry.location);
			
			//해당 장소의 상세정보창 띄우기
			$("#placeIcon").attr('src', place.icon);
			$("#placeName").html(place.name);
			$("#placePhoto").attr('src', place.photos[0].getUrl());
			$("#placeAdd").html(place.adr_address);
			$("#placePhone").html(place.formatted_phone_number);
			var star = "";
			for(var i = 1; i < 6; i++) {
			if(i <= place.rating) {
				star += '<a class="starImg" style="cursor: default;"><i class="fas fa-star"></i></a>';
			}else {
				star += '<a class="starImg" style="cursor: default;"><i class="far fa-star"></i></a>';
			}
		}
			$("#placeRating").html(star);
			
			var review = "";
			for(var i = 0; i < 3; i++) {
				review += '<div align="left"><div class="ui label" style="background: #2dc3c3; display: inline-block;">' + (i+1) + '</div>&nbsp;&nbsp;' 
							+ place.reviews[i].author_name +'</div><p style="white-space: pre-line; text-align: left;">' + place.reviews[i].text + '&nbsp;&nbsp;(' + place.reviews[i].relative_time_description + ')</p>';
			}
			
			$("#placeReview").html(review);
			
			$("#mapInfo").show();
		});
	}
	
	$("#mapDaySelect").change(function() {
		var day = $(this).children("option:selected").val();
		
		if(day == 'all') {
			allMap(map);
		}else {
			dayMap(map, day);
			
			$(".is-fullwidth").css("display","none");
	         $("#day" + day).removeAttr("style");
	         
	         $(".calendarTable").css("display","none");
	         $("#calendarTable-day" + day).removeAttr("style");
		}
	});
	
	function allMap(map) {
		
		markers.forEach(function(m) {
			m.setMap(null);
		});
		placeIds = [];
	    placeNames = [];
         
		initMap();
	}
	
	function dayMap(map, day) {
		
		markers.forEach(function(m) {
			m.setMap(null);
		});
		
		placeIds = [];
	    placeNames = [];
		
	    $(".day" + day + "Place").find("input[name=plcName]").each(function() {
			placeNames.push($(this).val());
		});
         
		$(".day" + day + "Place").find("input[name=plcId]").each(function() {
			placeIds.push($(this).val());
		});
		
		initMap();
	}

</script>

</body>
</html>