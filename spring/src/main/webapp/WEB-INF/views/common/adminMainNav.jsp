<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Travel Interface</title>
<link rel="stylesheet" href="resources/css/bulmaswatch.min.css">
<link rel="stylesheet" type="text/css" href="/ti/resources/css/semantic.min.css">
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<style>
   .navbar-item img {
       max-height: 100% !important;
   }
   .subnav{
   	color:black!important;
   }	
</style>

</head>
<body>
   <nav class="navbar is-info is-fixed-top" style="border-bottom:1px solid skyblue">
      <div class="navbar-brand">
         <a class="navbar-item" href="index.jsp"> 
            <img src="resources/images/logo2.png" width="120px" height="70px">
         </a>        
         <div class="navbar-burger burger is-hidden-tablet" data-target="mainNav">
            <span></span> <span></span> <span></span>
         </div>
      </div>
      <div id="mainNav" class="navbar-menu">
         <div class="navbar-start">

            <a class="navbar-item" href="adminMemberListForm.me?currentPage=1&status=ALL"> <strong>회원관리</strong> </a> <!-- href 경로수정(세령) -->

            <div class="navbar-item has-dropdown is-hoverable">
	            <a class="navbar-link " href="adminNoticeList.ad"> <strong>고객센터관리</strong> </a>
	            <div class="navbar-dropdown ">
	                  <a class="navbar-item subnav" href="adminNoticeList.ad"> 공지사항 </a> 
	                  <a class="navbar-item subnav" href="adminMoreQuestionList.ad"> 자주묻는 질문 </a>
	                  <a class="navbar-item subnav" href="oneToOneList.ad"> 1:1 문의 </a> 
	            </div>
	        </div>
            <div class="navbar-item has-dropdown is-hoverable">
               <a class="navbar-link " href="reqTotalList.ad"> <strong>게시판관리</strong> </a>
               <div class="navbar-dropdown ">
                  <a class="navbar-item subnav" href="reqTotalList.ad"> 게시판 </a> 
                  <a class="navbar-item subnav" href="selectAllSpotAdmin.sp?currentPage=1"> 여행지 </a> <!-- href 경로 추가 : 세령 -->
               </div>
            </div>
            <a class="navbar-item" href="reportControlList.ad"> <strong>신고관리</strong> </a>
            <div class="navbar-item has-dropdown is-hoverable">
           		<a class="navbar-link " href="toAPaymentView.po"> <strong>정산관리</strong> </a>
           		<div class="navbar-dropdown ">
                  <a class="navbar-item subnav" href="toAPaymentView.po"> 결제 내역 관리 </a> 
                  <a class="navbar-item subnav" href="toAPointView.po"> 포인트 내역 관리 </a>
                  <a class="navbar-item subnav" href="toAdRefundView.po" style="font-size:0.8em;margin-left:7%;" > 환불 관리</a>
                  <a class="navbar-item subnav" href="toAdProceedsView.po"> 수익금 내역 관리 </a>
                  <a class="navbar-item subnav" href="toAdRebateView.po" style="font-size:0.8em;margin-left:7%;" > 환급 관리</a> 
                </div>
          	</div>
            <a class="navbar-item" href="genderStatistics.sta"> <strong>통계관리</strong> </a>
         </div>
         <div class="navbar-end">
            
            <div class="navbar-item">
               <div class="field is-grouped">
                  <p class="control">
                     <a class="button is-info is-rounded" href="logout.me"> 
                        <span class="icon"><i class="fa fa-user"></i></span> 
                        <span>LOG OUT</span>
                     </a>
                  </p>
               </div>
            </div>
         </div>
      </div>
   </nav>
   <br><br><br><br><br>
</body>
</html>