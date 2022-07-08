<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.pagingBtn{
		width:30px;
		height:22px;
		background:white;
		color:purple;
		border:1px solid purple;
		border-radius:5px;
	}
	.pagingBtn:hover{
		background:purple;
		color:white;
	}
	#aPointTB *{
		text-align:center;
	}
	#aPointTB tbody *:hover{
		background:#ededff;
		color:#8484ff;
		font-weight:bold;
	}
	#noLoginBtn{
		background:#FFBD33;
		color:white;
		text-decoration:none;
		font-size:30px;
		border-radius:10px;
		margin-left:70%;
		border:3px solid #FF5733;
		padding:5px 10px 5px 10px;
	}
	#noLoginBtn:hover{
		background:#FFE09F;
		color:#FF5733;
	}
</style>
</head>
<body>
	<c:if test="${ empty sessionScope.loginUser || sessionScope.loginUser.memberId != 1}">
	<jsp:include page="../../common/adminMainNav.jsp"/>
		<div class="columns is-mobile">
			<div class="column">
				<section class="section" id="headerSection">
				</section>
				<section>
					<h1 align="center" style="color:#FF5733;"><c:out value="관리자만 접근 가능합니다."/></h1>
					<a href="javascript:history.back()" id="noLoginBtn">뒤로가기</a>
				</section>
			</div>
		</div>
	</c:if>
	<c:if test="${ !empty sessionScope.loginUser && sessionScope.loginUser.memberId == 1}">
		<jsp:include page="../../common/adminMainNav.jsp"/>
		<div class="columns is-mobile">
			<div class="column">
				<section class="section" id="headerSection" style="margin-bottom:-60px;">
					<jsp:include page="aPointNav.jsp"/>				
				</section>
				<section class="section">
					<div class="container" style="width:90%;height:100%;">
						<div style="width:100%;font-size:25px;color:#209cee;">포인트 내역</div>
			         <div style="width:100%;height:100%;">
			         	<div>
			         		<div class="field has-addons" style="float:right;">
								<p class="control">
									<input type="checkbox" style="display:inline-block;float:left;" id="searchNameCheck" name="searchNameCheck">
									<p style="width:100px;display:inline-block;"><label for="searchNameCheck">이름 검색하기</label></p>
									<input class="input" type="text" placeholder="회원 이름을 검색하세요" style="width:150px;height:20px;display:none" id="nameArea">
								</p>
								<p class="control" id="search" style="margin-left:1%;display:inline-block;float:right;">
									<a class="button is-primary" style="width:60px;height:20px;">
										<i class='fas fa-search' style='font-size:15px'></i>검색
									</a>
								</p>
								<a class="button is-primary is-outlined" style="width:120px;height:20px;margin-left:2%;" href="toAdRefundView.po">환불내역 보러가기</a>
							</div>
						</div>
			         	<div style="width:100%;height:25px;"></div>
			         </div>
			         <div style="width:100%;height:100%;" id="aPointArea">
						<table id="aPointTB" class="table is-narrow" align="center"style="width:100%;height:100%;" >
							<thead>
								<tr style="background:#ccccff;">
									<th width="5%"> No. </th>
									<th width="15%"> 이름 </th>
									<th width="15%"> 이메일 </th>
									<th width="30%"> 총 포인트 </th>
									<th width="30%"> 총 수익금 </th>
								</tr>
							</thead>
							<tbody id="aPointTBody">
							</tbody>
						</table>
			         </div>
						
					<div align="center" class="pagingBtnArea" style="margin-top:3%;">
					
					</div>
					</div>
				</section>
				<section class="section" id="modal2">
						<div class="modal" id="myModal2">
							<div class="modal-background" id="back2"></div>
							<div class="modal-card">
								<header class="modal-card-head">
									<p class="modal-card-title" id="modalHeader2" style="font-size:15px;text-align:center"></p>
									<button class="delete" id="del2"></button>
								</header>
								<footer class="modal-card-foot">
									<div style="margin-left:auto;margin-right:auto;">
										<a class="button is-success" style="border-radius:5px; height:25px;width:60px;" id="okay"> 확인 </a>
									</div>
								</footer>
							</div>
						</div>
					</section>
			</div>
		</div>
	</c:if>
	<script>
		$(function(){
			var nav = $(".navbar-item").eq(10);
			   nav.css("background", "#118fe4");
			   nav.siblings().css("background", "rgb(32, 156, 238)");
			$(".apointPo").parent().addClass('is-active');
			$(".apointPo").children().css({"color":"#209cee"});
			$("#searchNameCheck").change(function(){
				if($("#searchNameCheck").is(":checked")){
					$("#nameArea").css({"display":"inline-block"});
				}else{
					$("#nameArea").css({"display":"none"});
				}
			});
			var currentPage = 1;
			var memberId = ${sessionScope.loginUser.memberId};
			total(currentPage, memberId);//전체 내역 테이블 생성 에이작스 함수 호출
			//모달 닫기
			$("#back2, #del2").click(function(){
				$('#myModal2').removeClass('is-active');
			});
		});
		//전체 내역 테이블 생성 에이작스 함수
		function total(currentPage, memberId){
			var condition = 99;
			$.ajax({
				url:"allAdPoint.po",
				type:"post",
				data:{memberId:memberId,currentPage:currentPage},
				success:function(data){
					//console.log('success');
					makePointTB(data.adPointList, data.adPointPi, condition);
				},
				error:function(data){
					console.log('error');
				}
			});
		}
		//테이블 생성 함수
		function makePointTB(adPointList, adPointPi, condition){
			//console.log(condition);
			$("#aPointTBody").empty();
			var len = adPointList.length;
			
			/* <th width="5%"> No. </th>
				<th width="15%"> 이름 </th>
				<th width="15%"> 이메일 </th>
				<th width="30%"> 총 포인트 </th>
				<th width="30%"> 총 수익금 </th> */
			for(var i=0 ; i<len ; i++){
				var list = adPointList[i];
				var pi = adPointPi;

				var $listTr = $("<tr>");
				
				var $noTd = $("<td>").text(i+1);
				
				var $userNameTd = $("<td>").text(list.userName);
				var $emailTd = $("<td>").text(list.email);
				
				var userPoint = comma(list.userPoint);
				var $userPointTd = $("<td>").text(userPoint);
				var userProceeds = comma(list.userProceeds);
				var $userProceedsTd = $("<td>").text(userProceeds);
				
				$listTr.append($noTd);
				$listTr.append($userNameTd);
				$listTr.append($emailTd);
				$listTr.append($userPointTd);
				$listTr.append($userProceedsTd);
				
				$("#aPointTBody").append($listTr);
				paging(pi, condition);
			}
		};
		//페이징 처리 함수
		function paging(pi, condition){
			//console.log(pi);
			var memberId = ${sessionScope.loginUser.memberId};
			var $page = $(".pagingBtnArea");
			
			var currentPage = pi.currentPage;
			var limit = pi.limit;
			var maxPage = pi.maxPage;
			var startPage = pi.startPage;
			var endPage = pi.endPage;
			
			$page.empty();
			
			$page.append($("<button>").attr("class", "pagingBtn").text(" << ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){
					total(1, memberId);
				}else{
					searchFunc(1, memberId);
				}
			}));
			
			if(currentPage <= 1){
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" < ").css({"cursor":"pointer"}));
			}else{
				$page.append($("<button>").attr("class", "pagingBtn").text("<").click(function(){
					if(condition == 99){
						total(currentPage-1, memberId);
					}else{
						searchFunc(currentPage-1, memberId);
					}
              }));
			}
			for(var p=startPage ; p<=endPage ; p++){
				if(p == currentPage){
					$page.append($("<button>").attr("class", "pagingBtn").text(p).attr("disabled",true).css({"cursor":"pointer"}));
				}else{ 
					$page.append($("<button>").attr("class", "pagingBtn").text(p).css({"cursor":"pointer"}).click(function(){
						if(condition == 99){
							total($(this).text(),memberId);
						}else{
							searchFunc($(this).text(),memberId);
						}
					}));
				}
			}
			if(currentPage >= maxPage){ 
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}));         
            }else {
            	$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}).click(function(){
            		if(condition == 99){
            			total(currentPage + 1, memberId);
					}else{
						searchFunc(currentPage + 1, memberId);
					}
            	}));
            } 
			$page.append($("<button>").attr("class", "pagingBtn").text(" >> ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){
					total(maxPage, memberId);
				}else{
					searchFunc(maxPage, memberId);
				}
            }));
		}
		//천 단위마다 콤마 
		function comma(num){
		    var len, point, str; 
		       
		    num = num + ""; 
		    point = num.length % 3 ;
		    len = num.length; 
		   
		    str = num.substring(0, point); 
		    while (point < len) { 
		        if (str != "") str += ","; 
		        str += num.substring(point, point + 3); 
		        point += 3; 
		    } 
		    return str;
		};
		//검색 버튼 눌렀을 때
		$("body").on("click", "#search", function(){
			var memberId = ${sessionScope.loginUser.memberId};
			searchFunc(1, memberId);//검색 에이작스 함수 호출
		});
		//검색 에이작스 함수
		function searchFunc(currentPage, memberId){
			var userName = $("#nameArea").val();
			//console.log(userName);
			var condition = 99;
			var status = 99;//정상일경우
			
			if($("#searchNameCheck").is(":checked")){
				condition = 10;//이름 검색일 경우 -> 에러
				if(userName ==""){
					status = 10;//이름이 비었을 경우 -> 에러
				}
			}
			if(condition ==99){
				status = 10;
			}
			if(status != 10){//에러가 아닐 경우
				$.ajax({
					url:"seacrchAdPoint.po",
					type:"post",
					data:{userName:userName, condition:condition, currentPage:currentPage},
					success:function(data){
						//console.log('success');	
						makePointTB(data.adPointList, data.adPointPi, condition);
					},
					error:function(data){
						console.log('error');
					}
				});
			}else{
				$('#myModal').removeClass('is-active');
				$('#modalHeader2').text('검색 조건을 입력해주세요');
				$("#myModal2").toggleClass('is-active');
				$("#okay").click(function(){
					$('#myModal2').removeClass('is-active');
				});
			}
		};
	</script>
</body>
</html>