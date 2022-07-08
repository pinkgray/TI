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
		        	<!-- <form method="post">		 -->        	
		        		<!-- name and bank code -->
		        		<div class="field is-horizontal">
		        			<div class="field-body">
		        				<div class="field">
					          		<label class="label">예금주명</label>
						            <p class="control has-icons-left has-icons-right">
							          <input class="input is-success" name="accpnm" id="accpnm" type="text" 
							          		 placeholder="예금주명" style="border-color:gray;">
							        </p>
		        				</div>
		        				<div class="field">
		        					<label class="label">은행명</label>
						            <div class="select is-fullwidth">
						                <select name="bankcode" id="bankcode">
							                <option value=''>선택하세요
											<option value='003'>기업은행
											<option value='004'>국민은행
											<option value='020'>우리은행
											<option value='031'>대구은행
											<option value='023'>SC제일은행
											<option value='032'>부산은행
											<option value='045'>새마을금고
											<option value='027'>한국씨티은행
											<option value='007'>수협
											<option value='048'>신협
											<option value='037'>전북은행
											<option value='035'>제주은행
											<option value='071'>우체국
											<option value='081'>하나은행
											<option value='088'>신한은행
											<option value='266'>SK증권
											<option value='280'>유진증권
											<option value='287'>메리츠증권
						                </select>
						              </div>
		        				</div>
		        			</div>
					     </div> <!-- end name and bank code -->
					     
					     <!-- account number -->
					     <div class="field is-horizontal">
					     	<div class="field-body">
					     		<div class="field">
					          		<label class="label">계좌번호</label>
						            <p class="control has-icons-left has-icons-right">
							          <input class="input is-success" name="accnum" id="accnum" type="text" 
							          		 placeholder="-를 제외하고 입력하세요." style="border-color:gray;">
							        </p>
		        				</div>
		        				<div class="field">
	        						<label class="label">생년월일</label>
		        					<p class="control has-icons-left has-icons-right">
							          <input class="input is-success" name="account_holder_info" id="account_holder_info" type="text" 
							          		 placeholder="주민번호 앞 6자리를 입력하세요." style="border-color:gray;">
							        </p>
		        				</div>
					     	</div>
					     </div> <!-- end account number -->
					     
					     <!-- button area -->
					     <div class="field is-horizontal" style="float: right;">
					     	<div class="field-body">
					     		<div class="field">
					     			<button class="button is-primary" id="confirmacc" onclick="fnSearchAccessToken();">인증하기</button>
	        						<!-- <a class="button is-primary" id="updateAccInfo" href="updateUserAcc.me">저장하기</a> -->
					     		</div>
					     		<div class="field">
					     			<input type="checkbox" id="sbm-flag" name="checkacc" style="display:none">
									<label id="sbm-no" style="background:red;color:white;border-radius:3px;padding:3px;">미인증</label>
									<label id="sbm-ok" style="background:green;color:white;border-radius:3px;padding:3px;display:none">인증됨</label>
					     		</div>
					     	</div>
					     </div> <!-- end button area -->
					    <!--  </form> -->
		        	</div> <!-- end column -->
		        </div> <!-- end columns -->
		      </section>
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	<!-- hidden area -->
	<div style="display: none;">
		<form name="authCodeFrm" id="authCodeFrm" method="GET" action="https://testapi.open-platform.or.kr/oauth/2.0/authorize">
			<!-- <span class="ess">Client ID</span> -->
			<span><input type="hidden" id="client_id" name="client_id" value="l7xx12c95ed6254a439b8cff2ac3cd6703fb"></span>
			<!-- <span>Client Secret</span> -->
			<span><input type="hidden" id="client_secret" name="client_secret" value="9ee0c423de724527b73b00486e37b4c2"></span>
			<!-- <span>Access Token</span> -->
			<span><input type="hidden" id="access_token" name="access_token"></span>
			<!-- <span>요청일시</span> -->
			<span><input type="hidden" class="txt" id="tran_dtime" title="요청일시 입력" name="tran_dtime" /></span>
			<!-- <span>은행코드</span> -->
			<span><input type="hidden" class="txt" id="bank_code_std" name="bank_code_std"></span>
			<!-- <span>계좌번호</span> -->
			<span><input type="hidden" class="txt" id="account_num" name="account_num"></span>
		</form>
	</div> <!-- end hidden area -->
	<c:if test="${ !empty msg }">
		<script>
			alert('${ msg }');
			window.opener.location.reload();
			window.close(); 
		</script>
	</c:if>
	<c:if test="${ success eq 'success'}">
		<script type="text/javascript">
			window.opener.location.reload();
			window.close(); 
		</script>
	</c:if>
	<!-- script -->
	<script type="text/javascript">
		$.support.cors = true;
		var reqDate = new Date();
		var year = reqDate.getFullYear() +"";
		var month = (reqDate.getMonth() + 1) > 10?reqDate.getMonth() + 1 + "":"0" + (reqDate.getMonth() + 1);
		var date = (reqDate.getDate() > 10?reqDate.getDate() + "":"0" + reqDate.getDate());
		var hour = reqDate.getHours() > 9?reqDate.getHours() + "":"0" + reqDate.getHours();
		var min = reqDate.getMinutes() > 10?reqDate.getMinutes() + "":"0" + reqDate.getMinutes();
		var sec = reqDate.getSeconds() > 10?reqDate.getSeconds() + "":"0" + reqDate.getSeconds();
		
		var currentTime = year + month + date + hour + min + sec;
		console.log(currentTime)
		$("#tran_dtime").val(currentTime);
		/* 사용자인증 Access Token 획득 */
		function fnSearchAccessToken() {
			$("#bank_code_std").val($("#bankcode").val());
			$("#account_num").val($("#accnum").val());
			var client_id = $("#client_id").val();
			var client_secret = $("#client_secret").val();
			var grant_type = "client_credentials";
			var scope = "oob";
			$.ajax({
				//url: "/tpt/test/getOauthToken",
				url : "https://testapi.open-platform.or.kr/oauth/2.0/token",
				type : "POST",
				//cache: false,
				contenType : "application/json",
				data : {
					"client_id" : client_id,
					"client_secret" : client_secret,
					"grant_type" : grant_type,
					"scope" : scope
				},
				dataType : "json",
				success : function(data, data2, data3) {
					var list = JSON.parse(data3.responseText);
					$("#access_token").val(list.access_token);
					$("#user_seq_no").val(list.user_seq_no);
					fnSearchRealName();
				},
				error : function(data, data2, data3) {
					alert('error!!!');
				}
			});
		}
		/* 계좌실명조회API */
		function fnSearchRealName() {
			var bank_code_std = $("#bank_code_std").val();
			var account_num = $("#account_num").val();
			var account_holder_info = $("#account_holder_info").val();
			var tran_dtime = $("#tran_dtime").val();
			var access_token = "Bearer " + $("#access_token").val();
			console.log(bank_code_std);
			console.log(account_num);
			console.log(account_holder_info);
			console.log(tran_dtime);
			console.log(access_token);
			var resData = {
				"bank_code_std" : bank_code_std,
				"account_num" : account_num,
				"account_holder_info" : account_holder_info,
				"tran_dtime" : "20160310101921"
			};
			$.ajax({
				url : "https://testapi.open-platform.or.kr/v1.0/inquiry/real_name",
				beforeSend : function(request) {
					request.setRequestHeader("Authorization",
							access_token);
				},
				type : "POST",
				data : JSON.stringify(resData),
				dataType : "json",
				success : function(data, data2, data3) {
					console.log(data)
					if (data.account_holder_name == $("#accpnm").val()) {

						$("#sbm-flag").attr("checked", true);
						$("#sbm-ok").show();
						$("#sbm-no").hide();
						var checkacc = "인증됨";
						var pro_no = $
						{
							pro_no
						}
						;
						var bankcode = $('[name=bankcode]').val();
						var accpnm = $('[name=accpnm]').val();
						var accnum = $('[name=accnum]').val();
						
						
						alert('인증 성공!!!');
						$("#confirmacc").hide();
						$("#changeacc").show();
						$("#sbm-flag").attr("checked", true);
								$("#sbm-ok").show();
						$("#sbm-no").hide();
						$("[name=accpnm]").attr("readonly",
										"readonly");
						$("[name=accnum]").attr("readonly",
										"readonly");
						$("[name=bankcode]").not(":selected")
										.attr("disabled", "disabled");
						
						location.href = "updateUserAcc.me?bankcode=" + bankcode + 
						"&accnum=" + accnum;
					} else {
						alert('인증 실패');
						$("#sbm-flag").attr("checked", false);
						$("#sbm-ok").hide();
						$("#sbm-no").show();
						window.opener.location.reload();
						window.close(); 
					}
				},
				error : function(data, data2, data3) {
					alert('error!!!');
				}
			});
		}
	</script>
</body>
</html>