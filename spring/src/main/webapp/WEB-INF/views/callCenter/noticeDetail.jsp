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
	display: inline-block;
	margin-right: 70px;
	margin-left: 70px;
	margin-bottom: 30px;
	width: 150px;
	height: 150px;
	border: 1px solid black;
	width: 150px;
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
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<br><br>
	<div class="columns">
		<div class="column">
			<section class="section" id="table">
				<h1 class="title" style="text-align: center;">공지 사항</h1>
				<br><br>
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>공지 번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>작성자</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><b>${ b.boardId }</b></td>
							<td>${ b.boardTitle }</td>
							<td>${ b.enrollDate }</td>
							<td>관리자</td>
							<td>${ b.boardCount }</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="section" id="box">
				<div class="box">
					<article class="media">
						<div class="media-content">
							<c:if test="${ b.attachmentFileList.get(0).fileId ne 0 }">
							<h1 class="title">공지 사진</h1>
							<div class="content">
								<c:forEach var="img" items="${ b.attachmentFileList }">
									<div class="img">
										<img src="resources/uploadFiles/${ img.changeName }">
									</div>
								</c:forEach>
							</div>
							</c:if>
							<h1 class="title">공지 내용</h1>
							<div class="content">
								<p>${ b.boardContent }</p>
							</div>
						</div>
					</article>
					<br>
					<br>
				</div>
			</section>
			<section class="section" id="button">
				<div class="columns">
					<div class="column">
						<div class="buttons">
							<a class="button is-primary back" href="noticeList.cc">돌아가기 </a>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
</html>