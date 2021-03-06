<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" type = "text/css" href = "resources/css/companion/enterRoom.css">
<style>
	body {overflow-y: hidden; overflow-x: hidden;}
	
	#home {
		 width: 100%;
	   	 height:500px;
	     position: absolute;
	     overflow: hidden !important;  
	}
	
	#listWrap{
		width: 100%;
	    height:100%;
	    overflow-y:scroll;
	    padding-left: 5%;padding-right: 5%;s
	}
	
	::-webkit-scrollbar { 
    	display: none !important; 	
    }
    
    #listButton{
    	float:right;
    	padding : 10px;
    	margin-right : 10px;
    }
    
    .dropbtn {
	  background-color: #3498DB;
	  color: white;
	  padding: 16px;
	  font-size: 16px;
	  border-radius : 5px;
	}

	.dropup {
	  position: relative;
	  display: inline-block;
	  left: 85%;
	}
	
	.dropup-content {
	  display: none;
	  position: absolute;
	  background-color: #f1f1f1;
	  right: 0;
	  min-width: 160px;
	  bottom: 60px;
	  z-index: 1;
	}
	
	.dropup-content ul li {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropup-content a:hover {background-color: #ccc}
	
	.dropup:hover .dropup-content {
	  display: block;
	}
	
	.dropup:hover .dropbtn {
	  background-color: #2980B9;
	}
	
	.statusBtn{
		width : 100%;
		background : none;
		border : none;
		text-align : right;
	}
	.dropup-content ul{
		width : 100%;
	}
	
	.dropup-content ul li{
		width : 100%;
	}
	
	.dropup-content ul li:hover{
		color: #2980B9;
	}
</style>
</head>
<body>
	<jsp:include page = "../companion/CompanionMenu.jsp"/>
	 <input type = "hidden" value = "${loginUser.memberId}" id = "userId">
	<div id = "container">
	    <div id="home" >
	    	 <div id = "listWrap" ></div>
	    </div>
	  </div>
	  <div id="footer" >
	     	<div class="dropup">
			  <button class="dropbtn" id = "ProgressBtn"><i class="material-icons">reorder</i></button>
			  <div class="dropup-content">
			   <ul>
			    <li><button type = "button" class = "statusBtn">?????????</button></li>
			    <li><button type = "button" class = "statusBtn">????????????</button></li>
			    <li><button type = "button" class = "statusBtn">?????????</button></li>
			    <li><button type = "button" class = "statusBtn">????????????</button></li>
			    </ul>
			  </div>
			</div>
	  </div>
	  
	  <script src="http://192.168.30.107:8010/socket.io/socket.io.js"></script>
      <script src="https://code.jquery.com/jquery-1.11.1.js"></script>
	  <script>
		  function LoadingWithMask() {
			    //????????? ????????? ????????? ????????????.
			    var maskHeight = $(document).height();
			    var maskWidth  = window.document.body.clientWidth;
			     
			    //????????? ????????? ???????????? ??????????????????.
			    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
			    var loadingImg = '';
			      
			    loadingImg += "<div id='loadingImg'>";
			    loadingImg += " <img src='resources/images/loading.gif' style='position: relative; display: block; margin: 0px auto;'/>";
			    loadingImg += "</div>"; 
			  
			    //????????? ????????? ??????
			    $('body')
			        .append(mask)
			        .append(loadingImg)
			        
			    //???????????? ????????? ????????? ?????? ????????? ????????? ?????? ????????? ????????????.
			    $('#mask').css({
			            'width' : maskWidth
			            , 'height': maskHeight
			            , 'opacity' : '0.3'
			    });
			  
			    //????????? ??????
			    $('#mask').show();  
			  
			    //????????? ????????? ??????
			    $('#loadingImg').show();
		}
		  
		  function closeLoadingWithMask() {
			    $('#mask, #loadingImg').hide();
			    $('#mask, #loadingImg').remove(); 
			}




	  
	     $(document).ready(function() {
	    	 	LoadingWithMask();
	    	 	
	    	 	var user = "";
	    	 	if ($("#userId").val() == ""){
	    			location.href = "${contextPath}/error.ch";
	    	 	}else { 	    	 		
	    		 	 user = $("#userId").val();
	    	 	}
	    	 	
	    		console.log("user :"+user);
	    		
	        	//??????
				var socket = io("http://192.168.30.107:8010");
	        	
	        	if (user != ""){
	        		socket.emit('mychatting', {user : user});
		        	
					 socket.on('mychatting' , function(data){
						     closeLoadingWithMask();
						     
						     if (data != null){
							 	 var output = '';
				                 output += '<table id = "MyChatTable" class = "MyChatList" style = "width: 100%;">';
				                 output += '<tr>';
					     		 output += '<td colspan = "4" class = "chName">';
					     		 output += '<input type = "hidden" id = "chatNum" name = "chatRoomNum" value = "'+ data.chatnum +'">';
					     		 output += '<input type = "hidden" id = "chatRoomDetail" name = "chatRoomDetail" value = "'+ data.detail +'">';
					     		 output += '<label>'+ data.title +'</label></td>'
					     		 output += '<td><label>&nbsp;&nbsp;'+ data.status +'</label></td>';
				     			 output += '</tr>';
					     		 output += '<tr style=  "border-bottom : 1px solid lightgray;">';
					     		 output += '<td colspan = "5">';
					     		 output += '<i class="material-icons" id = "peopleIcon">group</i>';
					     		 output +=	'&nbsp;&nbsp;&nbsp;<label>('+ data.activityNum + '/' + data.peoplenum +')</label>';
					     		 output +=	'</td></tr>'
				                 output += '</table>';
				                 $(output).appendTo('#listWrap');
				                 
				                 console.log(data.chatnum);
						     }
	        		 });
					 
					 
					 //????????? ???????????? ?????? ??????
			    	  $(document).on("click","#MyChatTable tr",function(){
			    		 var chatList = $(this).parent().children().children();
			 	 	 		//var chatTitle = chatList.children("label").html(); 
			 	 	 	 var chatNum = chatList.children("#chatNum").val();
				 				
			 	 	 	console.log("chatNum :" + chatNum);	
				 		
			 	 	 	location.href = "${contextPath}/enterChatting.ch?num=" + chatNum;
				 		
				 			
			        });
					
			    	//????????? ?????? ???????????? 
			 		socket.on('updateChatName', function(data){
			 		 		var updateChatId = data._id;
			 		 		
			 		  	  $(".MyChatList").each(function(index ,item) {
			        			 var checkUserID = $(this).children().children().children().children("#chatNum").val();
			        			 console.log("updateChatId : " + updateChatId + "- checkUserId :" + checkUserID);
			        			 if (checkUserID == updateChatId){
			        				$(this).remove();
			        				
			        				 var output = '';
					                 output += '<table id = "MyChatTable" class = "MyChatList" style = "width: 100%;">';
					                 output += '<tr>';
						     		 output += '<td colspan = "4" class = "chName">';
						     		 output += '<input type = "hidden" id = "chatNum" name = "chatRoomNum" value = "'+ data._id +'">';
						     		 output += '<input type = "hidden" id = "chatRoomDetail" name = "chatRoomDetail" value = "'+ data.detail +'">';
						     		 output += '<label>'+ data.title +'</label></td>'
						     		 output += '<td><label>&nbsp;&nbsp;'+ data.status +'</label></td>';
					     			 output += '</tr>';
						     		 output += '<tr style=  "border-bottom : 1px solid lightgray;">';
						     		 output += '<td colspan = "5">';
						     		 output += '<i class="material-icons" id = "peopleIcon">group</i>';
						     		 output +=	'&nbsp;&nbsp;&nbsp;<label>('+ data.activityNum + '/' + data.peoplenum +')</label>';
						     		 output +=	'</td></tr>'
					                 output += '</table>';
					                 $(output).appendTo('#listWrap');
					                 
					                 console.log(data._id);
			        				
			        			 } 
			        	 });
	        		});
			    	
			 		//????????? ???????????? 
		 			 socket.on('UpdateChattingPeople', function(data){
		 				 console.log("????????? ??? ? ?????????????" + data._id);
		 				var updateChatId = data._id;
		 		 		
			 		  	  $(".MyChatList").each(function(index ,item) {
			        			 var checkUserID = $(this).children().children().children().children("#chatNum").val();
			        			 console.log("updateChatId : " + updateChatId + "- checkUserId :" + checkUserID);
			        			 if (checkUserID == updateChatId){
			        				$(this).remove();
			        				
			        				console.log(data.activityNum + "??????");
			        				
			        				 var output = '';
					                 output += '<table id = "MyChatTable" class = "MyChatList" style = "width: 100%;">';
					                 output += '<tr>';
						     		 output += '<td colspan = "4" class = "chName">';
						     		 output += '<input type = "hidden" id = "chatNum" name = "chatRoomNum" value = "'+ data._id +'">';
						     		 output += '<input type = "hidden" id = "chatRoomDetail" name = "chatRoomDetail" value = "'+ data.detail +'">';
						     		 output += '<label>'+ data.title +'</label></td>'
						     		 output += '<td><label>&nbsp;&nbsp;'+ data.status +'</label></td>';
					     			 output += '</tr>';
						     		 output += '<tr style=  "border-bottom : 1px solid lightgray;">';
						     		 output += '<td colspan = "5">';
						     		 output += '<i class="material-icons" id = "peopleIcon">group</i>';
						     		 output +=	'&nbsp;&nbsp;&nbsp;<label>('+ data.activityNum + '/' + data.peoplenum +')</label>';
						     		 output +=	'</td></tr>'
					                 output += '</table>';
					                 $(output).appendTo('#listWrap');
					                 
					                 console.log(data._id);
			        				
			        			 } 
			        	 });	        	
	        		});
			 		
			 		
			 		
		 		 	//???????????? ?????? ????????? 
		 		 	 socket.on('updateChatSatus', function(data){
		        		  var changeChatId = data._id;
		        		  
		        		  $(".MyChatList").each(function(index ,item) {
		        			  var checkUserID = $(this).children().children().children().children("#chatNum").val();
			        			 console.log("updateChatId : " + changeChatId + "- checkUserId :" + checkUserID);
			        			 if (checkUserID == changeChatId){
			        				$(this).remove();

			        				var output = '';
					                 output += '<table id = "MyChatTable" class = "MyChatList" style = "width: 100%;">';
					                 output += '<tr>';
						     		 output += '<td colspan = "4" class = "chName">';
						     		 output += '<input type = "hidden" id = "chatNum" name = "chatRoomNum" value = "'+ data._id +'">';
						     		 output += '<input type = "hidden" id = "chatRoomDetail" name = "chatRoomDetail" value = "'+ data.detail +'">';
						     		 output += '<label>'+ data.title +'</label></td>'
						     		 output += '<td><label>&nbsp;&nbsp;'+ data.status +'</label></td>';
					     			 output += '</tr>';
						     		 output += '<tr style=  "border-bottom : 1px solid lightgray;">';
						     		 output += '<td colspan = "5">';
						     		 output += '<i class="material-icons" id = "peopleIcon">group</i>';
						     		 output +=	'&nbsp;&nbsp;&nbsp;<label>('+ data.activityNum + '/' + data.peoplenum +')</label>';
						     		 output +=	'</td></tr>'
					                 output += '</table>';
					                 $(output).appendTo('#listWrap');
					                 
					                 console.log(data._id);
			        				
					                 
			        			 } 
			        	 });
		 		 	 
		        		  
		        	 });
		 		 	
		 		 	
		 		 	//?????? ?????? ????????? 
		 		 	$(document).on("click" , ".statusBtn" , function(){
		 		 		var status = $(this).text();
		 		 		
		 		 		 console.log("?????? :" + status);
		 		 		
		 		 		 socket.emit('SelectStatusChatting', {status : status , user : user});
		 		 			
		 		 		 
		 		 		 $(".MyChatList").remove();
		 		 		
		 		 		
		 			 	
		 		 	});
			 		
		 		 	
		 		 	 socket.on('SelectStatusChatting', function(data){
		 			 		
		 			 		
		 			 		var output = '';
			                 output += '<table id = "MyChatTable" class = "MyChatList" style = "width: 100%;">';
			                 output += '<tr>';
				     		 output += '<td colspan = "4" class = "chName">';
				     		 output += '<input type = "hidden" id = "chatNum" name = "chatRoomNum" value = "'+ data.chatnum +'">';
				     		 output += '<input type = "hidden" id = "chatRoomDetail" name = "chatRoomDetail" value = "'+ data.detail +'">';
				     		 output += '<label>'+ data.title +'</label></td>'
				     		 output += '<td><label>&nbsp;&nbsp;'+ data.status +'</label></td>';
			     			 output += '</tr>';
				     		 output += '<tr style=  "border-bottom : 1px solid lightgray;">';
				     		 output += '<td colspan = "5">';
				     		 output += '<i class="material-icons" id = "peopleIcon">group</i>';
				     		 output +=	'&nbsp;&nbsp;&nbsp;<label>('+ data.activityNum + '/' + data.peoplenum +')</label>';
				     		 output +=	'</td></tr>'
			                 output += '</table>';
			                 $(output).appendTo('#listWrap');
		 			 		
		 			 	 });
		 		 	
		 		 	//????????? ?????? ????????? 
		 		 	$("#ProgressBtn").click(function(){
		 		 		 $(".MyChatList").remove();
		 		 		
		 		 		 socket.emit('mychatting', {user : user});
		 		 	});
			 		
	        	}else {
	        		location.href = "${contextPath}/error.ch";
	        	}
	        	//if end 
	        	
	        	
	        	
	     }); //end
	 
	  </script>
</body>
</html>