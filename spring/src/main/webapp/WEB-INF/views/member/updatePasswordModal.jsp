<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
	<form action="updateUserPwd.me" method="post">	
	  <div class="modal" id="modalUpdatePassword">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	      <header class="modal-card-head">
	        <p class="modal-card-title" style="padding-top:20px;">비밀번호 재설정</p>
	        <button class="delete is-large" onclick="closeModal(1);"></button>
	      </header>
	      <section class="modal-card-body">
	        <div class="columns">
	        	<div class="column">
	        	
	        		<!-- now password -->
	        		<div class="field is-horizontal">
				     	<div class="field-label is-normal">
			          		<label class="label">현재 비밀번호</label>
			          	</div>
			          	<div class="field is-grouped">
				            <p class="control has-icons-left has-icons-right">
					          <input class="input is-success" type="password" name="oldPassword"
					          		 placeholder="Password" style="border-color:gray;">
					          <span class="icon is-small is-left">
					            <i class="fa fa-lock"></i>
					          </span>
					        </p>
			          	</div> 
				     </div> <!-- end now password -->
				     
				     <!-- change password 1 -->
				     <div class="field is-horizontal">
				     	<div class="field-label is-normal">
			          		<label class="label">변경 비밀번호</label>
			          	</div>
			          	<div class="field is-grouped">
				            <p class="control has-icons-left has-icons-right">
					          <input class="input is-success" type="password" name="newPassword" id="newPassword1"
					                 placeholder="Password" style="border-color:gray;">
					          <span class="icon is-small is-left">
					            <i class="fa fa-lock"></i>
					          </span>
					        </p>
			          	</div> 
				     </div> <!-- change password 1 -->
				     
				     <!-- change password 2 -->
				     <div class="field is-horizontal">
				     	<div class="field-label is-normal">
			          		<label class="label">비밀번호 확인</label>
			          	</div>
			          	<div class="field is-grouped" id="confirmPassword">
				            <p class="control has-icons-left has-icons-right">
					          <input class="input is-success" type="password" id="newPassword2"
					          		 placeholder="Password" style="border-color:gray;">
					          <span class="icon is-small is-left">
					            <i class="fa fa-lock"></i>
					          </span>
					        </p>
					         <p id="confirmResult" class="help is-danger" style="margin-left:10px; padding-top:6px;">비밀번호 불일치</p>
			          	</div> 
				     </div> <!-- change password 2 -->
				     
	        	</div> <!-- end column -->
	        </div> <!-- end columns -->
	      </section>
	      <footer class="modal-card-foot" style="justify-content:flex-end;">
	        <button class="button is-primary" type="submit" id="submitBtn"
	        		onclick="return confirmPassword();" disabled>비밀번호 변경하기</button>
	        <a class="button" onclick="closeModal(1);">취소</a>
	      </footer>
	    </div>
	  </div>
	</form>
	
	<script>
		$(function(){
			//비밀번호 일치여부 감지
			$("#newPassword2").on("change paste keyup", function(){
				if($("#newPassword1").val() == $("#newPassword2").val()){
					$("#confirmResult").removeClass();
					$("#confirmResult").addClass("help is-success");
					$("#confirmResult").text("비밀번호 일치");
					$("#submitBtn").attr("disabled", false);
				} else {
					$("#confirmResult").removeClass();
					$("#confirmResult").addClass("help is-danger");
					$("#confirmResult").text("비밀번호 불일치");
					$("#submitBtn").attr("disabled", true);
				}
			});
			
		});
	</script>
</body>