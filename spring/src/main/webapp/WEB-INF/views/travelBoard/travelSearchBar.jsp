<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.styleTag {
		background: #209cee;
	}
	.tags.has-addons {
		display: inline-block;
		padding-left: 7px;
	}
	
</style>
<body>

	<jsp:include page="../common/mainNav.jsp" />
	
<section class="section">
<div class="columns is-mobile">
	<div class="column" align="right"> 
		
		<!-- 검색조건 -->
		<div class="ui teal buttons">
			<div class="ui button" style="margin-right: 0;" id="searchTitle">여행 검색</div>
				<div class="ui floating dropdown icon button" style="padding: 0.8em; width: 2.5em;">
					<i class="dropdown icon"></i>
				<div class="menu">
					<div class="item" id="simpleSearch"><i class="fas fa-search"></i> 간편 검색</div>
					<div class="item" id="detailSearch"><i class="fas fa-search-plus"></i> 태그검색</div>
				</div>
			</div>
		</div>
		
	<div id="simpleSearchArea" style="display: none;">
		<!-- 기본검색바 -->
		
		<div class="field has-addons" style="justify-content: flex-end; margin-top: 1em;">
			<a class="button is-primary searchClose" data-tooltip="검색창 닫기" data-position="top right">X</a>
			
			<p class="control">
				<span class="select">
					<select id="orderBy">
						<option value="-">-검색조건-</option>
						<option value="completeDate">최신순</option>
						<option value="likeyCount">좋아요순</option>
						<option value="buyCount">구매순</option>
					</select>
				</span>
			</p>
			<p class="control">
				<span class="select">
					<select id="searchCondition">
						<option value="trvTitle">제목</option>
						<option value="userName">작성자</option>
					</select>
				</span>
			</p>
			<p class="control">
				<input class="input" type="text" id="searchContent" placeholder="검색어를 입력하세요">
			</p>
			<p class="control" onclick="searchTravelList()">
				<a class="button"><i class="fas fa-search"></i></a>
			</p>
		</div>
	</div>	<!-- id="simpleSearchArea" -->
	
	<div id="detailSearchArea" style="display: none;">
	
		<!-- 여행스타일 태그 -->
		<div class="tagSearchBar" style="display: inline-block; margin-top: 1em;">
		<div class="field has-addons">
			<a class="button is-info searchClose" data-tooltip="검색창 닫기" data-position="top right">X</a>
			<p class="control is-expanded">
				<span class="select is-fullwidth">
					<select id="travelStyle" name="travelStyle">
						<option id="styleTag">-여행태그-</option>
						<c:forEach var="tagList" items="${ tagList }" varStatus="st">
							<option value="${ tagList.tagId }">${ tagList.tagName }</option>
						</c:forEach>
					</select>
				</span>
			</p>
			<p class="control">
			  <button class="button is-info" id="styleAdd">추가</button>
			</p>
			
			<p class="control is-expanded">
				<span class="select is-fullwidth">
					<select name="country" id="travelCountry">
						<option id="countryTag">-나라태그-</option>
						<c:forEach var="cityList" items="${ cityList }" varStatus="st">
							<option value="${ cityList.countryId }">${ cityList.countryNameKo }</option>
						</c:forEach>
					</select>
				</span>
			</p>
			<p class="control">
			  <button class="button is-primary" id="countryAdd">추가</button>
			</p>
			
			<p class="control" onclick="searchTravelTag()">
				<a class="button" data-tooltip="태그 검색하기"><i class="fas fa-search"></i></a>
			</p>
		</div>
		</div>
		
		<div id="selectStyle" style="height: 25px;">
		
		</div>
		
		<div id="selectCountry" style="height: 25px;">
		</div>
		
      	</div>
	</div>
</div>
</section>	
		
</body>

<script>
	//간편검색 서치용
	function searchTravelList() {
		var orderBy = $("#orderBy").children("option:selected").val();
		var searchCondition = $("#searchCondition").children("option:selected").val();
		var searchContent = $("#searchContent").val();
		
		location.href="searchTravelList.tb?orderBy=" + orderBy + "&searchCondition=" + searchCondition + "&searchContent=" + searchContent;
	};
	
	/* 여행검색 관련 펑션 */
	$('.dropdown').dropdown({
	    transition: 'drop'
	});
	
	$("#simpleSearch").click(function() {
		$("#simpleSearchArea").removeAttr("style");
		$("#detailSearchArea").css("display", "none");
		$("#searchTitle").text("간편 검색");
	});
	
	$("#detailSearch").click(function() {
		$("#simpleSearchArea").css("display", "none");
		$("#detailSearchArea").removeAttr("style");
		$("#searchTitle").text("태그 검색");
	});
	
	$(".searchClose").click(function() {
		$("#simpleSearchArea").css("display", "none");
		$("#detailSearchArea").css("display", "none");
		$("#searchTitle").text("여행 검색");
	});
	
	/* 여행태그 선택 */
	$('#styleAdd').click(function() {
		var style = $("#travelStyle").children("option:selected").text();
		var tag = '<div class="tags has-addons"><a class="styleTag tag is-link style" style="background-color: #209cee;">' + style 
					+',</a><span class="tag is-delete">　</span></div>';
		
		if(style != '-여행태그-') {
			$("#travelStyle").children("option:selected").attr("disabled", true);
			$("#selectStyle").append(tag);
			
			$("#styleTag").prop("selected", true);
		}
	});
	
	/* 나라태그 선택 */
	$('#countryAdd').click(function() {
		
		var country = $("#travelCountry").children("option:selected").text();
		var tag = '<div class="tags has-addons"><a class="countryTag tag is-link style" style="background-color: #8e44ad;">' + country 
					+ ',</a><a class="tag is-delete">　</a></div>';
		
		if(country != '-나라태그-') {
			$("#travelCountry").children("option:selected").attr("disabled", true);
			$("#selectCountry").append(tag);
			
			$("#countryTag").prop("selected", true);
		}
	});
	
	$("body").on("click", ".tag, .is-delete", function(){
		$(this).parent().remove();
	});
	
	function searchTravelTag() {
		var trvTags = $(".styleTag").text();
		var cityTags = $(".countryTag").text();
		
		location.href="searchTagTravelList.tb?trvTags="+trvTags+"&cityTags="+cityTags;
	}
	
</script>
</html>