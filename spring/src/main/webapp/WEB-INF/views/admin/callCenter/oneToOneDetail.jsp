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

.box {
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

textarea {
	resize: none;
}

.result {
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
			<form action="updateInquiry.ad">
				<section class="section" id="table">
					<br>
					<br>
					<h1 class="title" style="text-align: center;">1:1문의</h1>
					<input type="hidden" value="${ i.inquiryId }" name="inquiryId">
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
							<tr>
						</tbody>
					</table>
				</section>
				<div class="box">
					<h1 class="title">문의내용</h1>
					<article class="media">
						<div class="media-content">
							<div class="content">
								<p>${ i.inquiryContent }</p>
							</div>
							<h1 class="title">답변 내용</h1>
							<c:if test="${ i.replyStatus eq 'N' }">
								<div class="content">
									<textarea style="width: 100%;" rows="15"
										placeholder="답변내용을 적으세요" name="replyContent"></textarea>
								</div>
							</c:if>
							<c:if test="${ i.replyStatus eq 'Y' }">
								<textarea style="width: 100%;" rows="15" readonly>${ i.replyContent }</textarea>
							</c:if>
						</div>
					</article>
				</div>
				<div class="field is-grouped">
					<p class="control result">
						<button type="reset" class="button is-link">돌아가기</button>
					</p>
					<p class="control result">
						<button type="submit" class="button is-primary">답변하기</button>
					</p>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	$(function() {
		var nav = $(".navbar-item").eq(2);
		   nav.css("background", "#118fe4");
		   nav.siblings().css("background", "rgb(32, 156, 238)");
		
		$(".is-link").click(function() {
			location = "oneToOneList.ad";
		});
		/* $(".is-primary").click(function() {
			location = "oneToOneList.ad";
		}); */
	});
</script>
</html>