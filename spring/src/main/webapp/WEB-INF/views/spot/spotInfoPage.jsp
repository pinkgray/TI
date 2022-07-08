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
<link rel="stylesheet" href="resources/css/spot/css/weather-icons.min.css">
<style>
	figure {
    	margin: 0em 0px !important;
    	margin-right:1em !important;
	}	
	.pageingBtn{
		width:30px;
		height:22px;
		background:white;
		color:purple;
		border:1px solid purple;
		border-radius:5px;
	}
	.pageingBtn:hover{
		background:purple;
		color:white;
	}
	#memberListTB *{
		text-align:center;
	}
	.section {
		width:90% !important;
		margin:0 auto;
	}
	.icon {
		font-size : 20px !important;
		margin-right:10px !important;
	}
	.widget-left-menu--compact {
		width: 400px !important;
	}
	
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" /> <br><br>
	<div class="columns">
		<div class="column">
			<!-- title -->
			<section class="section">
				<h1 class="title" style="color:gray;">
					<i class="fas fa-chevron-circle-left" style="font-size: 40px; color: skyblue;" onclick="history.go(-1);"></i>
					<b style="color:black;">${ countryInfo.countryNameKo }</b> &nbsp; ${ countryInfo.countryNameEn }
				</h1>
			</section> <!-- end title -->
			
			<!-- content -->
			<section class="section">
				
				<!-- header -->
				<div class="field is-horizontal">
					<div class="field-body">
							<img src="${ cityFile[0].filePath }" id="bigImgArea"
								 style="margin-right:10px; width:45%; height:300px;">
						<div class="field">
							<!-- 날씨 -->
							<!-- <div class="field" style="background-color:blue; width:100%; height:50%;" id="weaderArea">
								<div class="weather-wrapper">
								    <div class="weather-card madrid">
								        <div class="weather-icon sun"></div>
								        <h1>26º</h1>
								        <p>Madrid</p>
								    </div>
								    <div class="weather-card london">
								        <div class="weather-icon cloud"></div>
								        <h1>14º</h1>
								        <p>London</p>
								    </div>
								     <div class="weather-card madrid">
								        <div class="weather-icon sun"></div>
								        <h1>26º</h1>
								        <p>Madrid</p>
								    </div>
								    <div class="weather-card london">
								        <div class="weather-icon cloud"></div>
								        <h1>14º</h1>
								        <p>London</p>
								    </div>
								     <div class="weather-card london">
								        <div class="weather-icon cloud"></div>
								        <h1>14º</h1>
								        <p>London</p>
								    </div>
								</div>
								
								<p class="inspiration">Inspiration: <a href="http://drbl.in/olwj" target="_blank">Dribbble</a></p>
							</div> end 날씨
							환율<div class="field" style="background-color:yellow; width:100%; height:50%;"></div> -->
							<div class="field" style="justify-content: flex-end; text-align: right;">
								<div class="ui rating" data-max-rating="1"></div>
								<!-- <i class="far fa-star" style="font-size: 35px; color: yellow;"  onclick="clickStar(this);"></i> -->
							</div>
							<div class="field">
								<h3 class="title"><b>${ city.cityNameKo }</b></h3>
							</div>
							
							<hr>
							
							<div class="field is-horizontal">
								<div class="field-body">
									<div class="field is-grouped">
										<label class="label" style="width: 80%; color: gray;">${ city.cityNameEn }</label>
									</div>
								</div>
							</div>
							
							<hr>
							
							<div class="field">
								<p class="control"> ${ city.cityContent } </p>
							</div>
							
						</div>
					</div> <!-- end field body -->
				</div> <!-- end header -->
				
				<hr style="border: 0.5px solid gray;">
				
				<!-- header sub pic area -->
				<div class="field is-horizontal">
					<div class="field-body">
						<c:forEach var="cityFile" items="${ cityFile }">
							<div class="field" onclick="changeImg('${ cityFile.filePath }', this);" id="smallImgArea">
								<img class="image" src="${ cityFile.filePath }" style="width: 300px; height: 180px;">
							</div>
						</c:forEach>
					</div>
				</div> <!-- end header sub pic area -->
				
				<hr style="border: 0.5px solid gray;">
				
				<div class="field is-horizontal">
					<div class="field-body">
						<!-- 날씨 -->
						<div class="field" style="width: 100%; min-height: 100px; background-color: #3333cc;">
							<div class="field is-horizontal" style="background-color: #3333cc;">
								<span class="icon" style="width: 70%; height: auto; padding-top: 35px;">
									 <i class="wi wi-day-sunny" style="color: white; font-size: 80px;" id="iconResult"></i>
								</span>
								<span class="icon" style="width: 30%; height: auto; padding: 10px;">
									 <label class="label" style="color: white; font-size: 30px; margin-top: 10px;" id="tempArea"></label> &nbsp;
									 <i class="wi wi-celsius" style="color: white; font-size: 50px;"></i>
								</span>
							</div>
							
							<div class="field is-horizontal" style="widht: 100%; padding: 10px; background-color: #3333cc; float: right;">
								<div class="field-body">
									<label class="label" style="color: white; font-style: italic;" id="weatherCity"></label>&nbsp;&nbsp;&nbsp;
									<label class="label" style="color: white;" id="weatherStatus"></label>
								</div>
							</div>
							
							<div class="field is-horizontal" style="width: 100%;">
								<div class="field" style="width: 100%; height: auto; padding: 10px; background-color: white; border: 1px solid #3333cc;" align="center">
									 <i class="wi wi-strong-wind" style="color: black; font-size: 20px;"></i>
									 <label class="label" style="color: black;" id="windSpeed"></label>
								</div>
								<div class="field" style="width: 100%; height: auto; padding: 10px; background-color: white; border: 1px solid #3333cc;" align="center">
									 <i class="wi wi-humidity" style="color: black; font-size: 20px;"></i>
									 <label class="label" style="color: black;" id="humidityAmount"></label>
								</div>
								<div class="field" style="width: 100%; height: auto; padding: 10px; background-color: white; border: 1px solid #3333cc;" align="center">
									 <i class="wi wi-cloud" style="color: black; font-size: 20px;"></i>
									 <label class="label" style="color: black;" id="cloudAmount"></label>
								</div>
							</div>
						</div>
						
						<!-- 환율 -->
						<!-- <div class="field" style="width: 100%; height: 100px; background-color: yellow;">
						
						</div> -->
					</div>
				</div>
				
				
			</section> <!-- end content -->
			
		</div> <!-- column -->
	</div> <!-- end columns -->
	
	<!-- spot menu area -->
	<div class="tabs is-toggle is-fullwidth is-large">
	    <ul>
	    
	      <li>
	      	<a class="button is-info is-outlined" onclick="tabClick(1);">
	      		<span class="icon"> <i class="fas fa-plane-departure"></i> </span>
	      		가볼만한 곳 (${ fn:length(spotList) })
	      	 </a>
	      </li>
	      
	      <!-- <li>
	      	<a class="button is-info is-outlined" onclick="tabClick(2);">
	      		<span class="icon"> <i class="far fa-paper-plane"></i> </span>
	      		날씨
	      	 </a>
	      </li>
	      
	      <li>
	      	<a class="button is-info is-outlined" onclick="tabClick(3);">
	      		<span class="icon"> <i class="far fa-paper-plane"></i> </span>
	      		환율
	      	 </a>
	      </li> -->
	      
	      <!-- <li><a class="button is-info is-outlined"> 호텔 </a></li> -->
	      <!-- <li>
	      	<a class="button is-info is-outlined" onclick="tabClick(4);">
	      		<span class="icon"> <i class="fas fa-map-marked-alt"></i> </span>
	      		지도
	      	 </a>
	      </li> -->
	      
	    </ul>
	  </div> <!-- end spot menu area -->
	  
	<div class="columns" id="spotsArea" >
		<div class="column" style="overflow: scroll; height: 600px;">
			<!-- list area -->
			<section class="section">
			 	<c:forEach var="cityInfo" items="${ spotList }">
			 		<div class="field" style="border:0.5px solid gray; padding:10px;" class="listItem">
						<article class="media">
						    <figure class="media-left">
						      <p class="image" style="width: 280px; height: 180px; overflow: hidden">
						        <img src="${ cityInfo.filePath }" style="width: 280px; height: auto;">
						      </p>
						    </figure>
		    				<div class="media-content" style="padding: 10px;" onclick="detailSpot('${ cityInfo.spotId }');">
		      					<div class="content">
							        <p>
							          <strong style="font-size: 20px;">${ cityInfo.spotNameKo }</strong> <br>
							          <strong style="color: gray;">${ cityInfo.spotAddress }</strong>
							          <br><br> ${ cityInfo.spotContent } 
							        </p>
		      					</div>
		        			</div>
					    <div class="media-right" onclick="likeySpot('${ cityInfo.spotId }');">
					      <a class="level-item">
					        <span class="icon is-small"> <i class="far fa-star" id="${ cityInfo.spotId }"></i> </span>
					      </a>
					    </div>
					  </article>
			 		</div>
			 	</c:forEach>
			 	
			 	<!-- paging -->
				<%-- <div class="field" >
					<nav class="pagination">
				  	<ul class="pagination-list" style="justify-content: center;">
				  		
				  		<!-- 이전 -->
				  		<c:if test="${ pi.currentPage <= 1 }"> 
				  			<li><button class="pageingBtn" style="border-color: gray;"> < </button></li>
				  		</c:if>
				  		<c:if test="${ pi.currentPage > 1 }">
				  			<c:url var="mListBack" value="selectSpotInfoUser.sp">
				  				<c:param name="cityId" value="${ city.cityId }"/>
				  				<c:param name="currentPage" value="${ pi.currentPage - 1 }"/>
				  			</c:url>
				  			<li><button class="pageingBtn" onclick="location.href='${ mListBack }'"> < </button></li>
				  		</c:if><!-- end 이전 -->
				  		
				  		<!-- page number -->
				  		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				  			<c:if test="${ p eq pi.currentPage }">
				  				<li><button class="pageingBtn" style="border-color: gray;"> ${ p } </button></li>
				  			</c:if>
				  			<c:if test="${ p ne pi.currentPage }">
				  				<c:url var="mListCheck" value="selectSpotInfoUser.sp">
				  					<c:param name="cityId" value="${ city.cityId }"/>
				  					<c:param name="currentPage" value="${ p }"/>
				  				</c:url>
				  				<li><button class="pageingBtn" onclick="location.href='${ mListCheck }'"> ${ p } </button></li>
				  			</c:if>
				  		</c:forEach> <!-- end page number -->
				  		
				  		<!-- 다음 -->
				  		<c:if test="${ pi.currentPage >= pi.maxPage }">
				  			<li><button class="pageingBtn" style="border-color: gray;"> > </button></li>
				  		</c:if>
				  		<c:if test="${ pi.currentPage < pi.maxPage }">
				  			<c:url var="mListEnd" value="selectSpotInfoUser.sp">
				  				<c:param name="cityId" value="${ city.cityId }"/>
				  				<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
				  			</c:url>
				  			<li><button class="pageingBtn" onclick="location.href='${ mListEnd }'"> > </button></li>
				  		</c:if> <!-- end 다음 -->

				  	</ul>
				  </nav>
				</div> --%> <!-- end paging -->
				
			</section> <!-- end list area -->
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<!-- weather area -->
	<div class="columns" id="weaderArea">
		<div class="column">
			<section class="section">
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field" style="width: 100%; min-height: 100px; background-color: #7070db; color: white;">
							
									
						</div>
					</div>
				</div> <!-- end is-horizontal -->
			</section>
		</div>
	</div> <!-- end weather -->

	<script>
		$(function(){
			//tab 보여주기
			$("#spotsArea").show();
			$("#weaderArea").hide();
			
			console.log('${ countryInfo.countryId }');
			var countryId = '${ countryInfo.countryId }';
			var cityName = '${ city.cityNameEn }';
	        $.ajax({
	            url: "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&appid="+"ae0fb7b78db51eda5b256e2d45f056a7",
	            dataType: "json",
	            type: "GET",
	            async: "false",
	            success: function(resp) {
	                console.log(resp);
	                console.log("현재온도 : "+ (resp.main.temp- 273.15) );
	                console.log("현재습도 : "+ resp.main.humidity);
	                console.log("날씨 : "+ resp.weather[0].main );
	                console.log("상세날씨설명 : "+ resp.weather[0].description );
	                console.log("날씨 이미지 : "+ resp.weather[0].icon );
	                console.log("바람   : "+ resp.wind.speed );
	                console.log("나라   : "+ resp.sys.country );
	                console.log("도시이름  : "+ resp.name );
	                console.log("구름  : "+ (resp.clouds.all) +"%" );
	                var iconClass = "";
	                var desc = resp.weather[0].description + "";
	                var status = "";
	                switch(desc){
	                	case "sky is clear": iconClass = "wi wi-night-clear"; status = "맑음"; break;
	                	case "few clouds": iconClass = "wi wi-cloudy"; status = "구름 조금"; break;
	                	case "scattered clouds" : iconClass = "wi wi-cloudy"; status = "구름 약간"; break;
	                	case "broken clouds" : iconClass = "wi wi-cloudy"; status = "구름 약간"; break;
	                	case "overcast clouds" : iconClass = "wi wi-day-sunny-overcast"; status = "흐림"; break;
	                	case "shower rain" : iconClass = "wi wi-day-showers"; status = "소나기"; break;
	                	case "light rain" : iconClass = "wi wi-day-storm-showers"; status = "약한 비"; break;
	                	case "moderate rain" : iconClass = "wi wi-day-showers"; status = "비 내림"; break;
	                	case "Rain" : iconClass = "wi wi-rain"; status = "비"; break;
	                	case "Thunderstorm" : iconClass = "wi wi-thunderstorm"; status = "천둥번개"; break;
	                	case "snow" : iconClass = "wi wi-snow"; status = "눈"; break;
	                	case "mist" : iconClass = "wi wi-fog"; status = "안개"; break;
	                	case "heavy intensity rain" : iconClass = "wi wi-day-showers"; status = "비 내림"; break;
	                	default : iconClass = "wi wi-day-sunny"; status = "화창함"; break;
	                } //end switch
	                $("#iconResult").attr("class", iconClass);
	                $("#weatherStatus").text(status);
	                $("#weatherCity").text(resp.name + ", " + resp.sys.country);
	                $("#tempArea").text(Math.floor(resp.main.temp- 273.15));
	                $("#windSpeed").text((resp.wind.speed) + "m/s");
	                $("#humidityAmount").text((resp.main.humidity) + "%");
	                $("#cloudAmount").text((resp.clouds.all) +"%");
	            }
	        });

		});
		
		//명소 좋아요 추가
		function likeySpot(spotId){
			var icon = "#";
			if('${ loginUser }' == null || '${ loginUser }' == "" || '${ loginUser }' == " "){
				alert ("회원가입이 필요한 서비스 입니다.");
			} else {
				$.ajax({
					url : "insertLikeySpot.sp",
					type : "post",
					data : {"spotId" : spotId},
					success : function(data){
						alert(data);
						icon += spotId;
						if(data == "좋아요 리스트에 명소를 추가했습니다."){
							$(icon).attr("class", "fas fa-star");
							console.log($(icon));
						} else {
							$(icon).attr("class", "far fa-star");
							console.log($(icon));
						} //end if
					},
					error : function(data){
						alert(data);
					}
				}); //end ajax
			} //end if 
		} //end func
		
		function changeImg(srcVal, divArea){
			$("#bigImgArea").attr("src", srcVal);
		} //end func
		
		function detailSpot(spotId){
			location.href = "selectSpotDetailInfo.sp?spotId=" + spotId;
		}
		
		//탭클릭
		function tabClick(num){
			switch(num){
				case 1: 
					$("#spotsArea").show();
					$("#weaderArea").hide();
					break;
				case 2: 
					$("#spotsArea").hide();
					$("#weaderArea").show();
					break;
				case 3: 
					break;
				case 4: 
					break;			
			} //end switch
		} //end func
	</script>
</body>
</html>