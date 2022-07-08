<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<style>
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
		min-height:768px;
	}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp"/> <br>
	<div class="columns">
		<div class="column">
			<form action="insertOneSpot.sp" method="post">
			<section class="section">
				<div class="field">
					<h3 class="subtitle is-3" style="color:#209cee;"> 여행지 등록 </h3>
				</div>
				
				<!-- country and city -->
				<div class="field is-horizontal">
					<div class="field-body">
						<!-- country -->
						<div class="field">
					      <label class="label">* 국가명</label>
					      <p class="control">
					        <span class="select is-fullwidth">
					            <select id="countrySelect" name="countryId">
					              <option selected>국가명</option>
					              <c:forEach var="country" items="${ countryList }">
					              		<option value="${ country.countryId }">${ country.countryNameKo }</option>
					              </c:forEach>					              
					            </select>
					          </span>
					      </p>
					    </div> <!-- end country -->						
						
					    <!-- city -->
					    <div class="field">
					      <label class="label">* 도시명</label>
					      <p class="control">
					        <span class="select is-fullwidth">
					            <select name="cityId" id="cityArea">
					              <option>도시명</option>
					             <%--  <c:forEach var="city" items="${ cityList }">
					              	<option value="${ city.cityId }">${ city.cityNameKo }</option>
					              </c:forEach> --%>
					            </select>
					          </span>
					      </p>
					    </div> <!-- end city -->
					</div> <!-- end field-body -->
				</div> <!-- end country and ciry -->
				
				<div class="field">
					<label class="label">명소명</label>
				</div>
				
				<!-- spot name -->
				<div class="field is-horizontal">
					<div class="field-body">
						<!-- ko name -->
						<div class="field">
					    	<label class="label">* 한글 명소명</label>
					    	<p class="control">
					          <input class="input" type="text" placeholder="Text input" name="spotNameKo">
					        </p>
					    </div> <!-- end ko name -->
					    
					    <!-- eng name -->
					    <div class="field">
					    	<label class="label">영어 명소명</label>
					    	<p class="control">
					          <input class="input" type="text" placeholder="Text input" name="spotNameEn">
					        </p>
					    </div> <!-- end eng name -->
					</div> <!-- end field-body -->
				</div> <!-- end spot name -->
				
				<!-- detail address -->
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<label class="label">* 상세 주소</label>
							<p class="control">
					          <input class="input" type="text" placeholder="Text input" name="spotAddress">
					        </p>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end detail address -->
				
				<!-- spot content -->
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<label class="label">여행지 설명</label>
							<p class="control">
					          <textarea class="textarea" placeholder="Textarea" name="spotContent"></textarea>
					        </p>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end spot content -->
				
				<div class="field">
					<label class="label">영업시간</label>
				</div>
				
				<!-- opening hours -->
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<p class="control">
					          <input class="input" type="text" placeholder="Text input" name="openingHours">
					        </p>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end opening hours -->
				
				<!-- etc info -->
				<div class="field is-horizontal">
					<div class="field-body">
						<!-- spot type -->
						<div class="field" style="flex-grow: 0;">
							<label class="label">* 명소유형</label>
							<p class="control">
					        <span class="select">
					            <select style="width:300px;" name="plcTypeId">
					              <option>명소유형</option>
					              <option value="2">맛집</option>
					              <option value="1">명소</option>
					            </select>
					          </span>
					      </p>
						</div> <!-- end spot type -->
						
						<!-- web address -->
						<div class="field">
							<label class="label">웹사이트</label>
							<p class="control is-expanded">
					          <input class="input" type="url" placeholder="Text input" name="webAddress">
					        </p>
						</div> <!-- end web address -->
					</div> <!-- end field-body -->
				</div> <!-- end etc info -->
				
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<label class="label">사진</label>
						</div>
						<!-- <div class="buttons"  style="justify-content:flex-end;">
							<a class="button is-danger is-rounded is-small">삭제</a>
						</div> -->
					</div>
				</div>
				
				<!-- picture area -->
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<div class="pic_area" style="width:300px; height:180px;; border:1px solid gray;">
							<img id="picArea"  style="width:300px; height:180px;" ></div>
						</div>
						<div class="field is-grouped" style="float: bottom;">
							<p class="control"> * 이미지 주소를 넣어주세요. </p>
							<input class="input" type="url" placeholder="이미지 주소" id="filePath" name="filePath">
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end picture area -->
				
				<!-- btn area -->
				<div class="field is-horizontal">
					<div class="field-body"  style="justify-content:flex-end;">
						<div class="buttons">
							<a class="button is-danger is-outlined" style="width:200px;" href="selectAllSpotAdmin.sp?currentPage=1"> 취소 </a>
							<button class="button is-info is-outlined" style="width:200px;" type="submit"> 등록 </button>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end btn area -->
				
			</section> <!-- end session -->
			</form>
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<script>
		var id = 0;
		$(function(){
			$("#filePath").click(function(){
				$("#filePath").select();
			});
			
			$("#filePath").bind("paste", function(){
				var text = String($("#filePath").val());
				console.log(text);
				$("#picArea").attr("src", text);
			
			});
			
			//국가가 선택이 되었을 때
			$("#countrySelect").click(function(){
				id = $("#countrySelect option:selected").val();	
				
				var option = "<option>도시명 </option>";
				$("#cityArea").text(option);
				<c:forEach var="city" items="${ cityList }">
					if(id == '${ city.countryId }'){
						option += '<option value="${ city.cityId }">${ city.cityNameKo }</option>';
					}
			    </c:forEach>
			    $("#cityArea").append(option);
			});
		});
	</script>
</body>
</html>