<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.table {
	margin-right: auto;
	margin-left: auto;
	width: 80%;
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
	margin-left: 40% !important;
}

.table tr {
	cursor: pointer;
}

.pagination {
	width: 70%;
	margin-right: auto !important;
	margin-left: auto !important;
}

.pagination-list {
	margin-left: 30%;
}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<%-- <jsp:include page="../common/myPageHeader.jsp" /> --%>
	<div class="columns">
		<div class="column">
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
				<hr>
				<div class="columns">
					<div class="column cal">
						<div class="buttons">
							<a class="button is-primary is-rounded" href="goInquiryForm.mr?memberId=${ loginUser.memberId }">문의하기</a>
							<a class="button is-info is-rounded" href="myInquiryList.mr?memberId=${ loginUser.memberId }">나의
								문의 내역</a> <a class="button is-link is-rounded" href="paneltyList.pe?memberId=${ loginUser.memberId }">신고내역</a>
						</div>
					</div>
				</div>
			</section>
			<!-- <section class="section" id="button"> -->
			<!-- </section> -->
			<section class="section" id="table">

				<hr>
				<table class="table">

					<thead>
						<tr>
							<th>신고번호</th>
							<th>구분</th>
							<th>신고 종류</th>
							<th>신고일</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${ list }">
							<tr>
								<td><b>${ p.listId }</b></td>
								<td>${ p.list }</td>
								<td>${ p.penaltyType.penaltyName }</td>
								<td>${ p.penaltyDate }</td>
								<td>${ p.penaltyResult }</td>
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
				<c:url var="previous" value="paneltyList.pe?memberId=${ loginUser.memberId }">
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
					<c:url var="number" value="paneltyList.pe?memberId=${ loginUser.memberId }">
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
				<c:url var="next" value="paneltyList.pe?memberId=${ loginUser.memberId }">
					<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<li><a class="pagination-next" href="${ next }">다음</a></li>
			</c:if>
			</ul>
		</nav>
		<br>
	</section>
		</div>
	</div>
</body>
<script>
	$(function() {
		var menu = $(".myPageMenu li").eq(5);
        menu.addClass('is-active');
        menu.siblings().removeClass('is-active');
        
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
			var listId = $(this).parents().children("td").eq(0).text()
			console.log(listId);
			location = "paneltyDetail.pe?listId=" + listId;
		});
	});
</script>
</html>