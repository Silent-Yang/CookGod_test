<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.food.model.*"%>


<% FoodVO foodVO = (FoodVO) request.getAttribute("foodVO"); %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>食材資料新增 - addFood.jsp</title>
</head>
<body>
	<div id="main-wrapper" data-navbarbg="skin6" data-theme="light"
		data-layout="vertical" data-sidebartype="full"
		data-boxed-layout="full">
		<jsp:include page="/back-endTemplate/header.jsp" flush="true" />
		<aside class="left-sidebar" data-sidebarbg="skin5">
			<%--==============<jsp:include page="/back-end/XXXX/sidebar.jsp" flush="true" />=================================--%>

		</aside>
		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<%--=================================工作區================================================--%>
				<table id="table-1">
					<tr>
						<td>
							<h3>食材資料新增 - addfood.jsp</h3>
						</td>
						<td>
							<h4>
								<a
									href="<%=request.getContextPath()%>/back-end/food/select_page.jsp"><img
									src="<%=request.getContextPath()%>/back-end/food/images/tomcat.png"
									width="100" height="100" border="0">回首頁</a>
							</h4>
						</td>
					</tr>
				</table>

				<h3>資料新增:</h3>

				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color: red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>

				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/food/food.do" name="form1">
					<table>
						<tr>

							<td>食材名稱:${foodVO.food_name}</td>
							<td><input type="TEXT" name="food_name" size="45"
								<%--value="<%= (foodVO==null)? "大白菜" : foodVO.getFood_name()%>" /></td> --%>
					 value=${empty foodVO.food_name ? "大白菜":foodVO.food_name} /></td>
						</tr>
						<tr>
							<td>食材種類:</td>
							<td><select size="1" name="food_type_ID">
									<c:forEach var="foodType" items="${foodTypeMap}">
										<option value="${foodType.key}"
											${(foodVO.food_type_ID == foodType.key)?'selected':''}>${foodType.value}
									</c:forEach>
							</select></td>
						</tr>


					</table>
					<input type="hidden" name="action" value="insert"> <input
						type="submit" value="送出新增">
				</FORM>
				<%--=================================工作區================================================--%>
				<jsp:include page="/back-endTemplate/footer.jsp" flush="true" />
				<%--=================================jQuery===============================================--%>
			</div>
		</div>
	</div>
</body>
</html>