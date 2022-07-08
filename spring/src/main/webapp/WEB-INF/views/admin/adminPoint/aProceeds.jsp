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
						<div style="width:100%;font-size:25px;color:#209cee;">수익금 내역</div>
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
									<a class="button is-primary is-outlined" style="width:120px;height:20px;margin-left:2%;" href="toAdRebateView.po">환급내역 보러가기</a>
								</div>
							</div>
				         	<div style="width:100%;height:25px;"></div>
				         </div>
				         <div style="width:100%;height:100%;" id="aPointArea">
							<table id="aProceedsTB" class="table is-narrow" align="center"style="width:100%;height:100%;" >
								<thead>
									<tr style="background:#ccccff;">
										<th width="3%"> No. </th>
										<th width="15%"> 이름 </th>
										<th width="15%"> 이메일 </th>
										<th width="20%"> 수익금 </th>
										<th width="20%"> 수익발생일 </th>
										<th width="20%"> 수익발생글 </th>
									</tr>
								</thead>
								<tbody id="aProceedsTBody">
									
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
			$(".apointPro").parent().addClass('is-active');
			$(".apointPro").children().css({"color":"#209cee"});
			//모달 닫기
			$("#back2, #del2").click(function(){
				$('#myModal2').removeClass('is-active');
			});
			
			var currentPage = 1;
			//전체 리스트 출력으로 가는 함수
			total(currentPage);
			//체크 상태에 따라 인풋태그 보여주기
			$("#searchNameCheck").change(function(){
				if($("#searchNameCheck").is(":checked")){
					$("#nameArea").css({"display":"inline-block"});
				}else{
					$("#nameArea").css({"display":"none"});
				}
			});
		});
		//검색 버튼 눌렀을 때
		$("body").on("click", "#search", function(){
			searchFunc(1);
		});
		function total(currentPage){
			var condition = 99;
			$.ajax({
				url:"adProceeds.po",
				type:"post",
				data:{currentPage:currentPage, condition:condition},
				success:function(data){
					makeTable(data.adProceedsList, data.adProceedsPi, condition);
				},
				error:function(data){
					console.log('error');
				}
			});
		};
		function makeTable(adProceedsList, adProceedsPi, condition){
			//console.log(adProceedsList);
			//console.log(adProceedsPi);
			
			var len = adProceedsList.length;
			//console.log(len);
			$("#aProceedsTBody").empty();
			
			for(var i=0 ; i<len ; i++){
				var list = adProceedsList[i];
				//console.log(list);
				var pi = adProceedsPi;
				//console.log(pi);
				
				var $tr = $("<tr>"); 
				
				var $noTd = $("<td>").text(i+1);
				
				var $nameTd = $("<td>").text(list.userName);
				
				var $emailTd = $("<td>").text(list.email);
				
				var proceeds = list.proceeds;
				proceeds = comma(proceeds);
				var $proceedsTd = $("<td>").text(proceeds);
				
				var proceedsDate = new Date(list.proceedsDate);
				proceedsDate = getFormatDate(proceedsDate);
				var $proceedsDateTd = $("<td>").text(proceedsDate);
				
				var $proceedsTypeTd = $("<td>");
				var proceedsType = list.proceedsType;
				var $proceedsTypeIn, bid;
				if(proceedsType == 10){
					//일정판매
					bid = list.travel.trvId;
					$proceedsTypeIn = $('<input type="hidden">');
					$proceedsTypeIn.val(bid);
					$proceedsTypeA = $('<button id="trvLink" class="button is-info" data-bid='+bid+' style="border-radius:5px;line-height:50%;height:20px;" data-tooltip="해당글 보러가기" target="_blank">일정판매</button>');
				}else{
					//설계판매
					bid = list.travelRequestPlan.ptcpId;
					$proceedsTypeIn = $('<input type="hidden">');
					$proceedsTypeIn.val(bid);
					$proceedsTypeA = $('<button id="planLink" class="button is-success" data-bid='+bid+' style="border-radius:5px;line-height:50%;height:20px;" data-tooltip="해당글 보러가기" target="_blank">일정판매</button>');
				}
				$proceedsTypeA.append($proceedsTypeIn);
				$proceedsTypeTd.append($proceedsTypeIn);
				$proceedsTypeTd.append($proceedsTypeA);
				
				
				$tr.append($noTd);
				$tr.append($nameTd);
				$tr.append($emailTd);
				$tr.append($proceedsTd);
				$tr.append($proceedsDateTd);
				$tr.append($proceedsTypeTd);
				$("#aProceedsTBody").append($tr);
				
				paging(pi, condition)
			}
		};
		//페이징
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
		function searchFunc(currentPage){
			var condition = 99;
			var status = 99;
			var msg, userName;
			userName = $("#nameArea").val();
			
			if($("#searchNameCheck").is(":checked")){
				if(userName == ""){
					status = 10;
					msg = "검색하실 회원의 이름을 입력해주세요";
				}else{
					condition = 10;
				}
			}
			
			if(status != 10){
				$.ajax({
					url:"searchAdProceeds.po",
					type:"post",
					data:{currentPage:currentPage, condition:condition, userName:userName},
					success:function(data){
						console.log(data);
						makeTable(data.adProceedsList, data.adProceedsPi, condition);
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
		}
		$("body").on("click", "#trvLink",function(){
			var bid = $(this).parent().children().eq(0).val();
			var url = "oneBoard.po?bid="+bid;
			
			console.log("bid : " + bid);

			window.open(url, "oneBoard", "width=1000,height=700");
		});
		$("body").on("click", "#planLink",function(){
			var bid = $(this).parent().children().eq(0).val();
			var url = "oneBoardRequest.po?bid="+bid;
			
			console.log("bid : " + bid);

			window.open(url, "oneBoardRequest", "width=1000,height=700");
		});
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