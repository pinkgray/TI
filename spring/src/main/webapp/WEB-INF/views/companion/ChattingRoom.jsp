<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" type = "text/css" href = "resources/css/companion/chattingRoom.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<!-- modal   -->
<style>
	#chatpeopleTable {
		width : 100%;
	}

	#chatpeopleTable:hover{
		background : lightgray;
		cursor : pointer;
		width : 100%;
	}
	
	.label-danger {
		margin:5%; float:right;padding: .5em .6em .5em;
	}
	
	#chat_box {
		overflow-y: auto;
	   	height: 75%;
	    position: absolute;
	    width: 100%;
	    margin-top: 15%;
	}
	
	#ChatRoomTitle{
	    margin: 5%;
	}
	
	::-webkit-scrollbar { 
    	display: none !important; 	
    }
    
    .Firebtn{
    	background : none ; 
    	border : none;
    	color : red;
    }
    
    #reputicon { 
	 	width: 100%;
	    height: 100%;
	    max-width: 30%;
	    margin-left: 35%;
	    margin-top : 3%;
    }
    
    #reputid{
	   	margin: 5%;
	    margin-left: 20%;
	    font-size: 15px;
	    text-align : center;
    }
    
    #reputinfor{
    	margin-left: 43%;
    	font-size: 15px;
    	text-align : center;
    }
    
    .item{
    	height : auto;
    	max-height: 200px;
    	overflow-y: auto;
    }
    
    .itembtn{
    	width : 50% !important;
    	color: white!important;
    	background-color: #7c91dc!important;
    	border :1px solid #7c91dc!important;
	}
	
	.itembtn:hover{
    	width : 50% !important;
    	background-color: white!important;
    	color: #7c91dc!important;
    }
    
    #chatStatusTable td{
		padding : 3%;
    }
    

    #chatStatusTable {
    	width : 100%;	   
   	}
   	
   	#bathSpan {
    float: right;
    background: #fd5c5c;
    border-radius: 3px;
    padding: 3px;
    color: white;
	}
	
	.penaltybtn{
		background : none;
		border : none;
		float : right;
	}
	
	
	.reputMemssagebtn{
		background : none;
		float : right;
		border : none;
	}
	
	.reputForm{
		float : left;
	}
	
	.reputForm td{
		padding : 5px;
	}
	
	.switch {
	width: 100%;
    height: 50px;
    text-align: center;
    background: #00bc9c;
    transition: all 0.2s ease;
    border-radius: 25px;
	}
	
	
  	.switch label {
	    cursor: pointer;
	    color: rgba(0,0,0,0.2);
	    width: 60px;
	    line-height: 50px;
	    transition: all 0.2s ease;
	 }
	 
	#reputGoodLabel{
	    margin-left : 20%;
	    height: 20px;
	    float : left;
	}
	  
	#reputBadLabel {
	   margin-right : 20%;
	    float : right;
	 } 
	  
	

	#reputContent , #reputOneContent{
		 margin: 0px;
	    width: 339px;
	    height: 186px;
		resize : none;
	}
	
	.reputDetailTable{
		width: 100%;
	}
	
	.reputDetailTable td{
		padding : 10px;
	}
	
		
	#goodicon, #badicon{
		font-size : 20px;
		padding : 0 ;
		float : right ; 
	}
	
	#downDiv{
		width : 100%;
		height : 50px;
	}
	
	#downbtn {
    width: 40px;
    height: 40px;
    float: right;
    margin-right: 10px;
    border: none;
    border-radius: 50px;
    background: #79aaf7;
	}
	
	#footer{
		height : 20%;
	}
	
	#message {
    margin-left: 10px;
	}
    
	
