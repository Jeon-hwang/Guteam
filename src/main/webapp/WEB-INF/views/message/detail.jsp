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
	flex-wrap: wrap;
	width : 120px;
	height : 400px;
}
#m-board {
	display:flex
	flex-wrap: wrap;
}
#board-top {
	display:flex;
	flex-wrap: wrap;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 580px;
	height : 50px;
}
#main {
	display:flex;
	flex-wrap: wrap;
	background-color : #666666;
	width : 580px;
	height : 350px;
	float : left;
}
ul {
	
	margin: 0px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
   	text-align : center;
}
li {
	display : inline-block;
}
.cen {
	text-align : center;
}
.title {
	padding-left : 10px;
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

thead {
	background-color : #bcc2e5;
	text-align : center;
}
th {
	border-left : solid 1px gray;
}
td {
	color: #e5e5dc;
	border-left : solid 1px #bcc2e5;	
	border-bottom : solid 1px #bcc2e5;
}
#board-head {
	margin : 5px;
    
}
</style>
<meta charset="UTF-8">
<title>${vo.messageTitle }</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<img class="logoImg" alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" >
	<ul>
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

</div>
<div id="main">
	<ul>
		<li class="hdl">
		<c:if test="${sendOrReceive=='receive' }">
		보낸 사람 : ${vo.sendMemberNickname }
		</c:if>
		<c:if test="${sendOrReceive=='send' }">
		받은 사람 : ${vo.receiveMemberNickname }
		</c:if>
		</li>
		<li class="hdl">
		<c:if test="${sendOrReceive=='receive' }">
		받은 날짜 : <fmt:formatDate value="${vo.messageDateCreated }" pattern="MM-dd HH:mm:ss"/>
		</c:if>
		<c:if test="${sendOrReceive=='send' }">
		보낸 날짜 : <fmt:formatDate value="${vo.messageDateCreated }" pattern="MM-dd HH:mm:ss"/>
		</c:if>
		</li>
	</ul>
	
	<div>
	<table>
	<colgroup>
		<col class="lbl">
		<col class="val">
	</colgroup>
		<tbody>
			<tr style="border-bottom : solid 1px darkgray;">
			<td><h5>제목</h5></td>
			<td>${vo.messageTitle }</td>
			</tr>
			<tr>
			<td><h5>내용</h5></td>
			<td>${vo.messageContent }</td>
			</tr>
		</tbody>
	</table>
	</div>
	<div>
	<form action="../message/write">
		<input type="hidden" name="sendMemberId" value="${vo.sendMemberId }">
		<input type="submit" class="btn btn-light" style="float: right; margin-right: 10px;" value="답장하기">
	</form>
	</div>
</div>
</div>
</div>
</body>
</html>