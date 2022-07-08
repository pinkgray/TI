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
	margin-left: 40%;
}

.table tr {
	cursor: pointer;
}
#null {
	width:80%;
	margin-left:auto !important;
	margin-right:auto !important;
	padding-left:30%;
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
					<div class="column">
					
						<div class="buttons">
							<a class="button is-primary is-rounded" onclick="myRequest();">나의
								의뢰</a> <a class="button is-info is-rounded" onclick="myPlan();">나의
								설계</a> <a class="button is-link is-rounded" onclick="beforePlan();">미리작성</a>
							<a class="button is-success is-rounded" onclick="beforePlanForm();">작성하기</a>
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
							<th>설계번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ list.size() > 0 }">
							<c:forEach var="pList" items="${ list }">
								<tr>
									<td><b>${ pList.planId }</b></td>
									<td>${ pList.planTitle }</td>
									<td>${ pList.enrollDate }</td>
									<c:if test="${ pList.modifyDate eq null }">
										<td>수정 안함</td>
									</c:if>
									<c:if test="${ pList.modifyDate ne null }">
										<td>${ pList.modifyDate }</td>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</section>
			<c:if test="${ list.size() == 0 }">
				<div id="null" class="column" style="width:80%; margin-left:center; margin-right:center;">
					<h1>등록한 글이 없습니다.</h1>
				</div>
			</c:if>
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
				<c:url var="previous" value="myRequestList.mr?memberId=${ loginUser.memberId }">
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
					<c:url var="number" value="myRequestList.mr?memberId=${ loginUser.memberId }">
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
				<c:url var="next" value="myRequestList.mr?memberId=${ loginUser.memberId }">
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
		var menu = $(".myPageMenu li").eq(3);
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
			var planId = $(this).parents().children("td").eq(0).text();
			console.log(planId);
			location = "beforePlanDetail.mr?planId=" + planId + "&memberId=${ loginUser.memberId }";
		});
	});

	function myRequest() {
		location = "myRequestList.mr?memberId=${ loginUser.memberId }";
	}
	function myPlan() {
		location = "myPlanList.mr?memberId=${ loginUser.memberId }";
	}
	function beforePlan() {
		location = "beforePlan.mr?memberId=${ loginUser.memberId}";
	}
	function beforePlanForm() {
		location = "showBeforePlanForm.mr?memberId=${ loginUser.memberId }";
	}
</script>
</html>