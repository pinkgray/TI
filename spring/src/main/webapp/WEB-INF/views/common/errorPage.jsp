<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		overflow-y : hidden;
	}
	
	 ::-webkit-scrollbar { 
    	display: none !important; 	
    }
	
	
	.wrap{
		width : 100%;
		height : 100%;
	}
	
	#errorImg{
    max-height: 300px;
    width: 100%;
    height: 100%;
	}
	
	#mainBtn{
		margin-left : 20%;
	}
	
	#mainBtn,#returnBtn{
		width : 300px;
		height : auto;
		font-size : 18px;
		cursor: pointer;
		border : none;
		background : white;
		color : #79aaf7;
		padding : 10px;
	}
	
	#mainBtn:hover  , #returnBtn:hover{
		border-bottom : 1px solid #79aaf7;
		border-radius : 5%;
	}
	

</style>
</head>
<body>
	<c:set var = "contextPath" value = "${pageContext.servletContext.contextPath }" scope = "application"/>
	<jsp:include page = "../common/mainNav.jsp"/>
	<br><br><br>
	<div class = "wrap">
		<c:set value = "${requestScope['javax.servlet.error.status_code']}" var = "errorNum"/>
		<img src = "resources/images/error.png" alt = "error이미지" id = "errorImg">
		<h1 align = "center" style = "color : red; ">홈페이지 이용에 불편을 끼쳐서 죄송합니다.</h1>
		<c:choose>
			<c:when test = "${errorNum == 404}">
				<h3 align = "center">요청한 페이지를 찾을 수 없습니다.<br>삭제된 주소거나 일시적으로 사용할 수 없습니다.</h3>
			</c:when>
			<c:otherwise>
				<h3 align = "center">서비스 이용이 원할하지 않습니다.<br>잠시후 해당 서비스를 이용해 주시기 바랍니다.</h3>
			</c:otherwise>
		</c:choose>
		
		<button align = "left" id = "mainBtn" onclick = "location.href = '${contextPath}'">메인페이지로 이동</button>
		<button align = "left" id = "returnBtn" onclick = "history.back();">이전페이지로 이동</button>
	</div>
</body>
</html>