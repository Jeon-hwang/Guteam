<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.logoImg {
	display:flex;
	width: 70px;
	height: 70px;
	margin: 25px;
}
#full {
	display:flex;
	width : 750px;
	height : 420px;
}
#leftMenu {
	display:flex;
	flex-direction: column;
	width : 120px;
	height : 400px;
}
#m-board {
	display:flex;
	flex-direction: column;
}
#board-top {
	display:flex;
	flex-wrap: wrap;
	display:flex;
	justify-content: space-around;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 590px;
	height : 50px;
	color: #e5e5dc;
	font-size: 20px;
}
#main {
	display: flex;
    flex-flow: column wrap;
    flex-direction: row;
    justify-content: space-around;
    align-content: flex-start;
    background-color: #666666;
    width: 590px;
    height: 350px;
}
.msgInfo {
	display:flex;
	justify-content: space-around;
}
.msgInfo span {
	color: #e5e5dc;
}
#board-btm {
	display: flex;
}
ul.left{
	margin: 0px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
   	text-align : center;
   	display: flex;
   	flex-direction: column;
}
li {
	display : inline-block;
}
.btn {
	margin : 1px;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
}
body {
    margin: 0;
    padding: 0;
}
table {
	width: 590px;
}
thead {
	display: flex;
	width: 100%;
	background-color : #bcc2e5;
	text-align : center;
}

th {
	border-left : solid 1px gray;
}
tr {
	height: 35px;
}
td {
	color: #e5e5dc;
	border: solid 1px #bcc2e5;
	word-break: break-all;
}
.msgTitle {
	width: 10%;
	text-align: center;
}
.msgContent {
	word-wrap: break-word;
	white-space: normal;
}
.td {
	text-align : center;
	white-space: nowrap;
}
</style>
<meta charset="UTF-8">
<sec:authentication property="principal" var="principal"/>
<title>GUTEAM : ${principal.username }님의 쪽지함</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<img class="logoImg" alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" >
	<ul class="left">
	<li><a href="../message/write"><button class="btn btn-light">쪽지 쓰기</button></a></li>
	<br>
	<br>
	<li><a href="../message/list"><button class="btn btn-light">받은 쪽지함</button></a></li>
	<li><a href="../message/sent"><button class="btn btn-light">보낸 쪽지함</button></a></li>
	<li><a href="../message/msgBox"><button class="btn btn-light">쪽지 보관함</button></a></li>
	</ul>
</div>
<div id="m-board">
<div id="board-top">
<c:if test="${sendOrReceive=='receive' }">
		<span> 보낸 사람 : ${vo.sendMemberNickname }</span>
		</c:if>
		<c:if test="${sendOrReceive=='send' }">
		<span>받은 사람 : ${vo.receiveMemberNickname }</span>
		</c:if>
		<c:if test="${sendOrReceive=='receive' }">
		<span>받은 날짜 : <fmt:formatDate value="${vo.messageDateCreated }" pattern="MM-dd HH:mm:ss"/></span>
		</c:if>
		<c:if test="${sendOrReceive=='send' }">
		<span>보낸 날짜 : <fmt:formatDate value="${vo.messageDateCreated }" pattern="MM-dd HH:mm:ss"/></span>
	</c:if>
</div>
<div id="main">
<table>
	<tbody>
		<tr style="border : solid 1px darkgray;">
			<td class="msgTitle"><h5>제목</h5></td>
			<td>${vo.messageTitle }</td>
			</tr>
			<tr>
			<td class="msgTitle"><h5>내용</h5></td>
			<td class="msgContent">${vo.messageContent }</td>
		</tr>
	</tbody>
</table>
<div class="btn_send">
	<form action="../message/write" method="get">
	<c:if test="${vo.sendMemberId!=principal.username }">
		<input type="hidden" name="receiveMemberId" value="${vo.sendMemberId }">
		<input type="submit" class="btn btn-light" style="float: right; margin-right: 10px;" value="답장하기">
	</c:if>
	<c:if test="${vo.sendMemberId==principal.username }">
		<input type="hidden" name="receiveMemberId" value="${vo.receiveMemberId }">
		<input type="hidden" name="messageTitle" value="${vo.messageTitle }">
		<input type="hidden" name="messageContent" value="${vo.messageContent }">
		<input type="submit" class="btn btn-light" style="float: right; margin-right: 10px;" value="다시보내기">
	</c:if>
	</form>
</div>

</div>

</div>
</div>

</body>
</html>