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
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
			</section>
		
		<div class="column">
			<section class="section">
			
	         	<!-- 게시글 영역 -->
	         	<c:choose>
				<c:when test="${ fn:length(tbList) > 0 }">
					<div class="ui special cards">
		            <c:forEach var="tbList" items="${ tbList }" varStatus="status">
			            <div class="card">
			               <div class="blurring dimmable image">
			                  <div class="ui dimmer">
									<div class="content">
										<div class="center">
											<div class="ui inverted button" onclick="travelMake(${ tbList.trvId })">이 글로 내 일정 작성하기</div>
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
			               
			               <div class="content" onclick="location.href='travelDetailForm.tb?trvId=${ tbList.trvId }'">
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
			                  <span>
			                     <a data-tooltip="구매수"><i class="fas fa-shopping-cart"></i>&nbsp;&nbsp;${ tbList.buyCount }</a>
			                     &nbsp;&nbsp;&nbsp;&nbsp;
			                     <a data-tooltip="좋아요수"><i class="fas fa-star"></i>&nbsp;&nbsp;${ tbList.likeyCount }</a>
			                  </span>
			               </div>   
						</div>
					</c:forEach>
					</div>
				</c:when>
		           
					<c:otherwise>
						<div class="ui special cards" style="justify-content: center;">
			           		<div align="center">
			           			<h3 class="title is-1"><i class="fas fa-search"></i></h3>
			           			<p>구매한 여행일정이 없습니다.</p>
			           		</div>
		           		</div>
		           </c:otherwise>
	           </c:choose>
          </section>
          </div> 
         
      </div>   <!-- class="column" -->
   </div>   <!-- class="columns is-mobile" -->

<!-- 일정만들기 안내 모달 -->
	<section class="section" id="modal">
		<div class="modal" id="myModal">
		    <div class="modal-background"></div>
		    <div class="modal-card">
		    
				<header class="modal-card-head">
					<p class="modal-card-title"><i class="fas fa-info-circle"></i>&nbsp;일정만들기 안내</p>
					<button class="cancel delete"></button>
				</header>
			
				<section class="modal-card-body">
					
					<p>
						일정 오버라이딩은 여행 일정을 보다 쉽게 짤 수 있도록 도와주는 기능으로 작성 완료 후 개인소장만 가능하며, 사이트에 일정 공유는 불가함을 참고해주시기 바랍니다.
					</p>
				</section>
			
				<footer class="modal-card-foot" style="justify-content: center">
					<a class="button is-primary" id="travelMake">일정만들기</a>
					<a class="button cancel">닫기</a>
				</footer>
			
		    </div>
		</div>
	</section>


	
<script>
	//각 글에 마우스 올렸을 때 설명글
	$('.special.cards .image').dimmer({
	  on: 'hover'
	});	
	
	function travelMake(trvId) {
		$('#myModal').toggleClass('is-active').removeAttr('style');
		
		$("#travelMake").click(function() {
			location.href="overrideTravel.trv?trvId=" + trvId;
		});

		
		$(".cancel").click(function(){
			$('#myModal').removeClass('is-active');
	    });
	}
	
	$(function() {
		var menu = $(".myPageMenu li").eq(1);
          menu.addClass('is-active');
          menu.siblings().removeClass('is-active');
	});
	
</script>

</body>
</html>