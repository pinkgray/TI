<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

#box {
	width: 70%;
	margin-right: auto;
	margin-left: auto;
}

#button {
	width: 15%;
	margin-right: auto;
	margin-left: auto;
}

.back {
	font-size: 1.2em !important;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<%-- <jsp:include page="../common/myPageHeader.jsp" /> --%>
	<div class="columns">
		<div class="column">
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
			</section>
			<section class="section" id="table">
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>문의 번호</th>
							<th>종류</th>
							<th>제목</th>
							<th>문의일</th>
							<th>문의 상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>${ i.inquiryId }</b></td>
							<td>${ i.inquiryType }</td>
							<td>${ i.inquiryTitle }</td>
							<td>${ i.inquiryDate }</td>
							<c:if test="${ i.replyStatus eq 'N' }">
								<td>답변 대기중</td>							
							</c:if>
							<c:if test="${ i.replyStatus eq 'Y' }">
								<td>답변 완료</td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="section" id="box">
				<hr>
				<div class="box">
					<h1>문의내용</h1>
					<article class="media">
						<div class="media-content">
							<div class="content">
								<p>${ i.inquiryContent }</p>
							</div>
							<h1>답변 내용</h1>
							<div class="content" id="result">
							<c:if test="${ i.replyStatus eq 'N' }">
								<p>답변 중입니다</p>							
							</c:if>
							<c:if test="${ i.replyStatus eq 'Y' }">
								<p>${ i.replyContent }</p>
							</c:if>
							</div>
						</div>
					</article>
				</div>
			</section>
			<section class="section" id="button">
				<div class="columns">
					<div class="column">
						<div class="buttons">
							<a class="button is-primary back" href="myInquiryList.mr?memberId=${ loginUser.memberId }">
								돌아가기 </a>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
<script>
	$(function() {
		var menu = $(".myPageMenu li").eq(5);
        menu.addClass('is-active');
        menu.siblings().removeClass('is-active');
	});
</script>
</html>