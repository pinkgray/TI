<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style>
	figure {
	    margin: 0em 0px !important;
	}
	.conditionStyle {
		color: #660066 !important;
		font-weight: bold !important;
	}
	.conditionStyle:hover {
		color: #3366ff !important;
	}
</style>
</head>
<body>
	<div id="topPosition"></div>
	<jsp:include page="../common/mainNav.jsp" /> <br><br>
	<div class="columns is-mobile"  style="width:90%; margin:0 auto;">
		<div class="column">
			<!-- condition area -->
			<nav class="breadcrumb">
			    <ul style="justify-content:flex-end;">
			      <li> <a class="conditionStyle" href="selectAllSpotUser.sp?condition=all">주요도시</a> </li>
			      <li> <a class="conditionStyle" onclick="selectContinent('아시아');">아시아</a> </li>
			      <li> <a class="conditionStyle" onclick="selectContinent('유럽');">유럽</a> </li>
			      <li> <a class="conditionStyle" onclick="selectContinent('오세아니아');">오세아니아</a> </li>
			      <li> <a class="conditionStyle" onclick="selectContinent('북아메리카');">북미</a> </li>
			      <li> <a class="conditionStyle" onclick="selectContinent('남아메리카');">중남미</a> </li>
			  </ul>
			</nav> <!-- end condition area -->
			
			<!-- country area -->
			<div class="field is-horizontal">
				<div class="field-body">
					<div class="field">
						<div class="buttons">	
							<c:forEach var="country" items="${ countryList }">
								<a  onclick="selectCountry('${country.countryId}');"
									class="button is-primary is-outlined is-rounded"> ${ country.countryNameKo } </a>
							</c:forEach>
						</div>
					</div>
				</div> <!-- end field-body -->
			</div> <!-- end country area -->		
			
			<!-- card area -->
			<!-- card area -->
			<c:forEach var="i" begin="0" end="${ fn:length(cityMap) - 1 }" step="3">
				<div class="field is-horizontal">
					<div class="field-body">
						<c:if test="${ fn:length(cityMap) - 1 <= (i + 2) }">
							<c:set var="lastNum" value="${ fn:length(cityMap) - 1 }"/>
						</c:if>
						<c:if test="${ fn:length(cityMap) - 1 > (i + 2) }">
							<c:set var="lastNum" value="${ i + 2 }"/>
						</c:if>
						<c:forEach var="j" begin="${ i }" end="${ lastNum }" step="1">
							<div class="field">
								<div class="card" style="min-width: 300px; max-width: 450px;" onclick="clickCard('${ cityMap[j]['cityId'] }');">
							     <div class="card-image"> 
							     	<figure class="image"> <img src="${ cityMap[j]['filePath'] }" alt="Image" style="height: 230px;"> </figure>
							     </div>
							     <div class="card-content">
							       <div class="media">
							         <div class="media-content">
							           <p class="title">${ cityMap[j]['cityNameKo'] }</p>
							         </div>
							       </div>
							       <div class="content" style="height: 120px;"> ${ cityMap[j]['cityContent'] } </div>
							     </div>
							   </div> <!-- end cord -->
							</div> <!-- end field -->
						</c:forEach>
					</div> <!-- end field-body -->
				</div> <!-- end cardArea -->
			</c:forEach>
			
			<i class="fas fa-caret-square-up" onclick="location.href='#topPosition'"
			   style="position:fixed; font-size:40px; right:20px; bottom:10px; color: #5c0099;"></i>
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<script>
		//카드 클릭했을 때
		function clickCard(cityId){
			location.href='selectSpotInfoUser.sp?cityId=' + cityId
					+ "&currentPage=1";
		}
		
		//대륙으로 조회하기 위한 함수
		function selectContinent(continent){
			console.log(continent);
			location.href="selectAllSpotUser.sp?condition=" + continent;
		}
		
		//국가로 조회하기 위한 함수
		function selectCountry(countryId){
			console.log(countryId);
			location.href="selectConditionSpotUser.sp?countryId=" + countryId + "&condition=" + '${ nowContinent }';
		}
	</script>
</body>
</html>