</style>
<body>
	<c:set var = "contextPath" value = "${pageContext.servletContext.contextPath }" scope = "application"/>
	<input type = "hidden" value = "${chatId}" id = "ReChatID">
	<input type = "hidden" value = "${loginUser.userName}" id = "UserName">
	<input type = "hidden" value = "${loginUser.memberId}" id = "loginId">

	
	<div class="w3-sidebar w3-bar-block w3-card w3-animate-right" style="display:none;right:0;width:80%;" id="rightMenu">
	  <div style = "height : 7%; width : 100%; background: #6196ed;">
	  	<button onclick="closeRightMenu()" 
	  			class="w3-bar-item w3-button w3-large" 
	  		 	data-toggle="tooltip" data-placement="right" title="메뉴닫기"
	  			style = "width: 15%;float:left;height: 100%;">
			<i class="material-icons" 
			style = "color : black; font-size : 20px;">close</i>
	  	</button>
		 <label style = "font-size :15px; padding : 15px; margin-left : 15%; margin-top:1%;">채팅방 정보</label>
		 <span id = "Recruitingicon" class="label label-danger">모집중</span>
	  </div>
	  <div id = "RoomInfoDIV" style = "height : 30%; width : 100%; overflow-y: auto; "></div>
	  <div style = "height : 7%; width : 100%; background : #a8c9ff">
	  	 <label style = "margin: 20px;">대화상대</label>
	  </div>
	  <div id = "MemberInfoDiv" style = "height : 50%; width : 100%; overflow-y : auto;"></div>
	  <div style = "height : 5%;">
	  	<ul class="list-inline" style = "border-top:1px solid lightgray;">
   			 <li> 
   			 <button  data-toggle="tooltip" 
	  	      data-placement="right" title="채팅방 나가기" id = "outbtn" 
	  	      onclick="document.getElementById('id01').style.display='block'">
	  	 		<i class="material-icons" 
	  	 			style = "margin :0 ; padding : 3px; 
	  	 				color: black; font-size : 30px;">input</i>
	  	 	</button></li>
    		<li style = "margin: 3px;float: right;">
	    		<button id = "setting"  data-toggle="tooltip" 
	  	     		 data-placement="top" title="채팅방 설정"   onclick="document.getElementById('statusModal').style.display='block'">
	    			<i class="material-icons"
	    			style = "margin:0; padding: 0; color : gray; font-size : 30px;">
	    			settings</i>
	    		</button>
    		</li>
  		</ul>
	 </div>
	</div>
	
	<!-- content  -->
	<div class="w3-teal">
	  <button id = "returnBtn" onclick = "location.href = '${contextPath}/enterRoom.ch'"><i class="material-icons" >keyboard_arrow_left</i></button>
	  <button class="w3-button w3-teal w3-xlarge w3-right" id = "menubtn" onclick="openRightMenu()">&#9776;</button>
	  <div class="w3-container" id = "header">
	   	 <h4 align = "center" id = "ChatRoomTitle">채팅방 불러오기 실패</h4>
	  </div>
	</div>
	<div class="w3-container" id = "chat_box"></div>
	<div id="footer" >
		<div id = "downDiv">
			<button id = "downbtn" style = "float : right"><i class="material-icons">arrow_drop_down</i></button> 
		</div>
		<textarea rows="3" cols="30" name = "message" id = "message"></textarea>
		<button type="button" class="btn btn-primary" id = "sendbtn">전송</button>
	</div>
	
	<!--여기서 부터 모달창   -->
	<!-- 나가기 모달창 -->
	 <div id="id01" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('id01').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" >채팅방을 나가겠습니까?</h4>
	      </header>
	      <div class="w3-container">
	      <br>
	        <p>
	                  나가기를 하면 대화내용이 모두 삭제되고 채팅목록에서도 삭제됩니다 <br>
	                  또한, 나가기 버튼 클릭시 참여중인 채팅목록으로 이동됩니다.
	        </p>
	        <br>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "exitBtn" class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;">나가기</button>
	      </footer>
	    </div>
  	</div>
  	
  	 <!-- 상태 변화 하는 설정 모달 창   -->
  	 <div id="statusModal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('statusModal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center">설정</h4>
	      </header>
	      <div class="w3-container" id = "statusContent" align = "center">
	      	<br>
	   		<table id = "chatStatusTable">
	   			<tr>
	   				<td><b>채팅방 상태 </b></td>
	   				<td id = "chatStatusLabel" style = "text-align : right;"></td>
	   			</tr>
	   			<tr>
	   				<td colspan = "2" id = "chatSatusDetail"></td>
	   			</tr>
	   		</table>
	      </div>
	      <br>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "AddchangeBtn" class="w3-button w3-black" 
	       	 style = "float : left; background-color: #f09eda !important;height : 50px;">설정 더보기</button>
	       	 <button id = "changeBtn" class="w3-button w3-black" style = "float : right;height : 50px; background-color: #f09eda !important;"></button>
	      </footer>
	    </div>
  	</div>
  	
  	<!-- 사용자 정보 모달창  -->
  	<div id="reputInfo" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span id = "reputClose" onclick="document.getElementById('reputInfo').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" id = "reputuserName">사용자정보</h4>
	      </header>
	      <div class="w3-container">
	   		<div class = "info">
	   			<input type = "hidden" id = "selectUserId">
	   			<input type = "hidden" id = "selectUserName">
    			<img alt="user" src="resources/images/usericon.png" id = "reputicon">
    			<br>
    			<label id = "reputid"></label>
    			<br>
    			<label id = "reputinfor"></label>
    			<div class="w3-bar w3-black">
				  <button class="w3-bar-item w3-button itembtn" onclick="openItem('Like')" >좋아요 <span id = "goodCount"></span></button>
				  <button class="w3-bar-item w3-button itembtn" onclick="openItem('Bad')">싫어요 <span id = "badCount"></span></button>
				</div>
				<div id="Like" class="w3-container item">
					
				</div>
				<div id="Bad" class="w3-container item" style="display:none">
				
				</div>			
    		</div>
	      </div>
	      <br><br>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important; height: 50px;">
	       	 <button id = "Firebtn" class="w3-button w3-black" style = "height: 50px;  float : left; background-color: #f09eda !important;">강퇴하기</button>
	       	 <button id = "declarBtn" class="w3-button w3-black" style = "height: 50px; float : right; background-color: #f09eda !important;">신고하기</button>
	      </footer>
	    </div>
  	</div>
  	
  	 <!-- 상태 변화 하는 설정 모달 창   -->
  	 <div id="reputModal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('reputModal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center">여행 종료</h4>
	      </header>
	      <div class="w3-container" id = "statusContent" align = "center">
	      	 
	      	<!-- <label style = "text-align : left;">즐거운 여행을 하셨습니까?<br> 같이 여행간 동행자의 평판 관리를 해주세요</label> -->	      	 
	      	<div id = "reputChatInfor">
	      	
			</div>
			<hr>
	      	<div class="w3-content w3-display-container" id = "reputSendForm"></div>
			  <br>		
	     	</div>
	     	<label style = "color:red;font-size : 12px; margin-left : 10px;">한번이라도 평판관리 참여시 해당창은 더이상 나오지 않습니다. </label>
	      <br>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "prebtn" class="w3-button w3-black" 
	       	 style = "float : left; background-color: #f09eda !important;height : 50px;" onclick="plusDivs(-1)">이전으로</button>
	       	 <button id = "nextbtn" class="w3-button w3-black" style = "float : right;height : 50px; background-color: #f09eda !important;" 
	       	  onclick="plusDivs(+1)">건너뛰기</button>
	       	 <button  id = "submitbtn" class="w3-button w3-black" style = "float : right;height : 50px; background-color: #f09eda !important;">제출하기</button>
	      </footer>
	    </div>
  	</div>
  	
  	<!--한개의 평판관리 모달창  -->
  	 <div id="reputOneModal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('reputOneModal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" >평판관리</h4>
	      </header>
	      <div class="w3-container">
	      	<br>
	        	<table>
	        		<tr>
	        			<td>
	        				<input type = "hidden" id = "PutUserId">
	        				<div align = "center">
	        					<label id = "putUser"></label>님의 평판을 작성해주세요
	        				</div>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>
	        				   <input type="radio" name="rdo" id="reputOneGood" class = "reputGood" style = "display:none;" value = "good" checked>
		    		  		   <input type="radio" name="rdo" id="reputOneBad" class = "reputBad" style = "display:none;" value = "bad">
		    		  	  	   <div class="switch" id = "reputSwitch">
		    		  	  	   <label for="reputOneGood" id = "reputGoodLabel">좋아요</label>
		    		  	  	   <label for="reputOneBad" id = "reputBadLabel">싫어요</label>
		    		  	  	   </div>
		    		  	 </td>
	        		</tr>
	        		<tr>
	        			<td>
	        				<textarea placeholder = "상세내용을 작성해주세요" id = "reputOneContent"></textarea>
	        			</td>
	        		</tr>
	        	</table>
	        <br>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "ReputOneSubmit" class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;">제출하기</button>
	      </footer>
	    </div>
  	</div>
  	
  	<div id="ReputAlready" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('ReputAlready').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="left" >평판관리</h4>
	      </header>
	      <div class="w3-container">
	      	<br>
	        	<label>이미 평판관리 이력이 있습니다.</label>
	        <br>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "close" onclick="document.getElementById('ReputAlready').style.display='none'" 
	       	  class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;">확인</button>
	      </footer>
	    </div>
  	</div>
	
	
	
	<script src="http://192.168.30.107:8010/socket.io/socket.io.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.1.js"></script>
	<script>
		function openRightMenu() {
		  document.getElementById("rightMenu").style.display = "block";
		}
		
		function closeRightMenu() {
		  document.getElementById("rightMenu").style.display = "none";
		}
		
		
		$(document).ready(function() { //start
			var userId = ${ loginUser.memberId };
			var userName = $("#UserName").val();
			var chatId = $("#ReChatID").val();
			
    		console.log("userId :"+userId);
    		console.log("chatId :" + chatId);
    		  		
    	   //서버
		   var socket = io("http://192.168.30.107:8010");
    	  	
		   //채팅Manager 값 가져오기
	       socket.emit('preChatManager' , {chatId : chatId , div : "처음"});
	       
		   
	       //채팅Manager 값 가져오기
	       var  count = 0;
	       var goodcnt = 0;
		   var badcnt = 0;
		   
	
		   //채팅 스크롤
		   $("#chat_box").scroll(function () { 
			   var scrollValue = $("#chat_box").scrollTop(); console.log(scrollValue); 
			   if (scrollValue < 300){
				   $("#downbtn").show();
			   }else {
				   $("#downbtn").hide();
			   }
			});

		   //채팅 아래로 내리기 
		   $("#downbtn").click(function(){
			   $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight); 
		   });
	      
	       socket.on('preChatManager', function(data){
	        	   console.log(data);
	        	   
	        
	        	   $.ajax({
	        		   url : "${contextPath}/memberInfo.ch",
	        		   data : {userId : data.user},
	        	       success : function(userInfo) {
	        	    	   var output = "";
	        	    	   output += '<table id = "chatpeopleTable" class = "chatpeopleTable" style = "border-bottom : 1px solid lightgray;">';
	    	        	   output += '<tr><td colspan = "2">';
	    	        	   output += '<input type = "hidden" value = "'+ userInfo.memberId +'" name = "userId" id = "userId">';
	    				   output += '<input type = "hidden" value = "'+ userInfo.userName +'" name = "username" id = "username">';
	    				   output += '<input type = "hidden" value = "'+ userInfo.age +'" name = "userAge" id = "userAge">';
	    				   output += '<input type = "hidden" value = "'+ userInfo.gender +'" name = "usergender" id = "usergender">';
	    				   output += '<label id = "chUserInfo">'+ userInfo.userName +'('+userInfo.email+')</label>';	
	    				   if (data.level == 1){
	    					   output += '<span id = "bathSpan">방장</span>';		
	    				   }
	    				   output += '</tr>';
	    		  		   output += '</table>'; 
	    		  		   
	    		  		   
	    		  		   $(output).appendTo("#MemberInfoDiv");
	    		  		   
	    		  		   
	    		  		   if (userId != userInfo.memberId){
	    		  			 if (userInfo.gender == "M"){
		    		 	 			gender = "남";
		    		 	 		}else {
		    		 	 			gender = "여";
		    		 	 		}
		    		 	 		
		    		 	 		var age;
		    		 	 		if (userInfo.age != 0){
		    		 	 			var temp = userInfo.age / 10;
		    		 	 			
		    		 	 			temp = Math.floor(temp);
		    		 	 			
		    		 	 			age = temp + "0 대";
		    		 	 			
		    		 	 		}else {
		    		 	 			age = "미정";
		    		 	 		}
		    		  		   
		    		 	 	   var reputModelput = "";
		    		 	 	   
		    		 	 	   if (count == 0){
		    		 	 		 reputModelput +=  '<div class = "mySlides" style = "display:block;"">'; 
		    		 	 	   }else {
		    		 	 		 reputModelput +=  '<div class = "mySlides" style = "display:none;">'; 
		    		 	 	   }
		    		 	 	   
		    		  		  	
		    		  		   reputModelput +=  '<table class = "reputForm">';
		    		  		   reputModelput +=  '<tr>';
		    		  		   reputModelput += '<td>동행자</td>';
		    		  		   reputModelput += '<td colspan = "3">';
		    		  		   reputModelput += '<input type = "hidden" value = "'+ userInfo.memberId +'" name = "reputUserId" id = "reputUserId">';
		    		  		   reputModelput += '<label>'+userInfo.userName+'</label>('+userInfo.email+')</td></tr><tr>';
		    		  		   reputModelput += '<td>성별</td><td><label>'+gender+'</label></td>';
		    		  		   reputModelput += '<td>나이 </td><td><label>'+age+'</label></td></tr><tr>';
		    		  		   reputModelput += '<td colspan = "4"><label>평판</label></td></tr><tr>';
		    		  		   reputModelput += '<td colspan = "4"><input type="radio" name="rdo" id="reputGood'+count+'" class = "reputGood" style = "display:none;" value = "good" checked>';
		    		  		   reputModelput += '<input type="radio" name="rdo" id="reputBad'+count+'" class = "reputBad" style = "display:none;" value = "bad">';
		    		  	  	   reputModelput += '<div class="switch" id = "reputSwitch"><label for="reputGood'+count+'" id = "reputGoodLabel">좋아요</label><label for="reputBad'+count+'" id = "reputBadLabel">싫어요</label></div>';
		    		  	  	   reputModelput +=	'</td></tr><tr><td colspan = "4">';
		    		  	  	   reputModelput += '<textarea placeholder = "상세내용을 작성해주세요" id = "reputContent"></textarea>';
		    		  	  	   reputModelput += '</td></tr></table></div>';	
		    		  	  	   
		    		  	  	   $(reputModelput).appendTo("#reputSendForm");
					 			
			    		  	  count++;
	    		  		   }
	    		  		  
	    		  		   
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
	        	   });
	        	   
	        	  
	        	  
	        	   
	        	   if (userId == data.user){
	        		   var enterDate = data.enter_date
	        		   
	        		   console.log("들어온 날짜 :"+enterDate);
	        		   
	        		   if (data.div == "처음"){
	        			   //채팅방  대화 가져오기 위해서 소켓 실행
		    	           socket.emit('preChat', {userId : userId ,  chatId : chatId , enter_date : enterDate});
	        		   }
	        		   
	        		   $("#Firebtn").hide();
	        		   
	        		   if (data.level == 2){
	        			   $("#setting").hide();
	        			   $("#Firebtn").hide();
	        			   $("#bathSpan").hide();
	        		   }else {
	        			   $("#outbtn").attr("disabled" , "disabled");
	        			   $("#checkModel").show();
	        			   $("#setting").show();
	        			   $("#Firebtn").show();
	        			   $("#bathSpan").show();
	 	        	   }
	        		 
	        		 
	        	   }
	        	
	        	
	          });
    	  	
    	  	//메세지 보내기 enter 
			 $("#message").keydown(function(key) {
	                //해당하는 키가 엔터키(13) 일떄
	                if (key.keyCode == 13) {
	                    //msg_process를 클릭해준다.
	                    sendbtn.click();
	                }
	            });
	 
	           //msg_process를 클릭할 때
	           $("#sendbtn").click(function() {
	                //소켓에 send_msg라는 이벤트로 input에 #msg의 벨류를 담고 보내준다.
	                
	                console.log("message :" + $("#message").val());
	                
	                socket.emit('message', {
	                	userId :userId , userName : userName , message : $("#message").val() , chatId : chatId
	                });
	                //#msg에 벨류값을 비워준다.
	                $("#message").val("");
	          });
	           
	           //메세지 보낸 후
	           socket.on('message' , function(data){
	                var output = '';
	                
	                console.log(data);
	                
	                var mchatId = data.chat_id;
	                
	                if (mchatId == chatId){
	                	
	                	if (data.userId == userId){
	 		                output += '<div class="alert alert-info" id = "msg" style = "background : #f1ccfc; border-color: #f1ccfc;"><strong>';                	
	 	                }else {
	 	                	output += '<div class="alert alert-info" id = "msg"><strong>'; 
	 	                }
	                	
	                	if (data.userName != null){
	                		output += data.userName;
	                	}
	 	              	
	 	                
	 	                output += '</strong> ';
	 	                output += data.message;
	 	                output += '</div>';
	 	                $(output).appendTo('#chat_box');
	 	                
	 	                $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight);
	                }
	               
	            });
	           
      
	            //채팅들어왔을때 채팅 정보가져오기 
	           socket.on('preChat' , function(data){
	                var output = '';
	                
	                if (data.userId == userId ){
		                output += '<div class="alert alert-info" id = "msg" style = "background : #f1ccfc; border-color: #f1ccfc;"><strong>';                	
	                }else {
	                	output += '<div class="alert alert-info" id = "msg"><strong>'; 
	                }
	                
	                if (data.userName != null){
                		output += data.userName;
                		
                	}
	                
	                output += '</strong> ';
  		            output += data.message;
  		            
	                
	                if (data.sep == "나감"){
	                	output += "<input type = 'hidden' value = '"+data.userId+"' id = 'outUserId'>"
	                	output += "<button class = 'penaltybtn' id = 'chatoutbtn'> 신고 </button>";
				        output += "<button class = 'reputMemssagebtn' id = 'reputMemssagebtn'> 평판관리 </button>";
	                }
	                
	                output += '</div>';
	              
	                $(output).appendTo('#chat_box');
	                
	                $(".reputMemssagebtn").hide();
	                
	                $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight);
	            });
	           
	          //채팅방 정보  가져오기
	          socket.emit('preChatInfo' , {chatId : chatId});
	          
	          //채팅방 정보  가져오기
	          socket.on('preChatInfo' , function(data){  
	        	  var title = data.title;
	        	  
	        	  if (title != null){
					  if (title.length > 7){
				        	  $("#ChatRoomTitle").text(title.substr(0,7) + "...    (" + data.activityNum  + ")" );
			          }else {
			        		  $("#ChatRoomTitle").text(title + "     (" + data.activityNum + ")");
			          } 
				  }
	        	  
	        	  var formattedStartDate = new Date(data.start);
	        	  var sd = formattedStartDate.getDate();
	        	  var sm =  formattedStartDate.getMonth();
	        	  sm += 1;  // JavaScript months are 0-11
	        	  var sy = formattedStartDate.getFullYear();

				 var startDate = sy + "/" + sm  + '/' + sd;
				 
				 var formattedEndDate = new Date(data.end);
	        	  var ed = formattedEndDate.getDate();
	        	  var em =  formattedEndDate.getMonth();
	        	  em += 1;  // JavaScript months are 0-11
	        	  var ey = formattedEndDate.getFullYear();

				 var endDate = ey + "/" + em  + '/' + ed;
				 
				 var reputout = "";
				 reputout += '<input type = "hidden" id = "reputPlace" value = "'+data.place+'">';
				 reputout += '<input type = "hidden" id = "reputStart" value = "'+ startDate +'">'
				 reputout += '<input type = "hidden" id = "reputEnd" value = "'+ endDate +'">'
				 reputout += '<br><p style = "text-align : left;"><b>';
				 reputout += startDate +'~' + endDate  + '</b><br>의 모든 여행일정이 종료되었습니다.<br>';
				 reputout += '여행은 즐거웠나요?<br>함께간 동행자들에 대해서 익명으로 작성해주세요 <br>';
				 reputout +=  '저희 홈페이지 동행자 찾기에 많은 도움이 됩니다.<br>';
				 reputout +=  '사실적인 솔직한 후기를 작성해주세요 <br></p>';
				 
			     $(reputout).appendTo('#reputChatInfor');
			    
	        	 var output = "";
	        	  
	        	 output += '<table id = "Chattinginfor">';
	        	 output += '<tr><td><b>채팅방 제목</b></td>';
	  	  		 output += '<td>'+title+'</td>';
	  	  		 output += '</tr><tr>';
	  	  		 output += '<td><b>여행지</b></td>';
	  	  		 output += '<td>'+data.place+'</td>'
	  	  		 output +=	'</tr><tr>'
	  	  		 output += '<td><b>여행날짜</b></td>';
	  	  		 output += '<td>' + startDate + "~" + endDate + "</td>"
	  	  		 output += "</tr>"
	  	  		 output += '<tr><td><b>상세설명</b></td>';
	  	  		 output += "</tr>"
	  	  		 output += "<tr>"
	  	  		 output += "<td colspan = '2'>" + data.detail + "</td>"
	  	  		 output += '</table>';
	        	  
	  	  		 $(output).appendTo('#RoomInfoDIV');
	  	  		
	  	  	    var chatStatus = data.status;
	  	  	 	var temp = "";
	  	  		 $("#Recruitingicon").text(data.status); 
	  	  		 $("#chatStatusLabel").text(chatStatus);
	  	  		 if (chatStatus == "여행중"){
	  	  		 	$("#Recruitingicon").css("background" , "orange");
	  	  			$(".reputMemssagebtn").show();
	  	  		 }else if (chatStatus == "모집종료"){
	  	  			$("#Recruitingicon").css("background","green");
	  	  			temp = "다시 모집을 하시겠습니까?";
	  	  			$("#chatSatusDetail").text(temp);
	  	  			$("#changeBtn").text("모집하기");
	  	  			
	  	  		 }else if (chatStatus == "여행종료"){
	  	  			$("#Recruitingicon").css("background" , "#aa65a8");
	  	  			//document.getElementById('reputModal').style.display='block';
	  	  			
	  	  			 //설문조사 이력이 있을경우 모달창 없애기 
	  			 	 socket.emit('selectReputhistory' , {chatId : chatId , userId : userId});
	  			 	 $(".reputMemssagebtn").show();
	  	  		 }else if (chatStatus == "모집중"){
	  	  			temp = "모집종료를 하시겠습니까?";
	  	  			$("#chatSatusDetail").text(temp);
	  	  			$("#changeBtn").text("모집종료");
	  	  			$("#Recruitingicon").css("background" , "red");
	  	  		 }
	  	  		 
	  	  		 
	  	  		 
	        	 

	        	  
	          });
	          
	          //새로운 회원이 채팅방에 들어왔을 때
	          socket.on('newUser' , function(data){
	        	  var newUser = data;
	        	  
	        	  console.log("userName :" + data.userName)
	        	 
	        	  var mchatId = data.chatId;
	 			  var output = "";
		       	  if (mchatId == chatId){
	 	                output += '<div class="alert alert-info" id = "msg">';
			            output += data.message;
			            output += '</div>';
			            $(output).appendTo('#chat_box');
			            
	 	                $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight);
	               }
	        	  
	        	  $.ajax({
	        		   url : "${contextPath}/memberInfo.ch",
	        		   data : {userId : data.user},
	        	       success : function(userInfo) {
	        	    	   
	        	    	   var output = "";
	        	    	   output += '<table id = "chatpeopleTable" class = "chatpeopleTable" style = "border-bottom : 1px solid lightgray;">';
	    	        	   output += '<tr><td colspan = "2">';
	    	        	   output += '<input type = "hidden" value = "'+ userInfo.memberId +'" name = "userId" id = "userId">';
	    				   output += '<input type = "hidden" value = "'+ userInfo.userName +'" name = "username" id = "username">';
	    				   output += '<input type = "hidden" value = "'+ userInfo.age +'" name = "userAge" id = "userAge">';
	    				   output += '<input type = "hidden" value = "'+ userInfo.gender +'" name = "usergender" id = "usergender">';
	    				   output += '<label id = "chUserInfo">'+ userInfo.userName +'('+userInfo.email+')</label></td>';					
	    				   output += '</tr>';
	    		  		   output += '</table>';
	    		  		   $(output).appendTo("#MemberInfoDiv");
	    		  	
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
	        	   });
	        	 
	        	  
	        	  //채팅방 수정될때 다시 채팅방 정보불러오기 
		          socket.emit('updateChatName' , {chatId : chatId});
	 				
		       	
	 	       
	          });
	          
	         
	          
	          //채팅방에서 나갈때 
	          $("#exitBtn").click(function(){
	        	  
	        	  socket.emit('exitChatting',{userId: userId , chatId : chatId , userName : userName});
	        	  
	        	  
	        	  socket.on('exitChatting', function(data){
	        		  console.log("나간사람 :" +data);
	        		
	        		  
	        		  location.href = "${contextPath}/enterRoom.ch";
	        		  
	        	  });
	        	  
	        	  
	          }); 
	          
	        //사용자가 채팅방을 나간경우 
	        socket.on('outUser' , function(data){
	        	  var newUser = data;
	        	  
	        	 console.log("outUser :" + data);
	        	 
	        	  var mchatId = data.chat_id;
	 			  var output = "";
	 			  
	 			  if (data.div == "나감"){
	 				  if (mchatId == chatId){
		 	                output += '<div class="alert alert-info" id = "msg">'; 
				            output += data.message;
				        	output += "<input type = 'hidden' value = '"+data.userId+"' id = 'outUserId'>"
		                	output += "<button class = 'penaltybtn' id = 'chatoutbtn'> 신고 </button>";
					        if ($("#Recruitingicon").text() == "여행중"){
			                	output += "<button class = 'reputMemssagebtn' id = 'reputMemssagebtn'> 평판관리 </button>";
					        }else if ($("#Recruitingicon").text() == "여행종료"){
					        	output += "<button class = 'reputMemssagebtn' id = 'reputMemssagebtn'> 평판관리 </button>";
					        }
				            output += '</div>';
				            $(output).appendTo('#chat_box');
				            
		 	                $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight);
		               } 
	 			  }else {
	 				  if (mchatId == chatId){
		 	                output += '<div class="alert alert-info" id = "msg">'; 
				            output += data.message;
				            output += '</div>';
				            $(output).appendTo('#chat_box');
				            
		 	                $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight);
		               }  
	 			  }
		       	
		       	  var muserId = data.userId;
		       	  $(".chatpeopleTable").each(function(index ,item) {
	        			 var checkUserID = $(this).children().children().children().children("#userId").val();
	        			 console.log("muserId : " + muserId + "- checkUserId :" + checkUserID);
	        			 if (checkUserID == muserId){
	        				 var outTable = $(this);
	        				 outTable.remove();
	        			 } 
	        	 });
		       	  
		       	  if (userId == data.userId){
		       		  location.href = "${contextPath}/joinRoom.ch";
		       	  }
	        	  
	        	 
	        	  //채팅방 수정될때 다시 채팅방 정보불러오기 
		          socket.emit('updateChatName' , {chatId : chatId});
	 			
	 	       
	         });
	        
	          //강퇴하기 
	          $("#Firebtn").click(function(){
	        	  console.log("fireUser:" + $("#selectUserId").val() );
	        	  
	        	  var fireuser = $("#selectUserId").val();
	        	  var fireusername = $("#selectUserName").val();
	        	  
				  socket.emit('FireChattingUser',{user: fireuser , chatId : chatId , username : fireusername});
	        	  
	        	  
	        	  socket.on('FireChattingUser', function(data){
	        		  $("#reputClose").click();
	    
	        	  });
	        	  
	        	  
	          });
	          
	          //채팅방에 누군가 들어왔을때 다시 채팅방 정보 띄워주는 함수
	          socket.on('updateChatName' , function(data){
				  var title = data.title;
	        	  
				  if (title != null){
					  if (title.length > 7){
				        	  $("#ChatRoomTitle").text(title.substr(0,7) + "...    (" + data.activityNum  + ")" );
			          }else {
			        		  $("#ChatRoomTitle").text(title + "     (" + data.activityNum + ")");
			          } 
				  }
	        	
	          });
	          
	          //설정 더보기 버튼 클릭시 
	          $("#AddchangeBtn").click(function(){
	        	  location.href = "${contextPath}/showchange.ch?num=" + chatId;
	          });
	          
	          
	          //신고하기 버튼 클릭시 
	          $("#declarBtn").click(function(){
	        	 location.href = "${contextPath}/declaration.ch?num=" + chatId + "&id=" + $("#selectUserId").val();  
	          });
	          
	          
	          //채팅방 정보 수정
	          socket.on('updateChatInfo' , function(data){
	        	  console.log("???")
	        	  $("#RoomInfoDIV").empty();
	        	  
 				  var title = data.title;
	        	  
				  if (title != null){
					  if (title.length > 7){
				        	  $("#ChatRoomTitle").text(title.substr(0,7) + "...    (" + data.activityNum  + ")" );
			          }else {
			        		  $("#ChatRoomTitle").text(title + "     (" + data.activityNum + ")");
			          } 
				  }
				  
				  var formattedStartDate = new Date(data.start);
	        	  var sd = formattedStartDate.getDate();
	        	  var sm =  formattedStartDate.getMonth();
	        	  sm += 1;  // JavaScript months are 0-11
	        	  var sy = formattedStartDate.getFullYear();

				 var startDate = sy + "/" + sm  + '/' + sd;
				 
				 var formattedEndDate = new Date(data.end);
	        	  var ed = formattedEndDate.getDate();
	        	  var em =  formattedEndDate.getMonth();
	        	  em += 1;  // JavaScript months are 0-11
	        	  var ey = formattedEndDate.getFullYear();

				 var endDate = ey + "/" + em  + '/' + ed;

	        	 var output = "";
	        	  
	        	 output += '<table id = "Chattinginfor">';
	        	 output += '<tr><td><b>채팅방 제목</b></td>';
	  	  		 output += '<td>'+title+'</td>';
	  	  		 output += '</tr><tr>';
	  	  		 output += '<td><b>여행지</b></td>';
	  	  		 output += '<td>'+data.place+'</td>'
	  	  		 output +=	'</tr><tr>'
	  	  		 output += '<td><b>여행날짜</b></td>';
	  	  		 output += '<td>' + startDate + "~" + endDate + "</td>"
	  	  		 output += "</tr>"
	  	  		 output += '<tr><td><b>상세설명</b></td>';
	  	  		 output += "</tr>"
	  	  		 output += "<tr>"
	  	  		 output += "<td colspan = '2'>" + data.detail + "</td>"
	  	  		 output += '</table>';
	        	  
	  	  		 $(output).appendTo('#RoomInfoDIV');
	          });
	         
	          //방장 임명 
	          socket.on('giveAbbot', function(data){
	        	 var loginUser = $("#loginId").val();
    			 var changebath = data;
    			 
    			 if (loginUser == changebath){
    			   $("#outbtn").attr("disabled" , "disabled");
       			   $("#checkModel").show();
       			   $("#setting").show();
       			   $("#Firebtn").show();
    			 }
    			 
    			 $(".chatpeopleTable").remove();
    			 
    			 //채팅Manager 값 가져오기
    		     socket.emit('preChatManager' , {chatId : chatId , div : "처음"});
    		  });
	          
	          //모집종료 및 채팅상태 바꾸기
	          $("#changeBtn").click(function(){
	        	  var status = $("#chatStatusLabel").text();
	        	  
	        	  console.log("채팅방 상태 :" + status);
	        	  
	        	  socket.emit('updateChatSatus' , {chatId : chatId , status : status});
	        	  
	        	  socket.on('updateChatSatus', function(data){
	        		  var changeChatId = data._id;
	        		  
	        		 var chatStatus = data.status;
	        		 
	        		 console.log("상태 :" + chatStatus);
	        		 
	        		 var temp = "";
	 	  	  		 $("#Recruitingicon").text(data.status); 
	 	  	  		 $("#chatStatusLabel").text(chatStatus);
	 	  	  		 if (chatStatus == "여행중"){
	 	  	  		 	$("#Recruitingicon").css("background" , "orange");
	 	  	  			 $(".reputMemssagebtn").show();
	 	  	  		 }else if (chatStatus == "모집종료"){
	 	  	  			$("#Recruitingicon").css("background","green");
	 	  	  			temp = "다시 모집을 하시겠습니까?";
	 	  	  			$("#chatSatusDetail").text(temp);
	 	  	  			$("#changeBtn").text("모집하기");
	 	  	  		 }else if (chatStatus == "여행종료"){
	 	  	  			$("#Recruitingicon").css("background" , "#aa65a8");
	 	  	  		 	$(".reputMemssagebtn").show();
	 	  	  		 }else if (chatStatus == "모집중"){
	 	  	  			temp = "모집종료를 하시겠습니까?";
	 	  	  			$("#Recruitingicon").css("background" , "red");
	 	  	  			$("#chatSatusDetail").text(temp);
	 	  	  			$("#changeBtn").text("모집종료");
	 	  	  		 }
	 	  	  		 
	 	  	  		document.getElementById('statusModal').style.display='none';
	        		  
	        	  });
	        	  
	        	  
	          });
	         
	          socket.on('updateChatttingSatus', function(data){
        		 var changeChatId = data._id;
        		  
        		 var chatStatus = data.status;
        		 console.log("상태 :" + chatStatus);
        		 
        		 var temp = "";
 	  	  		 $("#Recruitingicon").text(data.status); 
 	  	  		 $("#chatStatusLabel").text(chatStatus);
 	  	  		 if (chatStatus == "여행중"){
 	  	  		 	$("#Recruitingicon").css("background" , "orange");
 	  	  		 }else if (chatStatus == "모집종료"){
 	  	  			$("#Recruitingicon").css("background","green");
 	  	  			temp = "다시 모집을 하시겠습니까?";
 	  	  			$("#chatSatusDetail").text(temp);
 	  	  			$("#changeBtn").text("모집하기");
 	  	  			$(".reputMemssagebtn").hide();
 	  	  		 }else if (chatStatus == "여행종료"){
 	  	  			$("#Recruitingicon").css("background" , "#aa65a8");
 	  	  		 }else if (chatStatus == "모집중"){
 	  	  			$("#Recruitingicon").css("background" , "red");
 	  	  			temp = "모집종료를 하시겠습니까?";
 	  	  			$("#chatSatusDetail").text(temp);
 	  	  			$("#changeBtn").text("모집종료");
 	  	  			$(".reputMemssagebtn").hide();
 	  	  		 }
        		  
        	  });
	          
	          
	          $(document).on("click" , "#chatoutbtn", function(){
	        	  var outUser = $(this).parent().children("#outUserId").val();
	        	  
	        	  location.href = "${contextPath}/declaration.ch?num=" + chatId + "&id=" + outUser;  
	          });
	          
	          //평판 제출
	          $("#submitbtn").click(function(){
	        	  $(".mySlides").each(function(index ,item) {
	        		  var reputSubtmDiv = $(this);
	        		  
	        		  if (reputSubtmDiv.css("display") == "block"){
	        			  var reputUserId = $(this).children().children().children().children().children("#reputUserId").val();
	        			  var rdo = $(this).children().children().children().children().children("input[name=rdo]:checked").val();
	        			  var reputContent = $(this).children().children().children().children().children("#reputContent").val();
	        			  var place = $("#reputPlace").val();
	        			  var start = $("#reputStart").val();
	        			  var end = $("#reputEnd").val();
	        			  console.log("reputContent :" + reputContent); 
	        			  
	        			  if (rdo != ""){
	        				  if (reputContent != ""){
	        					  socket.emit('CreateChatReput', {chatId : chatId , userId : userId , reputUserId : reputUserId , level : rdo , content : reputContent , place : place , start : start , end : end});
	    	        		  	  
	    	        			  socket.on('CreateChatReput' , function(){
	    	        				  reputSubtmDiv.remove();
	    	        				  plusDivs(+1);
	    	        			  });
	        				  }
	        			  }
	        	  
	        		  
					  }
	        	  });
	          });
	          
	       var goodcnt = 0;
		  	var badcnt = 0;
	        //참여중인 사용자 리스트 클릭시 
	  		$(document).on("click","#chatpeopleTable tr",function(){
	  		 
				var loginUser = $("#loginId").val();
				
	 	 		var userid = $(this).parent().children().children().children("#userId").val();
	 	 		var user = $(this).parent().children().children().children("#username").val();
	 	 		var ulabel = $(this).parent().children().children().children("#chUserInfo").html();
	 	 		var gender = $(this).parent().children().children().children("#usergender").val();
	 	 		var userAge = $(this).parent().children().children().children("#userAge").val();
	 	 		
	 	 		
	 	 		$("#selectUserId").val(userid);
	 	 		$("#selectUserName").val(user);
	 	 		
	 	 		console.log("user :" + ulabel);
	 	 		
	 	 		
	 	 		if (gender == "M"){
	 	 			gender = "남";
	 	 		}else {
	 	 			gender = "여";
	 	 		}
	 	 		
	 	 		var age;
	 	 		if (userAge != 0){
	 	 			var temp = userAge / 10;
	 	 			
	 	 			temp = Math.floor(temp);
	 	 			
	 	 			age = temp + "0 대";
	 	 			
	 	 		}else {
	 	 			age = "미정";
	 	 		}
	 	 		
	 	 		
	 	 		
	 	 		console.log("userId :" + userid + "- login" + loginUser );
	 	 		
	 	 		if (loginUser == userid ){
	 	 		   document.getElementById('declarBtn').disabled = true;
	 	 		   document.getElementById('Firebtn').disabled = true;
	 	 		}else {
	 	 			document.getElementById('declarBtn').disabled = false;
	  	 		   document.getElementById('Firebtn').disabled = false;
	 	 		}
	 	 		
	 	 		$("#reputid").text(ulabel);
	 	 		$("#reputinfor").text(age + " (" + gender + ") ");
	 	 		
	 	 		age == "";
	 	 		
	 	 	   socket.emit('preReputInfo', {userId : userid});
	 	 
	 	 	   $("#Like").empty();
	 	 	   $("#Bad").empty();
	 	 	   $("#goodCount").text(0);
			   $("#badCount").text(0);
			   goodcnt = 0;
			   badcnt = 0;

	 	 		
				document.getElementById('reputInfo').style.display='block';
	 	 		
	 	 	}); 
	     	
	  	    //평판 관리 이력
		 	 socket.on('preReputInfo', function(data){
		 	
		 		if (data != null){
		 			  console.log("?? ->" + data);
		 			  console.log("상태 :" + data.reLevel);
					   
					   if (data.reLevel == "good"){
							 
							  var temp = "";
							  temp += '<table id = "goodTable" class = "reputDetailTable">';
						  	  temp += '<tr><td><b>'+data.rePlace+'여행</b></td>';
						  	  temp += '<td>'+data.reStart + '~' + data.reEnd +'<i id = "goodicon" class="material-icons">thumb_up_alt</i></td></tr>';
						  	  temp += '<tr><td colspan = "2">';
						  	  temp += '<p>';
						  	  temp += data.reContent;
						  	  temp += '</p></td></tr></table>';
						  	  
						  	  
						  	  $(temp).appendTo("#Like");
						  	  
						  	  goodcnt++; 
						 }else {
							  var temp = "";
							  temp += '<table id = "goodTable" class = "reputDetailTable">';
						  	  temp += '<tr><td><b>'+data.rePlace+'여행</b></td>';
						  	  temp += '<td>'+data.reStart + '~' + data.reEnd +'<i id = "badicon" class="material-icons">thumb_down_alt</i></td></tr>';
						  	  temp += '<tr><td colspan = "2">';
						  	  temp += '<p>';
						  	  temp += data.reContent;
						  	  temp += '</p></td></tr></table>';
						  	  
						  	  
						  	  $(temp).appendTo("#Bad");
							  
						  	  badcnt++; 
						 }
				   
					
					   $("#goodCount").text(goodcnt);
					   $("#badCount").text(badcnt);
		 		}else {
		 			var temp = "<br><label>조회결과가 없습니다.</label>";
		 			$(temp).appendTo("#Like");
		 			$(temp).appendTo("#Bad");
		 		}
				 
						
					  
			  });
		 	 
		 	
			  //평판이력 조사 내여 - 이력없을 시 모달 창 나오게
		 	 socket.on('selectReputhistory', function(data){
		 		 var status = data.status;
		 		 var reputChat = data.chatId;
		 		 var reputUser = data.userId;
		 		 
		 		 console.log("상태 / 채팅방 / 유저" +status + "/" +reputChat + "/" +  reputUser);
		 		 if (status == "이력있음"){
				 		document.getElementById('reputModal').style.display='none';
		 		 }else {
			 			document.getElementById('reputModal').style.display='block';
		 		 }
		 		 
		 	 });
			  
			  //메세지에서 평판관리 클릭시 
			  $(document).on("click" , ".reputMemssagebtn" , function(){
				  var outUser = $(this).parent().children("#outUserId").val();
				  
				  $("#PutUserId").val(outUser);
				  $.ajax({
	        		   url : "${contextPath}/memberInfo.ch",
	        		   data : {userId : outUser},
	        	       success : function(userInfo) {
	        	    	   $("#putUser").text(userInfo.userName);
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
	        	   });
				  
				  document.getElementById('reputOneModal').style.display='block';
			  });
			  
			  //한개의 평판과닐 제출
			  $("#ReputOneSubmit").click(function(){
				  var reputUserId = $("#PutUserId").val();
    			  var rdo = $("input[name=rdo]:checked").val();
    			  var reputContent = $("#reputOneContent").val();
    			  var place = $("#reputPlace").val();
    			  var start = $("#reputStart").val();
    			  var end = $("#reputEnd").val();
    			  console.log("reputContent :" + reputContent); 
    			  
    			  if (rdo != ""){
    				  if (reputContent != ""){
    					  socket.emit('CreateChatReput', {chatId : chatId , userId : userId , reputUserId : reputUserId , level : rdo , content : reputContent , place : place , start : start , end : end});
	        		  	  
	        			  socket.on('CreateChatReput' , function(){
	        				  document.getElementById('reputOneModal').style.display='none';
	        			  });
	        			  
	        			  socket.on('alreadyReputhistory', function(){
	        				
	        				  document.getElementById('reputOneModal').style.display='none';
	        				  
	        				  document.getElementById('ReputAlready').style.display='block';
	        			  })
    				  }
    			  }
    			  
			  });
	           
	           
		}); //end
		
	     //라디오버튼 클릭 
	     //좋아요
        $(document).on("click", ".reputGood" , function(){
          var swith = $(this).parent().children("#reputSwitch");
      	  var goodlabel =  $(this).parent().children().children("#reputGoodLabel");
      	  var badlabel = $(this).parent().children().children("#reputBadLabel");
      	  
      	  swith.css("background-color", "#8282f6");
      	  goodlabel.css({"color" : "white"});
      	  badlabel.css({"color" : "lightgray" });
      	  
        });
        
		//싫어요
		$(document).on("click", ".reputBad" , function(){
			var swith = $(this).parent().children("#reputSwitch");
			var goodlabel =  $(this).parent().children().children("#reputGoodLabel");
      	  	var badlabel = $(this).parent().children().children("#reputBadLabel");
      	  
	      	  swith.css("background-color", "#f46363");
	      	  goodlabel.css({  "color" : "lightgray"});
	      	  badlabel.css({"color" : "white" });
        });
		
		
	
		
		//Tab탭 좋아요 싫어요 
		function openItem(ItemName) {
			  var i;
			  var x = document.getElementsByClassName("item");
			  for (i = 0; i < x.length; i++) {
			    x[i].style.display = "none";  
			  }
			  document.getElementById(ItemName).style.display = "block";  
		}
		
		//평판관리
		var slideIndex = 1;
		showDivs(slideIndex);
		
		function plusDivs(n) {
		  showDivs(slideIndex += n);
		}
		
		function showDivs(n) {
		  var i;
		  var x = document.getElementsByClassName("mySlides");
		  if (x.length > 0){
			  if (n > x.length) {slideIndex = 1}
			  if (n < 1) {slideIndex = x.length}
			  for (i = 0; i < x.length; i++) {
			    x[i].style.display = "none";  
			  }
			  x[slideIndex-1].style.display = "block";  
		  }
		 
		}
	
	
		
	</script>
</body>
</html>