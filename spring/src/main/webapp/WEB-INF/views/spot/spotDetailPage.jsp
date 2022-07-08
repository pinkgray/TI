<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<link rel="stylesheet" href="resources/css/bulmaswatch.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/semantic.min.css">
<link rel="stylesheet" href="resources/css/jquery-ui.theme.min.css">
<link rel="stylesheet" href="resources/css/jquery-ui.structure.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/semantic.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<style>
  /* Always set the map height explicitly to define the size of the div
   * element that contains the map. */
  #map {
    height: 100%;
  }
  /* Optional: Makes the sample page fill the window. */
  html, body {
    height: 100%;
    margin: 0;
    padding: 0;
  }
  #floating-panel {
    position: absolute;
    top: 10px;
    left: 25%;
    z-index: 5;
    background-color: #fff;
    padding: 5px;
    border: 1px solid #999;
    text-align: center;
    font-family: 'Roboto','sans-serif';
    line-height: 30px;
    padding-left: 10px;
  }
</style>
<style>
	.section {
		width:90% !important;
		margin:0 auto;
	}
	a:hover {
		background-color: white !important;
		color: skyblue !important;
	}
	.field-label {
		text-align: left;
		width: 100px;
		flex-grow: 0 !important;
	}
	.label {
		width: 100px;
	}
	.spotInfo {
		text-align: left;
	}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" /> <br><br>
  <c:if test="${ !empty msg && msg eq '' && msg eq ' '}">
  	<script>
  		alert("${ msg }");
  	</script>
  </c:if>
  <!-- content Area -->
  <div class="columns">
  	<div class="column">
  		
  		<!-- title -->
			<section class="section">
				<h1 class="title" style="color:gray;">
					<i class="fas fa-chevron-circle-left" style="font-size: 40px; color: skyblue;" onclick="history.go(-1);"></i>
					<b style="color:black;">${ city.cityNameKo }</b> ${ city.cityNameEn }
				</h1>
			</section> <!-- end title -->
			
			<!-- content -->
			<section class="section">
				
				<!-- header -->
				<div class="field is-horizontal">
					<div class="field-body">
						<img src="${ spotFile[0].filePath }" style="margin-right:10px; width:45%; height:300px;">
						
						<!-- text area -->
						<div class="field" style="width: 55%;">
							<div class="field" style="justify-content: flex-end; text-align: right;">
								<div class="ui rating" data-max-rating="1"></div>
								<!-- <i class="far fa-star" style="font-size: 35px; color: yellow;"  onclick="clickStar(this);"></i> -->
							</div>
							<div class="field">
								<h3 class="title" style="color: gray;"><b>${ spotList.spotNameKo }</b> ${ spotList.spotNameEn }</h3>
							</div>
							
							<hr>
							<%-- 
							<div class="field is-horizontal">
								<div class="field-body">
									<div class="field is-grouped">
										<i class="fas fa-map-marker-alt" style="color: purple; font-size: 20px;"></i> &nbsp;&nbsp;
										<label class="label" style="width: 80%; color: gray;">${ spotList.spotAddress }</label> 
									</div>
								</div>
							</div> --%>
							
							<hr>
							
							<div class="field">
								<p class="control"> ${ spotList.spotContent }</p>
							</div>
							
						</div> <!-- end text area -->
						
					</div> <!-- end field body -->
				</div> <!-- end header -->
				
				<!-- <hr style="border: 0.5px solid gray;"> -->
				
				<!-- header sub pic area -->
				<%-- <div class="field is-horizontal">
					<div class="field-body">
						<c:forEach var="spotImg" items="${ spotFile }">
							<div class="field">
								<img class="image" src="${ spotImg.filePath }"  style="width: 300px; height: 180px;">
							</div>
						</c:forEach>
					</div>
				</div> --%> <!-- end header sub pic area -->
				
				<hr style="border: 0.5px solid gray;">
				
				<div class="field is-horizontal">
					<div class="field-body">
					
						<!-- map -->
						<div class="field" style="width: 60%;">
							<div id="floating-panel">
						      <input id="address" type="text" value="${ spotList.spotAddress }">
						      <input id="submit" type="button" value="Geocode">
						    </div>
							<div id="map" style="height: 400px;"></div>
						</div>
						
						<!-- info -->
						<div class="field" style="widht: 40%;">
							<!-- spot detail info area -->
							<div class="field">
										<h4 class="title">기본 정보</h4>
								<div class="field is-horizontal">
									<div class="field-body">
										<div class="field-label">
											<label class="label">상세주소</label>
										</div>
										<div class="field spotInfo">
											<label class="label" style="width: 80%;">${ spotList.spotAddress }</label>
										</div>
									</div>
								</div>
								
								<div class="field is-horizontal">
									<div class="field-body">
										<div class="field-label">
											<label class="label">연락처 </label>
										</div>
										<div class="field spotInfo">
											<label class="label" style="width: 80%;">${ spotList.spotPhone }</label>
										</div>
									</div>
								</div>
								
								<div class="field is-horizontal">
									<div class="field-body">
										<div class="field-label">
											<label class="label">홈페이지</label>
										</div>
										<div class="field spotInfo">
											<a style="width: 80%;" target="_blank" href="${ spotList.webAddress }">${ spotList.webAddress }</a>
										</div>
									</div>
								</div>
								
								<div class="field is-horizontal">
									<div class="field-body">
										<div class="field-label">
											<label class="label">영업시간</label>
										</div>
										<div class="field">
											<label class="label spotInfo" style="width: 80%;">${ spotList.openingHours }</label>
										</div>
									</div>
								</div>
							</div> <!-- end spot detail info area -->
						</div>
						
					</div> <!--  end field body -->
				</div> <!-- end is-horizontal -->
				
				
				
				<hr style="border: 0.5px solid gray;">
				
				<!-- 리뷰 평균 구하기 -->
				<c:set var="sum" value="0"/>
				<c:forEach var="grade" items="${ spotReviews }">
					<c:set var="sum" value="${ sum + grade.grade }"/>
				</c:forEach>
				<c:set var="length" value="${ fn:length(spotReviews) }"/>	
				<c:set var="avg" value="${ sum / length }"/>
				<!-- end 리뷰 평균 구하기 -->
				
				<!-- reviews area -->
				<div class="field is-horizontal">
					<div class="field-body">
						<h3 style="color: purple;"><strong style="color: black;">리뷰</strong>&nbsp; &nbsp;( ${ length } )</h3>
						<div class="field is-horizontal">
							<div class="field-body">
								<div class="field is-grouped" style="justify-content: flex-end;">
									<i class="fas fa-smile" style="color: red; font-size: 30px;"></i> &nbsp; &nbsp;
									<div class="field">
										<c:if test="${ fn:length(spotReviews) gt 0 }">
											<c:choose>
												<c:when test="${ avg eq 1 }">
													<h2 style="color: red; font-size: 25px;">별로예요</h2> &nbsp; &nbsp;
												 </c:when>
												<c:when test="${ avg eq 2 }"> 
													<h2 style="color: red; font-size: 25px;">아쉬워요</h2> &nbsp; &nbsp;
												</c:when>
												<c:when test="${ avg eq 3 }">
													<h2 style="color: red; font-size: 25px;">가볼만해요</h2> &nbsp; &nbsp;
												</c:when>
												<c:when test="${ avg eq 4 }"> 
													<h2 style="color: red; font-size: 25px;">꽤 가볼만 해요</h2> &nbsp; &nbsp;
												</c:when>
												<c:when test="${ avg eq 5 }">
													<h2 style="color: red; font-size: 25px;">꼭 가봐야 해요!</h2> &nbsp; &nbsp;
												</c:when>
											</c:choose>
										</c:if>
										<c:if test="${ fn:length(spotReviews) eq 0 }">
											<h2 style="color: #cc0066; font-size: 15px; margin-top: 5px;">처음으로 리뷰를 남겨주세요!</h2> &nbsp; &nbsp;
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div> <!-- end header -->
				</div> <!-- end reviews area -->
			<!-- insert review area -->
			<form action="insertSpotReview.sp" method="post">
				<div class="field" style="border: 0.3px solid gray; padding:10px;" id="reviewAreaId">
					<c:if test="${ !empty loginUser }">
						<input type="hidden" value="${ loginUser.memberId }" name="memberId">
						<input type="hidden" value="${ spotList.spotId }" name="spotId">
						<label class="label">${ loginUser.userName }</label>
					</c:if>
					<c:if test="${ empty loginUser }">
						<label class="label" style="width: 100%;">익명의 사용자</label>
					</c:if>
					<div class="field is-horizontal">
						<div class="field-body">
							<div class="field" style="width: 15%;">		
								<div class="field" align="center">
										<i class="fas fa-grin-hearts" style="font-size: 70px; color: #ff0066;" id="gradeIcon"></i>
						          </div>				
								<span class="select" style="margin-top: 10px; width: 100%;">
						            <select name="grade" style="width: 100%; text-align: center;" id="gradeOption">
						              <option value="5" selected>꼭 가봐야 해요!(5)</option>
						              <option value="4">꽤 가볼만해요(4)</option>
						              <option value="3">가볼만해요(3)</option>
						              <option value="2">아쉬워요(2)</option>
						              <option value="1">별로예요(1)</option>
						            </select>
						        </span>					          
							</div>
							
							<!-- text area -->
							<div class="field" style="width: 60%;">
					           <div class="control">
					             <textarea class="textarea" placeholder="댓글을 남겨주세요." id="reviewContent" name="reviewContent"></textarea>
					           </div>
					        </div> <!--  end text area -->
					        
					        <div class="field buttons" style="width: 5%;">
					        	<button class="button is-info is-outlined" style="width: 100%; height: 100%;" onclick="return insertReview();"> 등록하기 </button>
					        </div>
						</div>
					</div>					
				</div> <!--  end insert review area -->
			</form>
			
			<!-- review list -->
			<c:forEach var="reviews" items="${ spotReviews }">
				<div class="field" style="border: 0.3px solid gray; padding:10px; background-color: #f7e6ff; margin-top: 10px;">
				
					<div class="field is-horizontal">
						<div class="field-body">
							<c:set var="iconId" value="userIcon${ reviews['memberId'] }"/>
							<c:set var="gradeOpId" value="gradeOp${ reviews['memberId'] }"/>
							<div class="field" id="${ gradeId }" style="width: 15%; padding-top: 10px;" align="center">
							
								<!-- User review icon area -->
								<c:choose>
									<c:when test="${ reviews['grade'] eq 1 }"> 
										<i class="fas fa-laugh" style="font-size: 70px; color: #ff0066;" id="${ iconId }"></i>
									 </c:when>
									<c:when test="${ reviews['grade'] eq 2 }"> 
										<i class="fas fa-grin-beam-sweat" style="font-size: 70px; color: #ff0066;" id="${ iconId }"></i>
									</c:when>
									<c:when test="${ reviews['grade'] eq 3 }"> 
										<i class="fas fa-grin-beam" style="font-size: 70px; color: #ff0066;" id="${ iconId }"></i>
									</c:when>
									<c:when test="${ reviews['grade'] eq 4 }"> 
										<i class="fas fa-grin-squint" style="font-size: 70px; color: #ff0066;" id="${ iconId }"></i> 
									</c:when>
									<c:when test="${ reviews['grade'] eq 5 }"> 
										<i class="fas fa-grin-hearts" style="font-size: 70px; color: #ff0066;" id="${ iconId }"></i> 
									</c:when>
								</c:choose> <!-- end user review icon area -->
								
								<!-- user review text area -->
								<c:if test="${ loginUser.memberId ne reviews['memberId'] }">
									<c:choose>
										<c:when test="${ reviews['grade'] eq 1 }">
											<label class="label" style="width: 100%;">별로예요</label>
										 </c:when>
										<c:when test="${ reviews['grade'] eq 2 }"> 
											<label class="label" style="width: 100%;">아쉬워요</label>
										</c:when>
										<c:when test="${ reviews['grade'] eq 3 }">
											<label class="label" style="width: 100%;">가볼만해요</label> 
										</c:when>
										<c:when test="${ reviews['grade'] eq 4 }"> 
											<label class="label" style="width: 100%;">꽤 가볼만 해요</label>
										</c:when>
										<c:when test="${ reviews['grade'] eq 5 }">
											<label class="label" style="width: 100%;">꼭 가봐야 해요!</label>
										</c:when>
									</c:choose> 
								</c:if>
								
								<c:if test="${ loginUser.memberId eq reviews['memberId'] }">
									<span class="select" style="margin-top: 10px; width: 100%;">
							            <select name="grade" style="width: 100%; text-align: center;" id="${ gradeOpId }"
							            	 	onchange="updateGrade(this);">
							              <option value="5" <c:if test="${ reviews['grade'] eq 5 }">selected</c:if>>꼭 가봐야 해요!(5)</option>
							              <option value="4" <c:if test="${ reviews['grade'] eq 4 }">selected</c:if>>꽤 가볼만해요(4)</option>
							              <option value="3" <c:if test="${ reviews['grade'] eq 3 }">selected</c:if>>가볼만해요(3)</option>
							              <option value="2" <c:if test="${ reviews['grade'] eq 2 }">selected</c:if>>아쉬워요(2)</option>
							              <option value="1" <c:if test="${ reviews['grade'] eq 1 }">selected</c:if>>별로예요(1)</option>
							            </select>
							        </span>	
								</c:if>						        
								<!-- end user review text area -->
								
							</div>
							<!-- text area -->
							<div class="field" style="width: 85%;">
										
								<div class="field is-horizontal">
									<div class="field-body">
										<label class="label" style="width: 80%;" > ${ reviews['userName'] } </label>
										<c:if test="${ loginUser.memberId eq reviews['memberId'] }">
											<div class="field" align="right">
												<a href="#" style="color: #666699;" onclick="updateReview('${reviews['spotReviewId']}');">수정</a> &nbsp; &nbsp;
												<a href="#" style="color: #666699;" onclick="deleteReview('${reviews['spotReviewId']}');">삭제</a> 
											</div>
										</c:if>
									</div>
								</div>
								
					           <div class="control">
					           		<c:set var="contentId" value="content${ reviews['memberId'] }"/>
					           		<c:if test="${ loginUser.memberId eq reviews['memberId'] }">
					           			<textarea class="textarea" id="${ contentId }"> ${ reviews['reviewContent'] } </textarea>
					           		</c:if>
					           		<c:if test="${ loginUser.memberId ne reviews['memberId'] }">
							            <textarea class="textarea" readonly id="${ contentId }"> ${ reviews['reviewContent'] } </textarea>
					           		</c:if>
					           </div>
					        </div> <!--  end text area -->					       
						</div> <!-- end field-body -->
					</div> <!-- end is-horizontal -->
				</div> 
			</c:forEach><!-- end review list -->
				
			</section> <!-- end content -->
			
  	</div> <!-- end column -->
  </div> <!-- end columns -->
  <!-- end contentArea -->
  
  <!-- script area -->
  <script>
  	function clickStar(star){
  		console.log($(star));
  		$(star).removeClass();
  		$(star).addClass("fas fa-star");
  		
  	} //end func
  	
  	//리뷰등록용 함수
  	function insertReview(){
  		if('${ loginUser}' != null && '${ loginUser}' != "" && '${ loginUser}' != " "){ //로그인 되어 있을 때
  			if($("#reviewContent").val() != null && $("#reviewContent").val() != "" && $("#reviewContent").val() != " "){
  				return true
  			} else {
  				alert("리뷰 내용을 입력해 주세요");
  				return false;
  			}
  		} else { //로그인 되지 않았을 때
  			alert("로그인 후 리뷰 등록이 가능합니다.");
  			return false;
  		}
  	} //end func
  	
  	//리뷰 수정용 함수
  	function updateReview(spotReviewId){
  		
  		var grade = $("#gradeOp"+'${ loginUser.memberId }').val();
  		var content = $("#content"+'${ loginUser.memberId }').val();
  		$.ajax({
  			url : "updateSpotReview.sp",
  			type : "post",
  			data : { "spotReviewId" : spotReviewId,
  					 "grade" : grade, "content" : content},
  			success : function(data){
  				//alert(data);
  				location.reload();
  			},
  			error : function(Data){
  				alert("빈 값으로 수정할 수 없습니다.");
  			}, 
  			complete : function(){
  		    	location.href="#reviewAreaId";
  			}
  		}); //end ajax
  	} //end func
  	
  	//리뷰 삭제용 함수
  	function deleteReview(spotReviewId){
  		location.href = "deleteSpotReview.sp?spotReviewId=" + spotReviewId 
  						+ "&spotId=" +  '${ spotList.spotId }';
  	} //end func
  	
  	//점수 onchange 이벤트용 함수
  	function updateGrade(selectedValue){
  		var value =	$(selectedValue).val();
  		var classVar = "";
  		var iconId = "#userIcon" + '${ loginUser.memberId }';
  		switch(value){
			case "1" : classVar = "fas fa-laugh"; break;
			case "2" : classVar = "fas fa-grin-beam-sweat"; break;
			case "3" : classVar = "fas fa-grin-beam"; break;
			case "4" : classVar = "fas fa-grin-squint"; break;
			case "5" : classVar = "fas fa-grin-hearts"; break;
		} //end switch
  		$(iconId).attr("class", classVar);
  	} //end func
  	
  	$(function(){
  		$("#submit").click();
  		if( '${ msg }' != null && '${ msg }' != "" && '${ msg }' != " "){
  			console.log("test");
  			alert('${ msg }');
  			location.href="#reviewAreaId";
  		}
  		
  		$('.toggle.example .rating')
	  	  .rating({
	  	    initialRating: 2,
	  	    maxRating: 4
	  	  });
  		
  		$("#gradeOption").change(function(){
  			console.log($("#gradeOption option:selected").val());
  			var value = $("#gradeOption option:selected").val();
  			var classVar = "";
  			switch(value){
	  			case "1" : classVar = "fas fa-laugh"; break;
	  			case "2" : classVar = "fas fa-grin-beam-sweat"; break;
	  			case "3" : classVar = "fas fa-grin-beam"; break;
	  			case "4" : classVar = "fas fa-grin-squint"; break;
	  			case "5" : classVar = "fas fa-grin-hearts"; break;
  			} //end switch
  			
  			$("#gradeIcon").attr("class", classVar);
  			
  		});
  	});
  </script> 
  
  <script>
  function initMap() {
      var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15,
        center: {lat: -34.397, lng: 150.644}
      });
      var geocoder = new google.maps.Geocoder();

      document.getElementById('submit').addEventListener('click', function() {
        geocodeAddress(geocoder, map);
      });
    }

    function geocodeAddress(geocoder, resultsMap) {
      var address = document.getElementById('address').value;
      geocoder.geocode({'address': address}, function(results, status) {
        if (status === 'OK') {
          resultsMap.setCenter(results[0].geometry.location);
          var marker = new google.maps.Marker({
            map: resultsMap,
            position: results[0].geometry.location
          });
        } else {
          alert('Geocode was not successful for the following reason: ' + status);
        }
      });
    }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCBPsggRrwEVvAPZQ5vVU2p2z-nFGtVe8Y&callback=initMap"
    async defer></script>
    
  <!-- end script -->
</body>
</html>