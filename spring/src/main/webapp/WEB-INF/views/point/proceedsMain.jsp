<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#rebateTB *, #proceedsTB *{
		text-align:center;
	}
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
	#rebateTB a, #proceedsTB a{
		height:20px;
		border-radius:5px;
	}
	#proceedsTB a:hover{
		background:white;
		color:purple;
		border-radius:5px;
		border:1px solid purple;
	}
	#rebateArea tbody *:hover,#proceedsArea tbody *:hover{
		background:#ededff;
		color:#adadff;
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
	#proceedsLink{
		background:#2068ee;
		height:20px;
		line-height:50%;
		border-radius:5px;
	}
	#requsetLink{
		height:20px;
		line-height:50%;
		border-radius:5px;
	}
	
</style>
</head>
<body>
	<c:if test="${ empty sessionScope.loginUser }">
	<jsp:include page="../common/mainNav.jsp"/>
		<div class="columns is-mobile">
			<div class="column">
				<section class="section" id="headerSection">
				</section>
				<section>
					<h1 align="center" style="color:#FF5733;"><c:out value="로그인이 필요한 서비스입니다."/></h1>
					<a href="javascript:history.back()" id="noLoginBtn">뒤로가기</a>
				</section>
			</div>
		</div>
		
	</c:if>
	<c:if test="${ !empty sessionScope.loginUser }">
		<div id="pt"></div>
		<jsp:include page="../common/mainNav.jsp"/>
		<div class="columns is-mobile">
			<div class="column">
				<section class="section" id="headerSection">
					<jsp:include page="../common/myPageHeader.jsp" />
					<jsp:include page="pointNav.jsp"/>				
				</section>
				<section class="tableSection">
				    <div class="container" style="width:95%;height:100%;border:1px solid #ccccff">
				    	<table style="width:30%;">
				  			<tr>
				  				<td><a class="button is-primary is-outlined" style="height:20px;" href="#">환급신청내역 바로가기</a></td>
				  				<td><a class="button is-primary is-outlined" style="height:20px;" href="#proceedsArea">수익금내역 바로가기</a></td>
				  			</tr>
					  	</table>
					  	<div id="rebateArea">
					  		<div id="rebateTop">
					  			<div id="rebateTitle" style="color:purple; font-size:28px;margin-top:3%;">
					    			수익금 환급신청 내역
				    			</div>
						        <div style="float:right;">
						        	<c:if test ="${ sessionScope.loginUser.accCode eq null}" >
						        		<a class="button is-danger is-outlined" id="toAccount"href="showConfirmAcc.me" 
						              		 onclick="window.open(this.href, '_blank', 'width=800px, height=280px, toolbars=no, scrollbars=no'); return false;">계좌인증하기</a>
					              	</c:if>
						            <c:set var="standard" value="30000"/>
						            <c:if test ="${ sessionScope.loginUser.accCode ne null}" >
						            	<c:if test="${ sessionScope.loginUser.userProceeds ge 30000}">
								        	<a class="button is-danger is-outlined" id="toRebate"onclick="$('#myModal').toggleClass('is-active')">환급신청 하기</a>
						            	</c:if>
						            </c:if>
						  			<div class="select" style="display:inline-block;float:right;margin-bottom:4px;">
							            <select name="rebateSelect" id="rebateSelect">
											<option value="defaultOption">--월--</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
							            </select>
							        </div>
						        </div>
						        <div id="rebateTB">
					    		<table class="table is-narrow" align="center" style="width:100%;">
								    <thead style="background:skyblue;">
								      <tr>
								        <th> No </th>
								        <th> 환급신청일 </th>
								        <th> 환급신청액 </th>
								        <th> 환급지급상태 </th>
								      </tr>
								    </thead>
								    <tbody id="rebateTBody">
								      
								    </tbody>
							  	</table>
					    	</div>
					    	<div align="center" class="rebatePagingArea">
					    	</div>
					    		<a style="height:20px;color:purple;margin-left:90%;" href="#pt"><i class='fas fa-chevron-circle-up' style='font-size:36px'></i></a>
					  		</div>
					  	</div>
					  	
					  	
					  	
					  	
					 	<div id="proceedsArea" style="border-top:1px solid lightgray">
					 		<div id="proceedsTop">
					 			<div id="proceedsTitle" style="color:purple; font-size:28px;margin-top:3%;">
					    			수익금 달성 내역
				    			</div>
					 			<div class="select" style="display:inline-block;float:right;margin-bottom:4px;">
						            <select name="proccedsSelect" id="proceedsSelect">
						            	<option value="defaultOption">--월--</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
						            </select>
						        </div>
					 		</div>
					 		<div id="proceedsTB">
					 			<table class="table is-narrow" align="center" style="width:100%;">
								    <thead style="background:skyblue;">
								      <tr>
								        <th> No </th>
								        <th> 달성일 </th>
								        <th> 달성 수익금 </th>
								        <th> 달성 게시글 </th>
								      </tr>
								    </thead>
								    <tbody id="proceedsTBody">
								     
								    </tbody>
							  </table>
							</div>
							<div align="center" class="proceedsPagingArea">
				    		</div>
				    		<a style="height:20px;color:purple;margin-left:90%;" href="#pt"><i class='fas fa-chevron-circle-up' style='font-size:36px'></i></a>
					 		</div>
					  	</div>
			    </section>
			    <section class="section" id="modal">
					<div class="modal" id="myModal">
						<div class="modal-background"></div>
						<div class="modal-card">
							<header class="modal-card-head">
								<p class="modal-card-title">환급 하시겠습니까?</p>
								<button class="delete" id="del"></button>
							</header>
							<section class="modal-card-body">
								금액 입력 : <input id="payAmount" type="number" style="width:80%;" min="10000" step="10000" placeholder="10000원 단위로 신청가능합니다.">
								<input type="hidden" value="${sessionScope.loginUser.memberId}">
							</section>
							<footer class="modal-card-foot">
								<div style="margin-left:auto;margin-right:auto;">
									<a class="button is-success yes" id="toApply" style="border-radius:5px; height:25px;width:60px;"> 예 </a>
									<a class="button is-danger no" style="border-radius:5px; height:25px;"> 아니요 </a>
								</div>
							</footer>
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
	<script type="text/javascript">
		$(function() {
			var memberId = $("#member").val();
			//console.log(memberId);
			var currentpage = 1;
			var month = 0;
			total(memberId, currentpage, month);//전체 페이지 생성해주는 함수
			//환급신청 월검색 시
			$("#rebateSelect").change(function(){
				var month = $(this).children('option:selected').val();
				var memberId = $("#member").val();
				var currentPage = 1;
				if(month!='defaultOption'){
					//console.log("month : " + month );
					var condition = 1;
					oneRebate(memberId, month, condition, currentPage);
				}
			});
			//수익 달성 월검색 시
			$("#proceedsSelect").change(function(){
				var month = $(this).children('option:selected').val();
				var memberId = $("#member").val();
				var currentPage = 1;
				if(month!='defaultOption'){
					//console.log("month : " + month );
					var condition = 2;
					oneProcceds(memberId, month, condition, currentPage);
				}
			});
		});
		//해당 글 바로가기//설계글 제외
		$("body").on("click", "#proceedsLink",function(){
			//var mid = $(this).children().eq(0).val();
			var bid = $(this).children().eq(1).val();
			var url = "oneBoard.po?bid="+bid;
			window.open(url, "oneBoard", "width=1000,height=700");
		});
		//해당 설계글 바로가기
		$("body").on("click", "#requsetLink",function(){
			var mid = $(this).children().eq(0).val();
			var bid = $(this).children().eq(1).val();
			var url = "oneBoardRequest.po?bid="+bid;
			window.open(url, "oneBoard", "width=1000,height=700");
		});
		//환급신청 모달에서 yes를 눌렀을 경우
		$("body").on("click", "#toApply",function(){
			var payAmountStr = $(this).parent().parent().parent().children().eq(1).children().eq(0).val();
			var memberId =$(this).parent().parent().parent().children().eq(1).children().eq(1).val();
			var payAmount = Number(payAmountStr);
			if(payAmount % 10000 != 0){
				//10000원 단위만 환급되게 막기
				$('#myModal').removeClass('is-active');
				$('#modalHeader2').text('10000원 단위만 환급신청이 가능합니다.');
				$("#myModal2").toggleClass('is-active');
				$("#okay").click(function(){
					$('#myModal2').removeClass('is-active');
				});
			}else{
				//10000원 단위일 경우 
				var userProceedsString = $("#userProceeds").text();
				var userProceedsStr =  userProceedsString.replace(/[^0-9]/g,"");
				var proceeds = Number(userProceedsStr);
				//console.log(payAmount);
				//console.log(proceeds);
				
				if(payAmount >= proceeds){
					//총 수익금과 환급신청액 비교
					$('#myModal').removeClass('is-active');
					$('#modalHeader2').text('현재 총 수익금이 모자릅니다.');
					$("#myModal2").toggleClass('is-active');
					$("#okay").click(function(){
						$('#myModal2').removeClass('is-active');
					});
				}else if(payAmount < proceeds){
					//총 수익금과 환급신청액 비교
					if(proceeds<30000){
						//총수익금이 30000원 미만이면 신청불가 
						$('#myModal').removeClass('is-active');
    					$('#modalHeader2').text('총 수익금이 30000원 이상이어야 환급신청이 가능합니다.');
    					$("#myModal2").toggleClass('is-active');
    					$("#okay").click(function(){
    						$('#myModal2').removeClass('is-active');
    					});
					}else{
						//총수익금이 30000원 이상이면 신청 가능
						$('#myModal').removeClass('is-active');
    					$('#modalHeader2').text('환급 신청한 내역이 관리자에게 전달 되었습니다.').append('<p>정산은 매월 15일에 이뤄집니다.</p>');
    					$("#myModal2").toggleClass('is-active');
    					$("#okay").click(function(){
    						//확인을 눌렀을 때 환급 신청 매핑으로 간다.
    						//환급 신청 내역에 인서트가 된다.
    						$('#myModal2').removeClass('is-active');
	    					location.href="rebateProceeds.po?memberId="+memberId+"&payAmount="+payAmount;
    					});
					}
				}
			}
			$("#payAmount").val("");//환급신청액 입력란을 비어줘야 한다.
		});
		//모달 닫기
		$('.modal-background, .modal-close').click(function() {
			$(this).parent().removeClass('is-active');
		});
		//모달 닫기
		$("#del").click(function(){
			$(this).parent().parent().parent().removeClass('is-active');
		});
		//환급신청시 아니오를 클릭했을 경우
		$(".no").click(function(){
			$("#payAmount").val("");
			$('#myModal').removeClass('is-active');
			$('#modalHeader2').text('환급신청을 취소하셨습니다.');
			$("#myModal2").toggleClass('is-active');
			$("#okay").click(function(){
				$('#myModal2').removeClass('is-active');
			});
		});
		//전체 페이지 에이작스 함수
		function total(memberId, currentpage, month){
			//controller에서도 condition 보내줘야 함
			//paging으로 연결
			//월검색 에이작스 만들고 그것도 테이블 생성하는 함수로 condition 20으로 보내주기
			var condition = 99;
			$.ajax({
				//수익금 달성 내역 조회 에이작스를 먼저 호출
				url:"allProceeds.po",
				type:"post",
				data:{memberId:memberId, currentpage:currentpage, month:month},
				success:function(data){
					makeProceedsTB(data.proPi, data.proceedsList, condition, month);//수익금 달성 내역 테이블 생성
					//console.log(data);
					$.ajax({
						//환급 신청 내역 조회 에이작스를 호출
						url:"allRebate.po",
						type:"post",
						data:{memberId:memberId, currentpage:currentpage, month:month},
						success:function(data){
							makeRebateTB(data.rebatePi, data.rebateList, condition, month);//환급 신청 내역 테이블 생성
							//console.log(data);
						},
						error:function(data){
							console.log('rebate main error');
						}
					});
				},
				error:function(data){
					console.log('proceeds main error');
				}
			});
		};
		//수익금 달성 테이블 생성
		function makeProceedsTB(proPi, proceedsList, condition, month){
			//console.log(proPi);
			//console.log(proceedsList);
			
			//console.log(month);
			$("#proceedsTBody").empty();
			
			var len = proceedsList.length;
			var memberId;
			//console.log(len);
			for(var i=0 ; i<len ; i++){
				var list = proceedsList[i];
				var proceeds = list.proceeds;
				memberId = list.memberId;
				if(proceeds>=30000){//수익 달성액이 30000점 이상인 글만 보여주기 위한 조건
					//console.log(list);
					var pi = proPi;
					//console.log(pi);
					
					var $listTr = $("<tr>");
					var $noTd = $("<td width='10px'>").text(i+1);//1,2,3,4,5...
					
					var date = new Date(list.proceedsDate);
					date = getFormatDate(date);
					var $proceedsDateTd = $("<td>").text(date);//수익금 달성 날짜 
					
					
					proceeds = comma(proceeds);
					var $proceedsTd = $("<td>").text(proceeds);//수익 달성액
					
					var $boardTd =$("<td>");
					var mid, bid, $proceedsIn, $proceedsBtn, $proceedsMidIn, $proceedsBidIn; 
					mid = list.memberId;
					if(list.trvId != 0){
						bid = list.trvId;
						console.log(bid);
						
						$proceedsIn = $('<input type="text">').val(list.trvId);//수익 달성 게시글 보기를 위한 여행일정번호
						//data-mid='+mid+'
						$proceedsBtn = $('<button id="proceedsLink" class="button is-info" data-bid='+bid+'data-tooltip="해당 글 보러가기" target="_blank">판매된 일정</button>');//게시글 보러가기
						
						$proceedsMidIn = $('<input type="hidden">').val(mid);//회원 번호
						$proceedsBidIn = $('<input type="hidden">').val(bid);//게시글번호
						
						$proceedsBtn.append($proceedsMidIn);
						$proceedsBtn.append($proceedsBidIn);
						
						$boardTd.append($proceedsIn);
						$boardTd.append($proceedsBtn);
					}else{
						bid = list.ptcpId;
						console.log(bid);
						
						$proceedsIn = $('<input type="text">').val(list.ptcpId);//수익 달성 게시글 보기를 위한 참여번호
						//data-mid='+mid+'
						$proceedsBtn = $('<button id="requsetLink" class="button is-success" data-bid='+bid+' data-tooltip="해당 글 보러가기" target="_blank">채택된 설계</button>');
						
						$proceedsMidIn = $('<input type="hidden">').val(mid);//회원번호
						$proceedsBidIn = $('<input type="hidden">').val(bid);//게시글 번호
						
						$proceedsBtn.append($proceedsMidIn);
						$proceedsBtn.append($proceedsBidIn);
						
						$boardTd.append($proceedsIn);
						$boardTd.append($proceedsBtn);
					}
					$listTr.append($noTd);
					$listTr.append($proceedsDateTd);
					$listTr.append($proceedsTd);
					$listTr.append($boardTd);
					
					$("#proceedsTBody").append($listTr);
				}
				pagingProceeds(pi, condition, memberId, month);
			}
		};
		//환급 신청 테이블 생성
		function makeRebateTB(rebatePi, rebateList, condition, month){
			//console.log(proPi);
			//console.log(proceedsList);
			//console.log(month);
			$("#rebateTBody").empty();
			var len = rebateList.length;
			var memberId;
			//console.log(len);
			for(var i=0 ; i<len ; i++){
				var list = rebateList[i];
				//console.log(list);
				var pi = rebatePi;
				//console.log(pi);
				memberId = list.memberId;
				var $listTr = $("<tr>");
				var $noTd = $("<td width='10px'>").text(i+1);//1,2,3,4,5,...
				var date = new Date(list.applyDate);
				date = getFormatDate(date);
				var $rebateDateTd = $("<td>").text(date);//환급신청일
				
				var payDate = new Date(list.payDate);//환급지급일
				payDate = getFormatDate(payDate);
				
				var rebate = list.payAmount;
				rebate = comma(rebate);
				var $rebateTd = $("<td>").text(rebate);//환급신청액
				
				var $statusTd =$("<td>");
				var mid, $rebateIn, $rebateBtn, $rebateMidIn, $rebateBidIn; 
				mid = list.memberId;//회원번호
				if(list.rebateStatus == 10){
					//미지급
					$rebateIn = $('<input type="hidden">').val(list.rebateId);//환급신청번호
					
					$rebateBtn = $('<button class="button is-warning" style="height:20px;line-height:60%;border-radius:5px;">지급 대기</button>');
					
					$statusTd.append($rebateIn);
					$statusTd.append($rebateBtn);
				}else if(list.rebateStatus == 20){
					//지급완료시 지급일도 표기
					$rebateIn = $('<input type="hidden">').val(list.rebateId);//환급신청번호
					
					$rebateBtn = $('<button class="button is-success" style="height:20px;line-height:60%;border-radius:5px;">지급 완료 '+payDate+'</button>');
					
					$statusTd.append($rebateIn);
					$statusTd.append($rebateBtn);
				}
				$listTr.append($noTd);
				$listTr.append($rebateDateTd);
				$listTr.append($rebateTd);
				$listTr.append($statusTd);
				
				$("#rebateTBody").append($listTr);
			}
			pagingRebate(pi, condition, memberId, month);
		};
		function oneRebate(memberId, month, condition, currentPage){
			//환급신청 월검색 페이징하기
			$.ajax({
				url:"oneMonthRebate.po",
				type:"post",
				data:{memberId:memberId, currentPage:currentPage, month:month},
				success:function(data){
					console.log(data);
					makeRebateTB(data.rebatePi, data.rebateList, condition, month);
				},
				error:function(data){
					console.log('환급신청 에이작스 에러');
				}
			});
		};
		function oneProcceds(memberId, month, condition, currentPage){
			//수익달성 월검색 페이징하기
			$.ajax({
				url:"oneMonthProceeds.po",
				type:"post",
				data:{memberId:memberId, currentPage:currentPage, month:month},
				success:function(data){
					console.log(data);
					makeProceedsTB(data.proPi, data.proceedsList, condition, month);
				},
				error:function(data){
					console.log('환급신청 에이작스 에러');
				}
			});
		};
		//환급 신청 페이징처리
		function pagingRebate(pi, condition, memberId, month){
			//console.log(pi);
			var $page = $(".rebatePagingArea");
			
			var currentPage = pi.currentPage;
			var limit = pi.limit;
			var maxPage = pi.maxPage;
			var startPage = pi.startPage;
			var endPage = pi.endPage;
			
			$page.empty();
			
			$page.append($("<button>").attr("class", "pagingBtn").text(" << ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){//그냥
					total(memberId, 1, month);
				}else{
					oneRebate(memberId, month, condition, 1)//검색했을 때
				}
			}));
			
			if(currentPage <= 1){
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" < ").css({"cursor":"pointer"}));
			}else{
				$page.append($("<button>").attr("class", "pagingBtn").text("<").click(function(){
					if(condition == 99){//그냥
						total(memberId, currentPage-1, month);
					}else{
						oneRebate(memberId, month, condition, currentPage-1)//검색했을 때
					}
              }));
			}
			for(var p=startPage ; p<=endPage ; p++){
				if(p == currentPage){
					$page.append($("<button>").attr("class", "pagingBtn").text(p).attr("disabled",true).css({"cursor":"pointer"}));
				}else{ 
					$page.append($("<button>").attr("class", "pagingBtn").text(p).css({"cursor":"pointer"}).click(function(){
						if(condition == 99){//그냥
							total(memberId, $(this).text(), month);
						}else{
							oneRebate(memberId, month, condition, $(this).text())//검색했을 때
						}
					}));
				}
			}
			if(currentPage >= maxPage){ 
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}));         
            }else {
            	$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}).click(function(){
            		if(condition == 99){//그냥
            			total(memberId, currentPage + 1, month);
					}else{
						oneRebate(memberId, month, condition, currentPage + 1)//검색했을 때
					}
            	}));
            } 
			$page.append($("<button>").attr("class", "pagingBtn").text(" >> ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){//그냥
					total(memberId, maxPage, month);
				}else{
					oneRebate(memberId, month, condition, maxPage)//검색했을 때
				}
            }));
		};
		//수익달성 페이징처리
		function pagingProceeds(pi, condition, memberId, month){
			//console.log(pi);
			var $page = $(".proceedsPagingArea");
			
			var currentPage = pi.currentPage;
			var limit = pi.limit;
			var maxPage = pi.maxPage;
			var startPage = pi.startPage;
			var endPage = pi.endPage;
			
			$page.empty();
			
			$page.append($("<button>").attr("class", "pagingBtn").text(" << ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){//그냥
					total(memberId, 1, month);
				}else{
					oneProcceds(memberId, month, condition, 1);
				}
			}));
			
			if(currentPage <= 1){
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" < ").css({"cursor":"pointer"}));
			}else{
				$page.append($("<button>").attr("class", "pagingBtn").text("<").click(function(){
					if(condition == 99){//그냥
						total(memberId, currentPage-1, month);
					}else{
						oneProcceds(memberId, month, condition, currentPage-1);
					}
              }));
			}
			for(var p=startPage ; p<=endPage ; p++){
				if(p == currentPage){
					$page.append($("<button>").attr("class", "pagingBtn").text(p).attr("disabled",true).css({"cursor":"pointer"}));
				}else{ 
					$page.append($("<button>").attr("class", "pagingBtn").text(p).css({"cursor":"pointer"}).click(function(){
						if(condition == 99){//그냥
							total(memberId, $(this).text(), month);
						}else{
							oneProcceds(memberId, month, condition, $(this).text());
						}
					}));
				}
			}
			if(currentPage >= maxPage){ 
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}));         
            }else {
            	$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}).click(function(){
            		if(condition == 99){//그냥
    					total(memberId, currentPage + 1, month);
    				}else{
    					oneProcceds(memberId, month, condition, currentPage + 1);
    				}
            	}));
            } 
			$page.append($("<button>").attr("class", "pagingBtn").text(" >> ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){//그냥
					total(memberId, maxPage, month);
				}else{
					oneProcceds(memberId, month, condition, maxPage);
				}
            }));
		};
		//날짜 폼을 위한 함수
		function getFormatDate(date){ 
			//console.log(date);
			//console.log(typeof(date));
			var year = date.getFullYear()+'';	//yyyy 
			year = year.substring( 2, 4 );
			var month = (1 + date.getMonth());	//M 
			month = month >= 10 ? month : '0' + month;	//month 두자리로 저장 
			var day = date.getDate();	//d
			day = day >= 10 ? day : '0' + day;	//day 두자리로 저장
			var hour = date.getHours();
			hour = hour >=10 ? hour : '0' + hour;
			var minu = date.getMinutes();
			minu = minu >=10 ? minu : '0' + minu;
			return year + '/' + month + '/' + day + '	' + hour + ':' + minu; 
		};
		//숫자 폼을 위한 함수
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
	</script>
</body>
</html>