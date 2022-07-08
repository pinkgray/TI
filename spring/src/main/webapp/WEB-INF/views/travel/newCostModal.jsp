<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal" id="newCostModal">
		<div class="modal-background"></div>
		<div class="modal-card" style="width:480px">
			<header class="modal-card-head">
				<span class="icon is-large" style="color:purple"><i class="fas fa-2x fa-wallet"></i></span>
				<p class="modal-card-title">가계부 항목</p>
				<button class="delete" aria-label="close"></button>
			</header>
			<section class="modal-card-body">
				<form id="newCostForm" method="POST">
					<div class="field">
						<p class="control">
							<input type="hidden" value="${ trv.trvId }" name="trvId">
							<input class="input is-primary is-large" type="text" placeholder="내용 입력"
							name="costContent" id="costContent">
						</p>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">일자</label>
						</div>
						<div class="field-body">
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="far fa-calendar-alt"></i></span>
									<span class="select"> 
										<select name="dayId" id="costDayId">
											<c:forEach var="trvDay" items="${ trvDayList }" varStatus="st">
												<option value="${ trvDay.dayId }">DAY ${ trvDay.dayNumber }</option>
											</c:forEach>
										</select>
									</span>
								</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">경비</label>
						</div>
						<div class="field-body">
							<div class="field is-grouped">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-tasks"></i></span>
									<span class="select"> 
										<select name="costType" id="costType">
											<option>숙박</option>
											<option>교통</option>
											<option>식비</option>
											<option>쇼핑</option>
											<option>관광</option>
											<option>기타</option>
										</select>
									</span>
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-receipt"></i></span>
									<input class="input" type="number" value="0" name="costAmount" id="costAmount"/>
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-dollar-sign"></i></span>
									<span class="select"> 
										<select name="currency" id="costCurrency">
											<c:forEach var="trvCity" items="${ trvCityList }" varStatus="st" >
												<option>${ trvCity.currencyUnit }</option>
											</c:forEach>
										</select>
									</span>
								</p>
							</div>
						</div>
					</div>
				</form>
			</section>
			<footer class="modal-card-foot" >
				<a class="button is-primary" id="costSubmitBtn">완료</a> 
				<a class="button cancelBtn">취소</a>
			</footer>
		</div>
	</div>
	<script>
		var costContent = $("#costContent");
		var costDayId = $("#costDayId");
		var costType = $("#costType");
		var costAmount = $("#costAmount");
		var costCurrency = $("#costCurrency");
		$(function() {
			$('.modal-background, .modal-card-head>.delete, .cancelBtn').click(function() {
        		clearCostModal();
        	});
        	
        	
        	$("#costSubmitBtn").click(function() {
        		if(costContent.val() == "") {
        			alert("경비내용을 입력해주세요");
        		}else if(costAmount.val() == 0) {
        			alert("금액을 입력해주세요");
        		}else {
        			var form = $("#newCostForm").serialize();
        			$.ajax({
        				url:"insertCost.trv",
        				type:"POST",
        				data:form,
        				success:function(data) {
        					
        					insertNewCost(data.trvCost);
        					clearCostModal();
        					
        					socket.emit('insertCost', {
        						trvCost:data.trvCost,
        						room:"${ trv.trvId }"
        					});
        					
        				},
        				error:function(err) {
        					alert(err);
        				}
        			});
        		}
        		
        	});
		});
		
		function clearCostModal() {
			$('html').removeClass('is-clipped');
			$('#newCostModal').removeClass('is-active');
			costContent.val("");
    	    costDayId.children().eq(0).prop("selected", true);
    	    costType.children().eq(0).prop("selected", true);
    	    costAmount.val(0);
    	    costCurrency.children().eq(0).prop("selected", true);
		}
	</script>
</body>
</html>