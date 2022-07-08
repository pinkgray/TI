<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	.readonlyBg {
		background-color: #f2f2f2 !important;
		color:black !important;
	}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp"/>
	<div class="columns">
		<div class="column">
			<section class="section">
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<h3 class="subtitle is-3" style="color:#209cee;"> 여행지 상세보기 </h3>
						</div>
						<!-- <div class="buttons" style="justity-content: flex-end;">
							<a class="button is-warning" href="selectAllSpotReviewAdmin.sp"> 사용자 평 보기 </a>
						</div> -->
					</div>
				</div>
				
				
				<!-- country and city -->
				<div class="field is-horizontal">
					<div class="field-body">
						<!-- country -->
						<div class="field">
					      <label class="label">* 국가명</label>
					      <p class="control">
					           <input type="text" value="${ country.countryNameKo }" class="input readonlyBg" >
					      </p>
					    </div> <!-- end country -->
					    
					    <!-- city -->
					    <div class="field">
					      <label class="label">* 도시명</label>
					      <p class="control">
					           <input type="text" value="${ city.cityNameKo }" class="input readonlyBg" >
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
					          <input class="input readonlyBg" type="text" placeholder="Text input" id="spotNameKo"
					          value="${ spotList.spotNameKo }">
					        </p>
					    </div> <!-- end ko name -->
					    
					    <!-- eng name -->
					    <div class="field">
					    	<label class="label">영어 명소명</label>
					    	<p class="control">
					          <input class="input readonlyBg" type="text" placeholder="Text input" id="spotNameEn"
					          value="${ spotList.spotNameEn }">
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
					          <input class="input readonlyBg" type="text" placeholder="Text input" value="spotAddress"
					          value="${ spotList.spotAddress }">
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
					          <textarea class="textarea readonlyBg" id="spotContent"
					          placeholder="Textarea">${ spotList.spotContent }</textarea>
					        </p>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end spot content -->
				
				
				<!-- opening hours -->
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<label class="label">영업시간</label>
							<p class="control">
					          <input class="input readonlyBg" type="text" placeholder="Text input" id="openingHours"
					          value="${ spotList.openingHours }">
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
					        <span class="select readonlyBg">
					            <select style="width:300px;" id="plcTypeId">
					              <option>명소유형</option>
					              <option value="2" <c:if test="${ spotList.plcTypeId eq 2 }">selected </c:if>>맛집</option>
					              <option value="1" <c:if test="${ spotList.plcTypeId eq 1 }">selected </c:if>>명소</option>
					            </select>
					          </span>
					      </p>
						</div> <!-- end spot type -->
						
						<!-- web address -->
						<div class="field">
							<label class="label">웹사이트</label>
							<p class="control is-expanded">
					          <input class="input readonlyBg" type="text" placeholder="Text input" id="webAddress"
					          value="${ spotList.webAddress }">
					        </p>
						</div> <!-- end web address -->
					</div> <!-- end field-body -->
				</div> <!-- end etc info -->
				
				<!-- date info area -->
				<div class="field is-horizontal">
					<div class="field-body">
					
						<div class="field">
							<label class="label">등록일</label>
							<p class="control is-expanded">
					          <input class="input readonlyBg" type="text" placeholder="2000-01-01" readonly
					          value="${ spotList.enrollDate }">
					        </p>
						</div>
						
						<div class="field">
							<label class="label">수정일</label>
							<p class="control is-expanded">
					          <input class="input readonlyBg" type="text" placeholder="2000-01-01" readonly
					          value="${ spotList.modifyDate }">
					        </p>
						</div>
						
						<div class="field">
							<label class="label">삭제일</label>
							<p class="control is-expanded">
					          <input class="input readonlyBg" type="text" placeholder="2000-01-01" readonly
					          value="${ spotList.delDate }">
					        </p>
						</div>
						
						<div class="field">
							<label class="label">복구일</label>
							<p class="control is-expanded">
					          <input class="input readonlyBg" type="text" placeholder="2000-01-01" readonly
					          value="${ spotList.recoveryDate }">
					        </p>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end date info area -->
				
				
				<div class="field is-horizontal">
					<div class="field-body">
						<div class="field">
							<label class="label">사진</label>
						</div>
					</div>
				</div>
				
				<c:if test="${ !empty spotFile }">
					<!-- picture area -->
					<div class="field is-horizontal">
						<div class="field-body">
							<div class="field">
								<div class="pic_area" style="width:300px; height:180px;; border:1px solid gray;">
								<img id="picArea"  style="width:300px; height:180px;" src="${ spotFile[0].filePath }"></div>
							</div>
							<div class="field is-grouped" style="float: bottom;">
								<p class="control"> * 이미지 주소를 넣어주세요. </p>
								<input class="input" type="url" placeholder="이미지 주소" id="filePath" name="filePath" value="${ spotFile[0].filePath }">
							</div>
						</div> <!-- end field-body -->
					</div> <!-- end picture area -->
				</c:if>
				
				<!-- btn area -->
				<div class="field is-horizontal">
					<div class="field-body"  style="justify-content:flex-end;">
						<div class="buttons">
							<a class="button is-success is-outlined" style="width:150px;" href="selectAllSpotAdmin.sp?currentPage=1"> 돌아가기 </a>
							<a class="button is-danger is-outlined" style="width:150px;" onclick="delSpot('${ spotList.spotId }');"> 삭제하기 </a>
							<%-- <a class="button is-info is-outlined" style="width:150px;" href="updateSpot('${ spotList.spotId }');"> 정보수정하기 </a> --%>
						</div>
					</div> <!-- end field-body -->
				</div> <!-- end btn area -->
				
			</section> <!-- end session -->
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<script>
	
		function delSpot(spotId) {
			location.href = "deleteOneSpot.sp?spotIds=" + spotId + ", ";
		}
	
		/* function updateSpot(spotId) {
			
		} */
	</script>
</body>
</html>