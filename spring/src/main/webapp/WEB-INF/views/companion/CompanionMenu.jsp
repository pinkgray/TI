<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel = "stylesheet" type = "text/css" href = "resources/css/companion/companion_main.css">
<style>
	#HeaderImage {
    width: 100%;
    height: 100%;
    max-height: 200px;
    margin: 0;
    padding: 0;
    }
    
    .container{
    	padding : 0;
    	margin : 0;
    }
    
</style>
</head>
<body>
	<c:set var = "contextPath" value = "${pageContext.servletContext.contextPath }" scope = "application"/>
	<div class="container">
	  	<!-- <h2 align = "center">Travel InterFace</h2> -->
	  	<img src = "resources/images/chatHeaderTitle.png" id ="HeaderImage">
	  	<ul class="nav" id = "chMenu">
	   	 	<li id = "enterMenu"><a href="${contextPath }/enterRoom.ch"><i class="material-icons">sms</i>&nbsp;&nbsp;&nbsp;<label class = "title">내 채팅방</label></a></li>
	    	 <li id = "joinMenu"><a href="${contextPath }/joinRoom.ch"><i class="material-icons">question_answer</i><label class = "title">동행자 찾기</label></a></li>
	  	</ul>
	  </div>

	
</body>
</html>