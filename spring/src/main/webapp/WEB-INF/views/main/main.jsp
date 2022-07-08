<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" type = "text/css" href = "resources/css/main/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
	body {
		overflow-y : hidden;
	}
	.wrap{
		margin : 0 ; padding : 0;
		width : 100%;
		height: 100%;
		overflow-y : hidden;
	}
	
	 ::-webkit-scrollbar { 
    	display: none !important; 	
    }
	
	
	.contentwrap{
		margin : 0 ; padding : 0;
		width : 100%;
		min-height: 100%;
		background-image : url("resources/images/main.jpg");
		background-repeat : no-repeat;
		background-size: cover;
		background-position : center;
		background-attachment : fixed;
  	 overflow-y : hidden;

	}
	
	
	.SearchArea{
		margin-top : 20%;
		margin-bottom : 30%;
		width: 100%;
		height : auto;
	}
	
	.dropbtn {
	   background-color: #99BCF4;
	    color: white;
	    padding: 16px;
	    font-size: 16px;
	    border: none;
	    cursor: pointer;
	    width: 300px;
	}
	
	.dropdown {
	  position: relative;
	  display: inline-block;
	}
	
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background: #6D89B6;
	  min-width: 300px;
	  max-height : 200px;
	  overflow-y : auto;
      top: 50px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	  z-index: 1;
	}
	
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropdown-content a:hover {background-color: #f1f1f1}
	
	.dropdown:hover .dropdown-content {
	  display: block;
	}
	
	.dropdown:hover .dropbtn {
	  background-color: #6D89B6;
	}
	
	.rankType{
		float : right;
	}
	
    #rank-list {
    overflow: hidden;
    width: 100%;
    height: 20px;
    margin: 0;
	}
	
	 #rank-list ol {
    width: 100%;
	}
	
	 #rank-list li {
    width: 100%;
	}
	
	
	
