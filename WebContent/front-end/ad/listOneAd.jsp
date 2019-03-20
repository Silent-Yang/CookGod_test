<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ad.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	AdVO adVO = (AdVO) request.getAttribute("adVO"); //SustServlet.java(Concroller), 存入req的adVO物件
%>

<html>
<head>
<title>廣告資料 - listOneAd.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>
	<%
		if (adVO != null) {
	%>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>廣告資料 - ListOneAd.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/ad/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>廣告編號</th>
			<th>廣告標題</th>
			<th>廣告內文</th>
			<th>廣告上架日期</th>
			<th>廣告下架日期</th>
			<th>廣告狀態</th>
			<th>廣告類別</th>
			<th>食材供應商</th>

		</tr>
		<tr>
			<td><%=adVO.getAd_ID()%></td>
			<td><%=adVO.getAd_con()%></td>
			<td><%=adVO.getAd_start()%></td>
			<td><%=adVO.getAd_end()%></td>
			<td><%=adVO.getAd_status()%></td>
			<td><%=adVO.getAd_type()%></td>
			<td><%=adVO.getFood_sup_ID()%></td>


		</tr>
	</table>
	<%
		}
	%>
</body>
</html>