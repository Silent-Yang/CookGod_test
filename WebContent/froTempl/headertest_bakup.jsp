<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.cust.model.CustVO"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ad.model.AdVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="adSvc" class="com.ad.model.AdService"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta HTTP-EQUIV="Refresh" content="20">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>Pixel - Digital Agency HTML Template</title>

<!-- Favicon -->
<link rel="icon"
	href="<%=request.getContextPath()%>/froTempl/temp/img/core-img/favicon.ico">

<!-- Stylesheet -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/froTempl/temp/style.css">
</head>

<body>
	<jsp:include page="/froTempl/header.jsp" flush="true" />


	<!-- ##### Hero Area Start ##### -->
	<section class="hero-area">
		<div id="adWall" class="hero-slideshow owl-carousel">


			<!-- Single Slide-->
			<div class="single-slide">
				<!-- Background Image-->
				<div class="slide-bg-img bg-img"
					style="background-image: url(<%=request.getContextPath()%>/froTempl/temp/img/bg-img/1.jpg);"></div>
				<!-- Welcome Text -->
				<div class="container h-100">
					<div class="row h-100 align-items-center">
						<div class="col-12 col-lg-9">
							<div class="welcome-text">
								<h2 data-animation="fadeInUp" data-delay="300ms">
									<span>Hungry?</span><br>Ready to Order
								</h2>
								<h4 data-animation="fadeInUp" data-delay="500ms">
									See the Cook God<span></span>
								</h4>
								<a href="#" class="btn pixel-btn mt-50"
									data-animation="fadeInUp" data-delay="700ms">View Project</a>
							</div>
						</div>
					</div>
				</div>
			</div>  
		<c:forEach var="adVO" items="${adSvc.allNowAd}">	
			<!-- Single Slide -->
            <div class="single-slide">
                <!-- Background Image-->
                <div class="slide-bg-img bg-img" style="background-image:url(<%=request.getContextPath()%>/ad/ad.do?ad_ID=${adVO.ad_ID});"></div>
                <!-- Welcome Text -->
                <div class="container h-100">
                    <div class="row h-100 align-items-center">
                        <div class="col-12 col-lg-9">
                            <div class="welcome-text">
                                <h2 data-animation="fadeInUp" data-delay="300ms"><span>${adVO.ad_title}</span><br>In Cook God</h2>
                                <h4 data-animation="fadeInUp" data-delay="500ms">${adVO.ad_con}<span></span></h4>
                                <a href="#" class="btn pixel-btn mt-50" data-animation="fadeInUp" data-delay="700ms">View Project</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>  
		</c:forEach>
<!-- 			<div class="single-slide"> -->
<!-- 				Background Image -->
<!-- 				<div id="imgPos" class="slide-bg-img bg-img"></div> -->
<!-- 				Welcome Text -->
<!-- 				<div class="container h-100"> -->
<!-- 					<div class="row h-100 align-items-center"> -->
<!-- 						<div class="col-12 col-lg-9"> -->
<!-- 							<div id="ad" class="welcome-text"> -->
<!-- 								<h2 data-animation="fadeInUp" data-delay="300ms"> -->
<!-- 									<span></span><br> -->
<!-- 								</h2> -->
<!-- 								<h4 data-animation="fadeInUp" data-delay="500ms"> -->
<!-- 									<span></span> -->
<!-- 								</h4> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->



			
		</div>
	</section>

	

	<!-- ##### Hero Area End ##### -->
	<jsp:include page="/froTempl/footer.jsp" flush="true" />
	<script>
	    var MyPoint = "/WebSocketForServlet";
		var host = window.location.host;
		var webCtx = '<%=request.getContextPath()%>';
		var endPointURL = "ws://" + host + webCtx + "/" + MyPoint;

		var adWebSocket;
		$(document).ready(function() {
			//adWSconnect();
			$('#adWall').owlCarousel({
	            items: 1,
	            loop: true,
	            nav: true,
	            navText: ['Prev', 'Next'],
	            dots: false,
	            autoplay: true,
	            autoplayTimeout: 10000,
	            smartSpeed: 500,
	            animateIn: 'fadeIn',
	            animateOut: 'fadeOut'
	        });
		});
		// 觸發connect()時註冊方法, 並建立WebSocket物件

		function adWSconnect() {
			//	建立 websocket 物件
			adWebSocket = new WebSocket(endPointURL);

			adWebSocket.onopen = function(event) {
			
			};

			//	隨然我是在連線建立好時傳送訊息(ServerWebSocket), 依舊會觸發這個onmessage

			adWebSocket.onmessage = function(event) {
				console.log(event);
// 				let adWallVar = $("#adWallhidden").clone();
				let adWallmsgs = JSON.parse(event.data);
// 				console.log(adWallmsgs);
				let urlStr = "url(<%=request.getContextPath()%>/ad/ad.do?ad_ID=" +adWallmsgs[0].ad_ID+ ")";
// 				console.log(urlStr);
				
// 				adWallVar.find("#imgPos").css('background-image', urlStr);
// 				adWallVar.find("span").text(adWallmsgs[0].ad_con);
// 				adWallVar.find("#imgPos").removeAttr("id");
// 				adWallVar.removeAttr("style");
// 				adWallVar.removeAttr("id");
				
		<%--		$("#adWall").append(
				`
					<div class="single-slide" >
						<!-- Background Image-->
						<div id="imgPos" class="slide-bg-img bg-img" style="background-image: `+urlStr+`;"></div>
						<!-- Welcome Text -->
						<div class="container h-100">
							<div class="row h-100 align-items-center">
								<div class="col-12 col-lg-9">
									<div id="ad" class="welcome-text">
										<h2 data-animation="fadeInUp" data-delay="300ms">
											<span>`+adWallmsgs[0].ad_title+`</span><br>
										</h2>
										<h4 data-animation="fadeInUp" data-delay="500ms">
											<span>`+adWallmsgs[0].ad_con+`</span>
										</h4>
									</div>
								</div>
							</div>
						</div>
					</div>
				`		
				);
				
				$('#adWall').owlCarousel('destroy');--%> 
				
			};

		}
		function adWSsendMessage() {

		}
		
	</script>
</body>
</html>