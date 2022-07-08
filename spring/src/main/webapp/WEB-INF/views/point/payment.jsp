<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
	.column .columns {
		margin:0 !important;
	}
	#noLoginBtn{
		background:#FFBD33;
		color:white;
		text-decoration:none;
		font-size:30px;
		border-radius:10px;
		margin-left:70%;
		border:3px solid #FF5733;
		padding:5px 10px 5px 10px;
	}
	#noLoginBtn:hover{
		background:#FFE09F;
		color:#FF5733;
	}
	
</style>
</head>
<body>
	<c:if test="${ empty sessionScope.loginUser }">
	<jsp:include page="../common/mainNav.jsp"/>
		<div class="columns is-mobile">
			<div class="column">
				<section class="section" id="headerSection">
				</section>
				<section>
					<h1 align="center" style="color:#FF5733;"><c:out value="로그인이 필요한 서비스입니다."/></h1>
					<a href="javascript:history.back()" id="noLoginBtn">뒤로가기</a>
				</section>
			</div>
		</div>
		
	</c:if>
	<c:if test="${ !empty sessionScope.loginUser }">
		<jsp:include page="../common/mainNav.jsp"/>
		<div class="columns is-mobile">
			<div class="column">
				<section class="section" id="headerSection">
					<jsp:include page="../common/myPageHeader.jsp" />
					<jsp:include page="pointNav.jsp"/>
				</section>
				<section class="section">
				      <div class="container" style="width:95%;height:100%;border:1px solid #ccccff;margin-top:-60px;">
						<div id="payment">
							<div id="paymentHeader" style="color:purple; font-size:28px;margin-top:3%;margin-bottom:3%;">
						    			포인트 충전내역
						    			
					    	</div>
							<div id="paymentSection" style="border-top:1px solid lightgray;">
								<div id="ps">
									<div id="psHeader" style="margin-top:3%;" align="center">
										<textarea cols="115" rows="4" style="resize:none;border:none;text-align:center;line-height:200%;"readonly>당사는 100원당 100P형식으로 운영되고 있습니다.
	당사에 게시되어있는 여행일정을 구매하시거나, 
	여행설계를 의뢰 맡기실 때에는 당사의 포인트로 이용가능합니다.
										</textarea>
									</div>
									<div id="serviceTerm" align="center">
										<textarea cols="115" rows="5" style="resize:none;border:none;text-align:center;line-height:200%;background:#e3e7ed;"readonly>Travle Interface전자금융거래 이용약관
	제1장 총칙
	제1조 (목적)
	본 약관은 주식회사 Travle Interface(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스, 선불전자지급수단의 발행 및 관리서비스(이하 통칭하여 '전자금융거래서비스'라 합니다)를 회원이 이용함에 있어, 회사와 회원 간 권리, 의무 및 회원의 이용절차 등에 관한 사항을 규정하는 것을 그 목적으로 합니다.
	제2조 (정의)
	1.본 약관에서 정한 용어의 정의는 아래와 같습니다.
	1) '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자금융업무를 제공하고, 회원이 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.
	2) '전자지급수단'이라 함은 선불전자지급수단, 신용카드 등 전자금융거래법 제2조 제11호에서 정하는 전자적 방법에 따른 지급수단을 말합니다.
	3) '전자지급거래'라 함은 자금을 주는 자(이하 '지급인'이라 합니다)가 회사로 하여금 전자지급수단을 이용하여 자금을 받는 자(이하 '수취인'이라 합니다)에게 자금을 이동하게 하는 전자금융거래를 말합니다.
	4) '전자적 장치'라 함은 전자금융거래정보를 전자적 방법으로 전송하거나 처리하는데 이용되는 장치로서 현금자동지급기, 자동입출금기, 지급용단말기, 컴퓨터, 전화기 그 밖에 전자적 방법으로 정보를 전송하거나 처리하는 장치를 말합니다.
	5) '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 회원 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함합니다), 전자서명법 상의 전자서명생성정보 및 인증서, 금융기관 또는 전자금융업자에 등록된 회원번호, 회원의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.
	6) '전자금융거래서비스'라 함은 회사가 회원에게 제공하는 제4조 기재의 서비스를 말합니다.
	7) '회원'이라 함은 본 약관 제2장과 제3장 에서 달리 정한 경우를 제외하고는 본 약관에 동의하고 본 약관에 따라 회사가 제공하는 전자금융거래서비스를 이용하는 이용자를 말합니다.
	8) '거래지시'라 함은 회원이 본 약관에 따라 회사에게 전자금융거래의 처리를 지시하는 것을 말합니다.
	9) '오류'라 함은 회원의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 회원의 거래지시에 따라 이행되지 아니한 경우를 말합니다.
	2.본 조 및 본 약관의 다른 조항에서 정의한 것을 제외하고는 전자금융거래법 등 관련 법령에 정한 바에 따릅니다.
	제3조 (약관의 명시 및 변경)
	1.회사는 회원이 전자금융거래를 하기 전에 본 약관을 개별 서비스에 게시하고 본 약관의 중요한 내용을 확인할 수 있도록 합니다.
	2.회사는 회원의 요청이 있는 경우 전자문서의 전송(전자우편을 이용한 전송을 포함합니다), 모사전송, 우편 또는 직접교부의 방식에 의하여 본 약관의 사본을 회원에게 교부합니다.
	3.회사가 본 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 금융거래정보 입력화면 또는 개별 서비스의 공지사항 게시판 등에 게시함으로써 회원에게 공지합니다. 다만, 법령의 개정으로 인하여 긴급하게 약관을 변경한 때에는 변경된 약관을 홈페이지에 1개월 이상 게시하고 회원에게 전자우편 등을 통하여 사후 통지합니다.
	4.회사는 제3항의 공지나 통지를 할 경우 회원이 변경에 동의하지 아니한 경우 공지나 통지를 받은 날로부터 30일 이내에 계약을 해지할 수 있으며, 계약해지의 의사표시를 하지 아니한 경우에는 변경에 동의한 것으로 본다.”라는 취지의 내용을 공지하거나 통지합니다.
	5.회원이 제4항의 공지나 통지를 받은 날로부터 30일 이내에 계약해지의 의사표시를 하지 아니한 경우에는 변경에 동의한 것으로 봅니다.
	제4조 (전자금융거래서비스의 구성 및 내용)
	1.전자금융거래서비스는 다음 각 호의 개별 서비스로 구성됩니다.
	1) 전자지급결제대행서비스
	2) 선불전자지급수단 발행 및 관리서비스
	2.회사는 필요시 회원에게 사전 고지하고 전자금융거래서비스를 추가하거나 변경할 수 있습니다.
	제5조 (이용시간)
	1.회사는 회원에게 연중무휴 1일 24시간 전자금융거래서비스를 제공함을 원칙으로 합니다. 다만, 금융회사 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.
	2.회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융회사 기타 결제수단 발행업자의 사정에 의하여 전자금융거래서비스 중단이 불가피한 경우, 전자금융거래서비스 중단 3일 전까지 게시 가능한 전자적 수단을 통하여 전자금융거래서비스 중단 사실을 게시한 후 전자금융거래서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등 불가피한 경우에는 사전 게시 없이 전자금융거래서비스를 중단할 수 있습니다.
	제6조 (거래내용의 확인)
	1.회사는 개별 서비스 내 회원 정보 조회 화면을 통하여 회원의 거래내용(회원의 오류정정 요구사실 및 처리 결과에 관한 사항을 포함합니다)을 확인할 수 있도록 하며, 회원이 거래내용에 대해 서면교부를 요청하는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송, 우편 또는 직접 교부의 방법으로 거래내용에 관한 서면을 교부합니다.
	2.회사는 제1항에 따른 회원의 거래내용 서면교부 요청을 받은 경우 전자적 장치의 운영장애, 그 밖의 이유로 거래내용을 제공할 수 없는 때에는 즉시 회원에게 전자문서 전송(전자우편을 이용한 전송을 포함한다)의 방법으로 그러한 사유를 알려야 하며, 전자적 장치의 운영장애 등의 사유로 거래내용을 제공할 수 없는 기간은 제1항의 거래내용에 관한 서면의 교부기간에 산입하지 아니합니다.
	3.제1항의 대상이되는 거래내용 중 대상기간이 5년인 것은 다음 각호와 같습니다.
	1) 거래계좌의 명칭 또는 번호
	2) 전자금융거래의 종류 및 금액
	3) 전자금융거래상대방을 나타내는 정보
	4) 전자금융거래일시
	5) 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보
	6) 회사가 전자금융거래의 대가로 받은 수수료
	7) 회원의 출금 동의에 관한 사항
	8) 해당 전자금융거래와 관련한 전자적 장치의 접속기록
										</textarea>
									</div>
									<div id="radioBtnArea" style="margin-left:10%;">
										<input type="radio" name="agreeStatus" value="yes" id="yes" checked>
											<label for="yes">동의&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
										<input type="radio" name="agreeStatus" value="no" id="no">
											<label for="no">비동의</label>
									</div>
									<div id="payArea" style="width:200px;margin-top:3%;margin-left:auto;margin-right:auto;line-height:160%;">
										<input type="radio" name="payAmount" value="1000" id="1000">
											<label for="1000">1,000원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1,000P</label><br>
										<input type="radio" name="payAmount" value="3000" id="3000">
											<label for="3000">3,000원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3,000P</label><br>
										<input type="radio" name="payAmount" value="5000" id="5000">
											<label for="5000">5,000원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5,000P</label><br>
										<input type="radio" name="payAmount" value="10000" id="10000">
											<label for="10000">10,000원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10,000P</label><br>
										<input type="radio" name="payAmount" value="30000" id="30000">
											<label for="30000">30,000원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30,000P</label><br>
										<input type="radio" name="payAmount" value="50000" id="50000">
											<label for="50000">50,000원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50,000P</label><br>
										<input type="radio" name="payAmount" id="etc">
											<label for="etc">기타&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="number"style="width:100px;visibility:hidden;" min="1000" step="1000" id="etcPay">
											</label><br>
									</div>
									<div id="psBottom" align="center" style="margin-top:3%;">
										포인트를 충전하시겠습니까?						
									</div>
									<div id="btnsArea" align="center" style="margin-top:3%; margin-bottom:3%;">
										<a class="button is-success" style="border-radius:5px; height:25px;" onclick="payTry()"> 충전 </a>
										<a class="button is-danger" style="border-radius:5px; height:25px;" onclick="noPay()"> 취소 </a>
									</div>				
								</div>
							</div>
						</div>
				         
				      </div>
				   </section>
				   <section class="section" id="modal">
					<div class="modal" id="myModal">
						<div class="modal-background"></div>
						<div class="modal-card">
							<header class="modal-card-head">
								<p class="modal-card-title" align="center" id="modayContent"></p>
								<button class="delete" id="del"></button>
							</header>
							
							<footer class="modal-card-foot">
								<div style="margin-left:auto;margin-right:auto;">
									<a class="button is-success okay" style="border-radius:5px; height:25px;width:60px;"> 확인 </a>
								</div>
							</footer>
						</div>
					</div>
				</section>
			</div>
		</div>
	</c:if>
	<script>
		$(function(){
			//기타 영역 자동으로 숨기고 생기고 하는 함수
			$('input[name="payAmount"]').click(function(){
				
				var amount = $('input[name="payAmount"]:checked').val();
	
		        if(amount!='on'){
		        	$("#etcPay").css({"visibility":"hidden"});
		        }else{
			        $("#etcPay").css({"visibility":"visible"});
		        	
		        }
		            
			});
		});
		
		function payTry(){
			var IMP = window.IMP; // 생략가능
			IMP.init('imp10998160');
	
			var status = $("input[name=agreeStatus]:checked").val();
			var money = $('input[name="payAmount"]:checked').val();
			
			if(money=='on'){
				//기타의 경우 input태그에 작성되는 금액 충전
				money = $("#etcPay").val();
				//1000원 단위로 충전가능
				if((money%1000)!=0){
					$("#modayContent").text("1000원 단위로 충전이 가능합니다.");
					$('#myModal').toggleClass('is-active');
					$(".okay").click(function(){
						$('#myModal').removeClass('is-active');
					});
				}else{
					money = money;
					pay(money, status);
				}
			}else{
				money = money;
				pay(money, status);
			}
		}
		function pay(money, status){
			console.log("money : "+money+"  status : "+status)
			if(status=="yes"){
				IMP.request_pay({
				    pg : 'inicis', // version 1.1.0부터 지원.
				    pay_method : 'card',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : '포인트 충전',
				    amount : money,
				   /*  buyer_name : 'id', */
				    /*buyer_email : 'iamport@siot.do',
				    buyer_tel : '010-1234-5678',
				    buyer_addr : '서울특별시 강남구 삼성동',
				    buyer_postcode : '123-456', */
				    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
				}, function(rsp) {
				    if ( rsp.success ) {
				        var msg = '결제가 완료되었습니다.';
						$("#modayContent").text(msg);
						$('#myModal').toggleClass('is-active');
				       /*  msg += '고유ID : ' + rsp.imp_uid;
				        msg += '상점 거래ID : ' + rsp.merchant_uid;
				        msg += '결제 금액 : ' + rsp.paid_amount;
				        msg += '카드 승인번호 : ' + rsp.apply_num;	 */
				        
				        $(".okay").click(function(){
							$('#myModal').removeClass('is-active');
							location.href="toPay.po?tid="+rsp.pg_tid+"&pAmount="+1000000;//rsp.paid_amount
							console.log('yyy');
						});
				        $('.modal-background, .modal-close').click(function() {
				        	console.log('dfsa');
				        	$('#myModal').removeClass('is-active');
				        	location.href="toPay.po?tid="+rsp.pg_tid+"&pAmount="+rsp.paid_amount;
				        })
				    } else {
				        var msg = '결제에 실패하였습니다';
				        msg += " : "+rsp.error_msg;
				        $("#modayContent").text(msg);
					    $('#myModal').toggleClass('is-active');
					    $('.modal-background, .modal-close, .okay').click(function() {
							$('#myModal').removeClass('is-active');
							location.href="toPayView.po";
						});
				    }
				});
			}else{
				$("#modayContent").text("동의를 하셔야 충전이 가능합니다.");
				$('#myModal').toggleClass('is-active');
				$(".okay").click(function(){
					$('#myModal').removeClass('is-active');
				});
			}
		}
		function noPay(){
			$("#modayContent").text("결제를 취소하셨습니다.");
			$('#myModal').toggleClass('is-active');
			$('.modal-background, .modal-close, .okay').click(function() {
				$('#myModal').removeClass('is-active');
				location.href="pointMainView.po?currentPage=1";
			});
		}
	</script>	
	
</body>
</html>