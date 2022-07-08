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
<link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<style>
	#bell:hover {
		color: red;
		cursor: pointer;
	}
	.title.thema {
		padding-bottom: 0.7em;
	}
	.buttons.themaBtn {
		display: inline;
		padding-left: 1em;
	}
	.dayTitle span {
		color: rgb(52, 73, 94);
	}
	.description {
		background: rgb(52, 73, 94);
		color: white;
		padding: 1em;
	}
	.ql-toolbar.ql-snow{
		display: none;
	}
</style>
</head>
<body>
	
	<jsp:include page="../common/mainNav.jsp" />
	
	<input type="text" id="loginId" value="${ sessionScope.loginUser.memberId }" hidden="hidden">
	<input type="text" id="userPoint" value="${ sessionScope.loginUser.userPoint }" hidden="hidden">
	
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
	
	<input type="number" hidden="hidden" id="totalDays" value="${ endDay - startDay + 1 }">
	<input type="number" hidden="hidden" id="showDays" value="${ showDays }">
	
	<div class="coumns" style="padding-top: 2.5em;">
		<div class="column">
		
			<!-- 버튼영역 -->
			<section class="section" style="padding-top:0; padding-bottom:0;">
				<div class="columns">
				
					<div class="column" id="btnArea" align="right">
						<c:choose>
							<c:when test="${ !empty loginUser }">
								<c:choose>
									<c:when test="${ detailTb.buyStatus eq 'N' && loginUser.memberId ne detailTb.memberId }">
										<a class="button is-primary" onclick="travelBuy()">
											<span class="icon" id="starIcon"><i class="fas fa-shopping-cart"></i></span>
								          	<span> &nbsp;일정구매 </span>
					        			</a>
					        			&nbsp;
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${ detailTb.likeyStatus eq 'N' }">
										<a class="button is-primary" onclick="travelLikeyInsert();">
											<span class="icon" id="starIcon"><i class="far fa-star"></i></span>
								          	<span> &nbsp;좋아요 </span>
					        			</a>
									</c:when>
									<c:when test="${ detailTb.likeyStatus eq 'Y' }">
										<a class="button is-primary" onclick="travelLikeyDelete();">
											<span class="icon" id="starIcon"><i class="fas fa-star"></i></span>
								          	<span> &nbsp;좋아요 </span>
						        		</a>
									</c:when>
								</c:choose>
							</c:when>
							
							<c:otherwise>
								<a class="button is-dark" onclick="loginInfo();">
									<span class="icon"><i class="fas fa-shopping-cart"></i></span>
						          	<span> &nbsp;일정구매 </span>
				        		</a>
				        		&nbsp;
								<a class="button is-dark" onclick="loginInfo();">
									<span class="icon" id="starIcon"><i class="far fa-star"></i></span>
						          	<span> &nbsp;좋아요 </span>
				        		</a>
							</c:otherwise>
						</c:choose>
						<!-- &nbsp;
						<a class="button is-primary" onclick="linkCopy();">
							<span class="icon"><i class="fas fa-share-alt"></i></span>
				          	<span> &nbsp;링크공유 </span>
				        </a> -->
					</div>
				</div>
			</section>
			
			<!-- 상단 타이틀 -->
			<section class="section" style="padding-bottom:0;">
				<div class="columns">
					<div class="column" id="title">
						<h3 class="title is-3">
							<span class="icon" style="color:skyblue">
								<i class="fas fa-plane"></i>
							</span>
							<span>&nbsp; ${ detailTb.trvTitle }</span>
							<c:if test="${ !empty loginUser.memberId }">
								<span id="bell" data-tooltip="이 글 신고하기"><i class="fas fa-bell" onclick="travelPenaltyModal()"></i></span>
							</c:if>
							<c:if test="${ empty loginUser.memberId }">
								<span id="bell" data-tooltip="신고하려면 로그인하셔야 합니다."><i class="fas fa-bell" onclick="loginInfo()"></i></span>
							</c:if>
						</h3>
						
						<h5 class="subtitle is-5">
							<i class="fas fa-map-marker-alt"></i>
							<c:choose>
								
								<c:when test="${ fn:length(detailTb.trvCities) > 0 }">
									<c:forEach var="trvCities" items="${ detailTb.trvCities }" varStatus="st">
										<span>${ trvCities.countryNameKo } ${ trvCities.cityNameKo }</span>
										<c:if test="${ st.count ne fn:length(detailTb.trvCities) }">&nbsp;/&nbsp;</c:if>
									</c:forEach>
								</c:when>
							</c:choose>
							&nbsp;&nbsp;<span style="color:gray;"><strong>${ endDay - startDay }박 ${ endDay - startDay + 1 }일</strong></span><br>
							<span style="color: black;"><i class="far fa-calendar"></i>&nbsp;${ detailTb.startDate } ~ ${ detailTb.endDate }</span>
						</h5>
					</div>
				</div>
			</section>	<!-- 상단 타이틀 -->
			
			<!-- 서브메뉴바 -->
			<section class="section" style="padding-top:0;">
				<div class="columns">
					<div class="column" id="title">
						<jsp:include page="travelDetailSubNav.jsp" />
					</div>
				</div>
			</section>	<!-- 서브메뉴바 -->
			
			<!-- 여행테마 영역 -->
			<section class="section" style="background: #C6E4F3; padding: 2em;">
				<ul id="travelThemaTag">
					<li><p class="title thema"><i class="fas fa-tags"></i> 여행테마</p></li>
					<li>
						<c:choose>
							<c:when test="${ fn:length(detailTb.trvTags) > 0 }">
								<c:forEach var="trvTags" items="${ detailTb.trvTags }">
									<div class="buttons themaBtn">
			     						<a class="button is-info is-rounded">#${ trvTags.tagName }</a>
			   						</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p>여행태그 없음</p>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</section>
			
			<!-- 상세일정 영역 -->
			<div class="columns">
			
				<!-- 상세일정 메뉴바 영역 -->
				<div class="column is-3">
					<section class="section" style="padding-left: 0px;">
						<aside class="menu">
							<p class="menu-label">일자별 상세글</p>
							<ul class="menu-list" id="schMenu">
								<li><a id="dayAll" class="dayList is-active">전체보기</a></li>
								<li><p style="margin: 0.3em;">일자별 모아보기</p>
								
								<ul>
								<c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
									<c:choose>
									
										<c:when test="${ st.count <= showDays }">
											<c:set var="check" value="false" />
											<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
												<c:if test="${ st.count == detailDay[j].dayNumber }">
													<li><a class="dayList" id="day${ detailDay[j].dayNumber }"><strong>DAY${ detailDay[j].dayNumber }</strong></a></li>
													<c:set var="check" value="true" />
												</c:if>
											</c:forEach>
											<c:if test="${ check == false }">
												<li><a style="color: lightgray;">DAY${ st.count }<br>(일정없음)</a></li>
											</c:if>
										</c:when>
										
										<c:otherwise>
											<c:set var="check" value="false" />
											<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
												<c:if test="${ st.count == detailDay[j].dayNumber }">
													<li onclick="buyInfo()" data-tooltip="상세보기를 원하시면 결제가 필요합니다."><a onclick="buyInfo()" style="color: gray;">DAY${ st.count } <i class="fas fa-exclamation-circle"></i> 미리보기 종료</a></li>
													<c:set var="check" value="true" />
												</c:if>
											</c:forEach>
											<c:if test="${ check == false }">
												<li><a onclick="buyInfo()" style="color: lightgray;">DAY${ st.count } <i class="fas fa-exclamation-circle"></i> 미리보기 종료<br>(일정없음)</a></li>
											</c:if>
										</c:otherwise>
										
									</c:choose>
								</c:forEach>
								</ul>	
							</ul>
							<p class="menu-label">사진 갤러리</p>
							<ul class="menu-list" id="gallaryMenu">
								<li><a class="dayList">전체보기</a></li>
								<li><p style="margin: 0.3em;">일자별 모아보기</p>
									<ul>
										<c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
									<c:choose>
									
										<c:when test="${ st.count <= showDays }">
											<c:set var="check" value="false" />
											<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
												<c:forEach var="a" begin="0" end="${ fn:length(detailDay[j].trvSchedule) }">
													<c:if test="${ st.count == detailDay[j].dayNumber && detailDay[j].trvSchedule[a].schFiles[0].fileId > 0 }">
														<c:set var="check" value="true" />
													</c:if>
												</c:forEach>
											</c:forEach>
											<c:if test="${ check == true }">
												<li><a class="dayList" id="day${ st.count }-gal">DAY${ st.count }</a></li>
											</c:if>
											<c:if test="${ check == false }">
												<li><a style="color: ligntgray;">DAY${ st.count }<br>(사진없음)</a></li>
											</c:if>
										</c:when>
										
										<c:otherwise>
											<!--  -->
											<c:set var="check" value="false" />
											<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
												<c:forEach var="a" begin="0" end="${ fn:length(detailDay[j].trvSchedule) }">
													<c:if test="${ st.count == detailDay[j].dayNumber && detailDay[j].trvSchedule[a].schFiles[0].fileId > 0 }">
														<c:set var="check" value="true" />
													</c:if>
												</c:forEach>
											</c:forEach>
											<c:if test="${ check == true }">
												<li onclick="buyInfo()" data-tooltip="상세보기를 원하시면 결제가 필요합니다."><a onclick="buyInfo()" style="color: gray;">DAY${ st.count } <i class="fas fa-exclamation-circle"></i> 미리보기 종료</a></li>
											</c:if>
											<c:if test="${ check == false }">
												<li><a onclick="buyInfo()" style="color: lightgray;">DAY${ st.count } <i class="fas fa-exclamation-circle"></i> 미리보기 종료<br>(사진없음)</a></li>
											</c:if>
											<!--  -->
										</c:otherwise>
										
									</c:choose>
								</c:forEach>	
									</ul>
								</li>
							</ul>
						</aside>
					</section>
				</div>	<!-- <div class="column is-3"> -->
				
		<!-- 상세일정 본문 영역 -->
		<div class="column is-9" id="schArea">
		
		<section class="section" style="margin-top: -0.5em;">
						
			<div class="ui divided items">
				
			<!-- 일자별 타이틀 -->
			<c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
				<c:choose>
				<c:when test="${ st.count <= showDays }">
					<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
					
						<c:if test="${ st.count == detailDay[j].dayNumber }">
							<div id="day${ detailDay[j].dayNumber }-sch" class="dayTitle" style="padding: 1em; background-color: #AFDCF5; margin-top: 1em; display: flex;">
								<div class="column is-10" style="justify-content: flex-start;">
									<span class="title is-3">DAY ${ st.count }</span>&nbsp; <span class="schTitle title is-5" style="vertical-align: middle;">${ detailDay[j].dayMemo }</span>
									<br>
									<span>${ detailDay[j].dayDate }</span>
								</div>
								<div class="column is-1" style="justify-content: flex-end;">
									<c:choose>
										<c:when test="${ detailDay[st.count-1].dayWeather eq 'SUN' }">
											<a class="button is-danger weatherBtn" id="SUN" data-tooltip="맑음" style="vertical-align: middle;">
											<i class="fas fa-sun"></i>
											</a>
										</c:when>
										<c:when test="${ detailDay[st.count-1].dayWeather eq 'CLOUD' }">
											<a class="button is-dark  weatherBtn" id="CLOUD" data-tooltip="흐림" style="vertical-align: middle;">
											<span class="icon" style="color: white;"><i class="fas fa-cloud"></i></span>
											</a>
										</c:when>
										<c:when test="${ detailDay[st.count-1].dayWeather eq 'RAIN' }">
											<a class="button is-info weatherBtn" id="RAIN" data-tooltip="비" style="vertical-align: middle;">
											<span class="icon" style="color: white;"><i class="fas fa-umbrella"></i></span>
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
								</div>
								 
								<div class="column is-1" style="justify-content: flex-end;">
									<c:if test="${ fn:length(detailDay[j].trvSchedule) > 0 }">
										<a class="card-header-icon" data-tooltip="상세일정 보기">
											<i class="fas fa-sort-down"></i>
											<input value="${ detailDay[j].dayNumber }" name="dayNum" hidden="hidden">
										</a>
									</c:if>
									<c:if test="${ fn:length(detailDay[j].trvSchedule) <= 0 }">
										<span class="card-header-icon" data-tooltip="상세일정이 없습니다."><i class="fas fa-sort-down"></i></span>
									</c:if>
								</div>
							</div>
							
							<div id="day${ detailDay[j].dayNumber }Content" class="dayContentAll" style="border: 1px solid #AFDCF5; border-top: none; display: none;">
								<c:if test="${ fn:length(detailDay[j].trvSchedule) > 0 && st.count == detailDay[j].dayNumber}">
									<c:forEach var="sch" items="${ detailDay[j].trvSchedule }" varStatus="status">
										<div class="contentTitle" style="background: #e1f4ff">
										<div class="column is-1" align="center" style="justify-content: flex-start; display: inline-block; vertical-align: middle;">
											<div class="ui label" style="background: #209cee;">${ status.count }</div>
										</div>
										<div class="column is-10" style="justify-content: center; display: inline-block; vertical-align: middle;">
											<c:if test="${ sch.isTimeset eq 'Y' }">
												<p><i class="far fa-clock"></i>&nbsp;${ sch.startTime } - ${ sch.endTime }</p>
											</c:if>
											<c:if test="${ sch.isTimeset eq 'N' }">
												<p style="color: gray;"><i class="far fa-clock"></i>&nbsp;시간정보 없음</p>
											</c:if>
											<p><strong>${ sch.schTitle }</strong></p>
										</div>
										</div>
										<div class="editor" style="border: 0px;">
											<input name="schId" value="${ sch.schId }" hidden="hidden">
										</div>
									</c:forEach>
								</c:if>
								
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div id="day${ st.count }-sch" class="dayTitle" style="padding: 1em; background-color: #AFDCF5; margin-top: 1em; display: none;">
						<div class="column is-10" style="justify-content: flex-start;">
							<span class="title is-3">DAY ${ st.count }</span>&nbsp; <span class="schTitle title is-5" style="vertical-align: middle;">${ detailDay[st.count-1].dayMemo }</span>
							<br>
							<span>${ detailDay[st.count-1].dayDate }</span>
						</div>
						<div class="column is-1" style="justify-content: flex-end;">
							<c:choose>
								<c:when test="${ detailDay[st.count-1].dayWeather eq 'SUN' }">
									<a class="button is-danger weatherBtn" id="SUN" data-tooltip="맑음" style="vertical-align: middle;">
									<i class="fas fa-sun"></i>
									</a>
								</c:when>
								<c:when test="${ detailDay[st.count-1].dayWeather eq 'CLOUD' }">
									<a class="button is-dark  weatherBtn" id="CLOUD" data-tooltip="흐림" style="vertical-align: middle;">
									<span class="icon" style="color: white;"><i class="fas fa-cloud"></i></span>
									</a>
								</c:when>
								<c:when test="${ detailDay[st.count-1].dayWeather eq 'RAIN' }">
									<a class="button is-info weatherBtn" id="RAIN" data-tooltip="비" style="vertical-align: middle;">
									<span class="icon" style="color: white;"><i class="fas fa-umbrella"></i></span>
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
						</div>
						 
						<div class="column is-1" style="justify-content: flex-end;">
							<c:if test="${ fn:length(detailDay[st.count-1].trvSchedule) > 0 }">
								<a class="card-header-icon" onclick="buyInfo()" data-tooltip="상세보기를 원하시면 결제가 필요합니다."><i class="fas fa-sort-down"></i></a>
							</c:if>
							<c:if test="${ fn:length(detailDay[st.count-1].trvSchedule) <= 0 }">
								<span class="card-header-icon" data-tooltip="상세일정이 없습니다."><i class="fas fa-sort-down"></i></span>
							</c:if>
						</div>
					</div>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 일자별 타이틀 끝 -->
			
			</div>
		</section>
		</div>	<!-- class="column is-9" -->
		
		<!-- 갤러리 영역! -->
		<div class="column is-9" id="gallaryArea" style="display: none;">
			<section class="section">
				<!-- 타이틀 영역 -->
				<c:forEach var="i" begin="1" end="${ totalDays }" step="1" varStatus="st">
				<c:if test="${ st.count <= showDays }">
					<c:forEach var="j" begin="0" end="${ fn:length(detailDay) }" step="1">
						<c:if test="${ st.count == detailDay[j].dayNumber }">
							<div class="gallay" id="gallary-day${ st.count }">
							<div id="day${ detailDay[j].dayNumber }-sch" class="gallaryTitle" style="padding: 1em; background-color: #155173; margin-top: 1em; display: flex;">
								<div class="column is-10" style="justify-content: flex-start;">
									<span class="title is-3" style="color: white;">DAY ${ st.count }</span>&nbsp; <span class="schTitle title is-5" style="color: white; vertical-align: middle;">${ detailDay[j].dayMemo }</span>
									<br>
									<span style="color: white;">${ detailDay[j].dayDate }</span>
								</div>
							</div>
							
							<!-- 사진영역 -->
							
							<c:forEach var="gallary" items="${ gallary }" varStatus="gst">
								<c:if test="${ gallary.dayNumber == detailDay[j].dayNumber }">
									<div class="imgArea" id="imgArea-day${ st.count }" style="display: inline-block;">
										<div class="ui centered card" style="padding: 1.3em; margin: 1em;">
											<div class="image">
												<img src="resources/uploadFiles/${ gallary.changeName }">
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>	
							
						</c:if>
					</c:forEach>
				</c:if>
				</c:forEach>
				
				<!-- 타이틀 영역 끝 -->
				
			</section>
		</div>
		<!-- 갤러리 영역끝 -->
		
	</div>	<!-- <div class="columns"> -->
			
		<section class="section" align="center" style="padding: 0.5em;">
			<div class="columns">
				<div class="column">
					<a class="button is-primary" href="travelList.tb">
						<span class="icon"><i class="fas fa-list"></i></span>
						<span> &nbsp;목록으로 </span>
					</a>
					
					<c:if test="${ loginUser.memberId eq detailTb.memberId }">
						&nbsp;
						<a class="button is-primary" onclick="travelDelete()">
							<span class="icon"><i class="fas fa-times"></i></span>
							<span> &nbsp;삭제하기 </span>
						</a>
					</c:if>
				
				</div>
			</div>
		</section>
				
		</div>
	</div>
	
	<!-- 일정삭제 안내 모달 -->
	<section class="section" id="modal" style="display: none;">
		<div class="modal" id="travelDeleteModal">
		    <div class="modal-background"></div>
		    <div class="modal-card">
		    
				<header class="modal-card-head">
					<p class="modal-card-title"><i class="fas fa-exclamation-triangle"></i>&nbsp;일정 삭제 안내</p>
					<button class="cancel delete"></button>
				</header>
			
				<section class="modal-card-body" align="center">
					
					<p>
						작성하신 일정글을 삭제할 경우 복구할 수 없습니다.<br>
						삭제하시겠습니까?
					</p>
				</section>
			
				<footer class="modal-card-foot" style="justify-content: center">
					<a class="button is-primary" id="travelDelete">일정삭제</a>
					<a class="button cancel">닫기</a>
				</footer>
			
		    </div>
		</div>
	</section>
	
	<!-- 일정구매 안내 모달 -->
	<section class="section" id="travelBuySection" style="display: none;">
		<div class="modal" id="travelBuyModal">
		    <div class="modal-background"></div>
		    <div class="modal-card">
		    
				<header class="modal-card-head">
					<p class="modal-card-title"><i class="fas fa-exclamation-triangle"></i>&nbsp;일정 구매 안내</p>
					<button class="cancel delete"></button>
				</header>
			
				<section class="modal-card-body" align="center">
					
					<p>
						해당 일정글을 구매하시겠습니까?<br>
						현재 보유 포인트 : ${ loginUser.userPoint }P <br>
						일정 결제 포인트 : ${ (endDay - startDay + 1) * 100 }P
					</p>
					<hr style="border: 1px solid lightgray;">
					<p>
						결제 후 잔액 포인트 : ${ loginUser.userPoint - ((endDay - startDay + 1) * 100) }P
					</p>
				</section>
			
				<footer class="modal-card-foot" style="justify-content: center">
					<a class="button is-primary" id="travelBuy">일정구매</a>
					<a class="button cancel">닫기</a>
				</footer>
			
		    </div>
		</div>
	</section>
	
	<!-- 일정신고 모달 -->
	<section class="section" id="travelPanaltySection" >
		<form action="insertPanelty.pe" method="post" enctype="multipart/form-data" id="trvPanelty" >
		<div class="modal" id="travelPanaltyModal">
		    <div class="modal-background"></div>
		    <div class="modal-card">
		    
				<header class="modal-card-head">
					<p class="modal-card-title"><i class="fas fa-exclamation-triangle"></i>&nbsp;일정 신고</p>
					<button class="cancel delete"></button>
				</header>
			
				<section class="modal-card-body" align="center">
					<input type="hidden" value="${ loginUser.memberId }" name="complainantId">
					<input value="일정글" name="list" style="display: none;">
					<input type="hidden" value="${ detailTb.trvId }" name="listType" style="display: none;">
					<p>해당 일정글을 신고하시겠습니까?<br>
					허위 신고 시 불이익이 있을 수 있습니다.</p>
					<hr style="border: 1px solid lightgray; margin-top: 0.5em;">
					<select name="penaltyId" id="travelPanalty" style="width: 60%;">
							<option value="11">부적절 게시물</option>
							<option value="12">욕설 및 비방</option>
							<option value="13">저작권 침해 및 명의 도용</option>
							<option value="30">기타</option>
					</select>
					<br>
					<textarea id="travelPanaltyContent" name="penaltyContent" rows="5" placeholder="신고 사유를 작성해주세요." style="width: 60%; resize: none; margin-top: 0.5em;" value=""></textarea>
					<br>
					<div style="display: inline-block; margin-top: 0.5em;">
						<div class="field" align="center" align="center">
							<div class="file has-name">
								<label class="file-label">
									<input class="file-input" type="file" name="attachmentFile" multiple="multiple" id="panaltyImg1">
									<span class="file-cta">
										<span class="file-icon"> <i class="fa fa-upload"></i></span>
										<span class="file-label"> Choose a file… </span>
									</span>
									<span class="file-name" id="file1" style="width: 250px;"><span style="color: gray;">신고용 사진을 첨부해주세요.</span></span>
								</label>
							</div>
						</div>
					</div>
					
				</section>
			
				<footer class="modal-card-foot" style="justify-content: center">
					<a class="button is-primary" id="travelPanaltySubmit">일정신고</a>
					<a class="button cancel">닫기</a>
				</footer>
		    </div>
		</div>
		</form>
	</section>
	
