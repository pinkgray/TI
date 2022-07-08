<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
						<ul class="userStaNav">
							<li>
								<a href="genderStatistics.sta">
									<span style="color:#ccccff;"><i class="fas fa-venus-mars"></i>&nbsp;성별</span>
								</a>
							</li>
							<li>
								<a href="ageGroupStatistics.sta">
									<span style="color:#ccccff;"><i class="fas fa-user-clock"></i>&nbsp;연령별</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<c:forEach var="user" items="${ user }">
				<input value="${ user.ageGroup }" class="ageGroupname" style="display: none;">
				<input value="${ user.ageCount }" class="ageGroupCount" style="display: none;">
			</c:forEach>
			<section class="section" id="cardSection">
				<div class="columns">
					
					<div class="statisticsArea" style="width: 100%;">
						<canvas id="genderChart" width="900"></canvas>	
					</div>
					
				</div>
			</section>
		</div>
	</div>
	
<script>
$(function(){
	var nav = $(".navbar-item").eq(16);
	nav.css("background", "#118fe4");
	nav.siblings().css("background", "rgb(32, 156, 238)");
	
	var menu = $(".userStaNav li").eq(1);
    menu.addClass('is-active');
    menu.find('span').css("color", "#209cee");
    menu.siblings().removeClass('is-active');
    
    var ctx = document.getElementById('genderChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: '연령별 회원수',
                data: [],
                backgroundColor: [
                	'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                	'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
            title: {
            	display: true,
            	text: '연령대별 회원 수',
            	fontSize: 25
            }
        }
    });
    
    /* 데이터 업데이트 */
    
    //데이터 넣기
    var ageGroup = [];
    var ageCount = [];
    var allCount = 0;

    $(".ageGroupname").each(function() {
    	ageGroup.push($(this).val());
    });
    
    $(".ageGroupCount").each(function() {
    	ageCount.push($(this).val());
    	allCount += $(this).val();
    });
    
    for(var i = 0; i < ageGroup.length; i++) {
		
    	myChart.data.labels.push(ageGroup[i]);
		myChart.data.datasets[0].data.push(ageCount[i]);
		
		myChart.update();
	}
    
});

</script>
	
</body>
</html>