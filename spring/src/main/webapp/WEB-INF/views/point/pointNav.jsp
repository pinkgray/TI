<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#pointTB thead *{
		font-size:25px;
	}
	#pointTB tbody tr td:first-child{
		color:red;
	}
	#pointTB tbody tr td:last-child{
		color:green;
	}
</style>
</head>
<body>
	
	<div class="tabs is-boxed"style="width:50%;margin-left:10px;">
		<ul style="border:none !important;">
			<li>
				<a href="pointMainView.po?payCurrentPage=1&reserveCurrentPage=1&usePointCurrentPage=1" class="pointNav">
					<span style="color:red;">&nbsp;<strong style="font-size:25px;">포인트관리</strong><br> <p id="userPoint"></p> </span>
				</a>
			</li>
			<li>
				<a href="toProceedsView.po" class="rebateNav">
					<span style="color:green;">&nbsp;<strong style="font-size:25px;">수익금관리</strong><br><p id="userProceeds"></p></span>
				</a>
			</li>
		</ul>
		<input id="member" type="hidden" value="${sessionScope.loginUser.memberId}">
    </div>
    <script>
    	$(function(){
    		var memberId = $("#member").val();
    		//console.log(memberId);
    		$.ajax({
    			url:"selectAccumulate.po",
    			data:{memberId:memberId},
    			type:"post",
    			success:function(data){
    				//console.log(data);
    				$("#userPoint").empty();
    				var userPoint = comma(data.userPoint);
    				$("#userPoint").text("누적 포인트 : "+userPoint+"P");
    				
    				$("#userProceeds").empty();
    				var userProceeds = comma(data.userProceeds);
    				$("#userProceeds").text("누적 수익금 : "+userProceeds);
    			},
				error:function(data){
    				console.log('point nav error');
    			}
    	
    		});
    	});
    	function comma(num){
		    var len, point, str; 
		       
		    num = num + ""; 
		    point = num.length % 3 ;
		    len = num.length; 
		   
		    str = num.substring(0, point); 
		    while (point < len) { 
		        if (str != "") str += ","; 
		        str += num.substring(point, point + 3); 
		        point += 3; 
		    } 
		    return str;
		}
    </script>
</body>
</html>