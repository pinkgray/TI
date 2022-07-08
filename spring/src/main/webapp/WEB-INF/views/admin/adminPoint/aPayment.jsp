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
	#aPayTB *{
		text-align:center;
	}
	#aPayTB tbody *:hover{
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
			         <div style="width:100%;font-size:25px;color:#209cee;">결제내역</div>
			         <div style="width:100%;height:100%;">
			         	<div>
			         		<div class="field has-addons" style="float:right;">
								
								<p class="control">
									<input type="checkbox" style="display:inline-block;float:left;" id="searchNameCheck" name="searchNameCheck">
									<p style="width:100px;display:inline-block;"><label for="searchNameCheck">이름 검색하기</label></p>
									<input class="input" type="text" placeholder="회원 이름을 검색하세요" style="width:150px;height:20px;display:none" id="nameArea">
								</p>
								<div style="margin-left:1%;width: 120px;">
									<input type="checkbox" style="display:inline-block;float:left;" id="searchDateCheck">
									<p style="width:100px;display:inline-block;"><label for="searchDateCheck">기간 검색하기</label></p>
								</div>
								<div style="width:353px;display:none;" id="dateArea">
									<input id="startDate" type="date" class="input is-primary" style="width:140px;height:20px;margin-left:1%;" data-tooltip="검색시작날짜 : 입력을 안하시면 현재 날짜로 검색됩니다.">
									<i class='far fa-calendar-alt' style='font-size:20px;color:purple;margin-right:1%;'></i>~
									<input id="endDate" type="date" class="input is-primary" style="width:140px;height:20px;margin-left:1%;" data-tooltip="검색종료날짜 : 입력을 안하시면 현재 날짜로 검색됩니다.">
									<i class='far fa-calendar-alt' style='font-size:20px;color:purple;'></i>
								</div>
								<p class="control" id="search" style="margin-left:1%;display:inline-block;float:right;">
									<a class="button is-primary" style="width:60px;height:20px;">
										<i class='fas fa-search' style='font-size:15px'></i>검색
									</a>
								</p>
							</div>
						</div>
			         	<div style="width:100%;height:25px;margin-top:3%;"> </div>
			         </div>
			         <div style="width:100%;height:100%;" id="aPayArea">
						<table id="aPayTB" class="table is-narrow" align="center"style="width:100%;height:100%;" >
							<thead>
								<tr style="background:#ccccff;">
									<th width="10%"> No. </th>
									<th width="10%"> 이름 </th>
									<th width="20%"> 아이디 </th>
									<th width="20%"> 결제일 </th>
									<th width="20%"> 결제액 </th>
								</tr>
							</thead>
							<tbody id="aPayTBody">
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
		   
			$(".apointPay").parent().addClass('is-active');
			$(".apointPay").children().css({"color":"#209cee"});
			var memberId = ${sessionScope.loginUser.memberId};
			var currentPage = 1;
			total(currentPage, memberId);//전체 내역 테이블 생성 에이작스 함수 호출
			
			//체크 상태에 따라 인풋태그 보여주기
			$("#searchNameCheck").change(function(){
				if($("#searchNameCheck").is(":checked")){
					$("#nameArea").css({"display":"inline-block"});
				}else{
					$("#nameArea").css({"display":"none"});
				}
			});
			//체크 상태에 따라 인풋태그 보여주기
			$("#searchDateCheck").change(function(){
				if($("#searchDateCheck").is(":checked")){
					$("#dateArea").css({"display":"inline-block"});
				}else{
					$("#dateArea").css({"display":"none"});
				}
			});
			//모달 닫기
			$("#back2, #del2").click(function(){
				$('#myModal2').removeClass('is-active');
			});
				
		});
		$("body").on("click", "#search", function(){
			var memberId = ${sessionScope.loginUser.memberId};//검색 버튼 눌렀을 때
			searchFunc(1, memberId);//검색 에이작스 함수 호출
		});
		//검색 에이작스 함수
		function searchFunc(currentPage, memberId){
			var userName = $("#nameArea").val();
			//console.log(userName);
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			//console.log(startDate);
			//console.log(endDate);
			
			var condition = 99;
			
			var status = 99;
			
			if($("#searchNameCheck").is(":checked") && $("#searchDateCheck").is(":checked")){
				condition = 30;
				if(userName ==""){
					status = 10;
				}
			}else if($("#searchNameCheck").is(":checked")){
				condition = 10;
				if(userName ==""){
					status = 10;
				}
			}else if($("#searchDateCheck").is(":checked")){
				condition = 20;
			}
			
			if(condition ==99){
				status = 10;
			}
			
			//console.log("condition : " + condition);
			
			var dateStart;
			var dateEnd;
			
			if(startDate ==""){
				dateStart = new Date();
				//console.log("dateStart : "+dateStart);
			}else{
				dateStart = startDate;
				//console.log("dateStart : "+dateStart);
			}
			if(endDate ==""){
				dateEnd = new Date();
				//console.log("dateEnd : "+dateEnd);
			}else{
				dateEnd = endDate;
				//console.log("dateEnd : "+dateEnd);
			}
			
			var start = new Date(dateStart);
			var startMili = start.getTime();
			//console.log("startMili : "+startMili);
			
			var end = new Date(dateEnd);
			var endMili = end.getTime();
			//console.log("endMili : "+endMili);
			
			if(startMili <= endMili && status != 10){
				$.ajax({
					url:"seacrchAdPay.po",
					type:"post",
					data:{userName:userName, startDate:startDate, endDate:endDate, condition:condition, currentPage:currentPage},
					success:function(data){
						console.log('success');	
						makePayTB(data.adPayList, data.adPayPi, condition);
					},
					error:function(data){
						console.log('error');
					}
				});
			}else if(startMili > endMili){
				$('#myModal').removeClass('is-active');
				$('#modalHeader2').text('검색 시작날짜와 종료날짜의 폼은 맞춰주세요');
				$("#myModal2").toggleClass('is-active');
				$("#okay").click(function(){
					$('#myModal2').removeClass('is-active');
				});
			}else if(status ==10){
				$('#myModal').removeClass('is-active');
				$('#modalHeader2').text('검색 조건을 입력해주세요');
				$("#myModal2").toggleClass('is-active');
				$("#okay").click(function(){
					$('#myModal2').removeClass('is-active');
				});
			}
		};
		function total(currentPage, memberId){
			var condition = 99;
			$.ajax({
				url:"allAdPay.po",
				type:"post",
				data:{memberId:memberId,currentPage:currentPage},
				success:function(data){
					console.log('success');
					makePayTB(data.adPayList, data.adPayPi, condition);
				},
				error:function(data){
					console.log('error');
				}
			});
		}
		function makePayTB(adPayList, adPayPi, condition){
			console.log(condition);
			$("#aPayTBody").empty();
			var len = adPayList.length;
			
			/* <th width="10%"> No. </th>
			<th width="30%"> 닉네임 </th>
			<th width="30%"> 결제일 </th>
			<th width="30%"> 결제액 </th> */
			for(var i=0 ; i<len ; i++){
				var list = adPayList[i];
				var pi = adPayPi;

				var $listTr = $("<tr>");
				
				var $noTd = $("<td>").text(i+1);
				
				var $userNameTd = $("<td>").text(list.userName);
				var $emailTd = $("<td>").text(list.email);
				
				var date = new Date(list.paymentDate);
				date = getFormatDate(date);
				var $paymentDateTd = $("<td>").text(date);
				
				var payAmount = list.payAmount;
				payAmount = comma(payAmount);
				var $payAmountTd = $("<td>").text(payAmount);
				
				$listTr.append($noTd);
				$listTr.append($userNameTd);
				$listTr.append($emailTd);
				$listTr.append($paymentDateTd);
				$listTr.append($payAmountTd);
				
				$("#aPayTBody").append($listTr);
				paging(pi, condition);
			}
		};
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