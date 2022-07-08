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

.img {
	margin-bottom: 30px;
	border: 1px solid black;
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
							<th>신고번호</th>
							<th>구분</th>
							<th>신고 종류</th>
							<th>신고일</th>
							<th>처리상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>${ p.listId }</b>
							<td>${ p.list }</td>
							<td>${ p.penaltyType.penaltyName }</td>
							<td>${ p.penaltyDate }</td>
							<td>${ p.penaltyResult }</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="section" id="box">
				<hr>
				<div class="box">
					<h1>신고내용</h1>
					<article class="media">
						<div class="media-content">
							<div class="content">
								<p>${ p.penaltyContent }</p>
							</div>
							<h1>첨부사진</h1>
							<div class="content">
								<c:forEach var="img" items="${ p.attachmentFileList }">
									<div class="img">
										<img src="resources/uploadFiles/${ img.changeName }">
									</div>
								</c:forEach>
							</div>
							<h1>처리 내용</h1>
							<div class="content" id="result">
							<c:if test="${ p.penaltyResult eq '처리대기' }">
								<p>신고 처리중</p>							
							</c:if>
							<c:if test="${ p.penaltyResult eq '승인' }">
								<p>승인 처리</p>
							</c:if>
							<c:if test="${ p.penaltyResult eq '거절' }">
								<p>${ p.rejectionReson }</p>
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
							<a class="button is-primary back" href="paneltyList.pe?memberId=${ loginUser.memberId }"> 돌아가기
							</a>
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