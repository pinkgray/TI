<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TI - Schedule Editor</title>
</head>
<style>
	.overlayPanel {
		display:inline-block;
	}
	.panel-heading {
		background:#8e44ad;
		color:white;
	}
	.notification {
		background:#C6E4F3;
	}
	.tag.is-primary {
		color:white !important;
		text-decoration:none !important;
	}
	.dayMemo {
		width:60%;
	}
	.tag:hover{
		cursor:pointer;
	}
	.schInfoBtn:hover, .backBtn:hover {
		cursor:pointer;
		color:#7AD9FC;
	}
	.overlay {
	  height: 100%;
	  width: 0;
	  position: fixed;
	  z-index: 10;
	  top: 0;
	  left: 0;
	  background-color: rgb(0,0,0);
	  background-color: rgba(0,0,0, 0.9);
	  overflow-x: auto;
	  transition: 0.9s;
	}
	.overlay-content {
	  position: relative;
	  top: 25%;
	  width: 100%;
	  text-align: center;
	  margin-top: 30px;
	}
	.overlay .closebtn {
	  position: absolute;
	  top: 100px;
	  right: 45px;
	  font-size: 60px;
	}
	@media screen and (max-height: 450px) {
	  .overlay a {font-size: 20px}
	  .overlay .closebtn {
	  font-size: 40px;
	  top: 15px;
	  right: 35px;
	  }
	}
	#left-panel {
		background: #fff;
    	opacity: 0.8;
		width:200px;
		height:400px;
		display:inline-block;
		position:absolute;
		z-index:10;
	}
	#detail-panel {
		background: #fff;
		height:500px;
		width:250px;
		overflow-y:scroll;
		display:inline-block;
		position:absolute;
		z-index:11;
	}
	#placeDetail {
		overflow-y:scroll;
	}
	#left-panel>ul {
		height:320px;
		overflow-y:scroll;
	}
	#left-panel li {
		border:1px solid lightgray;
	}
	#left-panel li:hover {
		cursor:pointer;
		background:lightgray;
		opacity:0.9;
	}
	.dayList, #likeList, #recommList {
		height:400px;
		overflow-y:scroll;
	}
	#likeList, #recommList {
		min-height:430px;
		overflow-y:scroll;
	}
