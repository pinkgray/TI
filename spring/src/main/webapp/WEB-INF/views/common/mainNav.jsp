<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Travel Interface</title>
<link rel="stylesheet" href="resources/css/bulmaswatch.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/semantic.min.css">
<link rel="stylesheet" href="resources/css/jquery-ui.theme.min.css">
<link rel="stylesheet" href="resources/css/jquery-ui.structure.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/semantic.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>

<!-- kakao -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
	body {
		overflow-x:visible !important;
	}
	.navbar-item img {
    	max-height: 100% !important;
   	}
</style>
</head>
<body>
	<c:set var = "contextPath" value = "${pageContext.servletContext.contextPath }" scope = "application"/>
	<nav class="navbar is-white is-fixed-top" style="border-bottom:1px solid skyblue;">
    	<div class="navbar-brand">
        	<a class="navbar-item" href="index.jsp"> 
            	<img src="resources/images/logoWide.png" width="120px">
         	</a>
         	<div class="navbar-item is-hidden-tablet">
         		<div class="field is-grouped">
         			<p class="control">
         				<a id="chatBtn" class="button is-rounded" onclick="showPopup()"> 
                        	<i class="fas fa-comments"></i>
                        	<span>동행찾기</span>
                     	</a>
            		</p>
            		
            		<!-- 로그인 안 되었을 때  수정 세량-->
            		<c:if test="${ empty loginUser }">
            			<p class="control">
	                     	<a class="button is-info is-rounded" href="loginForm.me"> 
	                        	<span class="icon"><i class="fa fa-user"></i></span> 
	                        	<span>LOG IN</span>
	                    	</a>
	                  	</p> 
            		</c:if>
            		
            		<!-- 로그인 되었을 시 수정 세령-->
            		<c:if test="${ !empty loginUser }">
            			<div class="control navbar-item has-dropdown is-hoverable"  style="margin-right:20px;">
	                     	<a class="button is-info is-rounded navbar-link" href="#"> 
	                        	<span class="icon"><i class="fa fa-user"></i></span>
	                        	<span>${ loginUser.email }</span>
	                    	</a>
	                    	<div class="navbar-dropdown">
	                    		<c:if test="${ loginUser.email eq 'admin@gmail.com' }">
                    				<a class="navbar-item " href="genderStatisticsYear.sta"> 관리자페이지 </a> 
                    			</c:if>
                   				<a class="navbar-item " href="showMyTravel.trv"> 마이페이지 </a>
		                  		<a class="navbar-item " onclick="Logout();"> 로그아웃 </a>
		              		</div>
	                  	</div> 
            		</c:if>
            		
            	</div>
         	</div>
            <div class="navbar-burger burger is-hidden-tablet" data-target="mainNav">

               	<span></span> <span></span> <span></span>
           	</div>
		</div>
      	<div id="mainNav" class="navbar-menu">
         	<div class="navbar-start">
            	<a class="navbar-item" href="#" 
            		data-target="#newTravelModal" onclick="showNewTrvModal();"> 
            		<strong>일정만들기</strong> 
            	</a>
            	<a class="navbar-item" href="travelList.tb"> <strong>여행일정</strong> </a>
            	<div class="navbar-item has-dropdown is-hoverable">
               		<a class="navbar-link " href="selectAllSpotUser.sp?condition=all"> <strong>여행지</strong> </a> <!-- href 수정(세령) -->
               		<div class="navbar-dropdown ">
                  		<a class="navbar-item " href="selectAllSpotUser.sp?condition=all"> 주요도시 </a> 
                  		<a class="navbar-item " href="selectAllSpotUser.sp?condition=아시아"> 아시아 </a> 
                  		<a class="navbar-item " href="selectAllSpotUser.sp?condition=유럽"> 유럽 </a> 
                  		<a class="navbar-item " href="selectAllSpotUser.sp?condition=오세아니아"> 오세아니아 </a> 
                  		<a class="navbar-item " href="selectAllSpotUser.sp?condition=북아메리카"> 북미 </a> 
                  		<a class="navbar-item " href="selectAllSpotUser.sp?condition=남아메리카"> 중남미 </a> 
              		</div>
				</div>
            	<a class="navbar-item" href="travelRequest.tr"> <strong>여행의뢰</strong> </a>
            	<a class="navbar-item " href="noticeList.cc"> <strong>고객센터</strong> </a>
              <!--임시-->
              <!-- <a class="navbar-item " href="showMyTravel.trv"> <strong>임시 마이페이지</strong> </a>
              <a class="navbar-item " href="genderStatisticsYear.sta"> <strong>임시 관리자페이지</strong> </a> -->
			</div>
        	<div class="navbar-end is-hidden-mobile">
            	<div class="navbar-item">
            		<div class="field is-grouped">
                  		<p class="control">
                     		<a id="chatBtn" class="button is-rounded" onclick="showPopup()"> 
                        		<i class="fas fa-comments"></i>
                        		<span>동행찾기</span>
                     		</a>
                  		</p>
                  		<!-- 로그인 안 되었을 때 수정 세령 -->
	            		<c:if test="${ empty loginUser }">
	            			<p class="control">
		                     	<a class="button is-info is-rounded" href="loginForm.me"> 
		                        	<span class="icon"><i class="fa fa-user"></i></span> 
		                        	<span>LOG IN</span>
		                    	</a>
		                  	</p> 
	            		</c:if>
	            		
	            		<!-- 로그인 되었을 시 수정 세령 -->
	            		<c:if test="${ !empty loginUser }">
	            			<div class="control navbar-item has-dropdown is-hoverable"  style="margin-right:20px;">
		                     	<a class="button is-info is-rounded navbar-link" href="#"> 
		                        	<span class="icon"><i class="fa fa-user"></i></span>
		                        	<span>${ loginUser.email }</span>
		                    	</a>
		                    	<div class="navbar-dropdown">
	                    			<c:if test="${ loginUser.email eq 'admin@gmail.com' }">
	                    				<a class="navbar-item " href="genderStatistics.sta"> 관리자페이지 </a> 
	                    			</c:if>
                    				<a class="navbar-item " href="showMyTravel.trv"> 마이페이지 </a>
                    				<a class="navbar-item " onclick="Logout();"> 로그아웃 </a>
			              		</div>
		                  	</div> 
	            		</c:if>
	            		
            		</div>
				</div>
			</div>
		</div>
	</nav>

   	<br><br>

  
   	<jsp:include page="../travel/newTravelModal.jsp" />
	

	<script>
        $(function() {
			var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
	        if ($navbarBurgers.length > 0) {
				$navbarBurgers.forEach(function ($el) {
	            	$el.addEventListener('click', function() {
	                 	var target = $el.dataset.target;
	                 	var $target = document.getElementById(target);
	                 	$el.classList.toggle('is-active');
	                 	$target.classList.toggle('is-active');
					});
	          	});
	        }
        });
		function showPopup(){
			var top  = (($(window).height()-700)/2+$(window).scrollTop()) + "px";
            var left = (($(window).width()-400)/2+$(window).scrollLeft()) + "px";
            //window.resizeTo(400,700);
       		window.open("${contextPath}/openCompanion.ch", "a", "width=400, height=650, left="+left+", top="+top+", resizable= 0");        	
       		
		}
		
		function Logout(){
			if('${ loginUser.enrollType }' == "카카오가입"){
				Kakao.init('a78d747cfbe06a103ff9224f83633086');
				Kakao.Auth.logout(function(data){
					if(data==true){
						alert("로그아웃");				
						location.href="logout.me";
					}
				});
			} else {
				location.href="logout.me";
			}
		}
   </script>
</body>
</html>