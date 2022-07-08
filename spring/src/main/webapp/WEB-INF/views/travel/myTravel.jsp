<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 여행 일정</title>
<style>
	.breadcrumb li a {
		color:#A276FF;
	}
	.breadcrumb li a:hover {
		color:#C6ACFE;
	}
	.breadcrumb li.is-active a {
		color:black;
		font-weight:bold;
	}
	.column .columns {
		margin:0 !important;
	}
	.privateTrvCard, .publicTrvCard {
		cursor:pointer;
	}
</style>
</head>
<body>
	<jsp:include page="../common/mainNav.jsp" />
	
	<div class="columns is-mobile">
		<div class="column">
			<section class="section" id="headerSection">
				<jsp:include page="../common/myPageHeader.jsp" />
			</section>
			<section class="section" id="bredcrumbSection" style="padding-top:0; padding-bottom:0">
				<nav class="breadcrumb">&nbsp;&nbsp;
					<ul style="padding-left:20px">
						<li class="my-trv-menu is-active" id="private"><a id="open">작성중</a></li>
						<li class="my-trv-menu" id="public"><a id="closed">작성완료</a></li>
						<li class="my-trv-menu" id="shared"><a id="closed">나에게 공유된 일정</a></li>
					</ul>
				</nav>
			</section>
			<section class="section" id="privateSection">
				<div class="columns is-multiline">
					<c:forEach var="trv" items="${ privateTrvList }" varStatus="st">
						<div class="column is-one-third">
							<div class="card privateTrvCard">
								<input type="hidden" value="${ trv.trvId }" name="trvId" />
								<div class="card-image">
									<figure class="image" style="margin:0">
										<c:if test="${ trv.mainImage ne null }">
											<img src="resources/uploadFiles/${ trv.mainImage.changeName }">
										</c:if>
										<c:if test="${ trv.mainImage eq null }">
											<img src="resources/images/logo1.png">
										</c:if>
									</figure>
								</div>
								<div class="card-content">
									<div class="media">
										<div class="media-left">
											<p class="title is-4">${ trv.trvTitle }</p>
											<p class="subtitle is-6">
												<c:forEach var="trvCity" items="${ trv.trvCityList }" varStatus="st2">
													${ trvCity.countryNameKo } &nbsp; ${ trvCity.cityNameKo }
													<c:if test="${ st2.count ne trv.trvCityList.size() }">/</c:if>&nbsp;
												</c:forEach>
											</p>
											<small>${ trv.startDate } ~ ${ trv.endDate }</small>&nbsp;&nbsp;
											<a class="button is-small"> 
												<span class="icon is-small"><i class="fa fa-user"></i></span> 
												<span> ${ sessionScope.loginUser.userName } </span>
											</a>
										</div>
										<div class="media-right">
										</div>
									</div>
									<div class="content">
										<c:forEach var="trvTag" items="${ trv.trvTagList }" varStatus="st2">
											<a>#${ trvTag.tagName }</a>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
			<section class="section" id="publicSection" style="display:none">
				<div class="columns is-multiline">
					<c:forEach var="trv" items="${ publicTrvList }" varStatus="st">
						<div class="column is-one-third">
							<div class="card publicTrvCard">
								<input type="hidden" value="${ trv.trvId }" name="trvId" />
								<div class="card-image">
									<figure class="image" style="margin:0">
										<c:if test="${ trv.mainImage ne null }">
											<img src="resources/uploadFiles/${ trv.mainImage.changeName }">
										</c:if>
										<c:if test="${ trv.mainImage eq null }">
											<img src="resources/images/logo3.png">
										</c:if>
									</figure>
								</div>
								<div class="card-content">
									<div class="media">
										<div class="media-left">
											<p class="title is-4">${ trv.trvTitle }</p>
											<p class="subtitle is-6">
												<c:forEach var="trvCity" items="${ trv.trvCityList }" varStatus="st2">
													${ trvCity.countryNameKo } &nbsp; ${ trvCity.cityNameKo }
													<c:if test="${ st2.count ne trv.trvCityList.size() }">/</c:if>&nbsp;
												</c:forEach>
											</p>
											<small>${ trv.startDate } ~ ${ trv.endDate }</small>&nbsp;&nbsp;
											<a class="button is-small"> 
												<span class="icon is-small"><i class="fa fa-user"></i></span> 
												<span> ${ sessionScope.loginUser.userName } </span>
											</a>
										</div>
										<div class="media-right">
										</div>
									</div>
									<div class="content">
										<c:forEach var="trvTag" items="${ trv.trvTagList }" varStatus="st2">
											<a>#${ trvTag.tagName }</a>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
			<section class="section" id="sharedSection" style="display:none">
				<div class="columns is-multiline">
					<c:forEach var="trv" items="${ sharedTrvList }" varStatus="st">
						<div class="column is-one-third">
							<div class="card privateTrvCard">
								<input type="hidden" value="${ trv.trvId }" name="trvId" />
								<div class="card-image">
									<figure class="image" style="margin:0">
										<c:if test="${ trv.mainImage ne null }">
											<img src="resources/uploadFiles/${ trv.mainImage.changeName }">
										</c:if>
										<c:if test="${ trv.mainImage eq null }">
											<img src="resources/images/logo1.png">
										</c:if>
									</figure>
								</div>
								<div class="card-content">
									<div class="media">
										<div class="media-left">
											<p class="title is-4">${ trv.trvTitle }</p>
											<p class="subtitle is-6">
												<c:forEach var="trvCity" items="${ trv.trvCityList }" varStatus="st2">
													${ trvCity.countryNameKo } &nbsp; ${ trvCity.cityNameKo }
													<c:if test="${ st2.count ne trv.trvCityList.size() }">/</c:if>&nbsp;
												</c:forEach>
											</p>
											<small>${ trv.startDate } ~ ${ trv.endDate }</small>&nbsp;&nbsp;
											<a class="button is-small"> 
												<span class="icon is-small"><i class="fa fa-user"></i></span> 
												<span> ${ trv.userName } </span>
											</a>
										</div>
										<div class="media-right">
										</div>
									</div>
									<div class="content">
										<c:forEach var="trvTag" items="${ trv.trvTagList }" varStatus="st2">
											<a>#${ trvTag.tagName }</a>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
		</div>
	</div>
	<script>
		$(function() {
 			var menu = $(".myPageMenu li").eq(0);
 			menu.addClass('is-active');
 			menu.siblings().removeClass('is-active');
 			
			$(".my-trv-menu").click(function() {
				$(this).addClass('is-active');
				$(this).siblings().removeClass('is-active');
				if($(this).is("#private")) {
					$("#privateSection").show();
					$("#publicSection").hide();
					$("#sharedSection").hide();
				}else if($(this).is("#public")) {
					$("#privateSection").hide();
					$("#publicSection").show();
					$("#sharedSection").hide();
				}else {
					$("#privateSection").hide();
					$("#publicSection").hide();
					$("#sharedSection").show();
				}
			});
		});
	
		$(".privateTrvCard").click(function() {
			var trvId = $(this).children().eq(0).val();
			location.href="selectTravel.trv?trvId=" + trvId;
		});
		$(".publicTrvCard").click(function() {
			var trvId = $(this).children().eq(0).val();
			location.href="travelDetailForm.tb?trvId=" + trvId;
		});
	</script>



</body>
</html>