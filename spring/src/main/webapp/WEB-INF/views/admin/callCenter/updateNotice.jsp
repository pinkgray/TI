<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	cursor:pointer;
}

.back {
	font-size: 1.2em !important;
}

.result {
	margin-left: auto;
	margin-right: auto;
}

textarea {
	resize: none;
}
#title {
	border: none;
	text-align:center;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
		<br><br>
			<form action="updateNotice.ad" method="post">
			<section class="section" id="table">
				<h1 class="title" style="text-align: center;">공지 사항</h1>
				<input type="hidden" value="공지사항" name="boardType">
				<input type="hidden" value="${ b.boardId }" name="boardId">
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
							<td><textarea id="title" name="boardTitle">${ b.boardTitle }</textarea></td>
							<td>${ b.enrollDate }</td>
							<td>관리자</td>
							<td>${ b.boardCount }</td>
						</tr>
					</tbody>
				</table>
			</section>
			<section class="section" id="box">
					<h1>제목/내용이 수정 가능합니다.</h1>
				<div class="box">
					<article class="media">
						<div class="media-content">
							<div class="content" id="plusImg">
							<c:if test="${ b.attachmentFileList.get(0).fileId ne 0 }">
								<c:forEach var="img" items="${ b.attachmentFileList }" varStatus="st">
								<div class="img" id="boardImg${ st.count }">
									<img id="img${ st.count }" src="resources/uploadFiles/${ img.changeName }">
								</div>
								</c:forEach>
							</c:if>
							</div>
							<h1 class="title">공지 내용</h1>
							<div class="content">
								<textarea style="width: 100%;" rows="15" name="boardContent">${ b.boardContent }</textarea>
							</div>
						</div>
						<c:if test="${ !b.attachmentFileList.isEmpty() }">
						<div id="fileArea">
							<c:forEach var="img" items="${ b.attachmentFileList }" varStatus="st">
								<input type="file" id="imgArea${ st.count }" name="attachmentFile" 
									multiple="multiple" onchange="loadImg(this, ${ st.count });">
							</c:forEach>
						</div>
						</c:if>
					</article>
					<br> <br>
				</div>
			</section>
			<div class="field is-grouped">
				<p class="control result">
					<button type="reset" class="button is-link">돌아가기</button>
				</p>
				<p class="control result">
					<button type="submit" class="button is-primary">수정하기</button>
				</p>
			</div>
			</form>
		</div>
	</div>
</body>
<script>
	$(function () {
		var nav = $(".navbar-item").eq(2);
		   nav.css("background", "#118fe4");
		   nav.siblings().css("background", "rgb(32, 156, 238)");
		
		$(".is-link").click(function() {
			location = "adminNoticeList.ad"
		});
		/* $(".is-primary").click(function() {
			location = "adminNoticeList.ad"
		}); */
		
		$("#fileArea").hide();
		$("#img1").click(function() {
			$("#img3").click();
		});
		$("#img2").click(function() {
			$("#img4").click();
		});
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
</script>
</html>