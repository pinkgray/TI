<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<link rel="stylesheet" href="resources/css/bulmaswatch.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style>
	/* body {
		min-width:800px;
		min-height:400px;
	} */
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
	<div class="columns">
		<div class="column">
			<section class="modal-card-body">
		        <div class="columns">
		        	<div class="column">
		        	<form action="changePasswordFromFind.me" method="post">	
		        		<input type="text" style="display: none;" value="${ email }" name="email">	        	
		        		<!-- new Password -->
		        		<div class="field is-horizontal">
		        			<div class="field-body">
		        				<div class="field">
					          		<label class="label">신규비밀번호 : </label>
						            <p class="control has-icons-left has-icons-right">
							          <input class="input is-success" name="newPassword" id="newPassword" type="password" 
							          		 placeholder="new password" style="border-color:gray;">
							        </p>
		        				</div>
		        			</div>
					     </div> <!-- end new Password -->
					     
					     <!-- confirm password -->
					     <div class="field is-horizontal">
					     	<div class="field-body">
					     		<div class="field">
					          		<label class="label">비밀번호 확인</label>
						            <p class="control has-icons-left has-icons-right">
							          <input class="input is-success" name="confirmPassword" id="confirmPassword" type="password" 
							          		 placeholder="confirm password" style="border-color:gray;">
							        </p>
		        				</div>
					     	</div>
					     </div> <!-- end confirm password -->

					     
					     <!-- button area -->
					     <div class="field is-horizontal" style="float: right;">
					     	<div class="field-body">
					     		<div class="field">
					     			<button class="button is-primary" type="submit" onclick="return confirmBtn();">비밀번호 변경하기</button>
	        						<!-- <a class="button is-primary" id="updateAccInfo" href="updateUserAcc.me">저장하기</a> -->
					     		</div>
					     	</div>
					     </div> <!-- end button area -->
					     
					     </form>
		        	</div> <!-- end column -->
		        </div> <!-- end columns -->
		      </section>
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<!-- script -->
	<script>
		function confirmBtn(){
			var newPwd = $("#newPassword").val();
			var confirmPwd = $("#confirmPassword").val();
			
			if(newPwd == confirmPwd){
				return true;
			} else {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
		}
	</script>
</body>
</html>