</style>
<body id="schBody">
	<div id="myNav" class="overlay">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<div class="overlay-content">
			<c:forEach var="trvDay" items="${ trvDayList }" varStatus="st" >
				<nav class="panel overlayPanel" style="width:300px">
					<div class="panel-heading" align="center"
						style="background: whitesmoke; color: black; height: 30px">
						<p class="help">${ trvDay.dayDate }</p>
					</div>
					<div class="panel-heading" align="center" style="margin: 0">
						<span>DAY ${ trvDay.dayNumber }</span>&nbsp; 
						<input type="hidden" value="${ trvDay.dayId }" name="dayId" />
						<input class="input dayMemo is-small day${ trvDay.dayId }Memo" type="text" placeholder="MEMO" value="${ trvDay.dayMemo }">
					</div>
					<!-- <label class="panel-block"><input type="checkbox">시간 보이기</label> -->
					<ul class="connectedSortable menu-list dayList" style="background:white" id="day${ trvDay.dayNumber }ListOver">
						<c:forEach var="sch" items="${ trvDay.schList }" varStatus="st">
							<li class="panel-block sch${ sch.schId }Block" style="background: white" id="sch_${ sch.schId }">
								<div class="media-left" style="width: 20%">
									<p class="schTime">${ sch.startTime } - ${ sch.endTime }</p>
									<input type="hidden" value="${ sch.schNumber }" name="schNumber">
								</div>
								<div class="media-content" style="width: 70%">
									<div class="content">
										<p><strong class="schTitle">${ sch.schTitle }</strong></p>
										<c:if test="${ !empty sch.trvCost }">
											<small class="costType">${ sch.trvCost.costType }:</small>
											<small ><strong class="costAmount">${ sch.trvCost.costAmount }</strong></small>
											<small class="costCurrency">(${ sch.trvCost.currency }) /</small>
										</c:if>
										<small class="schTransp">${ sch.schTransp }</small>
										<small>
											<c:if test="${ sch.plcId ne null }" >
												<a style="color:purple" class="schPlc">
													<input type="hidden" value="${ sch.plcId }" name="plcId"> 
													<span class="icon is-small" style="color:purple"> 
														<i class="fas fa-map-marker-alt"></i>
													</span>
													<span class="plcName">${ sch.plcName }</span>
												</a>
											</c:if>
											<c:if test="${ sch.plcId eq null }" >
												<a style="color:purple" class="schPlc">
													(장소 정보 없음)
												</a>
											</c:if>
										</small>
									</div>
								</div>
								<div class="media-right" style="width: 10%">
									<input type="hidden" value="${ sch.schId }" name="schId">
									<button class="delete schDeleteBtn" aria-label="close" data-toolptip="일정 삭제"></button>
									<br><br>	
									<span class="icon schInfoBtn" data-tooltip="일정 정보 수정" data-variation="mini"
										data-position="left center">
										<i class="fas fa-edit"></i>
									</span>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="panel-block">
						<button class="button is-primary is-outlined is-fullwidth newSchBtn">일정 추가</button>
					</div>
				</nav>
			</c:forEach>
		</div>
	</div>


	<!-- ------------------------------------------------------------- -->
	<div class="columns">
		<div class="column">
			<section class="section">
				<div class="columns">
					<div class="column is-3">
						<div style="height:50px">
							<span style="font-size:20px;cursor:pointer" onclick="openNav()">&#9776; 일정 펼쳐보기</span>
						</div>
						<c:forEach var="trvDay"  items="${ trvDayList }" varStatus="st" >
							<nav class="panel dayPanel" id="day${ trvDay.dayNumber }" style="display:none">
								<div class="panel-heading" align="center" 
								style="background:whitesmoke;color:black;;height:30px">
									<p class="help">${ trvDay.dayDate }</p>
								</div>
								<div class="panel-heading columns is-mobile" align="center" style="margin:0">
									<div class="column is-2" style="padding-left:0">
										<a class="button is-small dayLeftBtn">
											<span class="icon"> 
												<i class="fas fa-2x fa-caret-left"></i>
											</span>
										</a>
									</div>
									<div class="column is-8 dayTitle"  style="padding-left:0; padding-right:0">
										<span>DAY ${ trvDay.dayNumber }</span>&nbsp;
										<input type="hidden" value="${ trvDay.dayId }" name="dayId"/>
										<input class="input dayMemo is-small day${ trvDay.dayId }Memo" type="text" placeholder="MEMO"
											value="${ trvDay.dayMemo }" >
									</div>
									<div class="column is-2" style="padding-right:0">
										<a class="button is-small dayRightBtn">
											<span class="icon"> 
												<i class="fas fa-2x fa-caret-right"></i>
											</span>
										</a>
									</div>
								</div>
								<!-- <label class="panel-block"><input type="checkbox">시간 보이기</label> -->
								<ul class="connectedSortable menu-list dayList" id="day${ trvDay.dayNumber }List">
									<c:forEach var="sch" items="${ trvDay.schList }" varStatus="st">
										<li class="panel-block sch${ sch.schId }Block" style="background:white" id="sch_${ sch.schId }">
											<div class="media-left" style="width:20%">
												<p class="schTime">${ sch.startTime } - ${ sch.endTime }</p>
												<input type="hidden" value="${ sch.schNumber }" name="schNumber">
											</div>
											<div class="media-content" style="width:70%">
												<div class="content">
													<p>
														<strong class="schTitle">${ sch.schTitle }</strong>
													</p>
													<c:if test="${ !empty sch.trvCost }">
														<small class="costType">${ sch.trvCost.costType }:</small>
														<small><strong class="costAmount">${ sch.trvCost.costAmount }</strong></small>
														<small class="costCurrency">(${ sch.trvCost.currency }) /</small>
													</c:if>
													<small class="schTransp">${ sch.schTransp }</small>
													<small>
														<c:if test="${ sch.plcId ne null }" >
															<a style="color:purple" class="schPlc">
																<input type="hidden" value="${ sch.plcId }" name="plcId"> 
														 		<span class="icon is-small" style="color:purple"> 
																	<i class="fas fa-map-marker-alt"></i>
																</span>
																<span class="plcName">${ sch.plcName }</span>
														 	</a>
														</c:if>
														<c:if test="${ sch.plcId eq null }" >
															<a style="color:purple" class="schPlc">
																(장소 정보 없음)
															</a>
														</c:if>
													</small>
												</div>
											</div>
											<div class="media-right schEditArea" style="width:10%" >
												<input type="hidden" value="${ sch.schId }" name="schId">
												<button class="delete schDeleteBtn" aria-label="close" data-toolptip="일정 삭제"></button>
												<br><br>	
												<span class="icon schInfoBtn" data-tooltip="일정 정보 수정" data-variation="mini"
													data-position="left center">
													<i class="fas fa-edit"></i>
												</span>
											</div>
										</li>
									</c:forEach>
								</ul>
								<div class="panel-block">
									<button class="button is-primary is-outlined is-fullwidth newSchBtn" >일정 추가</button>
								</div>
							</nav>
						</c:forEach>
					</div>	
					
					
					<!-- --------------------------------- -->
								
					<div class="column is-3">
						<div style="height:50px;"></div>
						<nav class="panel">
							<div class="panel-heading" align="center" 
								style="background:whitesmoke;color:black;height:30px">
								<p class="help"><i class="far fa-hand-point-up"></i>
								원하는 장소를 일정에 골라 넣어보세요</p>
							</div>
							<div class="tabs is-toggle placeTab" align="center" style="padding:0;margin:0">
								<ul>
									<li class="is-active" style="width:50%">
								    	<a>
								        	<span class="icon is-small"><i class="far fa-heart"></i></span>
								          	<span>좋아요장소</span>
								        </a>
								    </li>
								    <li style="width:50%">
								     	<a>
								          	<span class="icon is-small"><i class="fas fa-thumbs-up"></i></span>
								          	<span>추천장소</span>
								        </a>
								    </li>
								</ul>
							</div>
							<!-- <label class="panel-block"><input type="checkbox">선택</label> -->
							<ul id="likeList" class="connectedSortable menu-list" style="height:400px">
								<c:forEach var="likeySpot" items="${ likeySpotList }" varStatus="st">
									<li class="panel-block" style="background:white">
										<div class="media-left">
											<a><span class="icon is-small" style="color:red">
								        			<i class="far fa-heart"></i>
								        	</span></a>
										</div>
										<div class="media-content">
											<div class="content">
												<p>
													<strong class="spotNameKo">${ likeySpot.get("spotNameKo") }</strong>
													<span class="icon is-small" style="color:orange"> <i class="fas fa-eye"></i></span>
													<small>${ likeySpot.get("spotCount") }</small>
													<span class="icon is-small" style="color:red"> <i class="fa fa-heart"> </i> </span>
													<small>${ likeySpot.get("likeCount") }</small>
												</p>
												<em><small class="cityName">${ likeySpot.get("cityNameKo") }</small></em>
												<em><small><strong class="spotType">${ likeySpot.get("plcTypeName") }</strong></small></em>
												<small>
													<a style="color: purple" class="spotPlc"> 
														<input type="hidden" value="" name="plcId">
														<span class="icon is-small" style="color: purple">
															<i class="fas fa-map-marker-alt"></i>
														</span> 
														<span class="plcName">${ likeySpot.get("spotAddress") }</span>
													</a>
												</small>
											</div>
										</div>
										<div class="media-right">
											<a class="button is-small is-link spotInsertBtn"
											data-tooltip="일정에 추가" data-variation="mini" data-position="left center">
												<i class="fas fa-calendar-plus"></i>
											</a>
										</div>
									</li>
								</c:forEach>
							</ul>
							
							<ul id="recommList" class="connectedSortable menu-list" style="display:none; hegiht:400px">
								<c:forEach var="recommSpot" items="${ recommSpotList }" varStatus="st">
									<li class="panel-block" style="background:white">
										<div class="media-left">
											<a><span class="icon is-small" style="color:skyblue">
								        			<i class="far fa-thumbs-up"></i>
								        	</span></a>
										</div>
										<div class="media-content">
											<div class="content">
												<p>
													<strong class="spotNameKo">${ recommSpot.get("spotNameKo") }</strong>
													<span class="icon is-small" style="color:orange"> <i class="fas fa-eye"></i></span>
													<small>${ recommSpot.get("spotCount") }</small>
													<span class="icon is-small" style="color:red"> <i class="fa fa-heart"> </i> </span>
													<small>${ recommSpot.get("likeCount") }</small>
												</p>
												<em><small class="cityName">${ recommSpot.get("cityNameKo") }</small></em>
												<em><small><strong class="spotType">${ recommSpot.get("plcTypeName") }</strong></small></em>
												<small>
													<a style="color: purple" class="spotPlc"> 
														<input type="hidden" value="" name="plcId">
														<span class="icon is-small" style="color: purple">
															<i class="fas fa-map-marker-alt"></i>
														</span> 
														<span class="plcName">${ recommSpot.get("spotAddress") }</span>
													</a>
												</small>
											</div>
										</div>
										<div class="media-right">
											<a class="button is-small is-link spotInsertBtn"
											data-tooltip="일정에 추가" data-variation="mini" data-position="left center">
												<i class="fas fa-calendar-plus"></i>
											</a>
										</div>
									</li>
								</c:forEach>
							</ul>
							
							<div class="panel-block">
								<button class="button is-primary is-outlined is-fullwidth">모두 삭제</button>
							</div>
						</nav>
					</div>
					
					
					<!-- ----------------------------------- -->
					
					
					<div class="column is-6">
						<div class="field is-horizontal">
							<div class="field-label is-normal">
								<label class="label">지도 검색</label>
							</div>
							<div class="field-body">
								<div class="field is-narrow">
									<div class="control">
										<div class="select is-fullwidth">
											<select id="placeType">
												<option>장소 찾기</option>
												<option>식당</option>
												<option>카페</option>
												<option>바</option>
												<option>쇼핑몰</option>
												<option>공원</option>
												<option>박물관</option>
												<option>호텔</option>
											</select>
										</div>
									</div>
								</div>
								<div class="field" >
									<p class="control is-grouped">
										<input class="input is-info" type="text" placeholder="장소 이름, 주소 검색" id="searchInput">
									</p>
								</div>
							</div>
						</div>
						<div style="border:1px solid gray; height:500px">
							<div id="left-panel" class="panel">
								<div class="panel-heading media">
									<div class="media-content" >검색 결과</div>
									<div class="media-right">
										<button class="delete" id="typeSearchDelete"></button>
									</div>
								</div>
								<ul id="placeList"></ul>
								<button class="button is-primary is-outlined is-fullwidth" 
									id="more">결과 더보기</button>
							</div>
							<div id="detail-panel" class="panel" style="display:none">
								<div class="panel-heading media" >
									<div class="media-content" id="placeName"></div>
									<div class="media-right">
										<button class="delete" id="closePlaceDetail"></button>
									</div>
								</div>
								<div class="card" id="placeDetail">
									<div class="card-image">
										<figure class="image" style="margin:0">
											<img src="" id="placePhoto">
										</figure>
									</div>
									<div class="card-content">
										<input type="hidden" id="placeId">
										<button class="button is-small is-link" id="placeInsertBtn">+ 일정에 추가</button>
										<p id="placeAdd"></p>
										<p class="subtitle is-6" id="placePhone"></p>
										<div class="ui star rating" data-rating="" data-max-rating="5" id="ratingStar"></div>
										<small id="placeRating"></small>
										
										<p><small id="openHour"></small></p>
										<hr style="border:1px solid lightgray">
										<div id="placeReview"></div>
									</div>
								</div>
							</div>	
							<div id="map" style="height:100%"></div>
						</div>
					</div>
				</div>
			</section>
			
			
			
			<!-- ------------------------------------------------------------------------ -->
			
						
			<section class="section">
				<div class="notification">
					<h4 class="title is-4">
						<i class="fas fa-tags"></i>여행테마 선택
					</h4>
					<div class="tags">
						<c:forEach var="tag" items="${ allTagList }" varStatus="st">
							<span class="tag is-white themes">
								<input type="hidden" value="${ tag.tagId }" name="tagId">
								${ tag.tagName }
							</span>
						</c:forEach>
					</div>
					<hr style="border:1px solid lightgray">
					<h6 class="title is-6">
						<i class="fas fa-hashtag"></i>내 여행 테마
					</h6>
					<div class="field is-grouped is-grouped-multiline" id="myTagArea">
						<c:forEach var="trvTag" items="${ trvTagList }" varStatus="st">
							<div class="control">
								<div class="tags has-addons">
									<a class="tag is-primary">${ trvTag.tagName }</a>
									<a class="tag is-delete tagDelete"></a>
									<input type="hidden" value="${ trvTag.tagId }" />
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
		</div>
	</div>
	
	<jsp:include page="newScheduleModal.jsp" />
	<jsp:include page="scheduleInfoModal.jsp" />

	<script>
		var start;
		var startArr;
		var startDayId;
		$(function() {
			$('.ui.rating').rating('disable');
			//setEvents();
			$("#day1").show();
			
			$(".dayList").sortable({
				connectWith:".dayList",
				start:function(event, ui) {
					startDayId = $(this).parent().find("input[name=dayId]").val();
					start = $(this).sortable("serialize", { key: "sch" });
					startArr = $(this).sortable("toArray");
				},
				update:function(event, ui) {
					var ul = $(this);
					var dayNumber = ul.attr("id").charAt(3);
					var item = ui.item.attr("id");
					var schId = item.substring(item.indexOf("_") + 1);
					var changeDayId = $(this).parent().find("input[name=dayId]").val();
					var change = $(this).sortable("serialize", { key: "sch" });
					var changeArr = $(this).sortable("toArray");
					
					if(ui.sender == null) {
						
						if(startArr.length == changeArr.length) { //1.같은 day에서 수정할때
							
							$.ajax({
								url:"updateSchNumber.trv?" + change,
								type:"post",
								data:{dayId:changeDayId},
								success:function(data) {
									updateSchList(dayNumber, data.updList);
									
									socket.emit('reorderSchListInADay', {
										dayNumber:dayNumber,
										schList:data.updList,
										room:"${ trv.trvId }"
									});
								},
								error:function(data) {
									alert('updateSchNumber 서버전송 실패');
								}
							});
							
						}else { //2.다른쪽으로 나갈때
							
							$.ajax({
								url:"deleteSchNumber.trv?" + change,
								type:"post",
								data:{originDayId:startDayId},
								success:function(data) {
									console.log("schNumber 삭제완료");
									
									//overlay, list
									var list = ul.children().clone(true);
									if(ul.attr("id") == "day" + dayNumber + "List") {
										$("#day" + dayNumber + "ListOver").empty();
										$("#day" + dayNumber + "ListOver").append(list);
									}else {
										$("#day" + dayNumber + "List").empty();
										$("#day" + dayNumber + "List").append(list);
									}
									var list2 = list.clone(true);
									list2.find(".media-right").empty();
									$("#day" + dayNumber + "ListAll").empty();
									$("#day" + dayNumber + "ListAll").append(list2);
								},
								error:function(data) {
									alert('deleteSchNumber 서버전송 실패');
								}
							});
						}
					
					
					}else { //1. 다른쪽에서 들어올때
						
						$.ajax({
							url:"changeSchDay.trv?" + change,
							type:"post",
							data:{schId:schId, dayId:changeDayId},
							success:function(data) {
								
								updateSchList(data.originDayNumber, data.originSchList);
								updateSchList(data.changeDayNumber, data.changeSchList);
								
								if(data.costId != undefined) {
									var costList = $("#day" + data.changeDayNumber + "CostList"); 
									costList.append($("#cost_" + data.costId));
								}

								socket.emit('reorderSchListBetweenDays', {
									originDayNumber:data.originDayNumber,
									originSchList:data.originSchList,
									changeDayNumber:data.changeDayNumber,
									changeSchList:data.changeSchList,
									costId:data.costId,
									room:"${ trv.trvId }"
								});
							},
							error:function(data) {
								alert('changeSchDay 서버전송 실패');
							}
						});
						
					}
				}
			});
			
			//여행테마 선택
			$(".themes").each(function() {
				var tag = $(this);
				var tagId = $(this).children().val();
				$(".tags.has-addons").each(function() {
					var trvTagId = $(this).children("input").val();
					if(tagId == trvTagId) {
						tag.removeClass('is-white').addClass('is-link');
					}
				});
			});

		});
		
		
		//지도 타입검색
		$("#placeType").change(function() {
			var type = $(this).children("option:selected").text();
			$("#placeList").empty();
			
			switch(type) {
			case '식당': type = 'restaurant'; break;
			case '카페': type = 'cafe'; break;
			case '바': type = 'bar'; break;
			case '쇼핑몰': type = 'shopping_mall'; break;
			case '공원': type = 'park'; break;
			case '박물관': type = 'museum'; break;
			case '호텔' : type = 'hotel'; break;
			case '장소찾기':return;
			}
			placeTypeSearch(type, map);
		});
		
		//장소insert
		$(document).on('click', '#placeInsertBtn', function() {
			var plcId = $("#placeId").val();
			console.log(plcId);
			var placeName = $("#placeName").text();
			$("#plcId1").val(plcId);
			$("#plcName1").val(placeName);
			$('#newScheduleModal').toggleClass('is-active');
		});
		
		
		//좋아요장소 insert
		$(document).on('click', '.spotInsertBtn', function() {
			var plcName = $(this).parent().prev().find(".plcName").text();
			console.log(plcName);
			placeTextSearch(plcName, map, "insert");
			//$("#plcName1").val(plcName);
			$("#newScheduleModal").toggleClass('is-active');
		});
		
		//장소select
		$(document).on('click', '.schPlc', function() {
			var plcId = $(this).children("input[name=plcId]").val();
			placeDetailSearch(plcId, map);
			
		});
		
		//좋아요장소 select
		$(document).on('click', '.spotPlc', function() {
			var plcName = $(this).children(".plcName").text();
			placeTextSearch(plcName, map);
		});
		
		
		
		//좋아요/추천 장소탭
		$(".placeTab").find("li").click(function() {
			$(this).addClass("is-active");
			$(this).siblings().removeClass("is-active");
			var text = $(this).children().children().eq(1).text();
			if(text == '추천장소') {
				$("#recommList").show();
				$("#likeList").hide();
			}else {
				$("#likeList").show();
				$("#recommList").hide();
			}
		});
		
		
		//day-1
		$(".dayLeftBtn").click(function() {
			
			var nav = $(this).parents("nav");
			if(!nav.is("#day1")) {
				nav.hide();
				nav.prev().show();
				var places = [];
				nav.prev().find("input[name=plcId]").each(function() {
					places.push($(this).val());
				});
				showRoute(places, map);				
			}
			
		});
		
		
		//day+1
		$(".dayRightBtn").click(function() {
			
			var nav = $(this).parents("nav");
			if(!nav.is("#day${ trvDayList.size() }")) {
				nav.hide();
				nav.next().show();
				var places = [];
				nav.next().find("input[name=plcId]").each(function() {
					places.push($(this).val());
				});
				showRoute(places, map);				
				
			}
			
		});
		
		
		
		//새일정
		$(".newSchBtn").click(function() {
			var dayId = $(this).parent().prev().prev().find("input[name=dayId]").val();
			$("#dayId1").children().each(function() {
				if($(this).val() == dayId) {
					$(this).prop("selected", true);
				}
			});
			$('#newScheduleModal').toggleClass('is-active');
		});
		
		
		
		
		
		//여행테마 추가,제거
		$(document).on('click', '.themes', function() {
			var tag = $(this);
			var tagName = $(this).text();
			var tagId = $(this).children().val();
			if(tag.is(".is-white")) {
				$.ajax({
					url:"insertTrvTag.trv",
					data:{tagId:tagId, trvId:"${ trv.trvId }"},
					type:"post",
					success:function(data) {
						console.log(data);
						tag.removeClass('is-white').addClass('is-link');
						$("#myTagArea").append($('<div class="control"><div class="tags has-addons"><a class="tag is-primary">' 
								+ tagName + '</a><a class="tag is-delete tagDelete"></a><input type="hidden" value="' + tagId + '"></div></div>'));
						
						//socket tagInsert
						socket.emit('insertTag', {
							tagId:tagId,
							tagName:tagName,
							room:'${ trv.trvId }'
						});
					},
					error:function(err) {
						alert("err");
					}
				});
				
				
				
			}else {
				$.ajax({
					url:"deleteTrvTag.trv",
					data:{tagId:tagId, trvId:"${ trv.trvId }"},
					type:"post",
					success:function(data) {
						console.log(data);
						tag.removeClass('is-link').addClass('is-white');
						$("#myTagArea .tags.has-addons").each(function() {
							if($(this).children().last().val() == tagId) {
								$(this).parent().remove();
							}
						});
						
						//socket tagDelete
						socket.emit('deleteTag', {
							tagId:tagId,
							tagName:tagName,
							room:'${ trv.trvId }'
						});
						
					},
					error:function(err) {
						alert("err");
					}
				});
			}
		});
		
		$(document).on('click', '.tagDelete', function() {
			var tagName = $(this).prev().text();
			var tagId = parseInt($(this).next().val());
			var trvTag = $(this).parent().parent();
			$.ajax({
				url:"deleteTrvTag.trv",
				data:{tagId:tagId, trvId:"${ trv.trvId }"},
				type:"post",
				success:function(data) {
					console.log(data);
					trvTag.remove();
					$(".themes").each(function() {
						if($(this).children().val() == tagId) {
							$(this).removeClass('is-link').addClass('is-white');
						}
					});
					
					//socket tagDelete
					socket.emit('deleteTag', {
						tagId:tagId,
						tagName:tagName,
						room:'${ trv.trvId }'
					});
				},
				error:function(err) {
					alert("err");
				}
			});
			
		});
		
		
		//일정 수정
		$(document).on('click', '.schInfoBtn', function() {
			showSchInfoModal($(this));
		});
		
		//일정 삭제
		$(document).on('click', '.schDeleteBtn', function() {
			deleteSch($(this));
		});
		
		
		//일정 수정버튼 클릭시 수정모달구성
		function showSchInfoModal(schInfoBtn) {
			var schId = schInfoBtn.siblings().eq(0).val();
			var li = schInfoBtn.parent().parent();
			var dayId = li.parent().prev().find("input[name=dayId]").val();
			var schTitle = li.find(".schTitle").text();
			var plcId = li.find("input[name=plcId]").val();
			var plcName = li.find(".plcName").text();
			
			var schTransp = li.find(".schTransp").text();
			var schTime = li.find(".schTime").text();
			console.log(schTime);
			var index = schTime.indexOf("-");
			var startTime = "";
			var endTime = "";
			if(schTime != "-") {
				startTime = schTime.substring(0, index - 1);
				endTime = schTime.substring(index + 2);
			}
			var costTypeStr = li.find(".costType").text();
			console.log(costTypeStr);
			var costType = costTypeStr.substring(0, costTypeStr.indexOf(":"));
			var costAmount = li.find(".costAmount").text();
			var costCurrency = li.find(".costCurrency").text();
			var currency = costCurrency.substring(1, costCurrency.length - 3);
			
			
			var modal = $("#scheduleInfoModal");
			modal.find("#schId2").val(schId);
			modal.find("#schTitle2").val(schTitle);
			modal.find("#plcId2").val(plcId);
			modal.find("#plcName2").val(plcName);
			modal.find("#dayId2").children().each(function() {
				if($(this).val() == dayId) {
					$(this).prop("selected", true);
				}
			});
			
			if(startTime == "" && endTime == "") {
				modal.find("#isTimeset2").prop("checked", true);
				modal.find("#startTime2").val("");
				modal.find("#endTime2").val("");
			}else {
				modal.find("#isTimeset2").prop("checked", false);
				modal.find("#startTime2").val(startTime);
				modal.find("#endTime2").val(endTime);
			}
			
			modal.find("#costType2").children().each(function() {
				if($(this).text() == costType) {
					$(this).prop("selected", true);
				}
			});
			
			
			if(costAmount == "") {
				modal.find("#costAmount2").val(0);
			}else {
				modal.find("#costAmount2").val(parseFloat(costAmount));
			}
			modal.find("#currency2").children().each(function() {
				if($(this).text() == currency) {
					$(this).prop("selected", true);
				}
			});
			modal.find("#schTransp2").val(schTransp);
			
			modal.toggleClass('is-active');
		}
		
		//일정삭제버튼 클릭시 db에서 삭제, listupdate, socket emit
		function deleteSch(deleteBtn) {
			var schId = deleteBtn.prev().val();
			var answer = window.confirm("일정을 삭제하시겠습니까? ");
			if(answer) {
				
				$.ajax({
					url:"deleteSch.trv",
					type:"POST",
					data:{schId:schId, trvId:"${ trv.trvId }"},
					success:function(data) {
						updateSchList(data.dayNumber, data.schList);
						if(data.costId != undefined) {
							deleteCost(data.costId);
						}
						var places = [];
						$("#day" + data.dayNumber).find("input[name=plcId]").each(function() {
							places.push($(this).val());
						});
						showRoute(places, map);
						
						//일정삭제 socket
						socket.emit('deleteSchedule', {
							costId:data.costId, 
							dayNumber:data.dayNumber, 
							schList:data.schList,
							room:"${ trv.trvId }"
						});
					},
					error:function(err) {
						alert("err");
					}
				});
			}
		}
		
		
		
		
		
		
		
		//--------------------------------------------------------------------------------------------------
		
		//일정리스트 update
		function updateSchList(dayNumber, schList) {
			var li = '';
			var section = '';
			
			for(var key in schList) {
				var sch = schList[key];
				console.log(sch);
				
				li += '<li class="panel-block sch' + sch.schId + 'Block" style="background: white" id="sch_' + sch.schId + '">'
				 	   + '<div class="media-left" style="width:20%">'
				 	   + '<p class="schTime">' + sch.startTime + ' - ' + sch.endTime + '</p>'
				 	   + '<input type="hidden" value="' + sch.schNumber + '" name="schNumber"></div>'
				 	   + '<div class="media-content" style="width: 70%"><div class="content">'
				 	   + '<p><strong class="schTitle">' + sch.schTitle + '</strong></p>';
				if(sch.trvCost != null) {
					li += '<small class="costType">' + sch.trvCost.costType + ':</small>'
				 	   + '<small ><strong class="costAmount">' + sch.trvCost.costAmount + '</strong></small>'
				 	   + '<small class="costCurrency">(' + sch.trvCost.currency + ') /</small>';
				}
				li += '<small class="schTransp">' + sch.schTransp + '</small>';
				
				if(sch.plcId != "") {
					li += '<small><a style="color:purple" class="schPlc">'
						+ '<input type="hidden" value="' + sch.plcId + '" name="plcId">'
						+ '<span class="icon is-small" style="color:purple">' 
						+ '<i class="fas fa-map-marker-alt"></i></span>'
						+ '<span class="plcName">' + sch.plcName + '</span></a></small></div></div>';
				}else {
					li += '<small><a style="color:purple" class="schPlc">(장소 정보 없음)</a></small></div></div>';
				}
				
				li += '<div class="media-right schEditArea" style="width: 10%">'
					+ '<input type="hidden" value="' + sch.schId + '" name="schId">'
					+ '<button class="delete schDeleteBtn" aria-label="close" data-tooptip="일정 삭제"></button>'
					+ '<br><br>'
					+ '<span class="icon schInfoBtn" data-tooltip="일정 정보 수정" data-variation="mini" data-position="left center">'
					+ '<i class="fas fa-edit"></i>'
					+ '</span>'
				  	+ '</div></li>';
				
				//상세글
				section += '<section class="section" id="sch' + sch.schId + 'CardSection">'
							+ '<div class="card">'
							+ '<header class="card-header">'
							+ '<p class="icon is-large" style="color:#8e44ad; margin:5px">'
							+ '<i class="fas fa-2x fa-bookmark"></i></p>'
							+ '<div class="card-header-title" style="display:block">'
							+ '<input type="hidden" value="' + sch.schId + '" name="schId">'
							+ '<p><strong>' +  sch.schTitle + '</strong></p>'
							+ '<p class="help schCost">';
				if(sch.trvCost != null) {
					section += '<small class="costType">' + sch.trvCost.costType + '</small> :'
							+ '<strong class="costAmount">' + sch.trvCost.costAmount + '</strong>'
							+ '(<small class="costCurrency">' + sch.trvCost.currency + '</small>) /';
				}
							
				section += '&nbsp;&nbsp;&nbsp;<small class="schTransp">' + sch.schTransp + '</small></p>'
							+ '<small><a style="color: purple">'
							+ '<span class="icon is-small" style="color: purple">'
							+ '<i class="fas fa-map-marker-alt"></i></span>'; 
				if(sch.plcName != "") {
					section += sch.plcName;
				}else {
					section += '(장소 정보 없음)';
				}
				section += '</a></small></div><a class="card-header-icon">'
						+ '<span class="icon detailShowBtn"><i class="fa fa-angle-down"></i></span>'
						+ '</a></header>'
						+ '<div class="card-content" style="display:none">'
						+ '<div class="content editor"></div></div>'
						+ '<footer class="card-footer" style="display:none">'
						+ '<a class="card-footer-item saveBtn" style="background:mediumpurple;color:white">Save</a>'
						+ '<a class="card-footer-item editBtn" style="background:skyblue;color:white">Edit</a>'
						+ '<a class="card-footer-item removeBtn" style="background:lightgray;color:white">Delete</a>'
						+ '</footer></div></section>';
			}
			
			
			$("#day" + dayNumber + "List").empty().append(li);
			$("#day" + dayNumber + "ListOver").empty().append(li);
			$("#day" + dayNumber + "ListAll").empty().append(li); 
			$("#day" + dayNumber + "ListAll").find(".media-right").empty();
			$("#day" + dayNumber + "Area").empty().append(section);
			
			
			var places = [];
			$("#day" + dayNumber).find("input[name=plcId]").each(function() {
				places.push($(this).val());
			});
			showRoute(places, map);
		}
		
		
		//가계부추가
		function insertNewCost(cost) {
			var dayId = cost.dayId;
			var type = cost.costType;
			var ul = $("#day" + dayId + "Cost").find(".costList");
			var costli = $("#day" + dayId + "Cost").find("li").eq(0).clone(true);
			
			switch(type) {
			case '숙박':costli.children().eq(0).children().each(function() { 
						if(!$(this).is(".accomm")) {
							$(this).remove();
						} 
					});break;
			case '교통':costli.children().eq(0).children().each(function() { 
						if(!$(this).is(".transp")) {
							$(this).remove();
						} 
					});break;
			case '식비':costli.children().eq(0).children().each(function() { 
						if(!$(this).is(".food")) {
							$(this).remove();
						} 
					});break;
			case '쇼핑':costli.children().eq(0).children().each(function() { 
						if(!$(this).is(".shopping")) {
							$(this).remove();
						} 
					});break;
			case '관광':costli.children().eq(0).children().each(function() { 
						if(!$(this).is(".tour")) {
							$(this).remove();
						} 
					});break;
			case '기타':costli.children().eq(0).children().each(function() { 
						if(!$(this).is(".etc")) {
							$(this).remove();
						} 
					});break;
			}
			
			costli.find(".costAmount").text(cost.costAmount);
			costli.find(".costCurrency").text(cost.currency);
			costli.find(".costContent").text(cost.costContent);
			costli.find("input[name=costId]").val(cost.costId);
			costli.css("display", "flex");
			costli.attr("id", "cost_" + cost.costId);
			ul.append(costli);
			updateSummary();
		}
		
		//가계부list update
		function updateCostList(dayNumber, costList) {
			var ul = $("#day" + dayNumber + "CostList");
			ul.children().filter(":gt(0)").remove();
			for(var key in costList) {
				var cost = costList[key];
				var dayId = cost.dayId;
				var type = cost.costType;
				var costli = ul.children().eq(0).clone(true);
				
				switch(type) {
				case '숙박':costli.children().eq(0).children().each(function() { 
							if(!$(this).is(".accomm")) {
								$(this).remove();
							} 
						});break;
				case '교통':costli.children().eq(0).children().each(function() { 
							if(!$(this).is(".transp")) {
								$(this).remove();
							} 
						});break;
				case '식비':costli.children().eq(0).children().each(function() { 
							if(!$(this).is(".food")) {
								$(this).remove();
							} 
						});break;
				case '쇼핑':costli.children().eq(0).children().each(function() { 
							if(!$(this).is(".shopping")) {
								$(this).remove();
							} 
						});break;
				case '관광':costli.children().eq(0).children().each(function() { 
							if(!$(this).is(".tour")) {
								$(this).remove();
							} 
						});break;
				case '기타':costli.children().eq(0).children().each(function() { 
							if(!$(this).is(".etc")) {
								$(this).remove();
							} 
						});break;
				}
				
				costli.find(".costAmount").text(cost.costAmount);
				costli.find(".costCurrency").text(cost.currency);
				costli.find(".costContent").text(cost.costContent);
				costli.find("input[name=costId]").val(cost.costId);
				costli.css("display", "flex");
				costli.attr("id", "cost_" + cost.costId);
				ul.append(costli);
				
			}
			updateSummary();
		}
		
		//가계부삭제
		function deleteCost(costId) {
			$("#cost_" + costId).remove();
			updateSummary();
		}
		
		//가계부수정
		function updateCost(cost) {
			var dayId = cost.dayId;
			var type = cost.costType;
    	   	var li = $("#cost_" + cost.costId);
			
			switch(type) {
			case '숙박': if(!li.children().eq(0).children().is(".accomm")) {
							li.children().eq(0).children().remove();
							li.children().eq(0).append($('<span class="icon costType accomm"><i class="fas fa-bed"></i></span>'));};break;
			case '교통':if(!li.children().eq(0).children().is(".transp")) {
							li.children().eq(0).children().remove();
							li.children().eq(0).append($('<span class="icon costType transp"><i class="fas fa-taxi"></i></span>'));};break;
			case '식비':if(!li.children().eq(0).children().is(".food")) {
							li.children().eq(0).children().remove();
							li.children().eq(0).append($('<span class="icon costType food"><i class="fas fa-utensils"></i></span>'));};break;
			case '쇼핑':if(!li.children().eq(0).children().is(".shopping")) {
							li.children().eq(0).children().remove();
							li.children().eq(0).append($('<span class="icon costType shopping"><i class="fas fa-shopping-bag"></i></span>'));};break;
			case '관광':if(!li.children().eq(0).children().is(".tour")) {
							li.children().eq(0).children().remove();
							li.children().eq(0).append($('<span class="icon costType tour"><i class="fas fa-tripadvisor"></i></span>'));};break;
			case '기타':if(!li.children().eq(0).children().is(".etc")) {
							li.children().eq(0).children().remove();
							li.children().eq(0).append($('<span class="icon costType etc"><i class="fas fa-ellipsis-h"></i></span>'));};break;
			}
			
			li.find(".costAmount").text(cost.costAmount);
			li.find(".costCurrency").text(cost.currency);
			li.find(".costContent").text(cost.costContent);
			
			var ul = li.parent();
			if(ul.parent().attr("id") != "day" + dayId + "Cost") {
				$("#day" + dayId + "Cost").find(".costList").append(li);
			}        					
			updateSummary();
			
			if(cost.schId != 0) {
				var schId = cost.schId;
				$(".sch" + schId + "Block")
					.find(".costType").text(type + " : ");
				$(".sch" + schId + "Block")
					.find(".costAmount").text(parseFloat(cost.costAmount));
				$(".sch" + schId + "Block")
					.find(".costCurrency").text("(" + cost.currency + ") /");
				$("#sch" + schId + "CardSection")
					.find(".costType").text(type);
				$("#sch" + schId + "CardSection")
					.find(".costAmount").text(parseFloat(cost.costAmount));
				$("#sch" + schId + "CardSection")
					.find(".costCurrency").text(cost.currency);
			}
		}
		
		//curtain menu open
		function openNav() {
			document.getElementById("myNav").style.width = "100%";
		}
		function closeNav() {
			document.getElementById("myNav").style.width = "0%";
		}
	</script>


</body>
</html>