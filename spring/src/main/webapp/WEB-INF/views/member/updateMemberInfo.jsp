<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<style>
	#form {
		width:80% !important;
		margin:0 auto;
	}
	.field-label {
	    flex-basis: 0;
	    flex-grow: 0 !important;
	    flex-shrink: 0;
	    margin-right: 1.5rem;
	    text-align: right;
	}
	.label {
		width:100px;
		text-align:left;
	}
	.readonlyBg {
		background-color: #d9d9d9 !important;
	}
</style>
</head>
<body>
	<!-- main nav -->
	<jsp:include page="../common/mainNav.jsp"/>
	
	<div class="columns is-mobile">
		<div class="column">
			<!-- myPage nav -->
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
			</section>
			
			<!-- update member information form -->
			<form action="updateUserInfo.me" method="post">
				<section class="section" id="form"  style="border:1px solid gray;">
					  <h3 class="title"> 계정 정보 수정 </h3>
				      <hr style="border:1px solid gray; background-color:gray;">
				      
				      <input type="text" value="${ loginUser.memberId }" style="display: none;" name="memberId">
				      
				      <!-- member name -->
				      <div class="field is-horizontal">
				        <div class="field-body">
					        <div class="field-label is-normal">
					          <label class="label">이름</label>
					        </div>
				          <div class="field is-grouped">
				            <p class="control is-expanded has-icons-left">
				              <input class="input" type="text" name="userName" value="${ loginUser.userName }" style="border:1px solid gray;">
				              <span class="icon is-small is-left">
				                <i class="fa fa-user"></i>
				              </span>
				            </p>
				          </div>
				        </div>
				      </div> <!-- end member name -->
				      
				      <!-- member email -->
				      <div class="field is-horizontal">
				      	<div class="field-body">
				      		<div class="field-label is-normal">
				          		<label class="label">이메일</label>
				          	</div>
				          	<div class="field is-grouped">
					            <p class="control is-expanded has-icons-left has-icons-right">
					              <input class="input is-success" type="email" name="email" value="${ loginUser.email }" style="border-color:gray;">
					              <span class="icon is-small is-left">
					                <i class="fa fa-envelope"></i>
					              </span>
					            </p>
				          	</div>
				      	</div>
				      </div> <!-- end member email -->
				      
				      <!-- change member password btn -->
				      <div class="field is-horizontal">
				        <div class="field-body">
					        <div class="field-label is-normal">
					          <label class="label">비밀번호</label>
					        </div>
				          <div class="field is-grouped" style="flex-grow:1;">
				            <p class="control is-expanded has-icons-left has-icons-right">
				              <a class="button is-primary is-outlined" style="width:50%;" id="resetPasswordBtn"
				              		  onclick="$('#modalUpdatePassword').toggleClass('is-active');"> 비밀번호 재설정 </a>
				               <span class="icon is-small is-left">
					              <i class="fas fa-mobile-alt"></i>
					           </span>
				            </p>
				          </div>
				        </div>
				      </div> <!-- end change member password btn -->
				      
				      <!-- member phone -->
				     <%--  <div class="field is-horizontal">
				        <div class="field-body">
					        <div class="field-label is-normal">
					          <label class="label">연락처</label>
					        </div>
				          <div class="field is-grouped">
				            <div class="field has-addons">
						        <p class="control">
						          <input class="input" type="text" name="phone" value="${ loginUser.phone }">
						        </p>
						        <p class="control">
						          <a class="button is-info">휴대폰 재인증</a>
						        </p>
						      </div>
					          <p class="help is-success" style="margin-left:10px; padding-top:6px;">인증 완료</p>
				          </div>
				        </div>
				      </div>  --%><!-- end member phone -->
				      
				      <!-- member gender -->
				      <div class="field is-horizontal">
				        <div class="field-body">
				        	<div class="field-label is-normal">
					          <label class="label">성별</label>
					        </div>
					        <p class="control">
					          <label class="radio">
					            <input type="radio" name="gender" id="genderF" value="F"> 여자
					          </label>
					          <label class="radio">
					            <input type="radio" name="gender" id="genderM" value="M"> 남자
					          </label>
					        </p>
				        </div>
				      </div> <!-- end member gender -->
				      
				      <!-- member birthday -->
				      <div class="field is-horizontal">
				        <div class="field-body">
				        	<div class="field-label is-normal">
					          <label class="label">생년월일</label>
					        </div>
					        <p class="control">
					          <input class="input is-danger" type="date" id="birthday" name="birthday"
					          		 style="width:100%; border-color:gray;">
					        </p>
				        </div>
				      </div> <!-- end member birthday -->
				      
				      <!-- change member account btn-->
				      <div class="field is-horizontal">
				      	<div class="field-body">
				      		<div class="field-label is-normal">
				          		<label class="label">계좌번호</label>
				          	</div>
				          	<div class="field is-grouped">
					            <p class="control is-expanded has-icons-left has-icons-right">
					              <a class="button is-primary is-outlined" style="width:50%;" href="showConfirmAcc.me" 
					              	 onclick="window.open(this.href, '_blank', 'width=800px, height=280px, toolbars=no, scrollbars=no'); return false;"> 
					              	<c:choose>
					              		<c:when test="${ !empty loginUser.accCode || !empty loginUser.accNumber }">사용계좌를 변경하시겠습니까?</c:when>
					              		<c:otherwise>사용 계좌를 등록하시겠습니까?</c:otherwise>
					              	</c:choose>
					              </a>
						          <span class="icon is-small is-left">
						            <i class="fas fa-dollar-sign"></i>
						          </span>
					            </p>
				          	</div>
				      	</div>
				      </div>  <!-- end change member account btn -->
				     
				     <!-- member account -->
				     <c:if test="${ !empty loginUser.accCode || !empty loginUser.accNumber }">
				     
					      <div class="field is-horizontal">
					      	<div class="field-body">
							     <div class="field">
							       <label class="label">은행명</label>
							       <p class="control">
							         <input class="input readonlyBg" type="text" placeholder="Text input" readonly id="bankName">
							       </p>
							     </div>
							     <div class="field">
							       <label class="label">계좌번호</label>
							       <p class="control">
							         <input class="input readonlyBg" type="text" placeholder="Text input" value="${ loginUser.accNumber }" readonly>
							       </p>
							     </div>
					      	</div>
					      </div>
					      
				     </c:if>
				      <!-- end member account -->
				      
				      <!-- drop out member and update member btn -->
				      <hr style="border:1px solid gray; background-color:gray;">
				      <div class="field is-horizontal">
				      	<div class="field-body">
				      		<a onclick="$('#modalDropOutMember').toggleClass('is-active');">회원 탈퇴 하시겠습니까? </a>
				      		<div class="field">
				    			<button class="button is-primary is-outlined" style="float:right;"> 변경 정보 저장 </button>
				      		</div>
				      	</div>
				      </div> <!-- end drop out member and update member btn -->
				      
				</section><!-- end update member information form -->	
			</form>
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<jsp:include page="../common/footer.jsp"/>
	<jsp:include page="updatePasswordModal.jsp"/>
	<jsp:include page="dropOutMemberModal.jsp"/>
	
	<script>
	  	//모달 닫기용 함수
	  	function closeModal(num) {
	  		if(num == 1){
	  			$("#modalUpdatePassword").toggleClass('is-active');
	  		}/*  else if(num == 2){
	  			$("#modalConfirmAcc").toggleClass('is-active');
	  		} */ else if(num == 3){
	  			$("#modalDropOutMember").toggleClass('is-active');
	  		}	  	
	  		return false;
	  	}
	  	
	  	$(function(){
	  		//성별
	  		if('${ loginUser.gender }' == 'M'){
	  			$("#genderM").attr("checked", "checked");
	  		} else {
	  			$("#genderF").attr("checked", "checked");
	  		}
	  		//생일 
	  		var birthday = '${ loginUser.birthday }';
	  		var year = birthday.substring(0,4);
	  		var month = birthday.substring(5,7);
	  		var day = birthday.substring(8,10);
	  		birthdayFormat = new Date(year, month, day);
	  		$("#birthday").val(birthdayFormat.getFullYear() + '-' + month + '-' + day);
	  		//은행명
	  		var accCode = '${ loginUser.accCode }';
	  		var accName = "";
	  		switch(accCode){
	  			case '003': accName = "기업은행"; break;
	  			case '004': accName = "국민은행"; break;
	  			case '020': accName = "우리은행"; break;
	  			case '031': accName = "대구은행"; break;
	  			case '023': accName = "SC제일은행"; break;
	  			case '032': accName = "부산은행"; break;
	  			case '045': accName = "새마을금고"; break;
	  			case '027': accName = "한국씨티은행"; break;
	  			case '007': accName = "수협"; break;
	  			case '048': accName = "신협"; break;
	  			case '037': accName = "전북은행"; break;
	  			case '035': accName = "제주은행"; break;
	  			case '071': accName = "우체국"; break;
	  			case '081': accName = "하나은행"; break;
	  			case '088': accName = "신한은행"; break;
	  			case '266': accName = "SK증권"; break;
	  			case '280': accName = "유진증권"; break;
	  			case '287': accName = "메리츠증권"; break;
	  		}
	  		$("#bankName").val(accName);
	  		//비밀번호 재설정 카카오 비활성화
			if('${ loginUser.enrollType }' == '카카오가입') {
				$("#resetPasswordBtn").attr("disabled", "disabled");
			}
	  	});
	</script>
	
</body>
</html>