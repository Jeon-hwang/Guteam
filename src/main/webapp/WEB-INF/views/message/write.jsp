<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.profileImg {
	width : 40px;
	height : 40px;
	border : 1px solid grey;
}
.btn {
	margin : 1px;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
}
.th {
	width : 100px;
	height : 250px;
}
.td {
	width : 480px;
	height : 250px;
}
.tdc {
	text-align: center;
}
body {
    margin: 0;
    padding: 0;
}
#full {
	width : 703px;
	height : 410px;
}
#leftMenu {
	width : 110px;
	height : 400px;
	float : left;
}
#board-top {
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 580px;
	height : 50px;
	float : left;
}
#main {
	background-color : lightgray;
	width : 580px;
	height : 350px;
	float : left;
}
ul{
	margin: 0px;
    padding-top : 20px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
   	text-align : center;
}
li {
	display : inline-block;
}
thead {
	background-color : darkgrey;
	text-align : center;
}
#board-head {
	margin : 5px;
    
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : ${vo.memberId }님의 쪽지함</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">

	<ul>
	<li><a href="../message/write"><button class="btn btn-light">쪽지 쓰기</button></a></li>
	<br>
	<br>
	<li><a href="../message/list"><button class="btn btn-light">받은 쪽지함</button></a></li>
	<li><a href="../message/sent"><button class="btn btn-light">보낸 쪽지함</button></a></li>
	<li><button class="btn btn-light">쪽지 보관함</button></li>
	</ul>
</div>
<div id="board-top">
	
	
</div>
<div id="main">
	<form action="write" method="post">
	<sec:csrfInput/>
	<h2>${vo.memberId }님의 쪽지 쓰기</h2>
	<div id="msg-title">
		<table>
		<colgroup>
			<col class="th">
			<col class="td">
		</colgroup>
		<tbody>
			<tr>
				<td class="tdc">보낼 닉네임</td>
				<td>
				<c:if test="${empty sendMemberId }">
					<input type="text" name="receiveMemberNickname" id="receiverNickname" required>				
				</c:if>
				<c:if test="${not empty sendMemberId }">
					<input type="hidden" name="receiveMemberId" id="receiverNickname" value="${sendMemberId }">
					${sendMemberId }
				</c:if>
				</td>
			</tr>
			<tr>
				<td class="tdc">제 목</td>
				<td>
				<input type="text" name="messageTitle" id="messageTitle" style="width: 465px;">
				</td>
			</tr>
			<tr>
				<td class="tdc">내 용</td>
				<td>
				<textarea name="messageContent" id="messageContent" style="width: 465px; height: 200px; resize:none; maxlength: 333;"></textarea><!-- 밑부분 70px -->
				</td>
			</tr>
			
		</tbody>
		</table>
	</div>		
	<div style="text-align: right; padding-right: 5px;">
		<input type="hidden" name="sendMemberId" id="sendMemberId" value="${vo.memberId }">
		<input type="hidden" name="sendMemberNickname" id="sendMemberNickname" value="${vo.nickname }">
		<input class="btn btn-light" type="submit" value="보내기">
	</div>
	</form>
	
</div>

</div>
</body>
</html>