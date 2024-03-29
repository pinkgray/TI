# Travel Interface
### 사용자가 여행 계획을 설계하고 공유하는 여행 정보 커뮤니티 플랫폼 개발 
  
## 역할 분담
천예랑 - 일정 게시판 및 상세보기, 관리자 통계 기능 개발  
김수민 - 결제 및 정산 기능 개발  
이선우 - 여행 설계 의뢰 기능 및 관리자 게시판 기능 개발  
박세령 - DB 관리 및 회원 관리 , 장소 게시판 기능 개발  
정민지 - 여행 일정 및 편집 기능 개발  
문지원 - 메인페이지 및 동행자 찾기 기능 개발  

## ERD 
<img src="https://user-images.githubusercontent.com/47417567/177513250-7e981059-1432-4366-af85-a275910d270c.png" width="800" height="400"/>

## 개발 환경
- DataBase : Oracle DB, Monogo DB   
- Libary : Mybatis, CSS3 , HTML5 , NodeJS, Jackspn , Javax.mail , Mail , Apache POI , Socket.io , aspectJ
- IDE : Eclipse
  
## 화면 구성 


### 메인페이지    
<img src="https://user-images.githubusercontent.com/47417567/178406798-07b04644-e4fe-4fca-ae8c-db5992e5cb1e.png" width="800" height="400"/>  


## 주요 소스 (내가 작성한 소스)

채팅방 - 메시지 일 경우

node.JS

``` javascript
    socket.on('message' , function(data){
        var msg = new Message({userId : data.userId , user_name : data.userName , message : data.message , chat_id : data.chatId });
        msg.save(function(err , data){
            if (err) {
                console.log("error");
            }else {
                var dbData = {userId : data.userId , userName : data.user_name , message : data.message , chat_id : data.chat_id};
                io.sockets.emit('message' ,dbData);
                console.log('message is inserted');
            }
        });
    });
```

웹페이지 통신 소스 

``` javascript 

socket.on('message' , function(data){
  var output = '';             
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

```


