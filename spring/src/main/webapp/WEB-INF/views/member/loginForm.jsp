<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<!-- kakao -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<style>
	.bg {
	  background-image: url(resources/images/loginBackgroundImgLarge.jpg);
	  background-position: center;
	  background-repeat: no-repeat;
	  background-size: cover;
	  min-height:720px;
	}
	#tabs {
		width:80%;
		margin:0 auto;
	}
	#form {
		width:50%;
		margin:0 auto;
		background-color: rgba( 0, 0, 0, 0.5 );
	}
	.colWhite {
		color:white !important;
	}
	.button.is-primary, .button.is-link{
	    width:100%;
	}
	.button.is-primary {
		background-color:#0066ff !important;
	}
	.button.is-link {
		background-color:#e6b800 !important;
	}
	.tabs.is-toggle li.is-active a {
		background-color: #9966ff !important;
		border-color: #9966ff !important;
	}
	#tabs > div > ul > li > a {
		color:#e0e0eb;
	}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	
	<c:if test="${ !empty msg }">
		<script>alert('${ msg }');</script>
	</c:if>
	
	<br><br>
	<div class="container bg">
		<section class="section" id="tabs">
			<div class="tabs is-toggle is-fullwidth is-large">
				<ul>
					<li class="is-active"><a onclick="showSignIn(this);">SIGN IN</a></li>
					<li><a onclick="showSignUp(this);">SIGN UP</a></li>
				</ul>
			</div> <!-- end tabs -->
		</section> <!-- end tabs section -->
		<section class="section" id="form">
		  <div class="columns">
		  
		  <!-- signInArea -->
		  <form action="login.me" id="signInArea" method="post" style="width:100%;">
		    <div class="column">
			      <div class="field">
			        <label class="label colWhite">이메일</label>
			        <p class="control has-icons-left has-icons-right">
			          <input class="input is-danger" type="text" placeholder="Email" name="email" id="email">
			          <span class="icon is-small is-left">
			            <i class="fa fa-envelope"></i>
			          </span>
			          <span class="icon is-small is-right">
			            <i class="fa fa-warning"></i>
			          </span>
			        </p>
			      </div>
			      <div class="field">
			        <label class="label colWhite">비밀번호</label>
			        <p class="control has-icons-left has-icons-right">
			          <input class="input is-success" type="password" placeholder="password" name="password" id="password">
			          <span class="icon is-small is-left">
			            <i class="fa fa-lock"></i>
			          </span>
			          <span class="icon is-small is-right">
			            <i class="fa fa-check"></i>
			          </span>
			        </p>
			      </div>
			      <div class="field">
			      	<p class="control">
			      		<a style="color:white;" onclick="$('#modalPassword').toggleClass('is-active')">비밀번호를 잊어버리셨습니까?</a>
			      	</p>
			      </div>
		      	
		      	  <input type="hidden" value="자사가입" name="enrollType" id="enrollType">
		      	  <input type="hidden" name="userName" id="userName">
			      <div class="field field-horizon">
			      	<div class="field-body">
			      		<div class="field">
				          <button class="button is-primary" type="submit" id="signInBtn"><b>SIGN IN</b></button>
				        </div>
			      	</div>
			      </div>
			      <div class="field">
			      	  <button class="button is-primary" id="kakaoLogin" style="background-color: yellow !important; color: #1a0d00;"><b>카카오계정으로 로그인</b></button>
			          <a id="kakao-login-btn" style="display : none;"></a>
			      </div>
		      </div>
		  </form>
		  
		      <!-- end SignInArea -->
		      <!-- signUpArea -->
		      <form action="insert.me"  id="signUpArea" method="post" style="width:100%;">
			      <div class="column">
				      <div class="field">
				        <label class="label colWhite">* 사용자 이름</label>
				        <p class="control has-icons-left has-icons-right">
				          <input class="input is-success" type="text" placeholder="User Name" name="userName" id="userName2">
				          <span class="icon is-small is-left">
				            <i class="fa fa-user"></i>
				          </span>
				          <span class="icon is-small is-right">
				            <i class="fa fa-check"></i>
				          </span>
				        </p>
				      </div>
				      <div class="field">
				        <label class="label colWhite">* 이메일</label>
				        <p class="control has-icons-left has-icons-right">
				          <input class="input is-danger" type="text" placeholder="Email" name="email" id="email2">
				          <span class="icon is-small is-left">
				            <i class="fa fa-envelope"></i>
				          </span>
				          <span class="icon is-small is-right">
				            <i class="fa fa-check"></i>
				          </span>
				        </p>
				      </div>
				      <div class="field">
				        <label class="label colWhite">* 비밀번호</label>
				        <p class="control has-icons-left has-icons-right">
				          <input class="input is-success" type="password" placeholder="password" name="password" id="password1">
				          <span class="icon is-small is-left">
				            <i class="fa fa-lock"></i>
				          </span>
				          <span class="icon is-small is-right">
				            <i class="fa fa-lock"></i>
				          </span>
				        </p>
				      </div>
				      <div class="field">
				        <label class="label colWhite">* 비밀번호 확인</label>
				        <p class="control has-icons-left has-icons-right">
				          <input class="input is-success" type="password" placeholder="password check" name="password2" id="password2">
				          <span class="icon is-small is-left">
				            <i class="fa fa-lock"></i>
				          </span>
				          <span class="icon is-small is-right">
				            <i class="fa fa-lock"></i>
				          </span>
				        </p>
				        <p id="confirmResult" class="help is-danger" style="margin-left:10px; padding-top:6px;">비밀번호 불일치</p>
				      </div>
				      <div class="field">
				      	<label class="label colWhite">* 휴대폰 인증</label>
				      	<div class="field has-addons" style="width:100%;">
					          <input class="input" type="tel" placeholder="-를 빼고 입력해주세요" name="phone" id="userPhoneNumber">
					          <a class="button" onclick="sendMessage();">본인 인증</a>
				      	</div>
				      	<p id="confirmPhoneResult" class="help is-success" style="margin-left:10px;"></p>
				      </div>
				      <div class="field" id="confirmNumberArea">
				      	<label class="label colWhite">* 인증번호 입력</label>
				      	<div class="field has-addons" style="width:100%;">
					          <input class="input" type="text" placeholder="발송된 인증번호를 입력하세요" id="confirmNumber">
					          <a class="button" id="checkSms">인증 하기</a>
				      	</div>
				      </div>
				      <div class="field is-horizontal">
				      	<div class="field" style="margin-right:20px;">
					        <label class="label colWhite"> 성별 </label>
					          <span class="select">
					            <select name="gender">
					              <option value="M">남자</option>
					              <option value="F">여자</option>
					            </select>
					          </span>
				      	</div>
				      	<div class="field">			      	
					        <label class="label colWhite"> 생년월일 </label>
					        <input class="input is-danger" type="date" placeholder="birthday" name="birthday">
				      	</div>
				      </div>
				      <div class="field">
				        <p class="control">
				          <label class="checkbox">
				            <input type="checkbox" style="color:white;" id="check">
							<a>개인정보 처리 방침</a> 및 <a>구매 약관</a>, <a>홈페이지 약관</a>에 대해 동의합니다.
				          </label>
				        </p>
				      </div>
				       <input type="hidden" value="자사가입" name="enrollType">
				      <div class="field">
				        <p class="control">
				          <button class="button is-primary" type="submit" onclick="return checkUserInfo();"><b>SIGN UP</b></button>
				        </p>
				      </div>
				  </div>
		      </form>
			  <!-- end signUpArea -->
		  </div>
      </section>
	</div> <!-- end container -->
	
	<jsp:include page="../common/footer.jsp"/>
	<jsp:include page="findPasswordModal.jsp"/>
		
	<!-- script -->
	<script>
		var checkPass = false;
		var checkSms = false;
		var sendConfirmNum = "000000";
		
		function checkUserInfo(){
			console.log("checkPass : " + checkPass);
			console.log("checkSms : " + checkSms);
			console.log("sendConfirmNum : " + sendConfirmNum);
			if($("#userName2").val() == null || $("#userName2").val() == "" || $("#userName2").val() == " "){
				alert("사용자 이름은 필수 입력 사항입니다.");
				return false;
			}
			if($("#email2").val() == null ||$("#email2").val() == "" || $("#email2").val() == " "){
				alert("이메일은 필수 입력 사항입니다.");
				return false;
			}
			if(checkPass == false){
				alert("비밀번호가 일치 하지 않습니다!");
				return false;
			}
			if(checkSms == false) {
				alert("휴대폰 인증이 필요합니다.");
				return false;
			}
			if($("#check").prop("checked") == false){
				alert("약관에 동의해 주세요!");
				return false;
			}
			return true;
		}
		
		
		$(function(){

			$("#checkSms").click(function(){
					var inputNum = $("#confirmNumber").val();
					if(sendConfirmNum == inputNum){
						//alert("인증이 완료 되었습니다.");
						$("#confirmNumberArea").hide();
						$("#confirmPhoneResult").text("인증 완료!");
						checkSms = true;
					} else {
						alert("인증번호를 다시 확인해 주세요.");
						$("#confirmNumber").css({
							"border" : "1px solid red",
							"color" : "red"
						});
						checkSms = false;
					}
				}
			);
			
			$("#email").click(function(){
				$(this).select();
			});
			$("#userPwd").click(function(){
				$(this).select();
			});
			$("#signUpArea").css({
				"display":"none"
			});
			$("#kakaoLogin").click(function(){
				$("#kakao-login-btn").click();
				return false;
			});
			
			$("#confirmNumberArea").hide();
			
			checkPass = false;
			checkSms = false;
			//비밀번호 일치여부 확인
			//비밀번호 일치여부 감지
			$("#password2").on("change paste keyup", function(){
				if($("#password1").val() == $("#password2").val()){
					$("#confirmResult").removeClass();
					$("#confirmResult").addClass("help is-success");
					$("#confirmResult").text("비밀번호 일치");
					$("#submitBtn").attr("disabled", false);
					checkPass = true;
				} else {
					$("#confirmResult").removeClass();
					$("#confirmResult").addClass("help is-danger");
					$("#confirmResult").text("비밀번호 불일치");
					$("#submitBtn").attr("disabled", true);
					checkPass = false;
				}
			});
		});
		//로그인 화면 보여주기용 함수
		function showSignIn(obj){
			$(obj).parent().attr("class", "is-active");
			$(obj).parent().parent().children().eq(1).removeClass();
			$("#signInArea").css({
				"display":"block"
			});
			$("#signUpArea").css({
				"display":"none"
			});
		}
		//회원가입 화면 보여주기용 함수
		function showSignUp(obj) {
			$(obj).parent().attr("class", "is-active");
			$(obj).parent().parent().children().eq(0).removeClass();
			$("#signInArea").css({
				"display":"none"
			});
			$("#signUpArea").css({
				"display":"block"
			});
		}
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('a78d747cfbe06a103ff9224f83633086');
		//kakao.cleanup();https://developers.kakao.com/docs/js-reference#kakao_cleanup()
	    // 카카오 로그인 버튼을 생성합니다.
	    Kakao.Auth.createLoginButton({
			container: '#kakao-login-btn',
			size : 'large',
			throughTalk : false, //간편 로그인 사용 여부
			persistAccessToken : false, //세션 종료 후 로컬 스토리지 저장 안함
		    success: function(authObj) {
		      
		      Kakao.API.request({
		        url: '/v1/user/me',
		        success: function(res) {
		        	  //이메일이 존재한다면 넣어라.
		        	  if(res.kaccount_email != null || res.kaccount_email != ""){
		        		  $("#email").val(res.kaccount_email);
		        	  }
		              $("#password").val(res.id);
		              $("#userName").val(res.properties['nickname']);
		              $("#enrollType").val("카카오가입");
					  $("#signInArea").attr("action", "kakaoLogin.me");
		              $("#signInBtn").click();
		            } 
		          });
		        },
	        fail: function(error) { //로그인 실패 시 에러를 받을 콜백 함수
	          alert("카카오 계정을 찾을 수 없습니다.");
	          Kakao.Auth.logout();
		      console.log(JSON.stringify(error));
	        }
		 });
		
		//휴대폰 인증하기
		function sendMessage(){
			var phone = $("#userPhoneNumber").val();
			 $.ajax({
		          url: "sendSms.me",
		          data: {
		            receiver: phone
		          },
		          type: "post",
		          success: function(result) {
		            if (result != null || result != "") {
		              alert("인증번호를 발송했습니다.");
		              $("#confirmNumberArea").show();
		              sendConfirmNum = result;
		            } else {
		              alert("인증번호를 발송하지 못했습니다. 휴대전화번호를 확인해 주세요.");
		            } //end if
		          } //end success
		          
		      });//end ajax
		} //end func
		
	</script>
	<!-- end script -->
</body>
</html>