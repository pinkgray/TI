<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
</style>
</head>
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
	<div class="columns">
		<div class="column">
			<form action="insertRequest.tr" method="post">
				<input type="hidden" value="${ loginUser.memberId }" name="memberId">
				<section class="section" id="form">
					<div class="field">
						<label class="label">제목</label>
						<p class="control">
							<input class="input"  name="requestTitle" type="text" placeholder="제목을 입력해주세요">
						</p>
					</div>
					<div class="field">
						<label class="label">나의 여행 스타일</label>
						<p class="control">
							<textarea class="textarea" name="requestContent" placeholder="여행테마/여행지/인원/일정을 입력해주세요"></textarea>
						</p>
						<div class="field">
							<p class="control">
								<label><b>의뢰가격</b></label> &nbsp; &nbsp; 
								<input type="number" name="requestPrice"> &nbsp; &nbsp; 
								<label><b>마감날짜</b></label> &nbsp; &nbsp; 
								<input type="date" name="endDate">
								<label><b>예산</b></label> &nbsp; &nbsp; 
								<input type="number" name="trvCost">
							</p>
						</div>
					</div>
					<div class="field is-grouped">
						<p class="control">
							<button class="button is-primary" type="submit">의뢰하기</button>
						</p>
						<p class="control">
							<button class="button is-link" onclick="reset();">취소</button>
						</p>
					</div>
					<br>
					<hr>
					<br>
				</section>
			</form>
		</div>
	</div>
</body>
<script>
	function reset() {
		location = "travelRequest.tr";
	}
</script>
</html>