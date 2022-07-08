<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
.is-half {
	margin-top: 5%;
	margin-right: auto;
	margin-left: auto;
	margin-right: auto;
}

.section {
	width: 70%;
	margin-right: auto;
	margin-left: auto;
}

.notification b {
	font-size: 1.5em;
}

.table {
	margin-right: auto;
	margin-left: auto;
	width: 100%;
}

.table th {
	text-align: center !important;
}

.table td {
	text-align: center !important;
}

.table tr {
	cursor: pointer;
}

.textarea {
	height: 300px !important;
	resize: none !important;
}

.request:hover {
	cursor: pointer;
}
.content {
	margin-left:0.4em;
}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="table">
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>의뢰번호</th>
							<th>제목</th>
							<th>의뢰자</th>
							<th>의뢰가격</th>
							<th>예산</th>
							<th>마감일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="reqId"><b>${ tr.requestId }</b></td>
							<td>${ tr.requestTitle }</td>
							<td id="userName">${ userName }</td>
							<td>
								<input type="hidden" id="uPoint" value="${ tr.requestPrice }">
								<fmt:formatNumber value="${ tr.requestPrice }" groupingUsed="true"/>원
							</td>
							<td><fmt:formatNumber value="${ tr.trvCost }"
									groupingUsed="true"/>원</td>
							<td>${ tr.endDate }</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="section" id="form">
				<div class="field">
					<label class="label">이런 여행을 원해요</label>
					<p class="control">
						<textarea class="textarea" readonly>${ tr.requestContent }</textarea>
					</p>
				</div>
				<div class="field is-grouped">
					<c:if test="${ loginUser.memberId eq 1 }">
						<p class="control">
						<button class="button is-link" onclick="adminReset();">돌아가기</button>
					</p>
					</c:if>
					<c:if test="${ loginUser.memberId ne 1 }">
						<p class="control">
							<button class="button is-primary" onclick="start();">설계해주기</button>
						</p>
						<p class="control">
							<button class="button is-link" onclick="reset();">돌아가기</button>
						</p>
					</c:if>
				</div>
			</section>
			<section class="section" id="card">
				<h1 class="title">설계글</h1>
				<hr>
				<c:if test="${ loginUser.userName eq userName }">
				<c:forEach var="plan" items="${ tr.planList }" varStatus="st">
				<c:if test="${ plan.planTitle != null}">
					<c:if test="${ tr.participationList.get(st.index).chooseStatus ne 'D' }">
						<div class="columns">
							<div class="column">
								<div class="card request">
									<div class="card-image">
										<!-- <figure class="image is-4by3" id="map">
											<img src="https://source.unsplash.com/random/800x600"
												alt="Image">
										</figure> -->
									</div>
									<div class="card-content">
										<div class="media">
											<div class="media-left"></div>
											<div class="media-content">
											<input type="hidden" value="${ tr.participationList.get(st.index).ptcpId }" id="ptcpId">
												<p class="title is-4">제목 : ${ plan.planTitle }</p><br>
												<p class="subtitle is-6">설계자 : ${ plan.userName }</p>
												<input type="hidden" value="${ plan.planId }">
												<p class="subtitle is-6">작성일 : ${ plan.enrollDate }</p>
											</div>
										</div>
										<div class="content">
											<textarea class="col-lg-12 content" style="width: 100%; resize: none;"
												readonly>${ plan.planContent }</textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				</c:if>
				</c:forEach>
				</c:if>
				<c:if test="${ loginUser.userName ne userName }">
					<div class="columns">
						<div class="column">
							<h3>의뢰자만 설계글 목록 확인이 가능합니다.</h3>
						</div>
					</div>
				</c:if>
			</section>
		</div>
	</div>
</body>
<script>
	$(function() {
		$(".request").click(function() {
			//useType : 10:일정구매, 20:설계의뢰
			var code;	//설계글 코드
			var ptcpId;	//참여글 코드
			var uPoint = $("#uPoint").val(); //의뢰 가격
			var reqId = $("#reqId").text();
			var userName = $("#userName").text();
			$(this).each(function() {
				code = $(this).find("input").val();
				ptcpId = $(this).find("#ptcpId").val();
				console.log(code);
				console.log(uPoint);
				console.log(ptcpId);
			});
			console.log("참여번호 : " + ptcpId);
			//location = "requestPlan.tr?code=" + code +"&useType=" + 20 + "&uPoint=" + uPoint + "&reqId=" + reqId + "&userName=" + userName;
			location = "requestPlan.tr?ptcpId=" + ptcpId;
		});
	});
	function start() {
		var reqId = $("#reqId").text();
		var userName = $("#userName").text();
		var loginName = "${ loginUser.userName }";
		console.log(userName);
		console.log(loginName);
		if(userName == (loginName)) {
			alert("본인이 설계해줄수 없습니다.");
			return false;
		} else {
			location = "showrequestStartForm.tr?reqId=" + reqId + "&userName=" + userName;
		}
	}
	
	//일반유저 돌아가기
	function reset() {
		location = "travelRequest.tr";
	}
	
	//관리자 돌아가기
	function adminReset() {
		location = "reqTotalList.ad";
	}
	//지도보기
	var count = $("figure").length;
	function initMap() {
	    var map;
	    map = new google.maps.Map(document.getElementById("map"), {
	    center: {lat: -33.93979965825738, lng: 151.171365661621},
	    zoom: 13
	});
}	
</script>
<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBHA8SfsYSWfcmA-kb6Y1Gf4ucjOrvfXZI&callback=initMap" async defer></script>
</html>