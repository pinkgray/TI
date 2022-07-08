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
	<div class="modal" id="newScheduleModal">
		<div class="modal-background"></div>
		<div class="modal-card" style="width:600px">
			<header class="modal-card-head">
				<span class="icon is-large" style="color:purple"><i class="fas fa-2x fa-edit"></i></span>
				<p class="modal-card-title">일정 정보</p>
				<button class="delete" aria-label="close"></button>
			</header>
			<section class="modal-card-body">
				<form action="" method="post" id="newSchForm">
					<div class="field">
						<p class="control">
							<input type="hidden" value="${ trv.trvId }" name="trvId">
							<input class="input is-primary is-large" type="text" placeholder="일정 제목 입력" name="schTitle"
								id="schTitle1">
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
									<input type="hidden" name="plcId" id="plcId1">
									<input class="input" type="text" placeholder="장소정보없음"
										readOnly name="plcName" id="plcName1" />
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
										<select name="dayId" id="dayId1">
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
										<input type="checkbox" name="isTimeset" id="isTimeset1">시간 지정 안함
									</label>
								</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label travelCityLabel">시간 (선택)</label>
						</div>
						<div class="field-body">
							<div class="field">
								<p class="control is-expanded has-icons-left" style="margin:0">
									<span class="icon is-small is-left"><i class="far fa-clock"></i></span> 
									<input class="input" type="time" name="startTime" id="startTime1">
								</p>
								<p class="help">시작시간</p>
							</div>
							<div class="field">
								<p style="font-size:20px">~</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left" style="margin:0">
									<span class="icon is-small is-left"><i class="far fa-clock"></i></span> 
									<input class="input" type="time" name="endTime" id="endTime1">
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
										<select name="costType" id="costType1">
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
									<input class="input" type="number" value="0" name="costAmount" id="costAmount1" />
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-dollar-sign"></i></span>
									<span class="select"> 
										<select name="currency" id="currency1">
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
									name="schTransp" id="schTransp1"/>
								</p>
							</div>
						</div>
					</div>
				</form>
			</section>
			<footer class="modal-card-foot" >
				<a class="button is-primary" id="submitSchBtn">완료</a> 
				<a class="button cancelBtn">취소</a>
			</footer>
		</div>
	</div>
	<script>
		var title1 =  $("#schTitle1");
		var dayId1 = $("#dayId1");
		var isTimeset1 = $("#isTimeset1");
		var startTime1 = $("#startTime1");
		var endTime1 = $("#endTime1");
		var costAmount1 = $("#costAmount1");
		var transp1 = $("#schTransp1");
		var plcId1 = $("#plcId1");
		var plcName1 = $("#plcName1");
		$(function() {
			$("#currency1").children().each(function() {
				if($(this).text() == $(this).siblings().text()) {
					$(this).remove();
				}
			});
		});
		
		$('.modal-background, .modal-card-head>.delete, .cancelBtn').click(function() {
    		clearNewSchModal();
    	});
		
		$("#isTimeset1").click(function() {
			if($(this).prop("checked")) {
				startTime1.val('');
        		endTime1.val('');
			}
		});
		
		$("#costAmount1").change(function() {
			console.log($(this).val());
			if($(this).val() == "") {
				$(this).val(0);
			}
		});
		
		//새일정 제출 버튼 클릭시 db insert, listUpdate, socket emit
    	$("#submitSchBtn").click(function() {
    		if(title1.val() == '') {
    			alert("일정제목을 입력해주세요.");
    		}else if(!isTimeset1.prop("checked") && (startTime1.val() == '' || endTime1.val() == '')) {
    			alert('시간을 지정하지 않으시려면 시간미지정 박스에 체크해주세요.');
    		}else if(startTime1.val() > endTime1.val()) {
    			alert('시작시간과 종료시간을 다시 확인하세요');
    		}else {
    			var form = $("#newSchForm").serialize();
    			var day
    			$.ajax({
    				url:"insertSch.trv",
    				type:"POST",
    				data:form,
    				success:function(data) {
    					
    					updateSchList(data.dayNumber, data.schList);
    					
    					for(var key in data.schList) {
    						var sch = data.schList[key];
    						
    						if(sch.schId == data.schId && sch.trvCost != null) {
		    					insertNewCost(sch.trvCost);
    						}
    					}
    					clearNewSchModal();
    					
    					socket.emit('insertSchedule', {
    						schId:data.schId,
	        				dayNumber:data.dayNumber,
	        				schList:data.schList,
	        				room:"${ trv.trvId }"
	        			});
    				},
    				error:function(err) {
    					alert("err");
    				}
    			});
    		}
    	});
		
		
		//--------------------------------------------------------------------------
		function clearNewSchModal() {
			$('html').removeClass('is-clipped');
    	    $("#newScheduleModal").removeClass('is-active');
    	   	title1.val('');
    	   	dayId1.children().eq(0).prop("selected", true);
    	   	isTimeset1.prop("checked", false);
    	   	startTime1.val('');
    	   	endTime1.val('');
    	   	costAmount1.val(0);
    	   	transp1.val('');
    	   	plcId1.val('');
    	   	plcName1.val('');
		}
		
		
		
	</script>
</body>
</html>