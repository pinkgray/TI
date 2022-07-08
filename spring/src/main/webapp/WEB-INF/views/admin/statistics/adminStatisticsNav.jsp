<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="columns is-multiline is-mobile is-vcentered" >
		<div class="column is-full-mobile" >
			<div class="tabs is-toggle is-fullwidth is-large">
				<ul class="statisticsNav">
					<li class="is-active">
						<a href="genderStatistics.sta">
							<span class="icon"><i class="fas fa-user"></i></span>
							<span>회원</span>
						</a>
					</li>
					<li>
						<a href='travelCountryStatisticsView.sta'>
							<span class="icon"><i class="fas fa-plane"></i></span>
							<span>여행</span>
						</a>
					</li>
					<li>
						<a href='paymentStatistics.sta'>
							<span class="icon"><i class="fas fa-coins"></i></span>
							<span>수익</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>

<script>
$(function(){
	var nav = $(".navbar-item").eq(16);
	nav.css("background", "#118fe4");
	nav.siblings().css("background", "rgb(32, 156, 238)");
});
</script>
</body>
</html>