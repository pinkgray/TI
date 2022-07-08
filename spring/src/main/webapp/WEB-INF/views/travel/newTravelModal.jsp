<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="modal" id="newTravelModal">
		<div class="modal-background"></div>
		<div class="modal-card" style="width:600px">
			<header class="modal-card-head">
				<span class="icon is-large"><i class="fas fa-2x fa-plane-departure"></i></span>
				<p class="modal-card-title">여행 정보</p>
				<button class="delete" aria-label="close"></button>
			</header>
			<section class="modal-card-body">
				<form action="insertTravel.trv" method="post" id="newTrvForm">
					<div class="field">
						<p class="control">
							<input type="hidden" value="${ sessionScope.loginUser.memberId }" name="memberId" />
							<input class="input is-primary is-large" type="text" placeholder="여행 제목 입력"
								name="trvTitle">
						</p>
					</div>
					<div class="field is-horizontal travelCityField">
						<div class="field-label is-normal">
							<label class="label travelCityLabel">여행지</label>
						</div>
						<div class="field-body">
							<div class="field is-grouped">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-globe-americas"></i></span>
									<span class="select"> 
										<select name="trvCountry" id="trvCountry1">
										</select>
									</span>
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left has-icons-right">
									<span class="icon is-small is-left"><i class="fas fa-location-arrow"></i></span> 
									<span class="select"> 
										<select name="trvCity" id="trvCity1">
										</select>
									</span>
								</p>
							</div>
							<div class="field" style="line-height:40px" align="center">
									<a style="font-size:2em; color:purple" data-tooltip="여행지 삭제" class="cityRemoveBtn">-</a>
								</div>
							<div class="field" style="line-height:40px" align="center">
								<a style="font-size:2em; color:purple" data-tooltip="여행지 추가" class="cityPlusBtn">+</a>
							</div>
						</div>
					</div>
					<div class="field is-horizontal">
						<div class="field-label is-normal">
							<label class="label">여행 기간</label>
						</div>
						<div class="field-body">
							<div class="field is-grouped">
								<p class="control is-expanded has-icons-left">
									<span class="icon is-small is-left"><i class="fas fa-calendar-check"></i></span>
									<input class="input" type="text" id="startPicker" placeholder="시작일" name="startDate"/>
								</p>
							</div>
							<div class="field">
								<p class="control is-expanded has-icons-left has-icons-right">
									<span class="icon is-small is-left"><i class="far fa-calendar-check"></i></span> 
									<input class="input" type="text" id="endPicker" placeholder="종료일" name="endDate"/>
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
										<input class="input" type="number" min="1" max="20" value="1" name="compNumber">
									</div>
								</div>
							</div>
						</div>
						<input type="hidden" value="0" name="trvRef">
					</div>
				</form>
			</section>
			<footer class="modal-card-foot" >
				<a class="button is-primary okBtn" id="trvSubmitBtn">완료</a> 
				<a class="button cancelBtn">취소</a>
			</footer>
		</div>
	</div>
	<script>
		$(function() {
			
			
			//modal close
			$('.modal-background, .modal-card-head>.delete, .cancelBtn').click(function() {
        		$('html').removeClass('is-clipped');
        	    $(this).parents(".modal").removeClass('is-active');
        	});
        	
			//set datePicker
			var startDate;
        	$("#startPicker").datepicker({
        		dateFormat:"yy-mm-dd",
        		onSelect:function(selectedDate) {
					startDate = $(this).datepicker('getDate');
					$("#endPicker").datepicker("option", "minDate", startDate);
				}, 
        	});
        	$("#endPicker").datepicker({
        		dateFormat:"yy-mm-dd"
        	});
        	
        	
        	//cityfield추가
        	$(".cityPlusBtn").click(function() {
        		var field = $(this).parents(".travelCityField").clone(true);
        		field.find(".travelCityLabel").text('');
        		field.find("select[name=trvCity]").children().remove();
        		field.insertAfter($(this).parents(".travelCityField"));
        	});
        	
        	//cityField 삭제
        	$(".cityRemoveBtn").click(function() {
        		if($(this).parents(".travelCityField").find(".travelCityLabel") != '') {
        			$(this).parents(".travelCityField").next().find(".travelCityLabel").text('여행지');
        		}
        		console.log($(this).parents(".travelCityField").siblings());
        		if($(this).parents(".travelCityField").siblings().length == 3) {
					alert("마지막 여행지입니다.");
        		}else {
	        		$(this).parents(".travelCityField").remove();
        		}
        	});
        	
        	//submit Form
        	$("#trvSubmitBtn").click(function() {
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
	        		$("#newTrvForm").submit();
        		}
        	});
		});
		function showNewTrvModal() {
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
					var country = $("#trvCountry1").children("option:selected");
		    		var citySelect = $("#trvCity1");
					$.ajax({
			    		url:"selectCityList.trv",
			    		type:"post",
			    		data:{countryId:country.val()},
			    		success:function(data) {
			    			citySelect.children().remove();
							for(var key in data.cityList) {
								var id = data.cityList[key].cityId;
								var city = data.cityList[key].cityNameKo;
								var $option = $("<option value='" + id + "'>").text(city);
								citySelect.append($option);
							}
			    		}, error:function(data) {
			    			alert("서버 전송실패");
			    		}
			    	});
				}, error:function(data) {
					alert("서버 전송실패");
				}
			});
			
			if(${ !empty sessionScope.loginUser }) {
				$('#newTravelModal').toggleClass('is-active');
			}else {
				alert("로그인을 해주세요.");
			}
		}
		$("select[name=trvCountry]").change(function() {
    		var country = $(this).children("option:selected");
    		var citySelect = $(this).parent().parent().parent().next().find("select[name=trvCity]");
	    	$.ajax({
	    		url:"selectCityList.trv",
	    		type:"post",
	    		data:{countryId:country.val()},
	    		success:function(data) {
	    			citySelect.children().remove();
					for(var key in data.cityList) {
						var id = data.cityList[key].cityId;
						var city = data.cityList[key].cityNameKo;
						var $option = $("<option value='" + id + "'>").text(city);
						citySelect.append($option);
					}
	    		}, error:function(data) {
	    			alert("서버 전송실패");
	    		}
	    	});
    	});
	</script>
</body>
</html>