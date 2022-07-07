var fs = require('fs');

let moment = require('moment');

var http = require('http');
var connect = require('connect');
var app = connect();
var socketio = require('socket.io');

var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/ti');

var db = mongoose.connection;

db.on('error' , console.error.bind(console, 'connection error :'));

db.once('open', function calback(){
    console.log('open : success');
});

Schema = mongoose.Schema;

var chat = Schema({
    title : 'String' ,
    place : 'String' ,
    start : {type :Date},
    end : {type :Date},
    peoplenum : Number ,
    detail : 'String',
    status : 'String' ,
    activityNum : Number 
    
});

var chatManager = Schema({
    level : Number,
    user : Number,
    chat_id : 'String' ,
    status : 'String' ,
    enter_date : {type : Date , default: Date.now} 
});

var message  = Schema({
    userId : Number ,
    user_name : 'String', 
    message : 'String' ,
    time : {type:Date , default : Date.now}, 
    chat_id : 'String' 
});

var Chat = mongoose.model('Chat' , chat);
var ChatManagement = mongoose.model('ChatManager', chatManager);
var Message = mongoose.model('Message' , message);

var server = http.createServer(app);

server.listen(8010, function(){
    console.log('server listen on port 8010');
});

var io = socketio.listen(server);

//소켓 연결
io.sockets.on('connection' , function(socket){
    //회원 연결
    console.log('user connected : ' + socket.id);
    
    //방만들기 함수
    socket.on('createChatRoom' , function(data){
      

        var ChatRoom = new Chat({title : data.title ,place  : data.place ,  start : data.start , end : data.end , peoplenum : data.peoplenum , detail : data.chatDetail , status : '모집중' , activityNum : 1 });
       
        var user = data.user;

        ChatRoom.save(function(err ,data ){
            if (err) {
                console.log("error");
            }else {
                console.log('chatroom is inserted');
                console.log('saved :' + data);
                
                var dbData = {chatnum : data._id , detail : data.detail , title : data.title , status : data.status , activityNum : data.activityNum , peoplenum : data.peoplenum }
                io.sockets.emit('createChatRoom' ,dbData);

                var cm = new ChatManagement({level : 1 , user : user , chat_id : data.id , status : '활동'});
                //var cmid = '';
                cm.save(function(err , data){
                    if (err) {
                        console.log("error");
                    }else {
                        console.log('chatmanager is inserted');

                        var cmid = data.chat_id;
                        io.sockets.emit('createRoomManager' , cmid);
                    }
                   
                });

                
                
            }

            
        });
    
        
    });

    //모집중인 방 가져오기
    socket.on('preload', function(){
        Chat.find({status:"모집중"},function(err,result) {

            if (err){
                console.log("모집중인 방 불러오기 error");
            }else {
                    for (i = 0; i < result
                        .length; i++) {
                        var dbDate = { chatnum : result[i].id ,title : result[i].title , 
                        place : result[i].place , status : result[i].status , detail : result[i].detail 
                        , peoplenum : result[i].peoplenum , activityNum : result[i].activityNum };
                    
    
                        io.sockets.sockets[socket.id].emit('preload', dbDate);
                    
                    }
            }
               
        });

    });
    

    //나의 채팅방 보기
    socket.on('mychatting' , function(data){
    
        ChatManagement.find({user : data.user , status : '활동' },(function(err,result) {
            
            if (err){
                console.log("나의 채팅방 error")
            }else {
                for (i = 0; i < result.length; i++) {
                    var ChId = result[i].chat_id;

                    //console.log("CHId :" + ChId);
                    if (ChId == undefined) {} else {
                        console.log("CHId :" + ChId);
                        Chat.findOne({_id : ChId},function(err , chresult){
                            if (err){
                                console.log("조회 실패");
                            }else {
                                var dbDate = { chatnum : chresult.id ,title : chresult.title , 
                                    place : chresult.place , status : chresult.status , detail : chresult.detail 
                                    , peoplenum : chresult.peoplenum , activityNum : chresult.activityNum };
            
                                    
                                socket.emit('mychatting', dbDate);
                            }
                         
                        });
                    }
                    
                    
                }
            }
            
        
        }));
    });

    //대화창에 채팅방 관리 정보 가져오기 
    socket.on('preChatManager' , function(data){
        var div = data.div;

        ChatManagement.find({chat_id : data.chatId , status : "활동"},function(err , result ){
            if (err) {
                console.log("채팅방 관리 조회 실패!")
            }else {
                for (i = 0; i < result.length; i++) {
                    var dbDate 
                     = {
                         user : result[i].user,
                         enter_date : result[i].enter_date,
                         status : result[i].status,
                         level : result[i].level,
                         div : div
                     }

                     socket.emit('preChatManager' , dbDate);
                }
            }
        });

    });

    //채팅
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

    //이전 채팅 목록 (대화 목록)
    socket.on('preChat', function(data){

            //gte : >= 라는 뜻을 가지고 있고 표현법은 
            var myquery = {chat_id : data.chatId , time : {$gte : data.enter_date}};

            Message.find( myquery ,function(err , result){

                if (err){
                    console.log('대화 조회 실패');
                }else {
                    for (var i = 0 ; i < result.length ; i++){
                        var dbData = {userId : result[i].userId , userName : result[i].user_name , message : result[i].message , chat_id : result[i].chat_id};
                        io.sockets.sockets[socket.id].emit('preChat', dbData);
    
                        console.log(result[i]);
                    }
                }
               
            });   

    });

   

    //채팅방에 정보 확인 하는 함수
    socket.on('checkRoom' , function(data){
        
        ChatManagement.findOne({user : data.user , chat_id : data.chatnum}, function(err , result){
            
            if (result != null){
                var dbDate =  {user : result.user , chat_id : result.chat_id , status : result.status};
                
               // console.log( "검사 결과 :"+result);

                 io.sockets.sockets[socket.id].emit('checkRoom' ,dbDate);
            }else {
                var dbDate = {status : '없음'}
                io.sockets.sockets[socket.id].emit('checkRoom' , dbDate);
            }
            
        });

    
    });

    //채팅방 들어가기 
    socket.on('EnterChattingRoom' , function(data){

        //console.log(data.chatnum + ":" + data.status + ":" + data.user);
        var chatID = data.chatnum;
        var Status = data.status;
        var userId = data.user;

        var userName = data.username;

        //console.log(Status + "??");

        if (Status == "없음"){
            var cm = new ChatManagement({level : 2 , user : data.user , chat_id : chatID , status : '활동'});
            
            cm.save(function(err , data){
                if (err) {
                    console.log("error");
                }else {
                    console.log('chatmanager is inserted');

                    var myquery = { _id: data.chat_id };
                    var newvalues = { $inc: {activityNum: +1} };

                    //update - 채팅방 activity 수 증가
                    Chat.updateOne(myquery, newvalues , function(err, data){
                        if (err) {
                            console.log("update 에러");
                        }else {
                            var msg = new Message({message : userName + "님이 채팅방에 들어왔습니다." , chat_id : chatID });
                            
                            msg.save(function(err,data){
                                if (err){ 
                                    console.log("message insert 에러"); 
                                }else {
                                    console.log("message is inserted");
        
                                    var dbData = {userName : data.user_name ,message : data.message , chatId : chatID , user : userId};
        
                                    io.sockets.emit('newUser' , dbData);
                                }
                            });
                        }
                    });

                    

                    var cmid = data.chat_id;
                    io.sockets.emit('EnterChattingRoom' , cmid);
                   
                }
               
            });

        }else if (Status == "나감"){
            var cmquery = {chat_id : chatID , user : userId};
            var newvalues = {status : '활동' , enter_date : moment() };
    
            //chatmanagement 상태를 나감으로 바꾸기
            ChatManagement.updateOne(cmquery , newvalues , function(err, data){
                if (err){
                    console.log("update 실패");
                }else {
                    console.log("update 성공");

                    var myquery = { _id: chatID };
                    var newvalues = { $inc: {activityNum: +1} };

                    //update - 채팅방 activity 수 증가
                    Chat.updateOne(myquery, newvalues , function(err, data){
                        if (err) {
                            console.log("update 에러");
                        }else {
                            console.log("채팅업데이트 성공")
                            var msg = new Message({message : userName + "님이 채팅방에 들어왔습니다." , chat_id : chatID });
                            
                            msg.save(function(err,data){
                                if (err){ 
                                    console.log("message insert 에러"); 
                                }else {
                                    console.log("message is inserted");
        
                                    var dbData = {userName : data.user_name ,message : data.message , chatId : chatID , user : userId};
        
                                    io.sockets.emit('newUser' , dbData);
                                }
                            });
                        }
                    });

                }

               // var cmid = data.chat_id;
                io.sockets.emit('EnterChattingRoom' , chatID);
            });

          
        }

    });

    //대화창에서 채팅방 정보 가져오기
    socket.on('preChatInfo', function(data){

        Chat.findOne({ _id : data.chatId },function(err , result){
            if (err){
                console.log("채팅방 조회 실패")
            }else {
                var dbDate =  {
                    title : result.title , place : result.place ,
                    start : result.start , end : result.end , peoplenum : result.peoplenum,
                    detail : result.detail , status : result.status , activityNum : result.activityNum 
                }

                socket.emit('preChatInfo' , dbDate);
            }
        });

    });

    //대화창에서 누군가 접속하거나 나갈때 
    socket.on('updateChatInfo' , function(data){
        var chatId = data.chatId;
        console.log(chatId + "??");

         Chat.findOne({ _id : data.chatId },function(err , result){
            if (err){
                console.log("채팅방 조회 실패")
            }else {
                console.log("채팅방 : " + result);

                socket.emit('updateChatInfo' , result);
            }
        }); 
    });

    //대화창에서 나갔을 때 
    socket.on('exitChatting', function(data){
        var userId = data.userId;
        var chatId = data.chatId;
        var userName = data.userName;

        console.log(userId + ":" + "-" + chatId + "-" + userName);

        var cmquery = {chat_id : chatId , user : userId};
        var newvalues = {status : '나감'};

        //chatmanagement 상태를 나감으로 바꾸기
        ChatManagement.updateOne(cmquery , newvalues , function(err, data){

            if (err) { console.log("chatmanagement update error");
            }else {
                var chquery = { _id: chatId};
                var newvalues = { $inc: {activityNum: -1} };    
                //update - 채팅방 activity 수 감소 
                Chat.updateOne(chquery, newvalues , function(err, data){
                    if (err) {
                        console.log("chat update 에러");
                    }else {
                        var msg = new Message({message : userName + "님이 채팅방에 나갔습니다." , chat_id : chatId });
                        
                        msg.save(function(err,data){
                            if (err){ 
                                console.log("message insert 에러"); 
                            }else {
                                console.log("message is inserted");
        
                                var dbData = {message : data.message , chat_id : data.chat_id , userId : userId, div : "나감"};
                                
                                io.sockets.emit('outUser' , dbData);
                            }
                        });

                        
                    }
                });
            }
        });

        io.sockets.emit('exitChatting', userId);

       
    });

    
    //강퇴될 때
    socket.on('FireChattingUser', function(data){
        var fireuser = data.user;
        var chatId  = data.chatId;
        var username = data.username;

        var cmquery = {chat_id : chatId , user : fireuser};
        var newvalues = {status : '강퇴'};

        //chatmanagement 상태를 나감으로 바꾸기
        ChatManagement.updateOne(cmquery , newvalues , function(err, data){

            if (err) { console.log("chatmanagement update error");
            }else {
                var chquery = { _id: chatId};
                var newvalues = { $inc: {activityNum: -1} };    
                //update - 채팅방 activity 수 감소 
                Chat.updateOne(chquery, newvalues , function(err, data){
                    if (err) {
                        console.log("chat update 에러");
                    }else {
                        var msg = new Message({message : username + "님이 강퇴되었습니다." , chat_id : chatId });
                        
                        msg.save(function(err,data){
                            if (err){ 
                                console.log("message insert 에러"); 
                            }else {
                                console.log("message is inserted");
        
                                var dbData = {message : data.message , chat_id : data.chat_id , userId : fireuser , div : "강퇴"};
                                
                                io.sockets.emit('outUser' , dbData);
                            }
                        });
                    }

                });
            }
        });

        io.sockets.emit('FireChattingUser', fireuser);


    });
   


    //소켓을 나갈경우
    socket.on('disconnect', function(){
        console.log('user disconnected :' + socket.id);
    });



});



