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
	tbody *:hover{
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
						<div style="width:400px;margin-left: 468px;">
					        <a class="button is-primary" id="downRebates" style="height:20px;float:right;margin-left:2px;border-radius:10px;" data-tooltip="미지급 내역을 다운로드 받으실 수 있습니다.">미지급 내역 다운로드</a>
					        <a class="button is-danger" id="toRebates" style="height:20px;float:right;border-radius:10px;" data-tooltip="선택항목들 지급하기">지급하기</a>	
						</div>
						<div style="width:100%;font-size:25px;color:#209cee;">환급 내역</div>
						<br>
				         <div style="width:100%;height:100%;">
				         	<div>
				         		<div class="field has-addons" style="display:inlin-block;float:right;margin-top:1%;">
									<p class="control">
										<input type="checkbox" style="display:inline-block;float:left;" id="searchNameCheck" name="searchNameCheck">
										<p style="width:70px;display:inline-block;"><label for="searchNameCheck">이름 검색</label></p>
										<input class="input" type="text" placeholder="회원 이름을 검색하세요" style="width:150px;height:20px;display:none;" id="nameArea">
									</p>
						        	<div style="margin-left:1%;width: 77px;">
										<input type="checkbox" style="display:inline-block;float:left;" id="searchDateCheck">
										<p style="display:inline-block;"><label for="searchDateCheck">기간 검색</label></p>
									</div>
									<div style="width:353px;display:none;" id="dateArea">
										<input id="startDate" type="date" class="input is-primary" style="width:140px;height:20px;margin-left:1%;" data-tooltip="검색시작날짜 : 입력을 안하시면 현재 날짜로 검색됩니다.">
										<i class='far fa-calendar-alt' style='font-size:20px;color:purple;margin-right:1%;'></i>~
										<input id="endDate" type="date" class="input is-primary" style="width:140px;height:20px;margin-left:1%;" data-tooltip="검색종료날짜 : 입력을 안하시면 현재 날짜로 검색됩니다.">
										<i class='far fa-calendar-alt' style='font-size:20px;color:purple;'></i>
									</div>
									<div class="select is-small is-primary" style="display:inline-block;float:right;text-align:center;">
							            <select name="rebateSelect" id="rebateSelect" style="height:20px;">
							              <option value="0">--환급지급상태--</option>
							              <option value="10">미지급</option>
							              <option value="20">지급완료</option>
							            </select>
						        	</div>
									<p class="control" id="search" style="margin-left:1%;display:inline-block;float:right;">
										<a class="button is-primary" style="width:60px;height:20px;">
											<i class='fas fa-search' style='font-size:15px'></i>검색
										</a>
									</p>
								</div>
							</div>
				         
				         	<div style="width:100%;height:25px;"></div>
				         </div>
				         
				         <div style="width:100%;height:100%;" id="aRebateArea">
							<table id="aRebateTB" class="table is-narrow"align="center"style="width:100%;height:100%;" >
								<thead>
									<tr style="background:#ccccff;">
										<th width="2%"> 
											<input type="checkbox" name="rebateCheck" id="allCheck">
										</th>
										<th width="3%"> No. </th>
										<th width="5%"> 아이디 </th>
										<th width="5%"> 환급신청수익금 </th>
										<th width="5%"> 환급신청일 </th>
										<th width="5%"> 환급지급상태 </th>
									</tr>
								</thead>
								<tbody id="aRebateTBody">
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
	<script type="text/javascript">
		$(function() {
			var nav = $(".navbar-item").eq(10);
			   nav.css("background", "#118fe4");
			   nav.siblings().css("background", "rgb(32, 156, 238)");
			$(".apointReb").parent().addClass('is-active');
			$(".apointReb").children().css({"color":"#209cee"});
			
			$("#allCheck").click(function(){
				if($("#allCheck").prop("checked")) { 
					$("#aRebateArea input[type=checkbox]").prop("checked",true); 
				}else { 
					$("#aRebateArea input[type=checkbox]").prop("checked",false); 
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
			//체크 상태에 따라 인풋태그 보여주기
			$("#searchNameCheck").change(function(){
				if($("#searchNameCheck").is(":checked")){
					$("#nameArea").css({"display":"inline-block"});
				}else{
					$("#nameArea").css({"display":"none"});
				}
			});
			//모달 닫기
			$("#back2, #del2").click(function(){
				$('#myModal2').removeClass('is-active');
			});
			var currentPage = 1;
			total(currentPage);
		});
		function total(currentPage){
			var condition = 99;
			$.ajax({
				url:"adRebate.po",
				type:"post",
				data:{currentPage:currentPage, condition:condition},
				success:function(data){
					console.log(data);
					makeTable(data.adRebateList, data.adRebatePi, condition);
				},
				error:function(data){
					console.log('error');
				}
			});
		};
		function makeTable(adRebateList, adRebatePi, condition){
			var len = adRebateList.length;
			
			$("#aRebateTBody").empty();
			for(var i=0 ; i<len ; i++){
				var list = adRebateList[i];
				var pi = adRebatePi;
				
				var $tr = $("<tr>");
				
				var $checkTd = $("<td>");
				var $checkIn = $("<input type='checkbox' name='rebateCheck' class='rebateCheck' id='rebateCheck'>");
				$checkTd.append($checkIn);
				
				var $noTd = $("<td>").text(i+1);
				
				var $nameTd = $("<td>").text(list.member.userName);
				
				var payAmount = list.payAmount;
				payAmount = comma(payAmount);
				var $payAmountTd = $("<td>").text(payAmount);
				
				var applyDate = new Date(list.applyDate);
				applyDate = getFormatDate(applyDate);
				var $applyDateTd = $("<td>").text(applyDate);
				
				var rebateStatus = list.rebateStatus;
				
				var $rebateStatusTd, $rebateStatusA;
				$rebateStatusTd = $("<td>");
				if(rebateStatus == 10){
					//미지급
					$rebateStatusA = $('<a id="unpaid" class="button is-danger" style="height:25px;width:80px;border-radius:5px;">미지급</a>');
					$rebateIdIn = $('<input type="hidden">');
					$rebateIdIn.val(list.rebateId);
					$rebateIdType = $('<input type="hidden">');
					$rebateIdType.val(list.rebateStatus);
				}else{
					//지급완료
					$rebateStatusA = $('<a id="paid" class="button is-success" disabled="true" style="height:25px;width:80px;border-radius:5px;">지급완료</a>')
					$rebateIdIn = $('<input type="hidden">');
					$rebateIdIn.val(list.rebateId);
					$rebateIdType = $('<input type="hidden">');
					$rebateIdType.val(list.rebateStatus);
				}
				$rebateStatusTd.append($rebateStatusA);
				$rebateStatusTd.append($rebateIdIn);
				$rebateStatusTd.append($rebateIdType);
				
				$tr.append($checkTd);
				$tr.append($noTd);
				$tr.append($nameTd);
				$tr.append($payAmountTd);
				$tr.append($applyDateTd);
				$tr.append($rebateStatusTd);
				$("#aRebateTBody").append($tr);
				paging(pi, condition);
			}
		};
		$("body").on("click", "#unpaid", function(){
			var refundId = $(this).parent().children().eq(1).val();
			console.log(refundId);
			location.href="updateOneAdRebate.po?refund="+refundId;
		});
		$("body").on("click", "#toRebates", function(){
			var rebatesArr = [];
			$(".rebateCheck:checked").each(function(i){
				var rebates = $(this).parent().parent().children().eq(5).children().eq(1).val();
				var rebatesType = $(this).parent().parent().children().eq(5).children().eq(2).val();
				if(rebatesType == 10){
					rebatesArr.push(rebates);
				}
			});
			console.log(rebatesArr.length);
			
			if(rebatesArr.length == 0){
				$('#myModal').removeClass('is-active');
				$('#modalHeader2').text('선택내역이 없거나 지급된 내역입니다.');
				$("#myModal2").toggleClass('is-active');
				$("#okay").click(function(){
					$('#myModal2').removeClass('is-active');
				});
			}else{
				location.href="updateAllAdRebate.po?rebatesArr="+rebatesArr;
			}
		});
		function paging(pi, condition){
			var $page = $(".pagingBtnArea");
			
			var currentPage = pi.currentPage;
			var limit = pi.limit;
			var maxPage = pi.maxPage;
			var startPage = pi.startPage;
			var endPage = pi.endPage;
			
			$page.empty();
			
			$page.append($("<button>").attr("class", "pagingBtn").text(" << ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){
					total(1);
				}else{
					searchFunc(1);
				}
			}));
			
			if(currentPage <= 1){
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" < ").css({"cursor":"pointer"}));
			}else{
				$page.append($("<button>").attr("class", "pagingBtn").text("<").click(function(){
					if(condition == 99){
						total(currentPage-1);
					}else{
						searchFunc(currentPage-1);
					}
              }));
			}
			for(var p=startPage ; p<=endPage ; p++){
				if(p == currentPage){
					$page.append($("<button>").attr("class", "pagingBtn").text(p).attr("disabled",true).css({"cursor":"pointer"}));
				}else{ 
					$page.append($("<button>").attr("class", "pagingBtn").text(p).css({"cursor":"pointer"}).click(function(){
						if(condition == 99){
							total($(this).text());
						}else{
							searchFunc($(this).text());
						}
					}));
				}
			}
			if(currentPage >= maxPage){ 
				$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}));         
            }else {
            	$page.append($("<button>").attr("class", "pagingBtn").attr("disabled",true).text(" > ").css({"cursor":"pointer"}).click(function(){
            		if(condition == 99){
            			total(currentPage + 1);
					}else{
						searchFunc(currentPage + 1);
					}
            	}));
            } 
			$page.append($("<button>").attr("class", "pagingBtn").text(" >> ").css({"cursor":"pointer"}).click(function(){
				if(condition == 99){
					total(maxPage);
				}else{
					searchFunc(maxPage);
				}
            }));
		};
		//검색 버튼 눌렀을 때
		$("body").on("click", "#search", function(){
			searchFunc(1);
		});
		function searchFunc(currentPage){
			var condition = 99;
			var status = 99;
			
			var userName = $("#nameArea").val();
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();
			var rebateSta = $('#rebateSelect').children('option:selected').val();
			//0: 선택안함, 10: 미지급, 20: 지급완료
			console.log(rebateSta);
			
			var dateStart;
			var dateEnd;
			
			if(rebateSta == 10 || rebateSta == 20){//10: 미지급, 20: 지급완료
				//상태 0
				if($("#searchNameCheck").is(":checked")){
					//이름 O
					if(userName==""){
						status=10;
						msg="검색하실 회원의 이름을 입력해주세요";
					}else{
						if($("#searchDateCheck").is(":checked")){
							//날짜O
							condition = 70;
						}else{
							//날짜X
							condition = 60;
						}
					}
				}else{
					//이름 X
					if($("#searchDateCheck").is(":checked")){
						//날짜O
						condition = 50;
					}else{
						//날짜X
						condition = 40;
					}
				}
			}else {
				//상태 X
				if($("#searchNameCheck").is(":checked")){
					//이름 O
					if(userName==""){
						status=10;
						msg="검색하실 회원의 이름을 입력해주세요";
					}else{
						if($("#searchDateCheck").is(":checked")){
							//날짜O
							condition = 30;
						}else{
							//날짜X
							condition = 20;
						}
					}
				}else{
					//이름 X
					if($("#searchDateCheck").is(":checked")){
						//날짜O
						condition = 10;
					}else{
						//날짜X
						condition = 99;
						status = 10;
						msg = "검색 내용을 입력해주세요";
					}
				}
			}
			//날짜 시작날짜와 종료날짜 폼 맞추기
			if(startDate ==""){
				dateStart = new Date();
			}else{
				dateStart = startDate;
			}
			if(endDate ==""){
				dateEnd = new Date();
			}else{
				dateEnd = endDate;
			}
			
			var start = new Date(dateStart);
			var startMili = start.getTime();
			
			var end = new Date(dateEnd);
			var endMili = end.getTime();
			
			if(startMili > endMili){
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
			}else{
				//모두 정상일 때 
				//console.log(condition);
				/* console.log(currentPage);
				console.log(userName);
				console.log(startDate);
				console.log(endDate);
				console.log(rebateSta); */
				$.ajax({
					url:"searchAdRebate.po",
					type:"post",
					data:{condition:condition, currentPage:currentPage, userName:userName, startDate:startDate, endDate:endDate, rebateSta:rebateSta},
					success:function(data){
						//console.log('success');
						console.log(condition);
						makeTable(data.adRebateList, data.adRebatePi, condition);
					},
					error:function(data){
						console.log('error');
					}
				});
				console.log()
			}
			
		};
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
		//다운로드 버튼 믈릭
		$("#downRebates").click(function(){
			var len = $("#aRebateTBody tr").length;
			var rebatesStatus = [];
			var rebatesId = [];
			var downArr = [];
			
			for(var i=0 ; i<len ; i++){
				rebatesStatus[i] = $("#aRebateTBody").children().eq(i).children().eq(5).children().eq(2).val();
				rebatesId[i] = $("#aRebateTBody").children().eq(i).children().eq(5).children().eq(1).val();
				//console.log(rebatesStatus[i]);
				//console.log(rebatesId[i]);
				if(rebatesStatus[i] == 10){
					downArr.push(rebatesId[i]);
				}
			}
			
			if(downArr.length == 0){
				$('#myModal').removeClass('is-active');
				$('#modalHeader2').text('미지급 항목이 없습니다.');
				$("#myModal2").toggleClass('is-active');
				$("#okay").click(function(){
					$('#myModal2').removeClass('is-active');
				});
			}else{
				location.href="adDownRebates.po?rebatesType="+10;
			}
		});
	</script>
</body>
</html>