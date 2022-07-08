<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel = "stylesheet" type = "text/css" href = "resources/css/companion/changechattingroom.css">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	#okcontent{
		padding : 30px;
	}
</style>

</head>
<body>
	<c:set var = "contextPath" value = "${pageContext.servletContext.contextPath }" scope = "application"/>
	<input type = "hidden" value = "${chatId}" id = "ReChatID">
	<div class = "wrap">
		 <div class = "header">
			 <button id = "returnBtn"><i class="material-icons" >keyboard_arrow_left</i></button>
			 <div style = "float : left;padding-top : 15px;">
			 	<label style = "padding: 0; font-size: 16px;">채팅방 정보 설정</label>
			 </div>
		</div> 
		<div class = "content">
			<div class="panel-group" id="accordion">
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h4 class="panel-title">
			          <a data-toggle="collapse" data-parent="#accordion" href="#collapse1"><b>채팅방 설정 바꾸기</b></a>
			        </h4>
			      </div>
			      <div id="collapse1" class="panel-collapse collapse in">
			        <div class="panel-body">
			        	<form>
				         	 <table id = "changeRoomTable">
				         		<tr>
				         			<td><b>채팅방 제목</b></td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<input type = "text" name = "chatTitle"  id = "chatTitle"
				         						class="form-control input-sm" placeholder = "채팅방이름을 작성해주세요"/>
				         			</td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<b>여행지</b>
				         			</td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<!-- <input type = "text" name = "chatPlace"  id = "chatPlace"
				         						class="form-control input-sm" placeholder = "떠날 여행지 작성해주세요"/> -->
				         				<select id = "chatPlace">
				         					
				         				</select>
				         			</td>
				         		</tr>
				         		<tr>
				         			<td><b>여행날짜</b></td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<input type="text" class="form-control input-sm" id="trStartDate" name = "trStartDate" > &nbsp; ~ &nbsp;&nbsp;
				         				<input type="text" class="form-control input-sm" id="trEndDate" name = "trEndDate" >
									</td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<b>인원 </b>   &nbsp;&nbsp;<input type="number" name= "peopleNum" id = "peopleNum" min="1" value = "1">
				         			</td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<b>채팅방 설명</b>
				         			</td>
				         		</tr>
				         		<tr>
				         			<td>
				         				<textarea name = "chatDetail" id = "txtDetail"></textarea>
				         			</td>
				         		</tr>
				         	</table> 
				         </form>
				         <button type = "button" class = "modifybtn" id = "editRoomBtn">변경하기</button>
			        </div>
			      </div>
			    </div>
			    <div class="panel panel-default">
			      <div class="panel-heading">
			        <h4 class="panel-title">
			          <a data-toggle="collapse" data-parent="#accordion" href="#collapse2"><b>방장위임</b></a>
			        </h4>
			      </div>
			      <div id="collapse2" class="panel-collapse collapse">
			        <div class="panel-body">
			        	<input type = "hidden" id = "nowBath">
			        	<h5>현재 방장은 <b id = "bath"></b>입니다.</h5>
			        	<h5><b>방장을 위임할 사람을 선택해주세요</b></h5>
			        	<div class="selectbox"> <label for="ex_select" id = "selectVar">방장선택</label>
			        	<select id="ex_select">
			        		<option>선택하세요</option>
			        	 </select>
			        	 </div>
			        	  <button type = "button" class = "modifybtn" id = "chiefStaffbtn">변경하기</button>

			        </div>
			      </div>
			    </div>
			 </div>
		</div>
	</div>
	
	<div id="okmodal" class="w3-modal">
	    <div class="w3-modal-content w3-animate-bottom w3-card-4" >
	      <header class="w3-container w3-teal" style = "background : #f09eda !important;" >
	        <span onclick="document.getElementById('okmodal').style.display='none'" 
	        class="w3-button w3-display-topright">&times;</span>
	        <h4 align="center" >채팅방 수정</h4>
	      </header>
	      <div class="w3-container">
	      		<label  id = "okcontent">채팅 정보가 수정되었습니다.</label>
	      </div>
	      <footer class="w3-container w3-teal" style = "background : #f09eda !important;">
	       	 <button  class="w3-button w3-black" style = "float : right; background-color: #f09eda !important;"
	       	 onclick="document.getElementById('okmodal').style.display='none'" >확인</button>
	      </footer>
	    </div>
  	</div>
	
	 <script src="http://192.168.30.107:8010/socket.io/socket.io.js"></script>
     <script src="https://code.jquery.com/jquery-1.11.1.js"></script>
	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	 <script>
			  $.datepicker.setDefaults({
		          dateFormat: 'yy-mm-dd' //Input Display Format 변경
		          ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		          ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		          ,changeYear: true //콤보박스에서 년 선택 가능
		          ,changeMonth: true //콤보박스에서 월 선택 가능                
		          ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
		          ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		          ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		          ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		          ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		          ,minDate: "0D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		          ,maxDate: "+1Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
		      });
				 		
		 
		       
			
		 	$(document).ready(function() { //start
				
				var userId = ${ loginUser.memberId };
				//var userName = $("#UserName").val();
				var chatId = $("#ReChatID").val();
	    	 	
	    		console.log("userId :"+userId);
	    		console.log("chatId :" + chatId);
	    		  		
	    	   //서버
			   var socket = io("http://192.168.30.107:8010");
	    	   
	    	
	    	   
	    	   
	    	   
	    	   
	    	   //뒤로가기
	    	   $("#returnBtn").click(function(){
	    		   location.href = "${contextPath}/enterChatting.ch?num="+ chatId;
	    	   });
	    	   
	    	   //채팅 정보 불러오기 
	           socket.emit('preChatInfo' , {chatId : chatId});
	           
	           socket.on('preChatInfo' , function(data){  
	        	  var title = data.title;
	        	  var place = data.place;
	        	  
	        	  $("#chatTitle").val(title);
	        	  //$("#chatPlace").val(place);
	        	  
	        	     //채팅방 여행지
	    	   		 $.ajax({
	        		   url : "${contextPath}/trBoardList.ch",
	        	       success : function(data) {
	        	    	   var $select = $("#chatPlace");
		   					  for(var key in data) {
		   						var id = data[key].countryId;
		   						var country = data[key].countryNameKo;
		   						if (country == place){
		   							var $option = $("<option value='" + country + "'selected>").text(country);
		   						}else {
		   							var $option = $("<option value='" + country + "'>").text(country);
		   						}
		   						
		   						$select.append($option);
		   					 }
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
		        	 });
		        	  
	        	  
	        	  var formattedStartDate = new Date(data.start);
	        	  var sd = formattedStartDate.getDate();
	        	  var sm =  formattedStartDate.getMonth();
	        	  sm += 1;  // JavaScript months are 0-11
	        	 
	        	  var sy = formattedStartDate.getFullYear();

				 var startDate = sy + "-" + sm  + '-' + sd;
				 
				 var formattedEndDate = new Date(data.end);
	        	  var ed = formattedEndDate.getDate();
	        	  var em =  formattedEndDate.getMonth();
	        	  em += 1;  // JavaScript months are 0-11
	        	  var ey = formattedEndDate.getFullYear();

				 var endDate = ey + "-" + em  + '-' + ed;
	        	  
	        	  $("#trStartDate").val(startDate); $("#trEndDate").val(endDate);
	        	  
	        	  var pnum = data.peoplenum;
	        	  
	        	  $("#peopleNum").val(pnum); $("#txtDetail").val(data.detail);
	        	  
	        	  if (data.status == "여행종료"){
	        		  $("#chatTitle").attr("readonly", "true");
		        	  $("#chatPlace").attr("readonly", "true");
		        	  $("#trStartDate").attr("readonly", "true"); $("#trEndDate").attr("readonly", "true");
		        	  $("#peopleNum").attr("readonly", "true"); $("#txtDetail").attr("readonly", "true");
	        	  }else if (data.status == "여행중"){
		        	  $("#chatPlace").attr("readonly", "true");
		        	  $("#trStartDate").attr("readonly", "true"); $("#trEndDate").attr("readonly", "true");
		        	  $("#peopleNum").attr("readonly", "true"); $("#txtDetail").attr("readonly", "true");
		        	  
		        	  
	        	  }else {
	        		//set datePicker
	      			var startDate = $("#trStartDate").val(); 
	      		    $("#trStartDate").datepicker({
	      		        onSelect:function(selectedDate) {
	      					startDate = $(this).datepicker('getDate');
	      					$("#trEndDate").datepicker("option", "minDate", startDate);
	      				}, 
	      		    });
	      		    
	      		  	$("#trEndDate").datepicker();
	  		 	
	        	  }
	        	 	   
		 		});
	           
	           //채팅Manager 값 가져오기
		       socket.emit('preChatManager' , {chatId : chatId , div : "처음"});
		          
		       socket.on('preChatManager', function(data){
		        	   console.log(data);
		      
		        		$.ajax({
			        		   url : "${contextPath}/memberInfo.ch",
			        		   data : {userId : data.user},
			        	       success : function(userInfo) {
			        	    	   if (data.level == 1){
					        		   $("#bath").text(userInfo.userName);
					        		   $("#nowBath").val(userInfo.memberId);
					        	   }else {
			        	    	  	 var output = '<option value ='+userInfo.memberId+'>'+userInfo.userName +'</option>';
			        	    	  	 
			        	    	  	 $('#ex_select').append(output);
					        	   }
			        	    	   
	
			        	       },
			        	       error : function(){
			        	    	   console.log("에러발생");
			        	       }
			        	});  
		        	   
		         });
	           
		       
		       //패팅방 update 
		       $("#editRoomBtn").click(function(){
		    	   var chatTitle = $("#chatTitle").val();
		    	   var chatPlace = $("#chatPlace").val();
		    	   var stardate = $("#trStartDate").val();
		    	   var enddate = $("#trEndDate").val();
		    	   var peoplenum = $("#peopleNum").val();
		    	   var detail = $("#txtDetail").val();
		    	   
		    	 //  console.log("채팅  :" + chatTitle + "/" + chatPlace + "/" + stardate + "/" + enddate + peoplenum + detail );
		    	   
		    	 //채팅정보  수정
		         socket.emit('updateChatInfo' , {chatId : chatId , Title : chatTitle , place : chatPlace , startdate : stardate , enddate : enddate , peoplenum : peoplenum , detail : detail  });
		    	 
		    	 
		    	 socket.on('updateChatInfo', function(data){
		    		  var title = data.title;
		        	  var place = data.place;
		        	  
		        	  console.log("upateDate :" + data.title);
		        	  
		        	  $("#chatTitle").val(title);
		        	  $("#chatPlace").val(place);
		        	  var formattedStartDate = new Date(data.start);
		        	  var sd = formattedStartDate.getDate();
		        	  var sm =  formattedStartDate.getMonth();
		        	  sm += 1;  // JavaScript months are 0-11
		        	 
		        	  var sy = formattedStartDate.getFullYear();

					 var startDate = sy + "-" + sm  + '-' + sd;
					 
					 var formattedEndDate = new Date(data.end);
		        	  var ed = formattedEndDate.getDate();
		        	  var em =  formattedEndDate.getMonth();
		        	  em += 1;  // JavaScript months are 0-11
		        	  var ey = formattedEndDate.getFullYear();

					 var endDate = ey + "-" + em  + '-' + ed;
		        	  
		        	  $("#trStartDate").val(startDate); $("#trEndDate").val(endDate);
		        	  
		        	  var pnum = data.peoplenum;
		        	  
		        	  $("#peopleNum").val(pnum); $("#txtDetail").val(data.detail);
		        	  
		        	  
		        	  document.getElementById('okmodal').style.display='block';
		        	  
		    	 });
		      });
		       
		       $("#ex_select").change(function(){
		    	   var select = $("#ex_select").val();
		    	   $("#ex_select option").each(function(index ,item) {
		    		   var value = $(this).val();
		    		   
		    		   //console.log("option value :" +value);
		    		   
		    		   if (select == value){
		    			   $("#selectVar").text($(this).text());
		    		   }
		    		     		   
		    		   
		    	   });
		    	 	
		       });
		     
		       
		      $("#chiefStaffbtn").click(function(){
		    	  var changebath = $("#ex_select").val();
		    	  
		    	 // console.log(changebath + "?");
		    	  if (changebath != "선택하세요"){
		    		  socket.emit('giveAbbot', {chatId : chatId, changebath : changebath , nowbath : $("#nowBath").val() });
		    		  
		    		  socket.on('giveAbbot', function(data){
		    			  location.href = "${contextPath}/enterChatting.ch?num="+ chatId;
		    		  });
		    	  }
		      });
		       
	    		
		});    //end
		 	 
	</script>
	
</body>
</html>