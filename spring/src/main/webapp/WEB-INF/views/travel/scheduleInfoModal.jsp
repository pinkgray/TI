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
	<div class="modal" id="scheduleInfoModal">
		<div class="modal-background"></div>
		<div class="modal-card" style="width:600px">
			<header class="modal-card-head">
				<span class="icon is-large" style="color:purple"><i class="fas fa-2x fa-edit"></i></span>
				<p class="modal-card-title">일정 정보</p>
				<button class="delete" aria-label="close"></button>
			</header>
			<section class="modal-card-body">
				<form action="" method="post" id="schUpdateForm">
					<div class="field">
						<p class="control">
							<input type="hidden" value="${ trv.trvId }" name="trvId">
							<input type="hidden" name="schId" id="schId2"/>
							<input class="input is-primary is-large" type="text" placeholder="일정 제목 입력" name="schTitle"
							id="schTitle2">
						</p>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">장소</label>
						</div>
						<div class="field-body">
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-map-marker-alt"></i></span>
									<input type="hidden" name="plcId" id="plcId2">
									<input class="input" type="text" placeholder="장소정보없음"
										readOnly name="plcName" id="plcName2"/>
								</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">일자</label>
						</div>
						<div class="field-body">
							<div class="field is-grouped">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="far fa-calendar-alt"></i></span>
									<span class="select"> 
										<select name="dayId" id="dayId2">
											<c:forEach var="trvDay" items="${ trvDayList }" varStatus="st">
												<option value="${ trvDay.dayId }">DAY ${ trvDay.dayNumber }</option>
											</c:forEach>
										</select>
									</span>
								</p>
							</div>
							<div class="field">
								<p class="control">
									<label class="checkbox"> 
										<input type="checkbox" name="isTimeset" id="isTimeset2">시간 지정 안함
									</label>
								</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">시간 (선택)</label>
						</div>
						<div class="field-body">
							<div class="field">
								<p class="control is-expanded has-icons-left" style="margin:0">
									<span class="icon is-small is-left"><i class="far fa-clock"></i></span> 
									<input class="input" type="time" name="startTime" id="startTime2">
								</p>
								<p class="help">시작시간</p>
							</div>
							<div class="field">
								<p style="font-size:20px">~</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left" style="margin:0">
									<span class="icon is-small is-left"><i class="far fa-clock"></i></span> 
									<input class="input" type="time" name="endTime" id="endTime2">
								</p>
								<p class="help">종료시간</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">경비 (선택)</label>
						</div>
						<div class="field-body">
							<div class="field is-grouped">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-tasks"></i></span>
									<span class="select"> 
										<select name="costType" id="costType2">
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
									<input class="input" type="number" placeholder="현지화 가격 입력 (선택 )" value="0" 
									name="costAmount" id="costAmount2" />
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-dollar-sign"></i></span>
									<span class="select"> 
										<select name="currency" id="currency2">
											<c:forEach var="trvCity" items="${ trvCityList }" varStatus="st" >
												<option>${ trvCity.currencyUnit }</option>
											</c:forEach>
										</select>
									</span>
								</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">교통 (선택)</label>
						</div>
						<div class="field-body">
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-subway"></i></span>
									<input class="input" type="text" placeholder="교통정보 입력(선택 )"
									name="schTransp" id="schTransp2"/>
								</p>
							</div>
						</div>
					</div>
				</form>
			</section>
			<footer class="modal-card-foot" >
				<a class="button is-primary" id="submitSchBtn2">완료</a> 
				<a class="button cancelBtn">취소</a>
			</footer>
		</div>
	</div>
	<script>
		var title2 =  $("#schTitle2");
		var dayId2 = $("#dayId2");
		var isTimeset2 = $("#isTimeset2");
		var startTime2 = $("#startTime2");
		var endTime2 = $("#endTime2");
		var costAmount2 = $("#costAmount2");
		var transp2 = $("#schTransp2");
		$(function() {
			$("#currency2").children().each(function() {
				if($(this).text() == $(this).siblings().text()) {
					$(this).remove();
				}
			});
		});
		$('.modal-background, .modal-card-head>.delete, .cancelBtn').click(function() {
			clearSchInfoModal();       		
       	});
		
		$("#isTimeset2").click(function() {
			if($(this).prop("checked")) {
				startTime2.val('');
        		endTime2.val('');
			}
		});
		
		$("#costAmount2").change(function() {
			console.log($(this).val());
			if($(this).val() == "") {
				$(this).val(0);
			}
		});

		//일정수정제출버튼 클릭시 db update, list update, socket emit
       	$("#submitSchBtn2").click(function() {
       		if(title2.val() == '') {
       			alert("일정제목을 입력해주세요.");
       		}else if(!isTimeset2.prop("checked") && (startTime2.val() == '' || endTime2.val() == '')) {
       			alert('시간을 지정하지 않으시려면 시간미지정 박스에 체크해주세요.');
       		}else if(startTime2.val() > endTime2.val()) {
       			alert('시작시간과 종료시간을 다시 확인하세요');
       		}else {
       			var form = $("#schUpdateForm").serialize();
    			var day
    			$.ajax({
    				url:"updateSch.trv",
    				type:"POST",
    				data:form,
    				success:function(data) {
    					console.log(data.changeDayNumber);
    					console.log(data.changeSchList);
    					console.log(data.changeCostList);
    					updateSchList(data.originDayNumber, data.originSchList);
    					updateCostList(data.originDayNumber, data.originCostList);
    					
    					
    					if(data.changeDayNumber != undefined) {
    						updateSchList(data.changeDayNumber, data.changeSchList);
    						updateCostList(data.changeDayNumber, data.changeCostList);
    					}

    					clearSchInfoModal();
    					
    					//상세일정 수정시 socket
    					socket.emit('updateSchedule', {
	        				originDayNumber:data.originDayNumber,
	        				originSchList:data.originSchList,
	        				originCostList:data.originCostList,
	        				changeDayNumber:data.changeDayNumber,
	        				changeSchList:data.changeSchList,
	        				changeCostList:data.changeCostList,
	        				room:"${ trv.trvId }"
	        			});
    				},
    				error:function(err) {
    					alert("err");
    				}
    			});
       		}
       	});
		
		
		function clearSchInfoModal() {
			$('html').removeClass('is-clipped');
    	    $("#scheduleInfoModal").removeClass('is-active');
    	   	title2.val('');
    	   	dayId2.children().eq(0).prop("selected", true);
    	   	isTimeset2.prop("checked", false);
    	   	startTime2.val('');
    	   	endTime2.val('');
    	   	costAmount2.val(0);
    	   	transp2.val('');
		}
	</script>
</body>
</html>