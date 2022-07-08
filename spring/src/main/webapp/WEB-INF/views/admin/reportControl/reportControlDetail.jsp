<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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

#box {
	width: 70%;
	margin-right: auto;
	margin-left: auto;
}

.img {
	margin-bottom: 30px;
	border: 1px solid black;
}

.buttons {
	width:13%;
	margin-left:auto;
	margin-right:auto;
}

.button {
	font-size: 1.2em !important;
}

.result {
	margin-left:auto;
	margin-right:auto;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="table">
				<h1 class="title" style="text-align: center;">신고 관리</h1>
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th>신고 번호</th>
							<th>구분</th>
							<th>사유</th>
							<th>신고자</th>
							<th>대상자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>${ p.listId }</b></td>
							<td>${ p.list }</td>
							<td>${ p.penaltyType.penaltyName }</td>
							<td>${ complainantName }</td>
							<td>${ userName }</td>
						</tr>
					</tbody>
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<thead>
						<tr>
							<th>신고일</th>
							<th>벌점</th>
							<th>패널티</th>
							<th>처리상태</th>
							<th>누적 벌점</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>${ p.penaltyDate }</b></td>
							<td>${ p.memberPenalty } 점</td>
							<c:if test="${ p.memberPenalty >= 20 && p.memberPenalty < 40 }">
								<td>15일 정지</td>													
							</c:if>
							<c:if test="${ p.memberPenalty >= 40 }">
								<td>영구정지</td>
							</c:if>
							<c:if test="${ p.memberPenalty < 20 }">
								<td>1회 경고</td>
							</c:if>
							<td>${ p.penaltyResult }</td>
							<td>${ penalty } 점</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="section" id="box">
				<div class="box">
					<article class="media">
						<div class="media-content">
							<h1 class="title">신고 사진</h1>
							<div class="content">
								<c:forEach var="img" items="${ p.attachmentFileList }">
									<div class="img">
										<img src="resources/uploadFiles/${ img.changeName }">
									</div>
								</c:forEach>
							</div>
							<h1 class="title">신고 내용</h1>
							<div class="content">
								<p>${ p.penaltyContent }</p>
							</div>
							<h1 class="title">처리 결과</h1>
							<div class="content">
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
					<br> <br>
				</div>
			</section>
			<div class="buttons">
				<a class="button is-success" href="reportControlList.ad"> 돌아가기 </a>
			</div>
		</div>
	</div>
</body>
<script>
	$(function() {
		var nav = $(".navbar-item").eq(9);
		console.log(nav);
		nav.addClass('is-active');
		nav.siblings().removeClass('is-active');
	});
</script>
</html>