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
textarea {
	resize: none !important;
}

.result {
	margin-left: auto !important;
	margin-right: auto !important;
}

#box {
	width: 80%;
	height: 40%;
	margin-left: auto;
	margin-right: auto;
}

#form {
	margin-right: auto;
	margin-left: auto;
}

.img {
	display: inline-block;
	margin-right: 30px;
	margin-left: 70px;
	margin-bottom: 30px;
	width: 150px;
	height: 150px;
	border: 1px solid black;
	width: 150px;
	cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
			<br><br>
			<form action="insertNotice.ad" method="post" enctype="multipart/form-data">
			<br><br>
				<h1 style="text-align: center;" class="title">공지사항</h1>
				<input type="hidden" value="공지사항" name="boardType">
				<hr>
				<section class="section" id="box">
					<div class="box">
						<article class="media">
							<div class="media-content">
								<div class="content">
									<section class="section" id="form">
										<div class="columns">
											<div class="column">
												<div class="field">
													<label class="label">제목</label>
													<p class="control">
														<input class="input" type="text" placeholder="제목을 입력하세요" name="boardTitle">
													</p>
												</div>
												<hr>
												<div class="field" id="plusImg">
													<label class="label">공지 사진</label>
													<button type="button" onclick="plusImg();">추가</button>
												</div>
												<hr>
												<div class="field">
													<label class="label">공지 내용</label>
													<p class="control">
														<textarea class="textarea" placeholder="공지 내용을 입력하세요" name="boardContent"></textarea>
													</p>
												</div>
												<div id="fileArea">											
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
							<button type="submit" class="button is-primary">작성하기</button>
						</p>
					</div>
				</section>
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
			location = "adminNoticeList.ad";
		});
		/* $(".is-primary").click(function() {
			location = "adminNoticeList.ad";
		}); */
		$("#fileArea").hide();
	});
	
	$(document).on("click","#boardImg1",function() {
		$("#imgArea1").click();
	});
	$(document).on("click","#boardImg2",function() {
		$("#imgArea2").click();
	});
	$(document).on("click","#boardImg3",function() {
		$("#imgArea3").click();
	});
	$(document).on("click","#boardImg4",function() {
		$("#imgArea4").click();
	});
	
	//사진 등록
	function loadImg(value, num) {
		if(value.files && value.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				switch(num) {
				case 1 :
					$("#img1").attr("src", e.target.result);
					break;
				case 2 :
					$("#img2").attr("src", e.target.result);
					break;
				case 3 :
					$("#img3").attr("src", e.target.result);
					break;
				case 4 :
					$("#img4").attr("src", e.target.result);
					break;
				}
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
	
	//사진영역 추가
	var count = 1;
	function plusImg() {
		$("#plusImg").append("<div class='img' id='boardImg" + count + "'><img id='img" + count + "'></div>");
		$("#fileArea").append("<input type='file' id='imgArea" + count + "' name='attachmentFile' multiple='multiple' onchange='loadImg(this, " + count + ");'>");
		count++;
	}
</script>
</html>