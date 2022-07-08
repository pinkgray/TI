<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/statistics/Chart.bundle.min.js"></script>
<script src="resources/js/statistics/Chart.min.js"></script>
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
						<ul class="revenueNav">
							<li>
								<a href="paymentStatistics.sta">
									<span style="color:#ccccff;"><i class="far fa-credit-card"></i>&nbsp;결제금액</span>
								</a>
							</li>
							<li>
								<a href="rebateStatistics.sta">
									<span style="color:#ccccff;"><i class="fas fa-coins"></i>&nbsp;수익금</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<section class="section" id="cardSection">
				<div class="columns" align="center">
					
					<div class="statisticsArea" style="display: flex; width: 100%;">
						<div class="column is-1" style="justify-content: flex-start;" onclick="yearRebate('left')">
							<a><i class="title is-2 fas fa-caret-left"></i></a>
						</div>
						<input id="yearValue" value="${ rs.year }" style="display: none" type="number">
						<div class="column is-10" style="justify-content: center;">
							<canvas id="rebateChart" width="900"></canvas>
						</div>
						<div class="column is-1" style="justify-content: flex-end;" onclick="yearRebate('right')">
							<a><i class="title is-2 fas fa-caret-right"></i></a>
						</div>
					</div>
					
				</div>
			</section>
		</div>
	</div>
	
<script>
var ctx;
var myChart;
var today;
var year;

$(function(){
	var nav = $(".navbar-item").eq(16);
	nav.css("background", "#118fe4");
	nav.siblings().css("background", "rgb(32, 156, 238)");
	
	var menu = $(".statisticsNav li").eq(2);
    menu.addClass('is-active');
    menu.siblings().removeClass('is-active');
    
    var sub = $(".revenueNav li").eq(1);
    sub.addClass('is-active');
    sub.find('span').css("color", "#209cee");
    sub.siblings().removeClass('is-active');
	
    today = new Date();
    year = today.getFullYear();
    
    /* 차트 생성 */
    ctx = document.getElementById('rebateChart').getContext('2d');
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: [{
                label: '월별 수익금 환급액',
                data: [],
                borderColor: [
                    '#5CD1E5'
                ],
                backgroundColor: 'rgba(0, 0, 0, 0)',
                borderWidth: 2
            }]
        },
        options: {
            title: {
            	display: true,
            	text: year + '년 월별 수익금 환급액',
            	fontSize: 25
            }
        }
    });
    
    //데이터 넣기
    myChart.data.labels.push(['1월']);
    myChart.data.labels.push(['2월']);
    myChart.data.labels.push(['3월']);
    myChart.data.labels.push(['4월']);
    myChart.data.labels.push(['5월']);
    myChart.data.labels.push(['6월']);
    myChart.data.labels.push(['7월']);
    myChart.data.labels.push(['8월']);
    myChart.data.labels.push(['9월']);
    myChart.data.labels.push(['10월']);
    myChart.data.labels.push(['11월']);
    myChart.data.labels.push(['12월']);
    
	myChart.data.datasets[0].data.push([${rs.m1}]);
	myChart.data.datasets[0].data.push([${rs.m2}]);
	myChart.data.datasets[0].data.push([${rs.m3}]);
	myChart.data.datasets[0].data.push([${rs.m4}]);
	myChart.data.datasets[0].data.push([${rs.m5}]);
	myChart.data.datasets[0].data.push([${rs.m6}]);
	myChart.data.datasets[0].data.push([${rs.m7}]);
	myChart.data.datasets[0].data.push([${rs.m8}]);
	myChart.data.datasets[0].data.push([${rs.m9}]);
	myChart.data.datasets[0].data.push([${rs.m10}]);
	myChart.data.datasets[0].data.push([${rs.m11}]);
	myChart.data.datasets[0].data.push([${rs.m12}]);
	
	myChart.update();
	
});

	function yearRebate(text) {
		
		var today = new Date();
		var todayYear = today.getFullYear();
		
		var searchYear = year;
		
		console.log(searchYear, text);
		console.log(todayYear);
		
		if(text == 'right' && searchYear == todayYear) {
			alert("가장 최근 년도입니다.");
		}else {
			if(text == 'left') {
				searchYear = year - 1;
				console.log(searchYear);
			}else {
				searchYear = Number(year) + 1;
				console.log(searchYear);
			}
			
			console.log(searchYear);
			$.ajax({
				url : "rebateYearSearch.sta",
				data : {year : searchYear},
				type : "post",
				success : function(rs) {
					console.log(rs);
					
					if(rs != null) {
						year = searchYear;
						$("#yearValue").val(year);
					}else {
						$("#yearValue").val(searchYear);
					}
					
					
					myChart.clear();
					
					ctx = document.getElementById('rebateChart').getContext('2d');
				    myChart = new Chart(ctx, {
				        type: 'line',
				        data: {
				            labels: [],
				            datasets: [{
				                label: '월별 수익금 환급액',
				                data: [],
				                borderColor: [
				                    '#5CD1E5'
				                ],
				                backgroundColor: 'rgba(0, 0, 0, 0)',
				                borderWidth: 2
				            }]
				        },
				        options: {
				            title: {
				            	display: true,
				            	text: searchYear + '년 월별 수익금 환급액',
				            	fontSize: 25
				            }
				        }
				    });
		    		
					myChart.data.labels.push(['1월']);
				    myChart.data.labels.push(['2월']);
				    myChart.data.labels.push(['3월']);
				    myChart.data.labels.push(['4월']);
				    myChart.data.labels.push(['5월']);
				    myChart.data.labels.push(['6월']);
				    myChart.data.labels.push(['7월']);
				    myChart.data.labels.push(['8월']);
				    myChart.data.labels.push(['9월']);
				    myChart.data.labels.push(['10월']);
				    myChart.data.labels.push(['11월']);
				    myChart.data.labels.push(['12월']);
				    
				    if(rs != null) {
				    	myChart.data.datasets[0].data.push([rs.m1]);
						myChart.data.datasets[0].data.push([rs.m2]);
						myChart.data.datasets[0].data.push([rs.m3]);
						myChart.data.datasets[0].data.push([rs.m4]);
						myChart.data.datasets[0].data.push([rs.m5]);
						myChart.data.datasets[0].data.push([rs.m6]);
						myChart.data.datasets[0].data.push([rs.m7]);
						myChart.data.datasets[0].data.push([rs.m8]);
						myChart.data.datasets[0].data.push([rs.m9]);
						myChart.data.datasets[0].data.push([rs.m10]);
						myChart.data.datasets[0].data.push([rs.m11]);
						myChart.data.datasets[0].data.push([rs.m12]);
				    }else {
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    	myChart.data.datasets[0].data.push(0);
				    }
					
					myChart.update();
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