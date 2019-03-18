<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.menuOrder.model.*"%>

<html>
<head>
<title>List_One_Menu_Order.jsp</title>
<style type="text/css">
	table{
		border: 2px solid gray;
		margin: 15px;
	}
	th,td{
		border:1px solid;
		width: 100px;
		height: 50px;
		text-align: center;
		padding:3px;
	}
</style>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
</head>
<body>
	<div class="card text-center" style="background-color: #D4E6F1">	  
	  <div class="card-body" >
	    <h5 class="card-title">�d�߳浧�q��</h5>
	    <p class="card-text">listOneMenuOrder.jsp</p>
	    <a href="index.jsp" class="btn btn-primary">�^����</a>
	  </div>
	</div>

<%--Error Message--%>
<c:if test = "${not empty errorMsgs} }">
	<font style="color:red;font-size:30px;">Error</font>
	<ul>
		<c:forEach var="errMsgs" items="${errorMsgs}">
			<li style="color:red;">${errMsgs}</li>
		</c:forEach>
	</ul>
</c:if>
	<div class="container justify-content-center">
  		<div class="row">
  			<div class="col-12">
				<table>
					<tr>
						<th>�q��s��</th>
						<th>�q�檬�A</th>
						<th>�U�q���</th>
						<th>�w�����</th>
						<th>�������</th>
						<th>�q�����</th>
						<th>�q��d��</th>
						<th>�U�Ƚs��</th>
						<th>�D�p�s��</th>
						<th>�M�\�s��</th>
					</tr>	
					<tr>
						<td>${menuOrderVO.menu_od_ID}</td>
						<td>${menuOrderVO.menu_od_status}</td>
						<td>${menuOrderVO.menu_od_start}</td>
						<td>${menuOrderVO.menu_od_book}</td>
						<td>${menuOrderVO.menu_od_end}</td>
						<td>${menuOrderVO.menu_od_rate}</td>
						<td>${menuOrderVO.menu_od_msg}</td>
						<td>${menuOrderVO.cust_ID}</td>
						<td>${menuOrderVO.chef_ID}</td>
						<td>${menuOrderVO.menu_ID}</td>
					</tr>
				</table>
			</div>
  		</div>
  	</div>
<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</body>
</html>