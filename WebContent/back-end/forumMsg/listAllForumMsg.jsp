<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.forumMsg.model.*"%>
<%@ page import="java.util.*,java.text.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%

    ForumMsgService forumMsgSvc = new ForumMsgService();
    List<ForumMsgVO> list = forumMsgSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有留言資料 - listAllForumMsg.jsp</title>

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
	width: 870px;
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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有留言資料 - listAllForumMsg.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>文章編號</th>
		<th>留言編號</th>
		<th>留言內容</th>
		<th>文章發表時間</th>
		<th>文章狀態</th>
		<th>顧客編號</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="forumMsgVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${forumMsgVO.forum_art_ID}</td>
			<td>${forumMsgVO.forum_msg_ID}</td>
			<td>${forumMsgVO.forum_msg_con}</td>
			<td><fmt:formatDate value="${forumMsgVO.forum_msg_start}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
			<td>${forumMsgVO.forum_msg_status}</td> 
			<td>${forumMsgVO.cust_ID}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/forumMsg/forumMsg.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="forum_msg_ID"  value="${forumMsgVO.forum_msg_ID}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/forumMsg/forumMsg.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="forum_msg_ID"  value="${forumMsgVO.forum_msg_ID}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<%@ include file="page2.file" %>
</body>
</html>