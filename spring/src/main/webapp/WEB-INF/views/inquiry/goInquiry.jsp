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
#box {
	width: 50%;
	height: 40%;
	margin-right: auto;
	margin-left: auto;
	margin-right: auto;
}

#form {
	width: 80%;
	margin-right: auto;
	margin-left: auto;
	margin-right: auto;
}

textarea {
	resize: none !important;
}

.result {
	margin-left: 20% !important;
	margin-right: 10% !important;
}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
			</section>
			<br>
			<h1 style="text-align: center;">문의 하기</h1>
			<section class="section" id="box">
				<form action="insertInquiry.mr">
					<input type="hidden" value="${ loginUser.memberId }" name="memberId">
					<div class="box">
						<article class="media">
							<div class="media-content">
								<div class="content">
									<section class="section" id="form">
										<div class="columns">
											<div class="column">
												<div class="field">
													<label class="label">문의 종류</label>
													<p class="control">
														<span class="select">
															<select name="inquiryType">
																<option value="이용">이용</option>
																<option value="결제">결제</option>
																<option value="기타">기타</option>
															</select>
														</span>
													</p>
												</div>
												<div class="field">
													<label class="label">제목</label>
													<p class="control">
														<input class="input" type="text" placeholder="제목을 입력하세요" name="inquiryTitle">
													</p>
												</div>
												<div class="field">
													<label class="label">문의 내용</label>
													<p class="control">
														<textarea class="textarea" placeholder="문의 내용을 입력하세요" name="inquiryContent"></textarea>
													</p>
												</div>
											</div>
										</div>
									</section>
								</div>
							</div>
						</article>
					</div>
					<br>
					<div class="field is-grouped">
						<p class="control result">
							<button type="reset" class="button is-link">돌아가기</button>
						</p>
						<p class="control result">
							<button type="submit" class="button is-primary">문의하기</button>
						</p>
					</div>
				</form>
			</section>
		</div>
	</div>
</body>
<script>
	$(function() {
		var menu = $(".myPageMenu li").eq(5);
		menu.addClass('is-active');
		menu.siblings().removeClass('is-active');

		$(".is-link").click(function() {
			location = "myInquiryList.mr";
		});
		$(".is-primary").click(function() {
			location = "myInquiryList.mr";
		});
	});
</script>
</html>