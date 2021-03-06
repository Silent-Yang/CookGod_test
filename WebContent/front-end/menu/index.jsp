<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.menu.model.*"%>

<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">

<title>套餐管理</title>
</head>
<body>

	<div class="card text-center" style="background-color: #D4E6F1">
		<div class="card-body">
			<h5 class="card-title">套餐管理</h5>
			<p class="card-text">Index.jsp</p>
		</div>
	</div>

	<a class="btn btn-outline-success"
		href='<%=request.getContextPath()%>/front-end/menu/addMenu.jsp'
		role="button" style="width: 50%; float: left;">新增套餐</a>
	<a class="btn btn-outline-success"
		href='<%=request.getContextPath()%>/front-end/menu/listAllMenu.jsp'
		role="button" style="width: 50%;">查詢所有套餐</a>

	<%--Error Message --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red; font-size: 20px;">Error:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<div class="container justify-content-center">
		<div class="row">
			<div class="col-12">

				<div class="alert alert-success" role="alert">請輸入或選擇套餐編號以查詢</div>
				<jsp:useBean id="menuSvc" scope="page"
					class="com.menu.model.MenuService" />

				<form method="post"
					action="<%=request.getContextPath()%>/front-end/menu/listOneByMenuID.jsp">
					<div class="input-group mb-3">
						<input type="text" class="form-control" name="menu_ID"
							placeholder="請輸入套餐編號">
						<div class="input-group-append">
							<input type="submit" class="btn btn-outline-secondary" value="送出">
						</div>
					</div>
				</form>

				<form method="post"
					action="<%=request.getContextPath()%>/front-end/menu/listOneByMenuID.jsp">
					<div class="input-group">
						<select size="1" name="menu_ID" class="form-control">
							<option value="請選擇套餐編號">請選擇套餐編號
								<c:forEach var="menuVO" items="${menuSvc.all}">
									<option value="${menuVO.menu_ID}">${menuVO.menu_ID}
								</c:forEach>
						</select>
						<div class="input-group-append">
							<input type="submit" class="btn btn-outline-secondary" value="送出">
						</div>
					</div>
				</form>

				<form method="post"
					action="<%=request.getContextPath()%>/front-end/menu/listOneByMenuID.jsp">
					<div class="input-group">
						<select size="1" name="menu_ID" class="form-control">
							<option value="請選擇套餐名稱">請選擇套餐名稱
								<c:forEach var="menuVO" items="${menuSvc.all}">
									<option value="${menuVO.menu_ID}">${menuVO.menu_name}
								</c:forEach>
						</select>
						<div class="input-group-append">
							<input type="submit" class="btn btn-outline-secondary" value="送出">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>



	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
</body>
</html>