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
	margin-left: 40% !important;
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
	border: 1px solid black;
	text-align: center;
}

#okModal td {
	border: 1px solid black !important;
}

.subtitle {
	color: black !important;
}

input {
	height:35px;
}

#hidden, #hiddenNo {
	display:none;
}

#hiddenName, #hiddenNameNo {
	display:none;
}

</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp" />
	<div class="columns">
		<div class="column">
			<section class="section" id="table">
			<br><br>
				<h1 class="title" style="text-align: center;">신고관리</h1>
				<br><br>
				<!-- <div class="field">
					<p class="control">
						<label>구분</label> &nbsp; &nbsp; <span class="select"> <select>
								<option>채팅방</option>
								<option>리뷰</option>
								<option>여행 일정</option>
								<option>여행 설계</option>
								<option>여행 의뢰</option>
						</select>
						</span> &nbsp; &nbsp; &nbsp; <label>사유</label> &nbsp; &nbsp; <span
							class="select"> <select>
								<option>부적절 게시물</option>
								<option>욕설 및 비방</option>
								<option>저작권 침해 및 명의 도용</option>
								<option>기타</option>
						</select>
						</span> &nbsp; &nbsp; &nbsp; <label>여부</label> &nbsp; &nbsp; <span
							class="select"> <select>
								<option>처리 대기</option>
								<option>승인</option>
								<option>거절</option>
						</select>
						</span> &nbsp; &nbsp; &nbsp; <label>신고일</label> &nbsp; <span> <input
							type="date" class="date">
						</span> &nbsp; &nbsp; &nbsp; <a class="button is-info"> 조회 </a>
					</p>
				</div> -->
				<hr>
				<table class="table">
					<thead>
						<tr>
							<th>신고 번호</th>
							<th>구분</th>
							<th>사유</th>
							<th>신고자</th>
							<th>대상자</th>
							<th>누적벌점</th>
							<th>신고일</th>
							<th>처리 상태</th>
							<th>여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${ list }">
							<tr>
								<td><b>${ p.listId }</b></td>
								<td>${ p.list }</td>
								<td>${ p.penaltyType.penaltyName }</td>
								<td>${ p.complainantName }</td>
								<td>${ p.userName }</td>
								<td>${ p.penalty }</td>
								<td>${ p.penaltyDate }</td>
								<td>${ p.penaltyResult }</td>
								<td>
									<a class="button is-danger is-rounded ok">승인</a> &nbsp; &nbsp;
									<a class="button is-success is-rounded no">거절</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</section>
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
				<c:url var="previous" value="reportControlList.ad">
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
					<c:url var="number" value="reportControlList.ad">
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
				<c:url var="next" value="reportControlList.ad">
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
	<form action="updatePenaltyOk.ad">
		<div class="modal" id="okModal">
			<div class="modal-background"></div>
			<div class="modal-card">
				<header class="modal-card-head">
					<p class="modal-card-title">승인 처리</p>
				</header>
				<section class="modal-card-body">
					<div class="column">
						<!-- <h3 class="title">신고번호</h3> -->
						<h4 class="subtitle is-4">신고번호</h4>
						<h4 class="subtitle is-4" id="listId"><b></b></h4>
						<textarea name="listId" id="hidden"></textarea>
						<hr style="border: solid 1px lightgray;">
					</div>
					<div class="column">
						<h4 class="subtitle is-4">대상자</h4>
						<h4 class="subtitle is-4" id="userName"></h4>
						<textarea name="userName" id="hiddenName"></textarea>
						<hr style="border: solid 1px lightgray;">
					</div>
					<div class="column">
						<h4 class="subtitle is-4" id="title">구분</h4>
						<h4 class="subtitle is-4" id="list"></h4>
						<hr style="border: solid 1px lightgray;">
					</div>
					<!-- <section class="section" id="box"> -->
					<div class="column">
						<h4 class="subtitle is-4">신고 사유</h4>
						<h4 class="subtitle is-4" id="penaltyName"></h4>
						<hr style="border: solid 1px lightgray;">
					</div>
					<div class="column">
						<!-- <h1 class="title">벌점/패널티</h1>
						<h3 class="subtitle is-3">15점/15일 정지</h3> -->
						<h4 class="subtitle is-4">벌점/패널티</h4>
						<label>벌점</label>
						<input type="number" id="penalty" min="5" step="5" value="5" required> &nbsp;
						<label>패널티</label>
						<input type="text" id="result" value="" readonly>
						<hr>
					</div>
				</section>
				<footer class="modal-card-foot">
					<button type="submit" class="button is-primary">확인</button>
					<button type="reset" class="button" onclick="cancel();">취소</button>
				</footer>
			</div>
		</div>
	</form>
	
	<!-- 거절하기 모달 -->
	<form action="updatePenaltyNo.ad">
		<div class="modal" id="noModal">
			<div class="modal-background"></div>
			<div class="modal-card">
				<header class="modal-card-head">
					<p class="modal-card-title">거절 처리</p>
				</header>
				<section class="modal-card-body">
					<div class="column">
						<h1 class="title">신고번호</h1>
						<h3 class="subtitle is-3" id="listIdNo"></h3>
						<textarea name="listId" id="hiddenNo"></textarea>
						<hr>
					</div>
					<div class="column">
						<h1 class="title">대상자</h1>
						<h3 class="subtitle is-3" id="userNameNo"></h3>
						<textarea name="userName" id="hiddenNameNo"></textarea>
						<hr>
					</div>
					<div class="column">
						<h1 class="title" id="titleNo">구분</h1>
						<h3 class="subtitle is-3" id="listNo"></h3>
						<hr>
					</div>
					<!-- <section class="section" id="box"> -->
					<div class="column">
						<h1 class="title">신고 사유</h1>
						<h3 class="subtitle is-3" id="penaltyNameNo"></h3>
						<hr>
					</div>
					<div class="column">
						<h1 class="title">거절 내용</h1>
						<div class="content">
							<textarea placeholder="처리내용을 입력하세요" rows="5" name="rejectionReson"></textarea>
						</div>
						<hr>
					</div>
				</section>
				<footer class="modal-card-foot">
					<button type="submit" class="button is-primary">확인</button>
					<button type="reset" class="button" onclick="cancel();">취소</button>
				</footer>
			</div>
		</div>
	</form>
