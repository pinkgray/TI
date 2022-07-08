<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.subMenu.is-active a span {
		color: #209cee;
	}
</style>
</head>
<body>
	<!-- 서브메뉴 영역(일정표, 가계부, 구매리뷰)  -->
	<section class="section">
		<div class="tabs is-boxed">
			<ul>
				<li class="subMenu is-active">
					<a>
						<span class="icon is-small"><i class="far fa-calendar"></i></span>
				        <span>일정표</span>
				    </a>
				</li>
				<li class="subMenu">
					<a>
				        <span class="icon is-small"><i class="far fa-money-bill-alt"></i></span>
				        <span>가계부</span>
				    </a>
				</li>
				<li class="subMenu">
				    <a>
					    <span class="icon is-small"><i class="far fa-comment-alt"></i></span>
					    <span>구매리뷰</span>
				    </a>
				</li>
			</ul>
		</div> <!-- class="tabs is-boxed" -->
		
		<!-- 일정표 -->
		<div id="calendarArea" style="">
			<jsp:include page="travelDetailSubCalendar.jsp" />
		</div>
		
		<!-- 가계부 -->
		<div id="costArea" style="display: none;">
			<jsp:include page="travelDetailSubCost.jsp" />
		</div>
		
		<!-- 구매리뷰 -->
		<div id="reviewArea" style="display: none;">
			<jsp:include page="travelDetailSubReview.jsp" />
		</div>
	</section>
	
<script>
	$(".subMenu").click(function() {
		
		var sub = $(this).children('a').children('span').eq(1).text();
			
		$(".tabs.is-boxed").children('ul').children('li').removeClass();
		$(".tabs.is-boxed").children('ul').children('li').addClass("subMenu");
		$(this).addClass("is-active");
		
		if(sub == "일정표") {
			$("#calendarArea").removeAttr("style");
			$("#costArea").css("display","none");
			$("#reviewArea").css("display","none");
		}
		if(sub == "가계부") {
			$("#costArea").removeAttr("style");
			$("#calendarArea").css("display","none");
			$("#reviewArea").css("display","none");
		}
		if(sub == "구매리뷰") {
			$("#reviewArea").removeAttr("style");
			$("#calendarArea").css("display","none");
			$("#costArea").css("display","none");
		}
		
		
	});
</script>
</body>
</html>