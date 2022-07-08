<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.select:not(.is-multiple):not(.is-loading)::after {
   		border-color:purple;
   	}
	#cityPlusBtn:hover {
   		cursor:pointer;
   	}
</style>
<body>
	<div class="modal" id="travelInfoModal">
		<div class="modal-background"></div>
		<div class="modal-card" style="width:600px">
			<header class="modal-card-head">
				<span class="icon is-large"><i class="fas fa-2x fa-plane-departure"></i></span>
				<p class="modal-card-title">여행 정보</p>
				<button class="delete" aria-label="close"></button>
			</header>
			<section class="modal-card-body">
				<form action="updateTravel.trv" method="post" id="trvInfoForm">
					<div class="field">
						<p class="control">
							<input type="hidden" value="${ trv.trvId }" name="trvId"> 
							<input class="input is-primary is-large" type="text" value="${ trv.trvTitle }" placeholder="여행 제목 입력"
								name="trvTitle">
						</p>
					</div>
					<c:forEach var="trvCity" items="${ trvCityList }" varStatus="st" >
						<div class="field is-horizontal travelCityField">
							<div class="field-label is-normal">
								<label class="label travelCityLabel">
									<c:if test="${ st.index == 0 }" >여행지</c:if>
								</label>
							</div>
							<div class="field-body">
								<div class="field is-grouped">
									<p class="control is-expanded has-icons-left">
										<span class="icon is-small is-left"><i class="fas fa-globe-americas"></i></span>
										<span class="select"> 
											<select name="trvCountry" id="trvCountry2">
												<option value="${ trvCity.countryId }" selected>${ trvCity.countryNameKo }</option>
											</select>
										</span>
									</p>
								</div>
								<div class="field">
									<p class="control is-expanded has-icons-left has-icons-right">
										<span class="icon is-small is-left"><i class="fas fa-location-arrow"></i></span> 
										<span class="select"> 
											<select name="trvCity" id="trvCity2">
												<option value="${ trvCity.cityId }" selected>${ trvCity.cityNameKo }</option>
											</select>
										</span>
									</p>
								</div>
								<div class="field" style="line-height:40px" align="center">
									<a style="font-size:2em; color:purple" data-tooltip="여행지 삭제" class="cityRemoveBtn2">-</a>
								</div>
								<div class="field" style="line-height:40px" align="center">
									<a style="font-size:2em; color:purple" data-tooltip="여행지 추가" class="cityPlusBtn2">+</a>
								</div>
							</div>
						</div>
					</c:forEach>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">여행 기간</label>
						</div>
						<div class="field-body">
							<div class="field is-grouped">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-calendar-check"></i></span>
									<input class="input" type="text" id="startPicker2" placeholder="시작일" value="${ trv.startDate }" name="startDate"/>
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left has-icons-right">
									<span class="icon is-small is-left"><i class="far fa-calendar-check"></i></span> 
									<input class="input" type="text" id="endPicker2" placeholder="종료일" value="${ trv.endDate }" name="endDate"/>
								</p>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">인원수</label>
						</div>
						<div class="field-body">
							<div class="field is-narrow">
								<div class="control">
									<div class="is-fullwidth">
										<input class="input" type="number" min="1" max="20" value="${ trv.compNumber }" name="compNumber">
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</section>
			<footer class="modal-card-foot" >
				<a class="button is-primary okBtn" id="trvUpdateBtn">완료</a> 
				<a class="button cancelBtn">취소</a>
			</footer>
		</div>
	</div>
	<script>
		var trvInfoModal;
		$(function() {
			$('.modal-card-head>.delete, .cancelBtn').click(function() {
        		$('html').removeClass('is-clipped');
        	    $(this).parents(".modal").removeClass('is-active');
        		$("#travelInfoModal").empty();
        		$("#travelInfoModal").append(trvInfoModal);
        	    /* $("#startPicker2").datepicker("setDate", "${ trv.startDate }");
        	    $("#endPicker2").datepicker("setDate", "${ trv.endDate }"); */
        		$("#startPicker2, #endPicker2").datepicker("destroy");
        		
        		var startDate;
            	$("#startPicker2").datepicker({
            		dateFormat:"yy-mm-dd",
            		onSelect:function(selectedDate) {
    					startDate = $(this).datepicker('getDate');
    					$("#endPicker2").datepicker("option", "minDate", startDate);
    				}
            	});
            	$("#endPicker2").datepicker({
            		dateFormat:"yy-mm-dd"
            	});
        	});
			
			var startDate;
        	$("#startPicker2").datepicker({
        		dateFormat:"yy-mm-dd",
        		onSelect:function(selectedDate) {
					startDate = $(this).datepicker('getDate');
					$("#endPicker2").datepicker("option", "minDate", startDate);
				}, 
        	});
        	$("#endPicker2").datepicker({
        		dateFormat:"yy-mm-dd"
        	});
        	
        	//cityField추가
        	$(".cityPlusBtn2").click(function() {
        		var field = $(this).parent().parent().parent().clone(true);
        		field.addClass('newField');
        		field.find("select[name=trvCountry]").addClass('newField');
        		field.find("select[name=trvCity]").addClass('newField');
        		field.find(".travelCityLabel").text('');
        		field.find("select[name=trvCity]").children().remove();
        		$(this).parent().parent().parent().after(field[0]);
        		showCityList(field.find("select[name=trvCountry]"));
        	});
        	
        	//cityField삭제
        	$(".cityRemoveBtn2").click(function() {
        		if($(this).parents(".travelCityField").find(".travelCityLabel") != '') {
        			$(this).parents(".travelCityField").next().find(".travelCityLabel").text('여행지');
        		}
        		if($(this).parents(".travelCityField").siblings().length == 3) {
					alert("마지막 여행지입니다.");
        		}else {
	        		$(this).parents(".travelCityField").remove();
        		}
        	});
        	      	
        	$("select[name=trvCountry], select[name=trvCity]").one('click', function() {
        		if(!$(this).is(".newField")) {
	        		$(this).children("option").eq(0).remove();
        		}
        	});
        	
        	$("select[name=trvCountry]").change(function() {
    			showCityList($(this));
    		});
        	
        	
        	$("#trvUpdateBtn").click(function() {
        		var title = $("input[name=trvTitle]").val();
        		var start = $("#startPicker").val();
        		var end = $("#endPicker").val();
        		var cities = [];
        		var duplicated = false;
        		$("select[name=trvCity]").each(function() {
        			var city = $(this).children("option:selected").text();
        			if(cities.indexOf(city) >= 0) {
        				duplicated = true; 
        			}else {
        				cities.push(city);
        			}
        		});
        		if(duplicated) {
        			alert('도시명이 중복됩니다. 다시 확인해주세요.');
        		}else if(title === '') {
					alert('여행 제목을 입력해주세요.');        			
        		}else if(start === '' || end === '') {
        			alert('여행 시작일과 종료일을 선택해주세요');
        		}else {
	        		$("#trvInfoForm").submit();
        		}
        		
        	});
		});
		
		function showTrvInfoModal() {
			$.ajax({
				url:"selectCountryList.trv",
				type:"post",
				success:function(data) {
					var $select = $("select[name=trvCountry]");
					for(var key in data.countryList) {
						var id = data.countryList[key].countryId;
						var country = data.countryList[key].countryNameKo;
						var $option = $("<option value='" + id + "'>").text(country);
						$select.append($option);
					}
				}, error:function(data) {
					alert("서버 전송실패");
				}
			});
	    			
			$("select[name=trvCountry]").each(function() {
				var country = $(this).children("option:selected");
				var citySelect = $(this).parent().parent().parent().next().find("select[name=trvCity]");
				$.ajax({
					url : "selectCityList.trv",
					type : "post",
					data : {countryId:country.val()},
					success : function(data) {
						for (var key in data.cityList) {
							var id = data.cityList[key].cityId;
							var city = data.cityList[key].cityNameKo;
							var $option = $("<option value='" + id + "'>").text(city);
							citySelect.append($option);
						}
					},
					error : function(data) {
						alert("서버 전송실패");
					}
				});
			});
			$('#travelInfoModal').toggleClass('is-active');
			trvInfoModal = $("#travelInfoModal").children().clone(true);
		}
		
		
		
		function showCityList(countrySelect) {
			var country = countrySelect.children("option:selected");
			console.log(country.val());
			var citySelect = countrySelect.parent().parent().parent().next().find("select[name=trvCity]");
			$.ajax({
				url : "selectCityList.trv",
				type : "post",
				data : {countryId : country.val()},
				success : function(data) {
					citySelect.children().remove();
					for ( var key in data.cityList) {
						var id = data.cityList[key].cityId;
						var city = data.cityList[key].cityNameKo;
						var $option = $("<option value='" + id + "'>").text(city);
						citySelect.append($option);
					}
				},
				error : function(data) {
					alert("서버 전송실패");
				}
			});
		}
			
	</script>
</body>
</html>