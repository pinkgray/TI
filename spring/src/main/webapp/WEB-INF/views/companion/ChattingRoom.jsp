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
	  		 	data-toggle="tooltip" data-placement="right" title="????????????"
	  			style = "width: 15%;float:left;height: 100%;">
			<i class="material-icons" 
			style = "color : black; font-size : 20px;">close</i>
	  	</button>
		 <label style = "font-size :15px; padding : 15px; margin-left : 15%; margin-top:1%;">????????? ??????</label>
		 <span id = "Recruitingicon" class="label label-danger">?????????</span>
	  </div>
	  <div id = "RoomInfoDIV" style = "height : 30%; width : 100%; overflow-y: auto; "></div>
	  <div style = "height : 7%; width : 100%; background : #a8c9ff">
	  	 <label style = "margin: 20px;">????????????</label>
	  </div>
	  <div id = "MemberInfoDiv" style = "height : 50%; width : 100%; overflow-y : auto;"></div>
	  <div style = "height : 5%;">
	  	<ul class="list-inline" style = "border-top:1px solid lightgray;">
   			 <li> 
   			 <button  data-toggle="tooltip" 
	  	      data-placement="right" title="????????? ?????????" id = "outbtn" 
	  	      onclick="document.getElementById('id01').style.display='block'">
	  	 		<i class="material-icons" 
	  	 			style = "margin :0 ; padding : 3px; 
	  	 				color: black; font-size : 30px;">input</i>
	  	 	</button></li>
    		<li style = "margin: 3px;float: right;">
	    		<button id = "setting"  data-toggle="tooltip" 
	  	     		 data-placement="top" title="????????? ??????"   onclick="document.getElementById('statusModal').style.display='block'">
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
	   	 <h4 align = "center" id = "ChatRoomTitle">????????? ???????????? ??????</h4>
	  </div>
	</div>
	<div class="w3-container" id = "chat_box"></div>
	<div id="footer" >
		<div id = "downDiv">
			<button id = "downbtn" style = "float : right"><i class="material-icons">arrow_drop_down</i></button> 
		</div>
		<textarea rows="3" cols="30" name = "message" id = "message"></textarea>
		<button type="button" class="btn btn-primary" id = "sendbtn">??????</button>
	</div>
	
	<!--????????? ?????? ?????????   -->
	<!-- ????????? ????????? -->
	 <div id="id01" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('id01').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" >???????????? ???????????????????</h4>
	      </header>
	      <div class="w3-container">
	      <br>
	        <p>
	                  ???????????? ?????? ??????????????? ?????? ???????????? ????????????????????? ??????????????? <br>
	                  ??????, ????????? ?????? ????????? ???????????? ?????????????????? ???????????????.
	        </p>
	        <br>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "exitBtn" class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;">?????????</button>
	      </footer>
	    </div>
  	</div>
  	
  	 <!-- ?????? ?????? ?????? ?????? ?????? ???   -->
  	 <div id="statusModal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('statusModal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center">??????</h4>
	      </header>
	      <div class="w3-container" id = "statusContent" align = "center">
	      	<br>
	   		<table id = "chatStatusTable">
	   			<tr>
	   				<td><b>????????? ?????? </b></td>
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
	       	 style = "float : left; background-color: #f09eda !important;height : 50px;">?????? ?????????</button>
	       	 <button id = "changeBtn" class="w3-button w3-black" style = "float : right;height : 50px; background-color: #f09eda !important;"></button>
	      </footer>
	    </div>
  	</div>
  	
  	<!-- ????????? ?????? ?????????  -->
  	<div id="reputInfo" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span id = "reputClose" onclick="document.getElementById('reputInfo').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" id = "reputuserName">???????????????</h4>
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
				  <button class="w3-bar-item w3-button itembtn" onclick="openItem('Like')" >????????? <span id = "goodCount"></span></button>
				  <button class="w3-bar-item w3-button itembtn" onclick="openItem('Bad')">????????? <span id = "badCount"></span></button>
				</div>
				<div id="Like" class="w3-container item">
					
				</div>
				<div id="Bad" class="w3-container item" style="display:none">
				
				</div>			
    		</div>
	      </div>
	      <br><br>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important; height: 50px;">
	       	 <button id = "Firebtn" class="w3-button w3-black" style = "height: 50px;  float : left; background-color: #f09eda !important;">????????????</button>
	       	 <button id = "declarBtn" class="w3-button w3-black" style = "height: 50px; float : right; background-color: #f09eda !important;">????????????</button>
	      </footer>
	    </div>
  	</div>
  	
  	 <!-- ?????? ?????? ?????? ?????? ?????? ???   -->
  	 <div id="reputModal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('reputModal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center">?????? ??????</h4>
	      </header>
	      <div class="w3-container" id = "statusContent" align = "center">
	      	 
	      	<!-- <label style = "text-align : left;">????????? ????????? ????????????????<br> ?????? ????????? ???????????? ?????? ????????? ????????????</label> -->	      	 
	      	<div id = "reputChatInfor">
	      	
			</div>
			<hr>
	      	<div class="w3-content w3-display-container" id = "reputSendForm"></div>
			  <br>		
	     	</div>
	     	<label style = "color:red;font-size : 12px; margin-left : 10px;">??????????????? ???????????? ????????? ???????????? ????????? ????????? ????????????. </label>
	      <br>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "prebtn" class="w3-button w3-black" 
	       	 style = "float : left; background-color: #f09eda !important;height : 50px;" onclick="plusDivs(-1)">????????????</button>
	       	 <button id = "nextbtn" class="w3-button w3-black" style = "float : right;height : 50px; background-color: #f09eda !important;" 
	       	  onclick="plusDivs(+1)">????????????</button>
	       	 <button  id = "submitbtn" class="w3-button w3-black" style = "float : right;height : 50px; background-color: #f09eda !important;">????????????</button>
	      </footer>
	    </div>
  	</div>
  	
  	<!--????????? ???????????? ?????????  -->
  	 <div id="reputOneModal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('reputOneModal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" >????????????</h4>
	      </header>
	      <div class="w3-container">
	      	<br>
	        	<table>
	        		<tr>
	        			<td>
	        				<input type = "hidden" id = "PutUserId">
	        				<div align = "center">
	        					<label id = "putUser"></label>?????? ????????? ??????????????????
	        				</div>
	        			</td>
	        		</tr>
	        		<tr>
	        			<td>
	        				   <input type="radio" name="rdo" id="reputOneGood" class = "reputGood" style = "display:none;" value = "good" checked>
		    		  		   <input type="radio" name="rdo" id="reputOneBad" class = "reputBad" style = "display:none;" value = "bad">
		    		  	  	   <div class="switch" id = "reputSwitch">
		    		  	  	   <label for="reputOneGood" id = "reputGoodLabel">?????????</label>
		    		  	  	   <label for="reputOneBad" id = "reputBadLabel">?????????</label>
		    		  	  	   </div>
		    		  	 </td>
	        		</tr>
	        		<tr>
	        			<td>
	        				<textarea placeholder = "??????????????? ??????????????????" id = "reputOneContent"></textarea>
	        			</td>
	        		</tr>
	        	</table>
	        <br>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "ReputOneSubmit" class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;">????????????</button>
	      </footer>
	    </div>
  	</div>
  	
  	<div id="ReputAlready" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('ReputAlready').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="left" >????????????</h4>
	      </header>
	      <div class="w3-container">
	      	<br>
	        	<label>?????? ???????????? ????????? ????????????.</label>
	        <br>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button id = "close" onclick="document.getElementById('ReputAlready').style.display='none'" 
	       	  class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;">??????</button>
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
    		  		
    	   //??????
		   var socket = io("http://192.168.30.107:8010");
    	  	
		   //??????Manager ??? ????????????
	       socket.emit('preChatManager' , {chatId : chatId , div : "??????"});
	       
		   
	       //??????Manager ??? ????????????
	       var  count = 0;
	       var goodcnt = 0;
		   var badcnt = 0;
		   
	
		   //?????? ?????????
		   $("#chat_box").scroll(function () { 
			   var scrollValue = $("#chat_box").scrollTop(); console.log(scrollValue); 
			   if (scrollValue < 300){
				   $("#downbtn").show();
			   }else {
				   $("#downbtn").hide();
			   }
			});

		   //?????? ????????? ????????? 
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
	    					   output += '<span id = "bathSpan">??????</span>';		
	    				   }
	    				   output += '</tr>';
	    		  		   output += '</table>'; 
	    		  		   
	    		  		   
	    		  		   $(output).appendTo("#MemberInfoDiv");
	    		  		   
	    		  		   
	    		  		   if (userId != userInfo.memberId){
	    		  			 if (userInfo.gender == "M"){
		    		 	 			gender = "???";
		    		 	 		}else {
		    		 	 			gender = "???";
		    		 	 		}
		    		 	 		
		    		 	 		var age;
		    		 	 		if (userInfo.age != 0){
		    		 	 			var temp = userInfo.age / 10;
		    		 	 			
		    		 	 			temp = Math.floor(temp);
		    		 	 			
		    		 	 			age = temp + "0 ???";
		    		 	 			
		    		 	 		}else {
		    		 	 			age = "??????";
		    		 	 		}
		    		  		   
		    		 	 	   var reputModelput = "";
		    		 	 	   
		    		 	 	   if (count == 0){
		    		 	 		 reputModelput +=  '<div class = "mySlides" style = "display:block;"">'; 
		    		 	 	   }else {
		    		 	 		 reputModelput +=  '<div class = "mySlides" style = "display:none;">'; 
		    		 	 	   }
		    		 	 	   
		    		  		  	
		    		  		   reputModelput +=  '<table class = "reputForm">';
		    		  		   reputModelput +=  '<tr>';
		    		  		   reputModelput += '<td>?????????</td>';
		    		  		   reputModelput += '<td colspan = "3">';
		    		  		   reputModelput += '<input type = "hidden" value = "'+ userInfo.memberId +'" name = "reputUserId" id = "reputUserId">';
		    		  		   reputModelput += '<label>'+userInfo.userName+'</label>('+userInfo.email+')</td></tr><tr>';
		    		  		   reputModelput += '<td>??????</td><td><label>'+gender+'</label></td>';
		    		  		   reputModelput += '<td>?????? </td><td><label>'+age+'</label></td></tr><tr>';
		    		  		   reputModelput += '<td colspan = "4"><label>??????</label></td></tr><tr>';
		    		  		   reputModelput += '<td colspan = "4"><input type="radio" name="rdo" id="reputGood'+count+'" class = "reputGood" style = "display:none;" value = "good" checked>';
		    		  		   reputModelput += '<input type="radio" name="rdo" id="reputBad'+count+'" class = "reputBad" style = "display:none;" value = "bad">';
		    		  	  	   reputModelput += '<div class="switch" id = "reputSwitch"><label for="reputGood'+count+'" id = "reputGoodLabel">?????????</label><label for="reputBad'+count+'" id = "reputBadLabel">?????????</label></div>';
		    		  	  	   reputModelput +=	'</td></tr><tr><td colspan = "4">';
		    		  	  	   reputModelput += '<textarea placeholder = "??????????????? ??????????????????" id = "reputContent"></textarea>';
		    		  	  	   reputModelput += '</td></tr></table></div>';	
		    		  	  	   
		    		  	  	   $(reputModelput).appendTo("#reputSendForm");
					 			
			    		  	  count++;
	    		  		   }
	    		  		  
	    		  		   
	        	       },
	        	       error : function(){
	        	    	   console.log("????????????");
	        	       }
	        	   });
	        	   
	        	  
	        	  
	        	   
	        	   if (userId == data.user){
	        		   var enterDate = data.enter_date
	        		   
	        		   console.log("????????? ?????? :"+enterDate);
	        		   
	        		   if (data.div == "??????"){
	        			   //?????????  ?????? ???????????? ????????? ?????? ??????
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
    	  	
    	  	//????????? ????????? enter 
			 $("#message").keydown(function(key) {
	                //???????????? ?????? ?????????(13) ??????
	                if (key.keyCode == 13) {
	                    //msg_process??? ???????????????.
	                    sendbtn.click();
	                }
	            });
	 
	           //msg_process??? ????????? ???
	           $("#sendbtn").click(function() {
	                //????????? send_msg?????? ???????????? input??? #msg??? ????????? ?????? ????????????.
	                
	                console.log("message :" + $("#message").val());
	                
	                socket.emit('message', {
	                	userId :userId , userName : userName , message : $("#message").val() , chatId : chatId
	                });
	                //#msg??? ???????????? ????????????.
	                $("#message").val("");
	          });
	           
	           //????????? ?????? ???
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
	           
      
	            //????????????????????? ?????? ?????????????????? 
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
  		            
	                
	                if (data.sep == "??????"){
	                	output += "<input type = 'hidden' value = '"+data.userId+"' id = 'outUserId'>"
	                	output += "<button class = 'penaltybtn' id = 'chatoutbtn'> ?????? </button>";
				        output += "<button class = 'reputMemssagebtn' id = 'reputMemssagebtn'> ???????????? </button>";
	                }
	                
	                output += '</div>';
	              
	                $(output).appendTo('#chat_box');
	                
	                $(".reputMemssagebtn").hide();
	                
	                $("#chat_box").scrollTop($("#chat_box")[0].scrollHeight);
	            });
	           
	          //????????? ??????  ????????????
	          socket.emit('preChatInfo' , {chatId : chatId});
	          
	          //????????? ??????  ????????????
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
				 reputout += startDate +'~' + endDate  + '</b><br>??? ?????? ??????????????? ?????????????????????.<br>';
				 reputout += '????????? ????????????????<br>????????? ??????????????? ????????? ???????????? ?????????????????? <br>';
				 reputout +=  '?????? ???????????? ????????? ????????? ?????? ????????? ?????????.<br>';
				 reputout +=  '???????????? ????????? ????????? ?????????????????? <br></p>';
				 
			     $(reputout).appendTo('#reputChatInfor');
			    
	        	 var output = "";
	        	  
	        	 output += '<table id = "Chattinginfor">';
	        	 output += '<tr><td><b>????????? ??????</b></td>';
	  	  		 output += '<td>'+title+'</td>';
	  	  		 output += '</tr><tr>';
	  	  		 output += '<td><b>?????????</b></td>';
	  	  		 output += '<td>'+data.place+'</td>'
	  	  		 output +=	'</tr><tr>'
	  	  		 output += '<td><b>????????????</b></td>';
	  	  		 output += '<td>' + startDate + "~" + endDate + "</td>"
	  	  		 output += "</tr>"
	  	  		 output += '<tr><td><b>????????????</b></td>';
	  	  		 output += "</tr>"
	  	  		 output += "<tr>"
	  	  		 output += "<td colspan = '2'>" + data.detail + "</td>"
	  	  		 output += '</table>';
	        	  
	  	  		 $(output).appendTo('#RoomInfoDIV');
	  	  		
	  	  	    var chatStatus = data.status;
	  	  	 	var temp = "";
	  	  		 $("#Recruitingicon").text(data.status); 
	  	  		 $("#chatStatusLabel").text(chatStatus);
	  	  		 if (chatStatus == "?????????"){
	  	  		 	$("#Recruitingicon").css("background" , "orange");
	  	  			$(".reputMemssagebtn").show();
	  	  		 }else if (chatStatus == "????????????"){
	  	  			$("#Recruitingicon").css("background","green");
	  	  			temp = "?????? ????????? ???????????????????";
	  	  			$("#chatSatusDetail").text(temp);
	  	  			$("#changeBtn").text("????????????");
	  	  			
	  	  		 }else if (chatStatus == "????????????"){
	  	  			$("#Recruitingicon").css("background" , "#aa65a8");
	  	  			//document.getElementById('reputModal').style.display='block';
	  	  			
	  	  			 //???????????? ????????? ???????????? ????????? ????????? 
	  			 	 socket.emit('selectReputhistory' , {chatId : chatId , userId : userId});
	  			 	 $(".reputMemssagebtn").show();
	  	  		 }else if (chatStatus == "?????????"){
	  	  			temp = "??????????????? ???????????????????";
	  	  			$("#chatSatusDetail").text(temp);
	  	  			$("#changeBtn").text("????????????");
	  	  			$("#Recruitingicon").css("background" , "red");
	  	  		 }
	  	  		 
	  	  		 
	  	  		 
	        	 

	        	  
	          });
	          
	          //????????? ????????? ???????????? ???????????? ???
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
	        	    	   console.log("????????????");
	        	       }
	        	   });
	        	 
	        	  
	        	  //????????? ???????????? ?????? ????????? ?????????????????? 
		          socket.emit('updateChatName' , {chatId : chatId});
	 				
		       	
	 	       
	          });
	          
	         
	          
	          //??????????????? ????????? 
	          $("#exitBtn").click(function(){
	        	  
	        	  socket.emit('exitChatting',{userId: userId , chatId : chatId , userName : userName});
	        	  
	        	  
	        	  socket.on('exitChatting', function(data){
	        		  console.log("???????????? :" +data);
	        		
	        		  
	        		  location.href = "${contextPath}/enterRoom.ch";
	        		  
	        	  });
	        	  
	        	  
	          }); 
	          
	        //???????????? ???????????? ???????????? 
	        socket.on('outUser' , function(data){
	        	  var newUser = data;
	        	  
	        	 console.log("outUser :" + data);
	        	 
	        	  var mchatId = data.chat_id;
	 			  var output = "";
	 			  
	 			  if (data.div == "??????"){
	 				  if (mchatId == chatId){
		 	                output += '<div class="alert alert-info" id = "msg">'; 
				            output += data.message;
				        	output += "<input type = 'hidden' value = '"+data.userId+"' id = 'outUserId'>"
		                	output += "<button class = 'penaltybtn' id = 'chatoutbtn'> ?????? </button>";
					        if ($("#Recruitingicon").text() == "?????????"){
			                	output += "<button class = 'reputMemssagebtn' id = 'reputMemssagebtn'> ???????????? </button>";
					        }else if ($("#Recruitingicon").text() == "????????????"){
					        	output += "<button class = 'reputMemssagebtn' id = 'reputMemssagebtn'> ???????????? </button>";
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
	        	  
	        	 
	        	  //????????? ???????????? ?????? ????????? ?????????????????? 
		          socket.emit('updateChatName' , {chatId : chatId});
	 			
	 	       
	         });
	        
	          //???????????? 
	          $("#Firebtn").click(function(){
	        	  console.log("fireUser:" + $("#selectUserId").val() );
	        	  
	        	  var fireuser = $("#selectUserId").val();
	        	  var fireusername = $("#selectUserName").val();
	        	  
				  socket.emit('FireChattingUser',{user: fireuser , chatId : chatId , username : fireusername});
	        	  
	        	  
	        	  socket.on('FireChattingUser', function(data){
	        		  $("#reputClose").click();
	    
	        	  });
	        	  
	        	  
	          });
	          
	          //???????????? ????????? ??????????????? ?????? ????????? ?????? ???????????? ??????
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
	          
	          //?????? ????????? ?????? ????????? 
	          $("#AddchangeBtn").click(function(){
	        	  location.href = "${contextPath}/showchange.ch?num=" + chatId;
	          });
	          
	          
	          //???????????? ?????? ????????? 
	          $("#declarBtn").click(function(){
	        	 location.href = "${contextPath}/declaration.ch?num=" + chatId + "&id=" + $("#selectUserId").val();  
	          });
	          
	          
	          //????????? ?????? ??????
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
	        	 output += '<tr><td><b>????????? ??????</b></td>';
	  	  		 output += '<td>'+title+'</td>';
	  	  		 output += '</tr><tr>';
	  	  		 output += '<td><b>?????????</b></td>';
	  	  		 output += '<td>'+data.place+'</td>'
	  	  		 output +=	'</tr><tr>'
	  	  		 output += '<td><b>????????????</b></td>';
	  	  		 output += '<td>' + startDate + "~" + endDate + "</td>"
	  	  		 output += "</tr>"
	  	  		 output += '<tr><td><b>????????????</b></td>';
	  	  		 output += "</tr>"
	  	  		 output += "<tr>"
	  	  		 output += "<td colspan = '2'>" + data.detail + "</td>"
	  	  		 output += '</table>';
	        	  
	  	  		 $(output).appendTo('#RoomInfoDIV');
	          });
	         
	          //?????? ?????? 
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
    			 
    			 //??????Manager ??? ????????????
    		     socket.emit('preChatManager' , {chatId : chatId , div : "??????"});
    		  });
	          
	          //???????????? ??? ???????????? ?????????
	          $("#changeBtn").click(function(){
	        	  var status = $("#chatStatusLabel").text();
	        	  
	        	  console.log("????????? ?????? :" + status);
	        	  
	        	  socket.emit('updateChatSatus' , {chatId : chatId , status : status});
	        	  
	        	  socket.on('updateChatSatus', function(data){
	        		  var changeChatId = data._id;
	        		  
	        		 var chatStatus = data.status;
	        		 
	        		 console.log("?????? :" + chatStatus);
	        		 
	        		 var temp = "";
	 	  	  		 $("#Recruitingicon").text(data.status); 
	 	  	  		 $("#chatStatusLabel").text(chatStatus);
	 	  	  		 if (chatStatus == "?????????"){
	 	  	  		 	$("#Recruitingicon").css("background" , "orange");
	 	  	  			 $(".reputMemssagebtn").show();
	 	  	  		 }else if (chatStatus == "????????????"){
	 	  	  			$("#Recruitingicon").css("background","green");
	 	  	  			temp = "?????? ????????? ???????????????????";
	 	  	  			$("#chatSatusDetail").text(temp);
	 	  	  			$("#changeBtn").text("????????????");
	 	  	  		 }else if (chatStatus == "????????????"){
	 	  	  			$("#Recruitingicon").css("background" , "#aa65a8");
	 	  	  		 	$(".reputMemssagebtn").show();
	 	  	  		 }else if (chatStatus == "?????????"){
	 	  	  			temp = "??????????????? ???????????????????";
	 	  	  			$("#Recruitingicon").css("background" , "red");
	 	  	  			$("#chatSatusDetail").text(temp);
	 	  	  			$("#changeBtn").text("????????????");
	 	  	  		 }
	 	  	  		 
	 	  	  		document.getElementById('statusModal').style.display='none';
	        		  
	        	  });
	        	  
	        	  
	          });
	         
	          socket.on('updateChatttingSatus', function(data){
        		 var changeChatId = data._id;
        		  
        		 var chatStatus = data.status;
        		 console.log("?????? :" + chatStatus);
        		 
        		 var temp = "";
 	  	  		 $("#Recruitingicon").text(data.status); 
 	  	  		 $("#chatStatusLabel").text(chatStatus);
 	  	  		 if (chatStatus == "?????????"){
 	  	  		 	$("#Recruitingicon").css("background" , "orange");
 	  	  		 }else if (chatStatus == "????????????"){
 	  	  			$("#Recruitingicon").css("background","green");
 	  	  			temp = "?????? ????????? ???????????????????";
 	  	  			$("#chatSatusDetail").text(temp);
 	  	  			$("#changeBtn").text("????????????");
 	  	  			$(".reputMemssagebtn").hide();
 	  	  		 }else if (chatStatus == "????????????"){
 	  	  			$("#Recruitingicon").css("background" , "#aa65a8");
 	  	  		 }else if (chatStatus == "?????????"){
 	  	  			$("#Recruitingicon").css("background" , "red");
 	  	  			temp = "??????????????? ???????????????????";
 	  	  			$("#chatSatusDetail").text(temp);
 	  	  			$("#changeBtn").text("????????????");
 	  	  			$(".reputMemssagebtn").hide();
 	  	  		 }
        		  
        	  });
	          
	          
	          $(document).on("click" , "#chatoutbtn", function(){
	        	  var outUser = $(this).parent().children("#outUserId").val();
	        	  
	        	  location.href = "${contextPath}/declaration.ch?num=" + chatId + "&id=" + outUser;  
	          });
	          
	          //?????? ??????
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
	        //???????????? ????????? ????????? ????????? 
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
	 	 			gender = "???";
	 	 		}else {
	 	 			gender = "???";
	 	 		}
	 	 		
	 	 		var age;
	 	 		if (userAge != 0){
	 	 			var temp = userAge / 10;
	 	 			
	 	 			temp = Math.floor(temp);
	 	 			
	 	 			age = temp + "0 ???";
	 	 			
	 	 		}else {
	 	 			age = "??????";
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
	     	
	  	    //?????? ?????? ??????
		 	 socket.on('preReputInfo', function(data){
		 	
		 		if (data != null){
		 			  console.log("?? ->" + data);
		 			  console.log("?????? :" + data.reLevel);
					   
					   if (data.reLevel == "good"){
							 
							  var temp = "";
							  temp += '<table id = "goodTable" class = "reputDetailTable">';
						  	  temp += '<tr><td><b>'+data.rePlace+'??????</b></td>';
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
						  	  temp += '<tr><td><b>'+data.rePlace+'??????</b></td>';
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
		 			var temp = "<br><label>??????????????? ????????????.</label>";
		 			$(temp).appendTo("#Like");
		 			$(temp).appendTo("#Bad");
		 		}
				 
						
					  
			  });
		 	 
		 	
			  //???????????? ?????? ?????? - ???????????? ??? ?????? ??? ?????????
		 	 socket.on('selectReputhistory', function(data){
		 		 var status = data.status;
		 		 var reputChat = data.chatId;
		 		 var reputUser = data.userId;
		 		 
		 		 console.log("?????? / ????????? / ??????" +status + "/" +reputChat + "/" +  reputUser);
		 		 if (status == "????????????"){
				 		document.getElementById('reputModal').style.display='none';
		 		 }else {
			 			document.getElementById('reputModal').style.display='block';
		 		 }
		 		 
		 	 });
			  
			  //??????????????? ???????????? ????????? 
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
	        	    	   console.log("????????????");
	        	       }
	        	   });
				  
				  document.getElementById('reputOneModal').style.display='block';
			  });
			  
			  //????????? ???????????? ??????
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
		
	     //??????????????? ?????? 
	     //?????????
        $(document).on("click", ".reputGood" , function(){
          var swith = $(this).parent().children("#reputSwitch");
      	  var goodlabel =  $(this).parent().children().children("#reputGoodLabel");
      	  var badlabel = $(this).parent().children().children("#reputBadLabel");
      	  
      	  swith.css("background-color", "#8282f6");
      	  goodlabel.css({"color" : "white"});
      	  badlabel.css({"color" : "lightgray" });
      	  
        });
        
		//?????????
		$(document).on("click", ".reputBad" , function(){
			var swith = $(this).parent().children("#reputSwitch");
			var goodlabel =  $(this).parent().children().children("#reputGoodLabel");
      	  	var badlabel = $(this).parent().children().children("#reputBadLabel");
      	  
	      	  swith.css("background-color", "#f46363");
	      	  goodlabel.css({  "color" : "lightgray"});
	      	  badlabel.css({"color" : "white" });
        });
		
		
	
		
		//Tab??? ????????? ????????? 
		function openItem(ItemName) {
			  var i;
			  var x = document.getElementsByClassName("item");
			  for (i = 0; i < x.length; i++) {
			    x[i].style.display = "none";  
			  }
			  document.getElementById(ItemName).style.display = "block";  
		}
		
		//????????????
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