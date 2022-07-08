<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.allSchTable {
		overflow-x:scroll !important;
	}
	.allSchTable td, .allSchTable th{
		text-align:center;
	}
	.dayInput {
		width:70%;
	}
	.allDayList {
		height:400px;
		overflow-y:scroll;
	}
	#right-panel {
		background: #fff;
    	opacity: 0.8;
		width:100px;
		height:200px;
		display:inline-block;
		position:absolute;
		z-index:10;
		overflow-y:scroll;
	}
	#detail-panel-wide {
		background: #fff;
		height:500px;
		width:300px;
		overflow-y:scroll;
		display:inline-block;
		position:absolute;
		z-index:11;
	}
	#placeDetailWide {
		overflow-y:scroll;
	}
	
	#right-panel li {
		height:30px;
		border:1px solid lightgray;
	}
	#right-panel li:hover {
		cursor:pointer;
		background:lightgray;
		opacity:0.9;
	}
	
</style>
</head>
<body>
	<div class="columns">
		<div class="column">
			<section class="section">
				<div style="border:1px solid gray; height:500px">
					<div id="right-panel" class="panel">
						<ul id="daySelectorList">
							<li id="daySelectorTotal" style="background:skyblue">TOTAL</li>
							<c:forEach var="trvDay" items="${ trvDayList }" varStatus="st">
								<li id="daySelector${ trvDay.dayNumber }">DAY ${ trvDay.dayNumber }</li>
							</c:forEach>
						</ul>
					</div>
					<div id="detail-panel-wide" class="panel" style="display:none">
						<div class="panel-heading media" >
							<div class="media-content" id="placeNameWide"></div>
							<div class="media-right">
								<button class="delete" id="closePlaceDetailWide"></button>
							</div>
						</div>
						<div class="card" id="placeDetailWide">
							<div class="card-image">
								<figure class="image" style="margin:0">
									<img src="" id="placePhotoWide">
								</figure>
							</div>
							<div class="card-content">
								<input type="hidden" id="placeIdWide">
								<!-- <button class="button is-small is-link" id="placeInsertBtn">+ 일정에 추가</button> -->
								<p id="placeAddWide"></p>
								<p class="subtitle is-6" id="placePhoneWide"></p>
								<div class="ui star rating" data-rating="" data-max-rating="5" id="ratingStarWide"></div>
								<small id="placeRatingWide"></small>
										
								<p><small id="openHourWide"></small></p>
								<hr style="border:1px solid lightgray">
								<div id="placeReviewWide"></div>
							</div>
						</div>
					</div>
					<div id="mapWide" style="height:100%"></div>
				</div>
			</section>
			<section class="section">
				<div align="right">
					<button class="button is-link" id="downSchBtn">
						<span class="icon is-small"><i class="fas fa-file-excel"></i></span>
						<span>일정 엑셀로 다운받기</span>
					</button>
					<br>
				</div>
				<div class="columns is-multiline">
					<c:forEach var="trvDay" items="${ trvDayList }" varStatus="st">
						<div class="column is-one-fifth" style="padding: 10.5px 0">
							<nav class="panel">
								<div class="panel-heading" align="center"
									style="background: whitesmoke; color: black; height: 30px">
									<p class="help">${ trvDay.dayDate }</p>
								</div>
								<div class="panel-heading" align="center" style="margin: 0">
									<span>DAY ${ trvDay.dayNumber }</span>&nbsp; 
									<input type="hidden" value="${ trvDay.dayId }">
									<input class="input dayMemo is-small day${ trvDay.dayId }Memo" type="text" placeholder="MEMO"
										value="${ trvDay.dayMemo }">
								</div>
								<!-- <label class="panel-block"><input type="checkbox">시간 보이기</label> -->
								<ul class="connectedSortable menu-list allDayList" style="background: white" id="day${ trvDay.dayNumber }ListAll">
									<c:forEach var="sch" items="${ trvDay.schList }" varStatus="st">
										<li class="panel-block sch${ sch.schId }Block" style="background: white">
											<div class="media-left" style="width:20%">
												<p>${ sch.startTime } - ${ sch.endTime }</p>
												
											</div>
											<div class="media-content" style="width:70%">
												<div class="content">
													<p>
														<strong>${ sch.schTitle }</strong>
													</p>
													<c:if test="${ !empty sch.trvCost }">
														<small class="costType">${ sch.trvCost.costType }:</small>
														<small><strong class="costAmount">${ sch.trvCost.costAmount }</strong></small>
														<small class="costCurrency">(${ sch.trvCost.currency }) /</small>
													</c:if>
													<small class="schTransp">${ sch.schTransp }</small>
													<small>
														<c:if test="${ sch.plcId ne null }" >
															<a style="color:purple" class="schPlcAll">
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
											<div class="media-right" style="width:10%">
											</div>
										</li>
									</c:forEach>
								</ul>
							</nav>
						</div>
					</c:forEach>
				</div>

			</section>
		</div>
	</div>
	
	<script>
		$(function() {
			
			$("#daySelectorList").children().click(function() {
				if($(this).text() == "TOTAL") {
					loadMapWide(mapWide);
				}else {
					var dayNumber = $(this).text().charAt(4);
					console.log(dayNumber);
					var places = [];
					$("#day" + dayNumber).find("input[name=plcId]").each(function() {
						places.push($(this).val());
					});
					showRoute(places, mapWide);
				}
				
			});
			
			$(".schPlcAll").click(function() {
				var plcId = $(this).children("input[name=plcId]").val();
				placeDetailSearch(plcId, mapWide);
				
			});
			
			$("#downSchBtn").click(function() {
				location.href="downloadSch.trv?trvId=${ trv.trvId }";
			});
		});
	</script>
</body>
</html>