</style>
</head>
<body>
	<jsp:include page = "../common/mainNav.jsp"/>
	
 		<div class = "wrap">

 		<div class = "contentwrap">
 			<div class = "SearchArea">
 				 <div style="background:black; background : rgba(0,0,0,0.6);"> 
 					<table id = "SearchTable">
 						<tr>
 							<td colspan = "3">여행지</td>
 							<td colspan = "3">테마 </td>
 						</tr>
 						<tr>
 							<td colspan = "3">
								<div class="field">
									<span class="select" style = "width : 100%" >
							           <select id = "Searchcontry" style = "width : 100%">
							              <option>여행지 선택</option>
							            </select>
							        </span>
     						 	</div>
							</td>
 							<td colspan = "3">
								<div class="field">
									<span class="select" style = "width : 100%">
							            <select id = "Searchtag" style = "width : 100%">
							              <option>태그 선택</option>
							            </select>
							        </span>
							
     						 	</div>
							</td>
 							<td>
								<div class="buttons" id = "searchBtn">
       								 <a class="button is-primary is-outlined">검색</a>   
       							</div>
							</td>
 						</tr>
 						<tr>
 							<td>실시간 급상승 검색어</td>
 						</tr>	
 						<tr>
 							<td colspan = "3">
							            <div class="dropdown">
										  <div class="dropbtn">
											  <dl id="rank-list">
								                <dt>실시간 급상승 검색어</dt>
								                <dd>
								                    <ol id = "countrylist">
								                       
								                    </ol>
								                </dd>
								            </dl>
							             </div>
										  <div class="dropdown-content" id = "contentCountry">
										  </div>
										</div>
							</td>
							<td colspan = "3">
										<div class="dropdown">
										  <div class="dropbtn">
											  <dl id="rank-list">
								                <dt>실시간 급상승 검색어</dt>
								                <dd>
								                    <ol id = "taglist">
								                       
								                    </ol>
								                </dd>
								            </dl>
							             </div>
										  <div class="dropdown-content" id = "contentTag">
										  </div>
										</div>
 							</td>
 						</tr>
 					</table>
 					</div>
 				</div>
 		
 		</div>	
	
		</div>
		<script>
			$(function() {
			   	//나라 태그 가져오기
			    $.ajax({
	        		   url : "${contextPath}/trBoardList.ch",
	        	       success : function(data) {
	        	    	   var $select = $("#Searchcontry");
		   					  for(var key in data) {
		   						var id = data[key].countryId;
		   						var country = data[key].countryNameKo;
		   						var $option = $("<option value='" + country + "'>").text(country);
		   						$select.append($option);
		   					 }
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
	        	   });
			    
			   	//여행 태그 가져오기  
			    $.ajax({
	        		   url : "${contextPath}/trTagList.ch",
	        	       success : function(data) {
	        	    	   var $select = $("#Searchtag");
		   				   for(var key in data) {
		   						var id = data[key].tagId;
		   						var tag = data[key].tagName;
		   						var $option = $("<option value='" + tag + "'>").text(tag);
		   						$select.append($option);
		   					 }
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
	        	   });
			    
			    $.ajax({
	        		   url : "${contextPath}/trRank.ch",
	        	       success : function(data) {
	        	    	   var tagRank = data.tagList;
		   				   var CountryRank = data.countryList;
	        	    	   
	        	    	   //console.log(tagRank);
	        	    	   var output = "";
	        	    	   var temp = "";
	        	    	   var tagNum = 1;
	        	    	   for(var key in tagRank) {
		   						
		   						output += '<li><a href="${contextPath}/searchTagTravelList.tb?trvTags='+tagRank[key].tagName+'&cityTags=">'+ tagNum + '순위 ' + tagRank[key].tagName + '<span class = "rankType" style = "color : blue;">여행태그</span></a></li>';
		   						temp += '<a href="${contextPath}/searchTagTravelList.tb?trvTags='+tagRank[key].tagName+'&cityTags=">'+ tagNum + '순위 ' + tagRank[key].tagName+'<span class = "rankType" style = "color : blue;">여행태그</span></a>';
		   						
		   						tagNum++;
		   					}
	        	    	   
	        	    	   $(output).appendTo("#taglist");
	        	    	   $(temp).appendTo("#contentTag");
	        	    	   
	        	    	   output = "";
	        	    	   temp = "";
	        	    	   var countryNum = 1;
	        	    	   for (var key in CountryRank){
	        	    		   output += '<li><a href="${contextPath}/searchTagTravelList.tb?trvTags=&cityTags='+CountryRank[key].countryNameKo+'">'+ countryNum + '순위 ' + CountryRank[key].countryNameKo + '<span class = "rankType" style = "color : #AF57E1;">나라태그</span></a></li>';
		   						temp += '<a href="${contextPath}/searchTagTravelList.tb?trvTags=&cityTags='+CountryRank[key].countryNameKo+'">'+ countryNum + '순위 ' + CountryRank[key].countryNameKo+'<span class = "rankType" style = "color : #AF57E1;">나라태그</span></a>';
		   						
		   					    countryNum++;
	        	    	   }
	        	    	   
	        	    	  
	        	    	   
	        	    	   $(output).appendTo("#countrylist");
	        	    	   $(temp).appendTo("#contentCountry");
	        	    	   
	        	    	   var count = $('#taglist li').length;
	        	 			  var height = $('#taglist li').height();
	        				 function Tagstep(index) {
	        				        $('#taglist').delay(2000).animate({
	        				            top: -height * index,
	        				        }, 500, function() {
	        				        	Tagstep((index + 1) % count);
	        				        });
	        				    }
	        				 
	        				 var Citycount = $('#countrylist li').length;
	        				  var Cityheight = $('#countrylist li').height();
	        				 function Countrystep(index) {
	        				        $('#countrylist').delay(2000).animate({
	        				            top: -Cityheight * index,
	        				        }, 500, function() {
	        				        	Countrystep((index + 1) % Citycount);
	        				        });
	        				    }
		       	
		       			  
	        	    	   
	        	    	   
	        	    	   Tagstep(1);
	        	    	   Countrystep(1);

	        	    	   
	        	       },
	        	       error : function(){
	        	    	   console.log("에러발생");
	        	       }
	        	   });
			    
			    
			    
			    
			    $("#searchBtn").click(function(){
			    	var selectTag = $("#Searchtag").val();
			    	var selectContry = $("#Searchcontry").val();
			    	
			    	if (selectTag == "태그 선택"){
		                   selectTag = "";
		            }
		                
		             if (selectContry == "여행지 선택" ){
		                   selectContry = "";
		             }

			    	
			    	console.log(selectTag + "-" + selectContry);
			    	
			    	location.href = "${contextPath}/searchTagTravelList.tb?trvTags="+selectTag+"&cityTags="+selectContry;
			    });
			    
			    
			});
			
			
		</script>
</body>
</html>