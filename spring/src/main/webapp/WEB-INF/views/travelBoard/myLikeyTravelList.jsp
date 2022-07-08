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
</head>

<style>
	.blurring {
		cursor: pointer;
	}
	.content {
		cursor: pointer;
	}
	#travelListArea {
      padding: 3rem 1.5rem;
      padding-top: 0;
   }
   .card {
      cursor: pointer;
      text-align: center;
   }
	#imgDiv{
  	 width : 100%;
  	 height : 300px;
   }
   
   #imgDiv img{
   	position: absolute; top:0; left: 0;
	width: 100%;
	height: 100%;
   }
</style>

<body>
	
	<jsp:include page="../common/mainNav.jsp" />
	
	<div class="columns is-mobile">
	<div class="column">
		<section class="section" style="padding-bottom:0">
			<jsp:include page="../common/myPageHeader.jsp" />
		</section>
		
		<!-- 서브메뉴바 영역 -->
		<section class="section" style="padding-top:0;">
		
			<div class="tabs is-toggle is-toggle-rounded" style="justify-content: center; width: 100%;">
				<ul>
					<li class="is-active" style="width: 100%;">
						<a>
						<span class="icon"><i class="fas fa-paper-plane"></i></span>
						<span>여행일정 좋아요</span>
						</a>
					</li>
					<li style="width: 100%;">
						<a href="selectAllLikeySpot.sp">
						<span class="icon"><i class="fas fa-globe-americas"></i></span>
						<span>여행지 좋아요</span>
						</a>
					</li>
				</ul>
			</div>			
		</section>
		
		<!-- 본문 -->
		
		<div class="column">
			<section class="section">
			      
         <!-- 게시글 영역 -->
         
		<c:choose>
			<c:when test="${ fn:length(tbList) > 0 }">
				<div class="ui special cards">
				  <c:forEach var="tbList" items="${ tbList }" varStatus="status">
					<div class="card">
						<div class="blurring dimmable image" onclick="location.href='travelDetailForm.tb?trvId=${ tbList.trvId }'">
							<div class="ui dimmer">
								<div class="content">
									<div class="center">
									<p class="title is-4" style="color: white;">${ tbList.trvTitle }</p>
									</div>
								</div>
							</div>
					
								<div id = "imgDiv">
									<c:if test="${ !empty tbList.schFiles[0] }">
										<img src="resources/uploadFiles/${ tbList.schFiles[0].changeName }">
									</c:if>
									<c:if test="${ empty tbList.schFiles[0] }">
										<img src="resources/images/logo1.png">
									</c:if>
								</div>
               		</div>
               
               <div class="content">
                  <div class="header">
                     <p class="title is-3">${ tbList.trvTitle }</p>
                  </div>
                  <div class="meta">
                     <div>
	                     <c:choose>
	                     	<c:when test="${ fn:length(tbList.trvCities) > 0 }">
	                     		<c:forEach var="city" items="${ tbList.trvCities }" varStatus="st">
	                     			<a>@${ city.countryNameKo } ${ city.cityNameKo }</a>
	                     			<c:if test="${ st.count ne fn:length(tbList.trvCities) }">&nbsp;/&nbsp;</c:if>
	                     		</c:forEach>
	                     	</c:when>
	                     	<c:otherwise>
	                     		<p>나라태그 없음</p>
	                     	</c:otherwise>
	                     </c:choose>
                     </div>
                     <fmt:parseDate var="startDate" value="${ tbList.startDate }" pattern="yyyy-MM-dd" />
                     <fmt:parseNumber value="${ startDate.time / (1000*60*60*24) }" integerOnly="true" var="startDay" />
                     <fmt:parseDate var="endDate" value="${ tbList.endDate }" pattern="yyyy-MM-dd" />
                     <fmt:parseNumber value="${ endDate.time / (1000*60*60*24) }" integerOnly="true" var="endDay" />
                     <p class="date"><small>[${ endDay - startDay + 1 }DAYS] ${ tbList.startDate } ~ ${ tbList.endDate }</small></p>
                     <a class="button is-small"> 
                        <span class="icon is-small"><i class="fa fa-user"></i></span> 
                        <span> ${ tbList.userName } </span>
                     </a>
                  </div>
               </div>
               
               <div class="extra content">
					<c:choose>
						<c:when test="${ fn:length(tbList.trvTags) > 0 }">
                     		<c:forEach var="trvTags" items="${ tbList.trvTags }">
                     			<a>#${ trvTags.tagName }</a>
                     		</c:forEach>
                     	</c:when>
                     	<c:otherwise>
                     		<p>여행태그 없음</p>
                     	</c:otherwise>
                     </c:choose>
               	
               </div>
               <div class="extra content">
					<div class="button is-danger is-rounded" onclick="myLikeyTravelCancel(${ tbList.trvId })">
						<i class="fas fa-heart"></i>
						&nbsp;<p>좋아요 취소</p>
					</div>
				</div>	
            </div>   <!-- class="card" 글 하나-->
            </c:forEach>
            </div>   <!-- class="ui special cards" -->
           </c:when>
           <c:otherwise>
           	<div class="ui special cards" style="justify-content: center;">
           		<div align="center">
           			<h3 class="title is-1"><i class="fas fa-search"></i></h3>
           			<p>좋아요 한 여행일정이 없습니다.</p>
           		</div>
           	</div>
           </c:otherwise>
           </c:choose>
		</section>
	</div>
         
      </div>   <!-- class="column" -->
   </div>   <!-- class="columns is-mobile" -->

<script>
	
	//각 글에 마우스 올렸을 때 설명글
	$('.special.cards .image').dimmer({
	  on: 'hover'
	});
	
	function likeyCancel(num) {
		
		$("#travelMake").click(function() {
			alert("일정만들기 작성");
			location.href="travelMake.tb";
		})
		
		$(".cancel").click(function(){
			$('#myModal').removeClass('is-active');
	    });
	}
	
	function myLikeyTravelCancel(trvId) {
		var answer = confirm("좋아요를 취소하시겠습니까?");
		
		if(answer) {
			$.ajax({
				url : "travelLikeyDelete.tb",
				data : {trvId : trvId, memberId : ${ loginUser.memberId } },
				success : function(data) {
					alert("좋아요 취소 처리");
					location.href="myLikeyTravelListView.tb";
				}
			})
		}
	}
	
	$(function() {
		var menu = $(".myPageMenu li").eq(2);
          menu.addClass('is-active');
          menu.siblings().removeClass('is-active');
	});
	
</script>

</body>
</html>