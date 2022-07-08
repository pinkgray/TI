<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
.input {
	width: 30% px !important;
}

textarea {
	width: 100%;
	resize: none !important;
	border: none;
	text-align: center;
}

.introduce {
	height: 100px !important;
}

.hover-indigo {
	margin-left: 65%;
}

.db {
	cursor: pointer;
}

#okModal td {
	border: 1px solid black !important;
}

th, td {
	text-align: center !important;
}

.more {
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="form">
				<h1 class="title">일정</h1>
				<hr>
				<div class="columns">
					<div class="column">
						<br>
						<div class="field">
							<a class="button is-primary"> Day1 </a>
							<textarea class="textarea" readonly
								style="height: 50px; min-height: 50px;">일정 - 일정 - 일정</textarea>
							<p class="control">
								<textarea class="textarea" readonly>이러한 일정들</textarea>
							</p>
						</div>
						<br>
						<hr>
						<br>
						<div class="field">
							<a class="button is-primary"> Day2 </a>
							<textarea class="textarea" readonly
								style="height: 50px; min-height: 50px;">일정 - 일정 - 일정</textarea>
							<p class="control">
								<textarea class="textarea" readonly>이러한 일정들</textarea>
							</p>
						</div>
						<br>
						<hr>
						<br>
						<div class="field">
							<a class="button is-primary"> Day3 </a>
							<textarea class="textarea" readonly
								style="height: 50px; min-height: 50px;">일정 - 일정 - 일정</textarea>
							<p class="control">
								<textarea class="textarea" readonly>이러한 일정들</textarea>
							</p>
						</div>
						<br>
						<hr>
						<br>
						<div class="buttons">
							<a class="button is-primary is-rounded more" onclick="more();">일정
								더 보기</a>
						</div>
					</div>
					<div class="column map" style="width: 50%;">
						<div class="card">
							<div class="card-image">
								<figure class="image is-4by3">
									<img src="https://source.unsplash.com/random/800x600"
										alt="Image">
								</figure>
							</div>
							<div class="card-content">
								<div class="media">
									<div class="media-left">
										<!-- <figure class="image" style="height: 40px; width: 40px;">
											<img src="https://source.unsplash.com/random/96x96"
												alt="Image">
										</figure> -->
									</div>
									<div class="media-content">
										<p class="title is-4">지역명</p>
									</div>
								</div>
								<div class="content">
									<div class="card">
										<div class="card-content">
											<div class="content">
												<table class="table">
													<thead>
														<tr>
															<th>글 번호</th>
															<th>작성자</th>
															<th>작성일</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>1</b></td>
															<td>user01</td>
															<td>2019/07/10</td>
														</tr>
													</tbody>
												</table>
												<textarea class="textarea" type="text"
													style="height: 50px; min-height: 50px;" readonly>여행제목</textarea>
												<hr>
												<textarea class="textarea" readonly>여행 소개</textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<section class="section" id="box">
							<h1 class="title">가계부</h1>
							<hr>
							<div class="box">
								<article class="media">
									<div class="media-content">
										<div class="content">
											<section class="section" id="table">
												<table class="table">
													<thead>
														<tr>
															<th>숙박</th>
															<th>경비</th>
															<th>기타</th>
															<th>총액</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><textarea readonly>100,000원</textarea></td>
															<td><textarea readonly>100,000원</textarea></td>
															<td><textarea readonly>100,000원</textarea></td>
															<td><textarea readonly>300,000원</textarea></td>
													</tbody>
												</table>
											</section>
										</div>
									</div>
								</article>
							</div>
						</section>
					</div>
				</div>
			</section>
		</div>
	</div>
</body>
<script>
	$(function() {
		var nav = $(".navbar-item").eq(6);
		   nav.css("background", "#118fe4");
		   nav.siblings().css("background", "rgb(32, 156, 238)");
	});
</script>
</html>