<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	width: 80%;
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
	margin-left: 40%;
}

textarea {
	width: 100%;
	resize: none !important;
	border: none;
	text-align: center;
}

.modal-card {
	width: 400px !important;
	height: 800px !important;
}

#null {
	width:80%;
	margin-left:auto !important;
	margin-right:auto !important;
	padding-left:30%;
}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
				<hr>
				<div class="columns">
					<div class="column cal">
						<div class="buttons">
							<a class="button is-primary is-rounded" onclick="myRequest();">나의
								의뢰</a> <a class="button is-info is-rounded" onclick="myPlan();">나의
								설계</a> <a class="button is-link is-rounded" onclick="beforePlan();">미리작성</a>
						</div>
					</div>
					<!-- <div class="column">
						<div class="field">
							<p class="control">
								<span class="select"> <select>
										<option>설계 참여중</option>
										<option>설계 미참여</option>
								</select>
								</span> &nbsp; &nbsp; &nbsp; <span class="select"> <select>
										<option>채택</option>
										<option>미채택</option>
								</select>
								</span>
							</p>
						</div>
					</div> -->
					<!-- <div class="column">
						<div class="field is-grouped">
							<p class="control">
								<a class="button is-info"> 조회 </a>
							</p>
						</div>
					</div> -->
				</div>
			</section>
			<!-- <section class="section" id="button"> -->
			<!-- </section> -->
			<section class="section" id="table">
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>설계번호</th>
							<th>의뢰번호</th>
							<th>제목</th>
							<th>마감일</th>
							<th>의뢰인</th>
							<th>의뢰가격</th>
							<th>채택상태</th>
							<th>신고하기</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ list.size() > 0 }">
							<c:forEach var="pList" items="${ list }">
								<c:if test="${ pList.chooseStatus eq 'D' }">
									<tr style="background:lightgray;">
										<td class="first"><b>${ pList.planId }</b></td>
										<td class="first">${ pList.reqId }</td>
										<td class="first">${ pList.planTitle }</td>
										<td class="first">${ pList.endDate }</td>
										<td class="first">${ pList.reqName }</td>
										<td class="first"><fmt:formatNumber value="${ pList.reqPrice }" groupingUsed="true"/>원</td>
										<td class="first">관리자에 의해 삭제</td>
										<td class="report first">
											<i class="far fa-bell"></i>
										</td>
									</tr>
								</c:if>
								<c:if test="${ pList.chooseStatus ne 'D' }">
									<tr>
										<td class="second"><b>${ pList.planId }</b></td>
										<td class="second">${ pList.reqId }</td>
										<td class="second">${ pList.planTitle }</td>
										<td class="second">${ pList.endDate }</td>
										<td class="second">${ pList.reqName }</td>
										<td class="second"><fmt:formatNumber value="${ pList.reqPrice }" groupingUsed="true"/>원</td>
										<c:if test="${ pList.chooseStatus eq 'Y' }">
											<td class="second">채택완료</td>
										</c:if>
										<c:if test="${ pList.chooseStatus eq 'N' }">
											<td class="second">미채택</td>
										</c:if>
										<td class="report second">
											<i class="far fa-bell"></i>
										</td>
									</tr>
								</c:if>
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
				<c:url var="previous" value="myPlanList.mr?memberId=${ loginUser.memberId }">
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
					<c:url var="number" value="myPlanList.mr?memberId=${ loginUser.memberId }">
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
				<c:url var="next" value="myPlanList.mr?memberId=${ loginUser.memberId }">
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
	
	<!-- 의뢰인 신고하기 -->
	<form action="insertPanelty.pe" method="post" enctype="multipart/form-data">
	<div class="modal" id="reportModal">
		<div class="modal-background"></div>
		<div class="modal-card">
			<header class="modal-card-head">
				<p class="modal-card-title">신고하기</p>
			</header>
			<section class="modal-card-body">
			<input type="hidden" value="${ loginUser.memberId }" name="complainantId">
				<div class="column">
					<h1>신고 종류</h1>
					<hr>
					<div class="field">
						<p class="control">
							<span class="select"> <select name="penaltyId">
									<option value="11">부적절 게시물</option>
									<option value="12">욕설 및 비방</option>
									<option value="13">저작권 침해 및 명의 도용</option>
									<option value="30">기타</option>
							</select>
							</span>
						</p>
					</div>
				</div>
				<section class="section" id="box">
					<h1>신고사유</h1>
					<textarea name="list" readonly>의뢰글</textarea>
					<textarea id="panelty" name="listType" readonly></textarea>
					<hr>
					<div class="box">
						<article class="media">
							<div class="media-content">
								<div class="content">
									<textarea placeholder="신고사유를 입력하세요" rows="5" name="penaltyContent"></textarea>
								</div>
							</div>
						</article>
					</div>
					<h1>첨부파일</h1>
					<hr>
					<div class="field">
						<div class="file has-name">
							<label class="file-label"> <input class="file-input"
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
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
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
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
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
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
								type="file" name="attachmentFile" multiple="multiple"> <span class="file-cta">
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
				<button type="submit" class="button is-primary">신고</button>
				<button class="button" onclick="cancel();">취소</button>
			</footer>
		</div>
	</div>
	</form>
</body>
<script>
	$(function() {
		var menu = $(".myPageMenu li").eq(3);
        menu.addClass('is-active');
        menu.siblings().removeClass('is-active');
        
		$(".table").find("td").not(".first").mouseenter(function() {
			$(this).parents("tr").css({
				"background" : "#209CEE",
				"cursor" : "pointer",
				"color" : "white"
			});
		});
		$(".table").find("td").not(".first").mouseout(function() {
			$(this).parents("tr").css({
				"background" : "white",
				"color" : "black"
			});
		});
		$(".first").click(function() {
			alert("관리자에 의해 삭제되었습니다.");
		});

		$(".far").parent().siblings().not(".first").click(function() {
			var planId = $(this).parents().children("td").eq(0).text();
			var reqId = $(this).parents().children("td").eq(1).text();
			console.log("설계번호 : " + planId);
			console.log("의뢰번호 : " + reqId);
			location = "loadRequetPlan.mr?reqId=" + reqId + "&planId=" + planId;
		});
		
		/* 모달띄우기 */
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

	function myRequest() {
		location = "myRequestList.mr?memberId=${ loginUser.memberId }";
	}
	function myPlan() {
		location = "myPlanList.mr?memberId=${ loginUser.memberId }";
	}
	function cancel() {
		location = location;
	}
	function beforePlan() {
		location = "beforePlan.mr?memberId=${ loginUser.memberId}";
	}
	
	$(document).on("click",".report", function(){
		var code = $(this).parent().find("td").eq(1).text();
		console.log($(this).parent().find("td").eq(1).text());
		$.ajax({
			url:"selectPanelty.pe",
			data:{code:code},
			success:function(data) {
				console.log(data);
				
				var $code = $("#panelty").text(data);
				
				$("#panelty").append($code);
				
				$('#reportModal').toggleClass('is-active');
			},
			error:function() {
				alert("실패");
			}
		});
	});
</script>
</html>