<script>
	function loginInfo() {
		alert("로그인이 필요한 서비스입니다.");
	};
	
	function buyInfo() {
		var answer = confirm("결제가 필요한 서비스입니다. 결제하시겠습니까?");
		var memberId = $("#loginId").val();
		
		if(answer && memberId > 0) {
			travelBuy();
		}
		if(memberId == "") {
			loginInfo();
		}
	}
	
	function linkCopy() {
	    alert("현재 주소 복사하기");
	}
	
	function travelPenaltyModal() {
		
		$("#travelPanaltySection").removeAttr('style');
		$('#travelPanaltyModal').toggleClass('is-active').removeAttr('style');
		
		$(".cancel").click(function(){
			$('#travelPanaltyModal').removeClass('is-active');
			$("#travelPanaltySection").css("display","none");
	    });
	}
	
	//파일 업로드 시 해당 파일이름으로 칸 바꾸기
	$("#panaltyImg1").click(function() {
		var fileTarget = $(this);
		
		fileTarget.on('change', function(){
			// 값이 변경되면
			if(window.FileReader){
				// modern browser
				var filename = $(this)[0].files[0].name; } else {
					// old IE
					var filename = $(this).val().split('/').pop().split('\\').pop();
					// 파일명만 추출
					}
			// 추출한 파일명 삽입
			$("#file1").text(filename); });
	});
	
	//일정 신고 버튼을 눌렀을 때
	$("#travelPanaltySubmit").click(function() {
		
		var trvId = '${ detailTb.trvId }';
		var memberId = $("#loginId").val();
		var penaltyId = $("#travelPanalty").val();
		var penaltyContent = $("#travelPanaltyContent").val();
		var file = $("#file1").text();
		
		var check = false;
		
		if(penaltyContent.length <= 0){
			alert("신고 사유를 반드시 작성해주세요");
			check = false;
		}
		if(file == '신고용 사진을 첨부해주세요.') {
			alert("신고 첨부파일을 반드시 첨부해주세요");
			check = false;
		}
		if(penaltyContent.length > 0 && file != '신고용 사진을 첨부해주세요.'){
			check = true;
		}
		
		if(check) {
			$("#trvPanelty").submit();
		}
		
	});
	
	function travelLikeyInsert() {
		var trvId = ${ detailTb.trvId };
		var memberId = $("#loginId").val();
		
		$.ajax({
			url : "travelLikeyInsert.tb",
			data : {trvId : trvId, memberId : memberId},
			success : function(data) {
				
				alert("해당 일정 좋아요 추가");
				
				location.href="travelDetailForm.tb?trvId=" + trvId;
			},
			error:function(data) {
    			alert("서버 전송실패");
    		}
		});
	}
	
	function travelLikeyDelete() {
		var trvId = ${ detailTb.trvId };
		var memberId = $("#loginId").val();
		
		$.ajax({
			url : "travelLikeyDelete.tb",
			data : {trvId : trvId, memberId : memberId},
			success : function(data) {
				
				alert("해당 일정 좋아요 삭제");
				
				location.href="travelDetailForm.tb?trvId=" + trvId;
				
			},
			error:function(data) {
    			alert("서버 전송실패");
    		}
		});
	}
	
	$(".place").click(function() {
		alert("여행지 정보로 연결");
	});
	
	//일정 삭제
	function travelDelete() {
		
		$("#modal").removeAttr('style');
		$('#travelDeleteModal').toggleClass('is-active').removeAttr('style');
		
		$("#travelDelete").click(function() {
			alert("해당 일정 삭제");
			location.href="travelDelete.tb?trvId=" + ${ detailTb.trvId };
		})
		
		$(".cancel").click(function(){
			$('#travelDeleteModal').removeClass('is-active');
			$("#modal").css("display","none");
	    });
	}
	
	//일정구매
	function travelBuy() {
		
		$("#travelBuySection").removeAttr('style');
		$('#travelBuyModal').toggleClass('is-active').removeAttr('style');
		
		$("#travelBuy").click(function() {
			
			var memberId = $("#loginId").val();
			var code = ${ detailTb.trvId };
			var userPoint = $("#userPoint").val();
			var payment = ${ (endDay - startDay + 1) * 100 };
			
			if((userPoint - payment) > 0) {
				
				alert("해당 일정을 구매하였습니다.");
				
				location.href="usePoint.po?memberId=" + memberId + "&code=" + code + "&useType=10&uPoint=" + payment;
				
			}else {
				var answer = confirm("잔여 포인트가 부족합니다. 포인트를 충전하시겠습니까?");
				
				if(answer) {
					location.href='toPayView.po';
				}
			}
		});
		
		$(".cancel").click(function(){
			$('#travelBuyModal').removeClass('is-active');
			$("#travelBuySection").css("display","none");
	    });
	}
	
	//상세일정 본문내용
	$(".editor").each(function() {
		var container = $(this).get(0);
		var schId = $(this).children("input[name=schId]").val();
		var quill = new Quill(container, {
		    theme: 'snow'
		});
		
		//상세일정 내용 조회
		$.ajax({
			url : "selectSchContent.tb",
			data : {schId : schId},
			type : "post",
			success : function(data) {
				if(data.schId == schId) {
					quill.setContents(JSON.parse(data.schContent));
				}
			},
			error : function(data) {
				console.log("접속실패");
			}
		});
	});
	
	//상세일정 펼치기
	$(".card-header-icon").click(function() {
		var dayNumber = $(this).children("input[name=dayNum]").val();
		var div = 'day' + dayNumber + 'Content';
		$("#" + div).toggle(function() {
			$(this).removeAttr("style");
		},function() {
			
		})
	});
	
	/* 일자별 보기 */
	$(".dayList").click(function() {
		
		var menu = $(this).text();
		$(".dayList").removeClass("is-active");
		$(this).addClass("is-active");
		
	})
	
	//일자별 상세글 전체보기
	$("#schMenu>li").children('a').click(function() {
		
		$("#schArea").show();
		$("#gallaryArea").hide();
		
		$(".dayList").removeClass("is-active");
		$(this).addClass("is-active");
		
		$(".dayTitle").show();
	});
	
	//각 일자별 상세글 보기
	$("#schMenu>li>ul>li").children('a').click(function() {
		
		$("#schArea").show();
		$("#gallaryArea").hide();
		
		var menu = $(this).text();
		menu = menu.toLowerCase();
		
		$(".dayTitle").hide();
		$(".dayContentAll").hide();
		$("#" + menu + "-sch").show();
		
	});
	
	
	//갤러리 전체 보기
	$("#gallaryMenu>li").children('a').click(function() {
		$("#gallaryArea").show();
		$("#schArea").hide();
		
		$(".dayList").removeClass("is-active");
		$(this).addClass("is-active");
		
		$(".gallay").show();
	});
	
	//각 일자별 갤러리 상세보기
	$("#gallaryMenu>li>ul>li").children('a').click(function() {
		
		$("#gallaryArea").show();
		$("#schArea").hide();
		
		var menu = $(this).text();
		menu = menu.toLowerCase();
		
		$(".gallay").hide();
		$("#gallary-" + menu).show();
		
	});
	
</script>
</body>
</html>