</body>
<script>
	$(function() {
		var nav = $(".navbar-item").eq(9);
		console.log(nav);
		nav.addClass('is-active');
		nav.siblings().removeClass('is-active');
		
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
			var listId = $(this).parents().children("td").eq(0).text();
			var complainantName = $(this).parents().children("td").eq(3).text();
			var userName = $(this).parents().children("td").eq(4).text();
			var penalty = $(this).parents().children("td").eq(5).text();
			console.log("신고번호 : " + listId);
			console.log("신고자 : " + complainantName);
			console.log("대상자 : " + userName);
			console.log("누적벌점 : " + penalty);
			location = "reportControlDetail.ad?listId=" + listId +"&complainantName=" + complainantName
						+ "&userName=" + userName + "&penalty=" + penalty;
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
	
	function cancel() {
		location = "reportControlList.ad";
	}
	
	//신고 승인
	$(document).on("click",".ok", function(){
		var penaltyResult = $(this).parent().parent().find("td").eq(7).text();
		if(penaltyResult != "처리대기") {
			alert("이미 처리했습니다");
			return false;
		}
		var listId = $(this).parent().parent().find("td").eq(0).text();
		var userName = $(this).parent().parent().find("td").eq(4).text();
		console.log(listId);
		console.log(userName);
		$.ajax({
			url:"selectPenaltyOk.ad",
			data:{listId:listId},
			success:function(data) {
				console.log(data);
				
				var $listId = $("#listId").text(data.listId);
				var $hidden = $("#hidden").text(data.listId);
				var $list = $("#list").text(data.list);
				var $penaltyName = $("#penaltyName").text(data.penaltyType.penaltyName);
				var $penalty = $("#penalty").val(data.penalty);
				var $userName = userName;
				var $result;
				if(data.penalty >= 40) {
					$result = $("#result").val("영구 정지");					
				} else if(data.penalty >= 20) {
					$result = $("#result").val("15일 정지");
				} else {
					$result = $("#result").val("1회 경고");
				}
				
				$("#listId").append($listId);
				$("#hidden").append($hidden);
				$("#userName").append($userName);
				$("#hiddenName").append($userName);
				$("#list").append($list);
				$("#penaltyName").append($penaltyName);
				$("#penalty").append($penalty);
				$("#result").append($result);
				$('#okModal').toggleClass('is-active')
			},
			error:function() {
				alert("실패");
			}
		});	
	});
	
	//신고 거절
	$(document).on("click",".no", function(){
		var penaltyResult = $(this).parent().parent().find("td").eq(7).text();
		if(penaltyResult != "처리대기") {
			alert("이미 처리했습니다");
			return false;
		}
		var listId = $(this).parent().parent().find("td").eq(0).text();
		var userName = $(this).parent().parent().find("td").eq(4).text();
		console.log(listId);
		console.log(userName);
		$.ajax({
			url:"selectPenaltyOk.ad",
			data:{listId:listId},
			success:function(data) {
				console.log(data);
				
				var $listId = $("#listIdNo").text(data.listId);
				var $hidden = $("#hiddenNo").text(data.listId);
				var $list = $("#listNo").text(data.list);
				var $penaltyName = $("#penaltyNameNo").text(data.penaltyType.penaltyName);
				var $userName = userName;
				
				$("#listIdNo").append($listId);
				$("#hiddenNo").append($hidden);
				$("#userNameNo").append($userName);
				$("#hiddenNameNo").append($userName);
				$("#listNo").append($list);
				$("#penaltyNameNo").append($penaltyName);
				$('#noModal').toggleClass('is-active')
			},
			error:function() {
				alert("실패");
			}
		});
	});
</script>
</html>