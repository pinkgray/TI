<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<style>
	.pageingBtn{
		width:30px;
		height:22px;
		background:white;
		color:purple;
		border:1px solid purple;
		border-radius:5px;
	}
	.pageingBtn:hover{
		background:purple;
		color:white;
	}
	#memberListTB *{
		text-align:center;
	}
	.section {
		width:90% !important;
		margin:0 auto;
		min-height:768px;
	}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp"/>
	<div class="columns">
		<div class="column">
			<section class="section">
				<div class="field">
					<h3 class="subtitle is-3" style="color:#209cee;"> 회원관리 </h3>
				</div>
				
				<!-- member condition search -->
				<div class="field is-horizontal">
					<div class="field-body">
						<!-- condition button area 1 -->
						<div class="field buttons">
							<a class="button is-primary" href="adminMemberListForm.me?currentPage=1&status=ALL"> 전체회원 </a>
							<a class="button is-primary" href="adminMemberListForm.me?currentPage=1&status=Y"> 가입회원 </a>
							<a class="button is-primary" href="adminMemberListForm.me?currentPage=1&status=N"> 탈퇴회원 </a>
						</div> <!-- end condition button area 1 -->
						
						<!-- condition keyword -->
						<div class="field has-addons" style="justify-content: flex-end;">
					      <p class="control">
					        <span class="select">
					          <select name="condition" id="condition">
					            <option value="name">이름</option>
					            <option value="email">이메일</option>
					            <option value="phone">연락처</option>
					          </select>
					       </span>
					      </p>
					      <p class="control">
					        <input class="input" type="text" placeholder="Search Member" name="conditionValue" id="conditionValue">
					      </p>
					      <p class="control">
					        <a class="button" id="conditionBtn"><i class="fas fa-search"></i></a>
					      </p>
					    </div>
					</div><!-- end condition keyword -->
				</div> <!-- end member condition search -->
				
				<!-- page forward btn -->
				<div class="field is-horizontal">
					<div class="field-body">
						<label class="label">전체회원 수 : ${ listCount } 명</label>
						<!-- <div class="field is-grouped" style="justify-content: flex-end;">
							<div class="field-label is-normal">
					          <label class="label">상세보기</label>
					        </div>
					        <div class="buttons">
					        	<a class="button is-rounded" style="background-color:yellow; border-color:yellow;">게시글 내역</a>
					        	<a class="button is-info is-rounded"
					        		onclick="forwardPointPage();">결제 내역</a>
					        	<a class="button is-danger is-rounded">신고 내역</a>
					        	<a class="button is-link is-rounded">문의 내역</a>
					        </div>
				        </div> -->
					</div>
				</div><!-- end page forward brn -->
				
				<!-- member list -->
				<div class="field">
					<table id="memberListTB" class="table is-narrow"style="width:100%;height:100%; margin:0 auto;" >
						<thead>
							<tr style="background:#ccccff;">
								<th width="5%"> No. </th>
								<th width="10%"> 이름 </th>
								<th width="10%"> 이메일 </th>
								<th width="10%"> 연락처 </th>
								<th width="10%"> 생년월일 </th>
								<th width="10%"> 성별 </th>
								<th width="10%"> 가입일 </th>
								<th width="10%"> 탈퇴일 </th>
								<th width="10%"> 가입여부 </th>
							</tr>
						</thead>
						<!-- member list -->
						<tbody>
							<c:forEach var="member" items="${ mList }">
								<tr onclick="trClick(this);">
									<td>${ member.memberId }</td>
									<td>${ member.userName }</td>
									<td>${ member.email }</td>
									<td>${ member.phone }</td>
									<td>${ member.birthday }</td>
									<c:choose>
										<c:when test="${ member.gender == 'M' }">
											<td>남</td>
										</c:when>
										<c:otherwise>
											<td>여</td>
										</c:otherwise>
									</c:choose>
									<td>${ member.enrollDate }</td>
									<td>${ member.secessionDate }</td>
									<td>${ member.enrollStatus }</td>
								</tr>
							</c:forEach>
						</tbody> <!-- end member list -->
						
					</table>
				</div> <!-- end member list -->
				
				<!-- paging -->
				<div class="field" >
					<nav class="pagination">
				  	<ul class="pagination-list" style="justify-content: center;">
				  		
				  		<!-- 이전 -->
				  		<c:if test="${ pi.currentPage <= 1 }"> 
				  			<li><button class="pageingBtn" style="border-color: gray;"> < </button></li>
				  		</c:if>
				  		<c:if test="${ pi.currentPage > 1 }">
				  			<c:url var="mListBack" value="adminMemberListForm.me">
				  				<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
				  				<c:param name="status" value="${ status }"/>
				  			</c:url>
				  			<li><button class="pageingBtn" onclick="location.href='${ mListBack }'"> < </button></li>
				  		</c:if><!-- end 이전 -->
				  		
				  		<!-- page number -->
				  		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				  			<c:if test="${ p eq pi.currentPage }">
				  				<li><button class="pageingBtn" style="border-color: gray;"> ${ p } </button></li>
				  			</c:if>
				  			<c:if test="${ p ne pi.currentPage }">
				  				<c:url var="mListCheck" value="adminMemberListForm.me">
				  					<c:param name="currentPage" value="${ p }"/>
				  					<c:param name="status" value="${ status }"/>
				  				</c:url>
				  				<li><button class="pageingBtn" onclick="location.href='${ mListCheck }'"> ${ p } </button></li>
				  			</c:if>
				  		</c:forEach> <!-- end page number -->
				  		
				  		<!-- 다음 -->
				  		<c:if test="${ pi.currentPage >= pi.maxPage }">
				  			<li><button class="pageingBtn" style="border-color: gray;"> > </button></li>
				  		</c:if>
				  		<c:if test="${ pi.currentPage < pi.maxPage }">
				  			<c:url var="mListEnd" value="adminMemberListForm.me">
				  				<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
				  				<c:param name="status" value="${ status }"/>
				  			</c:url>
				  			<li><button class="pageingBtn" onclick="location.href='${ mListEnd }'"> > </button></li>
				  		</c:if> <!-- end 다음 -->

				  	</ul>
				  </nav>
				</div> <!-- end paging -->
				
			</section> <!-- end section -->
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<!-- script -->
	<script>
	
		var userNameTr = "";
		//검색 조회용 함수
		$(function(){		
			$("#conditionBtn").click(function(){
			 	var condition = $("#condition").val();
			 	var conditionValue = $("#conditionValue").val();
				location.href = "selectCondition.me?condition=" + condition +
								 "&conditionValue=" + conditionValue;
			});
			var nav = $(".navbar-item").eq(1);
		    nav.css("background", "#118fe4");
		    nav.siblings().css("background", "rgb(32, 156, 238)");
		});
		
		//tr 클릭시 사용자 정보 저장
		function trClick(tr){
			userNameTr = $(tr).children().eq(1).text();
			console.log(userNameTr);
		}
		
		//사용자 결제내역 페이지로 이동
		function forwardPointPage(){
			if(userNameTr != null && userNameTr != "" && userNameTr != " "){
				location.href = "seacrchAdPay.po?" +
				"userName=" + userNameTr + 
				"&startDate=1999-01-01&endDate=2030-12-30" +
				"&condition=10&currentPage=1";
			} else {
				alert("먼저 회원을 선택해 주세요.")
			}			
		}
	</script>
</body>
</html>