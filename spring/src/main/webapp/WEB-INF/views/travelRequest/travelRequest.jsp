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
</head>
<style>
.is-half {
	margin-top: 5%;
	margin-left: auto;
	margin-right: auto;
}

.message-header {
	font-size: 1.5em;
}

.message-header b {
	margin-right: auto;
	margin-left: auto;
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

.pagination {
	width: 70%;
	margin-right: auto !important;
	margin-left: auto !important;
}

.pagination-list {
	margin-left: 30%;
}

.table tr {
	cursor: pointer;
}

.button {
	margin-left: 4%;
}
</style>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<br>
	<br>
	<br>
	<br>
	<article class="message is-info">
		<div class="notification is-info" style="text-align: center;">
			<b>여행 의뢰 게시판</b>
		</div>
	</article>
	<hr>
	<br>
	<section class="section" id="table">
		<table class="table">
			<a class="button is-info is-active" href="showRequestForm.tr"> 의뢰하기 </a>
			<br>
			<br>
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
				<c:forEach var="list" items="${ list }">
					<tr>
						<td><b>${ list.requestId }</b></td>
						<td>${ list.requestTitle }</td>
						<td>${ list.userName }</td>
						<td><fmt:formatNumber value="${ list.requestPrice }" groupingUsed="true"></fmt:formatNumber>원</td>
						<td><fmt:formatNumber value="${ list.trvCost }" groupingUsed="true"></fmt:formatNumber>원</td>
						<td>${ list.endDate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</section>

	<section class="section" id="pagination">
		<hr>
		<nav class="pagination is-rounded" role="navigation"
			aria-label="pagination">
			<ul class="pagination-list">
			<!-- 이전버튼 -->
			<c:if test="${pi.currentPage <= 1 }">
				<li><a class="pagination-previous">이전</a></li>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="previous" value="travelRequest.tr">
					<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
				</c:url>
				<li><a class="pagination-previous" href="${ previous }">이전</a></li>
			</c:if>
			<!--  -->
			
			<!-- 숫자버튼 -->
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${ p eq pi.currentPage }">
					<li><a class="pagination-link" aria-label="Goto page 1">${ p }</a></li>
				</c:if>
				<c:if test="${ p ne pi.currentPage }">
					<c:url var="number" value="travelRequest.tr">
						<c:param name="currentPage" value="${ p }"/>
					</c:url>
					<li><a class="pagination-link" aria-label="Goto page 1" href="${ number }">${ p }</a></li>
				</c:if>
			</c:forEach>
			<!--  -->
			
			<!-- 다음 버튼 -->
			<c:if test="${ pi.currentPage >= pi.maxPage }">
				<li><a class="pagination-next">다음</a></li>
			</c:if>
			<c:if test="${ pi.currentPage < pi.maxPage }">
				<c:url var="next" value="travelRequest.tr">
					<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<li><a class="pagination-next" href="${ next }">다음</a></li>
			</c:if>
			</ul>
		</nav>
		<br>
	</section>
</body>
<script>
	$(function() {
		$(".table").find("td").mouseenter(function() {
			$(this).parents("tr").css({
				"background" : "#209CEE",
				"cursor" : "pointer",
				"color" : "white"
			});
		}).mouseout(function() {
			$(this).parents("tr").css({
				"background" : "white",
				"color" : "black"
			});
		}).click(function() {
			var reqId = $(this).parents().children("td").eq(0).text();
			var userName = $(this).parents().children("td").eq(2).text();
			console.log(reqId);
			location = "requestDetail.tr?reqId=" + reqId + "&userName=" + userName;
		});
	});
</script>
</html>