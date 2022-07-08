<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.date {
	height:36px;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
		<br><br>
			<section class="section" id="table">
				<h1 class="title" style="text-align: center;">1:1문의</h1>
				<!-- <div class="field">
					<p class="control">
						<span class="select">
							<select>
								<option>이용</option>
								<option>결제</option>
								<option>기타</option>
							</select>
						</span> &nbsp; &nbsp; &nbsp; 
						<span class="select">
							<select>
								<option>답변 중</option>
								<option>답변 완료</option>
							</select>
						</span> &nbsp; &nbsp; &nbsp;
						<span> 
							<input type="date" class="date">
						</span> &nbsp; &nbsp; &nbsp;
						<a class="button is-info"> 조회 </a>
					</p>
				</div> -->
				<hr>
				<table class="table">

					<thead>
						<tr>
							<th>문의 번호</th>
							<th>종류</th>
							<th>제목</th>
							<th>작성일</th>
							<th>작성자</th>
							<th>문의 상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="i" items="${ list }">
							<tr>
								<td><b>${ i.inquiryId }</b></td>
								<td>${ i.inquiryType }</td>
								<td>${ i.inquiryTitle }</td>
								<td>${ i.inquiryDate }</td>
								<td>${ i.member.userName }</td>
								<c:if test="${ i.replyStatus eq 'N' }">
									<td>처리 대기중</td>
								</c:if>
								<c:if test="${ i.replyStatus eq 'Y' }">
									<td>처리 완료</td>
								</c:if>
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
				<c:url var="previous" value="oneToOneList.ad">
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
					<c:url var="number" value="oneToOneList.ad">
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
				<c:url var="next" value="oneToOneList.ad">
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
	$(function () {
		var nav = $(".navbar-item").eq(2);
		   nav.css("background", "#118fe4");
		   nav.siblings().css("background", "rgb(32, 156, 238)");
		
		$(".table").find("td").mouseenter(function () {
			$(this)
			.parents("tr")
			.css({"background":"#209CEE","cursor":"pointer", "color":"white"});
		}).mouseout(function() {
			$(this)
			.parents("tr")
			.css({"background":"white", "color":"black"});
		}).click(function () {
			var inquiryId = $(this).parents().children("td").eq(0).text()
			console.log(inquiryId);
			location = "oneToOneDetail.ad?inquiryId=" + inquiryId;
		});
	});
</script>
</html>