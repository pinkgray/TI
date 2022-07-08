<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style>
	#errorImg {
    max-width: 500px;
    max-height: 300px;
    width: 100%;
    height: 100%;
    margin-top: 15%;
	}
	
	#closebtn,#loginbtn {
	    width: 200px;
	    margin-left: 25%;
	    height: 40px;
	    background: #79aaf7;
	    color: white;
	    cursor: pointer;
	    border : none;
	    border-radius : 5%;
	}
</style>
</head>
<body>
	<c:set var = "contextPath" value = "${pageContext.servletContext.contextPath }" scope = "application"/>
	<img src = "resources/images/error.png" alt = "error이미지" id = "errorImg">
	<c:choose>
			<c:when test = "${loginUser == null}">
				<h3 align = "center" style = "color:red;">죄송합니다. <br> 로그인 상태가 아니면 <br> 서비스를 이용할수 없습니다. <br> 로그인 후 다시 이용해주세요  </h3>
			</c:when>
			<c:otherwise>
				<h3 align = "center" style = "color:red;">죄송합니다. <br> 서비스의 오류가 발생했습니다. <br> 종료 후 다시 이용해주세요  </h3>
			</c:otherwise>
	</c:choose>
	<c:choose>
			<c:when test = "${loginUser == null}">
				<button id = "loginbtn">로그인 하러가기</button>
			</c:when>
			<c:otherwise>
				<button id = "closebtn">창 닫기</button>
			</c:otherwise>
	</c:choose>

	<script>
		$(function(){
			$("#closebtn").click(function(){
				window.close();
			});
			
			$("#loginbtn").click(function(){
				window.opener.location.href = '${contextPath}/loginForm.me';
				window.close();
			})
		});
	</script>
</body>
</html>