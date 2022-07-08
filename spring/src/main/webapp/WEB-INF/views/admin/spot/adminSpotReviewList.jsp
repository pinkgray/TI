<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Interface</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style>
	.pageingBtn{
		width:30px;
		height:22px;
		background:white;
		color:purple;
		border:1px solid purple;
		border-radius:5px;
	}
	.pageingBtn:hover{
		background:purple;
		color:white;
	}
	#memberListTB *{
		text-align:center;
	}
	.section {
		width:90% !important;
		margin:0 auto;
		min-height:768px;
	}
	.readonlyBg {
		background-color: #d9d9d9 !important;
		text-align:center;
	}
</style>
</head>
<body>
	<jsp:include page="../../common/adminMainNav.jsp"/>
	<div class="columns">
		<div class="column">
			<section class="section">
				<div class="field is-horizontal">
					<div class="field-body">
						  <div class="field is-grouped">
				            <p class="control">
				                <i class="fas fa-chevron-circle-left " style="font-size:80px; color: #9966ff;" onclick="location.href='selectSpotInfoAdmin.sp'"></i>
				            </p>
						  	<h3 class="subtitle is-3" style="color:#209cee;"> 여행지정보 </h3>
				          </div>
					</div>
				</div>
				
				<br><br>
				
				<!-- review count info area -->
				<div class="field is-horizontal">
					<div class="field-body">
							<label class="field-label is-normal">리뷰 수</label>
							<p class="control">
								<input class="input readonlyBg" type="text" value="10" readonly>
							</p>
					</div>
					<div class="field-body">
							<label class="field-label is-normal">조회수</label>
							<p class="control">
								<input class="input readonlyBg" type="text" value="10" readonly>
							</p>
					</div>
					<div class="field-body">
							<label class="field-label is-normal">평균 평점</label>
							<p class="control">
								<input class="input readonlyBg" type="text" value="10" readonly>
							</p>
					</div>
				</div> <!-- end review count info area -->
				
				<!-- spot list -->
				<div class="field">
					<table id="memberListTB" class="table is-narrow"style="width:100%;height:100%; margin:0 auto;" >
						<thead>
							<tr style="background:#ccccff;">
								<th width="5%">NO.</th>
								<th width="10%"> 이메일 </th>
								<th width="10%"> 평점 </th>
								<th width="10%"> 등록일 </th>
								<th width="50%"> 내용 </th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div> <!-- end spot list -->
				
				<!-- paging -->
				<div class="field" >
					<nav class="pagination">
				  	<ul class="pagination-list" style="justify-content: center;">
				  		<li><button class="pageingBtn"> << </button></li>
				  		<li><button class="pageingBtn"> < </button></li>
				  		<li><button class="pageingBtn"> 1 </button></li>
				  		<li><button class="pageingBtn"> 2 </button></li>
				  		<li><button class="pageingBtn"> > </button></li>
				  		<li<button class="pageingBtn"> >> </button>></li>
				  	</ul>
				  </nav>
				</div> <!-- end paging -->
			</section> <!-- end section -->
			
		</div> <!-- end column -->
	</div> <!-- end columns -->
	
	
</body>
</html>