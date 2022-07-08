<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<style>
	.column .columns {
		margin:0 !important;
	}
	.statisticsArea {
		width: 100%;
		height: 100%;
	}
	#myChart {
		width: 100%;
		height: 100%;
	}
</style>
<body>
	<jsp:include page="../../common/adminMainNav.jsp"/>
	
	<div class="columns is-mobile">
		<div class="column">
			<section class="section" id="headerSection">
				<jsp:include page="adminStatisticsNav.jsp" />
			</section>
			<section class="section" id="bredcrumbSection" style="padding-top:0; padding-bottom:0">
				<div class="column">
					<div class="tabs is-boxed">
						<ul class="travelStaNav">
							<li>
								<a href="travelCountryStatisticsView.sta">
									<span style="color:#ccccff;"><i class="fas fa-globe-americas"></i>&nbsp;나라별</span>
								</a>
							</li>
							<li>
								<a href="travelTagStatisticsView.sta">
									<span style="color:#ccccff;"><i class="fas fa-tags"></i>&nbsp;여행스타일별</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<section class="section" id="cardSection">
				<div class="columns">
				
					<div class="statisticsArea" style="display: flex; width: 100%;">
						
						<input id="yearValue" value="" style="display: none" type="number">
						
						<div class="statisticsArea" align="center">
							<div class="field has-addons" style="justify-content: flex-end; margin-top: 1em;" align="right">
								<p class="control">
									<span class="select">
										<select id="monthSelect">
											<option value="1">1월</option>
											<option value="2">2월</option>
											<option value="3">3월</option>
											<option value="4">4월</option>
											<option value="5">5월</option>
											<option value="6">6월</option>
											<option value="7">7월</option>
											<option value="8">8월</option>
											<option value="9">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
									</span>
								</p>
							</div>
							
							<div style="display: table-cell;">
								<span style="justify-content: flex-start; display: inline-block; vertical-align: middle;" onclick="yearCountry('left')">
									<a><i class="title is-2 fas fa-caret-left"></i></a>
								</span>
								
								&nbsp;&nbsp;
								
								<span class="title is-4" style="color: #424242; vertical-align: middle;"><span id="monthText"></span>월 인기 여행나라 10</span>
								
								&nbsp;&nbsp;
								
								<span style="justify-content: flex-start; display: inline-block; vertical-align: middle;" onclick="yearCountry('right')">
									<a><i class="title is-2 fas fa-caret-right"></i></a>
								</span>
							</div>
							<br>
							<div id="regions_div" style="width: 900px; height: 500px;"></div>
						</div>
					
					</div>
				</div>
			</section>
		</div>
	</div>
	
<script>
var today;
var year;
var month;
var day = "";

$(function(){
	var nav = $(".navbar-item").eq(16);
	nav.css("background", "#118fe4");
	nav.siblings().css("background", "rgb(32, 156, 238)");
	
	var menu = $(".statisticsNav li").eq(1);
    menu.addClass('is-active');
    menu.siblings().removeClass('is-active');
    
    var sub = $(".travelStaNav li").eq(0);
    sub.addClass('is-active');
    sub.find('span').css("color", "#209cee");
    sub.siblings().removeClass('is-active');
    
  	//현재 월 기준 인기 태그 10위 조회
    today = new Date();
    year = today.getFullYear();
    
    $("#yearValue").val(year);
    
    month = today.getMonth() + 1;
    
    $("#monthSelect option").each(function() {
    	if($(this).val() == month) {
    		$(this).attr("selected", "selected");
    	}
    });
    
    var day = "";
    if(month < 10) {
    	month = '0' + month;
    }
    
    $("#monthText").text(year + "년 " + month);
    
    day = year + '-' + month;
    
	//현재 월 기준 인기 나라 10위 조회
    today = new Date();
    year = today.getFullYear();
    month = today.getMonth() + 1;
    
    day = "";
    if(month < 10) {
    	day = year + '-0' + month;
    }else {
    	day = year + '-' + month;
    }
    
    $.ajax({
    	url : "travelCountryMonthStatistics.sta",
    	data : {month : day},
    	type : "post",
    	success : function(list) {
    		
    	    google.charts.load('current', {
    	        'packages':['geochart'],
    	        'mapsApiKey': 'AIzaSyD19cUtWTevnQL9Nh6Nd8BMgPoQs6OWyX0'
			});
    		
    		google.charts.setOnLoadCallback(drawRegionsMap);
    		
    		function drawRegionsMap() {

    			var chatarray = new Array;
    			var array = ['Country', '인기도'];
    			chatarray.push(array);
    			
    			if(list.length > 0) {
    				for (var i = 0 ; i < list.length ; i++){
    					var chlist = [list[i].countryNameEn, list[i].countryCount];
     					chatarray.push(chlist);
     				}
    			}
    			
    			var data = google.visualization.arrayToDataTable(chatarray);
    			var options = {};
    			var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
    			
    			chart.draw(data, options);
    			
    		}
    		
    	},
    	error : function(data) {
    		alert("접속에러");
    	}
    });
    
});

//월 검색
var selection_array = [];
selection_array.push(['Country', '인기도']);

$("#monthSelect").change(function() {
	month = $(this).val();
	if(month < 10) {
    	month = '0' + month;
    }
	$("#monthText").text(year + "년 " + month);
	day = year + '-' + month;
	
	$.ajax({
    	url : "travelCountryMonthStatistics.sta",
    	data : {month : day},
    	type : "post",
    	success : function(list) {
    		
    		google.charts.setOnLoadCallback(drawRegionsMap);
    		
    		function drawRegionsMap() {
    			
			var chatarray = new Array;
			var array = ['Country', '인기도'];
			
			chatarray.push(array);
			
			if(list.length > 0) {
				for (var i = 0 ; i < list.length ; i++){
					var chlist = [list[i].countryNameEn, list[i].countryCount];
					chatarray.push(chlist);
				}
			}
			
			var data = google.visualization.arrayToDataTable(chatarray);
			var options = {};
			var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
			
			chart.draw(data, options);
    		}
    	},
    	error : function(data) {
    		alert("접속에러");
    	}
    });
});

function yearCountry(text) {
	var today = new Date();
	var todayYear = today.getFullYear();
	var searchYear = year;
	
	if(text == 'right' && searchYear == todayYear) {
		alert("가장 최근 년도입니다.");
	}else {
		if(text == 'left') {
			searchYear = year - 1;
		}else {
			searchYear = Number(year) + 1;
		}
		
		var month = $("#monthSelect option:selected").val();
		
		if(month < 10) {
	    	month = '0' + month;
	    }
		
		var searchDay = searchYear + "-" + month;
		
		$.ajax({
			url : "travelCountryMonthStatistics.sta",
	    	data : {month : searchDay},
	    	type : "post",
	    	success : function(list) {
				
				$("#yearValue").val(searchYear);
				year = searchYear;
				
				$("#monthText").text(searchYear + "년 " + month);
				
				google.charts.setOnLoadCallback(drawRegionsMap);
	    		
	    		function drawRegionsMap() {
	    			
				var chatarray = new Array;
				var array = ['Country', '인기도'];
				
				chatarray.push(array);
				
				if(list.length > 0) {
					for (var i = 0 ; i < list.length ; i++){
						var chlist = [list[i].countryNameEn, list[i].countryCount];
						chatarray.push(chlist);
					}
				}
				
				var data = google.visualization.arrayToDataTable(chatarray);
				var options = {};
				var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));
				
				chart.draw(data, options);
	    		}
				
				
				
				
				
			},
			error : function(data) {
				alert("접속에러");
			}
		});
	}
}
</script>
	
</body>
</html>