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
	width: 100%;
}

.table th {
	text-align: center !important;
}

.table td {
	text-align: center !important;
}

.pagination {
	width: 70%;
	margin-right: auto !important;
	margin-left: auto !important;
}

.pagination-list {
	margin-left: 30%;
}

.table tr {
	cursor: pointer;
}

.pagination {
	width: 70%;
	margin-right: auto !important;
	margin-left: auto !important;
}

.pagination-list {
	margin-left: 40% !important;
}

.date {
	height: 36px;
}

textarea {
	width: 100%;
	resize: none !important;
	border: none;
	text-align: center;
}

#okModal td {
	border: 1px solid black !important;
}

#null {
	width:80%;
	margin-left:auto !important;
	margin-right:auto !important;
	padding-left:30%;
}
.field a {
	margin-left:0.5em;
}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="table">
			<br><br>
				<h1 class="title" style="text-align: center;">게시판</h1>
				<div class="field table" align="right">
					<a class="button is-primary is-rounded" href="reqTotalList.ad">여행 의뢰</a> &nbsp; &nbsp;
					<a class="button is-success is-rounded" href="planTotalList.ad">의뢰 설계</a> &nbsp; &nbsp;
					<a class="button is-info is-rounded" href="trvTotalList.ad">여행 일정</a> &nbsp; &nbsp;
					<a class="button is-link is-rounded" href="reviewTotalList.ad">리뷰</a> &nbsp;&nbsp;
				</div>
				<br>
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>글 번호</th>
							<th>구분</th>
							<th>제목</th>
							<th>작성일</th>
							<th>작성자</th>
							<th>여부</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ list.size() > 0 }">
							<c:forEach var="trv" items="${ list }">
								<tr>
									<td><b>${ trv.trvId }</b></td>
									<td>여행 일정</td>
									<td>${ trv.trvTitle }</td>
									<td>${ trv.openDate }</td>
									<td>${ trv.userName }</td>
									<td class="no"><a class="button is-danger is-rounded">삭제하기</a></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</section>
			<c:if test="${ list.size() == 0 }">
				<div id="null" class="column" style="width:80%; margin-left:center; margin-right:center;">
					<h1>등록한 글이 없습니다.</h1>
				</div>
			</c:if>
			<section class="section" id="pagination">
		<hr>
		<nav class="pagination is-rounded" role="navigation"
			aria-label="pagination">
			<ul class="pagination-list">
			<!-- 이전버튼 -->
			<c:if test="${pi.currentPage <= 1 }">
				<li><a class="pagination-previous">이전</a></li>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="previous" value="reqTotalList.ad">
					<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
				</c:url>
				<li><a class="pagination-previous" href="${ previous }">이전</a></li>
			</c:if>
			<!--  -->
			
			<!-- 숫자버튼 -->
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${ p eq pi.currentPage }">
					<li><a class="pagination-link" aria-label="Goto page 1">${ p }</a></li>
				</c:if>
				<c:if test="${ p ne pi.currentPage }">
					<c:url var="number" value="reqTotalList.ad">
						<c:param name="currentPage" value="${ p }"/>
					</c:url>
					<li><a class="pagination-link" aria-label="Goto page 1" href="${ number }">${ p }</a></li>
				</c:if>
			</c:forEach>
			<!--  -->
			
			<!-- 다음 버튼 -->
			<c:if test="${ pi.currentPage >= pi.maxPage }">
				<li><a class="pagination-next">다음</a></li>
			</c:if>
			<c:if test="${ pi.currentPage < pi.maxPage }">
				<c:url var="next" value="reqTotalList.ad">
					<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<li><a class="pagination-next" href="${ next }">다음</a></li>
			</c:if>
			</ul>
		</nav>
		<br>
	</section>
		</div>
	</div>
	<!-- 신고하기 모달 -->
	<div class="modal" id="reportModal">
		<div class="modal-background"></div>
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">삭제하기</p>
			</header>
			<section class="modal-card-body">
				<div class="column">
					<h1 class="title">삭제 종류</h1>
					<hr>
					<div class="field">
						<p class="control">
							<span class="select"> <select>
									<option>부적절 게시물</option>
									<option>욕설 및 비방</option>
									<option>저작권 침해 및 명의 도용</option>
									<option>기타</option>
							</select>
							</span>
						</p>
					</div>
				</div>
				<section class="section" id="box">
					<h1 class="title">삭제 사유</h1>
					<h1>
						<b>작성자 : user01</b>
					</h1>
					<hr>
					<div class="box">
						<article class="media">
							<div class="media-content">
								<div class="content">
									<textarea placeholder="삭제사유를 입력하세요" rows="5"></textarea>
								</div>
							</div>
						</article>
					</div>
					<h1 class="title">첨부파일</h1>
					<hr>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="resume"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="resume"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="resume"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="resume"> <span class="file-cta">
									<span class="file-icon"> <i class="fa fa-upload"></i>
								</span> <span class="file-label"> Choose a file… </span>
							</span> <span class="file-name"> Screen Shot 2017-07-29 at
									15.54.25.png </span>
							</label>
						</div>
					</div>
				</section>
			</section>
			<footer class="modal-card-foot">
				<a type="submit" class="button is-primary" href="noticeControlList.ad">삭제</a>
				<a class="button" href="noticeControlList.ad">취소</a>
			</footer>
		</div>
	</div>
</body>
<script>
	$(function() {
		var nav = $(".navbar-item").eq(6);
		   nav.css("background", "#118fe4");
		   nav.siblings().css("background", "rgb(32, 156, 238)");
		
		$(".table").find("td").mouseenter(function() {
			$(this).parents("tr").css({
				"background" : "#209CEE",
				"cursor" : "pointer",
				"color" : "white"
			});
		}).mouseout(function() {
			$(this).parents("tr").css({
				"background" : "white",
				"color" : "black"
			});
		});

		$(".is-danger").parent().siblings().click(function() {
			var trvId = $(this).parents().children("td").eq(0).text()
			console.log(trvId);
			location = "travelDetailForm.tb?trvId=" + trvId
		});
		
		$('.modal-background, .modal-close').click(function() {
	   		$('html').removeClass('is-clipped');
	    	$(this).parent().removeClass('is-active');
	  	});
	  	$('.theme-switcher').change(function(e) {
	    	if (e.target.value) {
		      window.location.href = '/bulmaswatch/' + e.target.value;
		    }
		  });
	
		  // Get all "navbar-burger" elements
		  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
	
		  // Check if there are any nav burgers
		  if ($navbarBurgers.length > 0) {
	
		    // Add a click event on each of them
		    $navbarBurgers.forEach(function ($el) {
		      $el.addEventListener('click', () => {
	
		        // Get the target from the "data-target" attribute
		        var target = $el.dataset.target;
		        var $target = document.getElementById(target);
	
		        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
		        $el.classList.toggle('is-active');
		        $target.classList.toggle('is-active');
		      });
		   });
		}
	});
	
	$(document).on("click",".no", function(){
		var trvId = $(this).parent().find("td").eq(0).text();
		console.log(trvId);
		
		var result = confirm("일정 번호 : " + trvId + "\n"
							 + "해당글을 정말 삭제하시겠습니까?");
		if(result) {
			location = "trvDelete.ad?trvId=" + trvId;
		}
	});
</script>
</html>