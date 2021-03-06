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
			        <label class="label colWhite">?????????</label>
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
			        <label class="label colWhite">????????????</label>
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
			      		<a style="color:white;" onclick="$('#modalPassword').toggleClass('is-active')">??????????????? ?????????????????????????</a>
			      	</p>
			      </div>
		      	
		      	  <input type="hidden" value="????????????" name="enrollType" id="enrollType">
		      	  <input type="hidden" name="userName" id="userName">
			      <div class="field field-horizon">
			      	<div class="field-body">
			      		<div class="field">
				          <button class="button is-primary" type="submit" id="signInBtn"><b>SIGN IN</b></button>
				        </div>
			      	</div>
			      </div>
			      <div class="field">
			      	  <button class="button is-primary" id="kakaoLogin" style="background-color: yellow !important; color: #1a0d00;"><b>????????????????????? ?????????</b></button>
			          <a id="kakao-login-btn" style="display : none;"></a>
			      </div>
		      </div>
		  </form>
		  
		      <!-- end SignInArea -->
		      <!-- signUpArea -->
		      <form action="insert.me"  id="signUpArea" method="post" style="width:100%;">
			      <div class="column">
				      <div class="field">
				        <label class="label colWhite">* ????????? ??????</label>
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
				        <label class="label colWhite">* ?????????</label>
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
				        <label class="label colWhite">* ????????????</label>
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
				        <label class="label colWhite">* ???????????? ??????</label>
				        <p class="control has-icons-left has-icons-right">
				          <input class="input is-success" type="password" placeholder="password check" name="password2" id="password2">
				          <span class="icon is-small is-left">
				            <i class="fa fa-lock"></i>
				          </span>
				          <span class="icon is-small is-right">
				            <i class="fa fa-lock"></i>
				          </span>
				        </p>
				        <p id="confirmResult" class="help is-danger" style="margin-left:10px; padding-top:6px;">???????????? ?????????</p>
				      </div>
				      <div class="field">
				      	<label class="label colWhite">* ????????? ??????</label>
				      	<div class="field has-addons" style="width:100%;">
					          <input class="input" type="tel" placeholder="-??? ?????? ??????????????????" name="phone" id="userPhoneNumber">
					          <a class="button" onclick="sendMessage();">?????? ??????</a>
				      	</div>
				      	<p id="confirmPhoneResult" class="help is-success" style="margin-left:10px;"></p>
				      </div>
				      <div class="field" id="confirmNumberArea">
				      	<label class="label colWhite">* ???????????? ??????</label>
				      	<div class="field has-addons" style="width:100%;">
					          <input class="input" type="text" placeholder="????????? ??????????????? ???????????????" id="confirmNumber">
					          <a class="button" id="checkSms">?????? ??????</a>
				      	</div>
				      </div>
				      <div class="field is-horizontal">
				      	<div class="field" style="margin-right:20px;">
					        <label class="label colWhite"> ?????? </label>
					          <span class="select">
					            <select name="gender">
					              <option value="M">??????</option>
					              <option value="F">??????</option>
					            </select>
					          </span>
				      	</div>
				      	<div class="field">			      	
					        <label class="label colWhite"> ???????????? </label>
					        <input class="input is-danger" type="date" placeholder="birthday" name="birthday">
				      	</div>
				      </div>
				      <div class="field">
				        <p class="control">
				          <label class="checkbox">
				            <input type="checkbox" style="color:white;" id="check">
							<a>???????????? ?????? ??????</a> ??? <a>?????? ??????</a>, <a>???????????? ??????</a>??? ?????? ???????????????.
				          </label>
				        </p>
				      </div>
				       <input type="hidden" value="????????????" name="enrollType">
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
				alert("????????? ????????? ?????? ?????? ???????????????.");
				return false;
			}
			if($("#email2").val() == null ||$("#email2").val() == "" || $("#email2").val() == " "){
				alert("???????????? ?????? ?????? ???????????????.");
				return false;
			}
			if(checkPass == false){
				alert("??????????????? ?????? ?????? ????????????!");
				return false;
			}
			if(checkSms == false) {
				alert("????????? ????????? ???????????????.");
				return false;
			}
			if($("#check").prop("checked") == false){
				alert("????????? ????????? ?????????!");
				return false;
			}
			return true;
		}
		
		
		$(function(){

			$("#checkSms").click(function(){
					var inputNum = $("#confirmNumber").val();
					if(sendConfirmNum == inputNum){
						//alert("????????? ?????? ???????????????.");
						$("#confirmNumberArea").hide();
						$("#confirmPhoneResult").text("?????? ??????!");
						checkSms = true;
					} else {
						alert("??????????????? ?????? ????????? ?????????.");
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
			//???????????? ???????????? ??????
			//???????????? ???????????? ??????
			$("#password2").on("change paste keyup", function(){
				if($("#password1").val() == $("#password2").val()){
					$("#confirmResult").removeClass();
					$("#confirmResult").addClass("help is-success");
					$("#confirmResult").text("???????????? ??????");
					$("#submitBtn").attr("disabled", false);
					checkPass = true;
				} else {
					$("#confirmResult").removeClass();
					$("#confirmResult").addClass("help is-danger");
					$("#confirmResult").text("???????????? ?????????");
					$("#submitBtn").attr("disabled", true);
					checkPass = false;
				}
			});
		});
		//????????? ?????? ??????????????? ??????
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
		//???????????? ?????? ??????????????? ??????
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
		// ????????? ?????? JavaScript ?????? ????????? ?????????.
	    Kakao.init('a78d747cfbe06a103ff9224f83633086');
		//kakao.cleanup();https://developers.kakao.com/docs/js-reference#kakao_cleanup()
	    // ????????? ????????? ????????? ???????????????.
	    Kakao.Auth.createLoginButton({
			container: '#kakao-login-btn',
			size : 'large',
			throughTalk : false, //?????? ????????? ?????? ??????
			persistAccessToken : false, //?????? ?????? ??? ?????? ???????????? ?????? ??????
		    success: function(authObj) {
		      
		      Kakao.API.request({
		        url: '/v1/user/me',
		        success: function(res) {
		        	  //???????????? ??????????????? ?????????.
		        	  if(res.kaccount_email != null || res.kaccount_email != ""){
		        		  $("#email").val(res.kaccount_email);
		        	  }
		              $("#password").val(res.id);
		              $("#userName").val(res.properties['nickname']);
		              $("#enrollType").val("???????????????");
					  $("#signInArea").attr("action", "kakaoLogin.me");
		              $("#signInBtn").click();
		            } 
		          });
		        },
	        fail: function(error) { //????????? ?????? ??? ????????? ?????? ?????? ??????
	          alert("????????? ????????? ?????? ??? ????????????.");
	          Kakao.Auth.logout();
		      console.log(JSON.stringify(error));
	        }
		 });
		
		//????????? ????????????
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
		              alert("??????????????? ??????????????????.");
		              $("#confirmNumberArea").show();
		              sendConfirmNum = result;
		            } else {
		              alert("??????????????? ???????????? ???????????????. ????????????????????? ????????? ?????????.");
		            } //end if
		          } //end success
		          
		      });//end ajax
		} //end func
		
	</script>
	<!-- end script -->
</body>
</html>