<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
.table {
	margin-right: auto;
	margin-left: auto;
	width: 70%;
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
	<div class="columns">
		<div class="column">
			<section class="section" id="table">
				<br>
				<br>
				<h1 class="title" style="text-align: center;">공지사항</h1>
				<div class="field">
					<a class="button is-primary is-rounded" href="noticeList.cc">공지사항</a>
					<a class="button is-info is-rounded" href="moreQuestionList.cc">자주
						묻는 질문</a>
				</div>
				<br><br>
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>공지번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>작성자</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notice" items="${ list }">
							<tr>
								<td><b>${ notice.boardId }</b></td>
								<td>${ notice.boardTitle }</td>
								<td>${ notice.enrollDate }</td>
								<td>관리자</td>
								<td>${ notice.boardCount }</td>
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
							<c:url var="previous" value="noticeList.cc">
								<c:param name="currentPage" value="${ pi.currentPage - 1 }" />
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
								<c:url var="number" value="noticeList.cc">
									<c:param name="currentPage" value="${ p }" />
								</c:url>
								<li><a class="pagination-link" aria-label="Goto page 1"
									href="${ number }">${ p }</a></li>
							</c:if>
						</c:forEach>
						<!--  -->

						<!-- 다음 버튼 -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
							<li><a class="pagination-next">다음</a></li>
						</c:if>
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="next" value="noticeList.cc">
								<c:param name="currentPage" value="${ pi.currentPage + 1 }" />
							</c:url>
							<li><a class="pagination-next" href="${ next }">다음</a></li>
						</c:if>
					</ul>
				</nav>
				<br>
			</section>
		</div>
	</div>
	</div>
	</div>
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
			var boardId = $(this).parents().children("td").eq(0).text()
			console.log(boardId);
			location = "noticeDetail.cc?boardId=" + boardId;
		});
	});
</script>
</html>