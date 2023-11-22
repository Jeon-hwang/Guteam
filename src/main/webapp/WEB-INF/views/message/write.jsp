<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
#m-board h2{
	margin: 0px;
	padding-top:8px;
	color: #e5e5dc;
}
#board-top {
	display:flex;
	flex-wrap: wrap;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 590px;
	height : 50px;
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
#board-btm {
	display:flex;
	justify-content: flex-end;
	padding-right: 5px;
}
#messageTitle {
	width: 495px;
}
#messageContent {
	display:flex;
	justify-content: center;
	align-item: center;
	width: 495px;
	height: 227px;
	margin: 0px;
	padding: 0px;
	resize:none;
	
	background-color: #FFFFFFFF;
	color: #000;
	border: 1px solid grey;
}
.sendInfo {
	text-align : center;
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
	width: 100%;
}
thead {
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
	
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : ${vo.memberId }님의 쪽지함</title>
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
	<h2>${vo.memberId }님의 쪽지 쓰기</h2>

<div id="main">
<form action="write" method="post" onsubmit="sendRequest();">
<sec:csrfInput/>
<table>
	<tbody>
		<tr>
			<td class="sendInfo">보낼 닉네임</td>
			<td>
				<c:if test="${empty receiveMemberId }">
					<input type="text" name="receiveMemberNickname" id="receiverNickname" required>				
				</c:if>
				<c:if test="${not empty receiveMemberId }">
					<input type="hidden" name="receiveMemberId" id="receiverId" value="${receiveMemberId }">
					${receiveMemberId }
					<input type="hidden" name="receiveMemberNickname" id="receiveNickname" value="${receiveMemberNickname }">
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="sendInfo">제 목</td>
			<td>
			<input type="text" name="messageTitle" id="messageTitle" value="${messageTitle }">
			</td>
		</tr>
		<tr>
			<td class="sendInfo">내 용</td>
			<td>
			<textarea name="messageContent" id="messageContent" >${messageContent }</textarea><!-- 밑부분 70px -->				</td>
		</tr>
		
	</tbody>
</table>
		
	<div id="board-btm">
		<input type="hidden" name="sendMemberId" id="sendMemberId" value="${vo.memberId }">
		<input type="hidden" name="sendMemberNickname" id="sendMemberNickname" value="${vo.nickname }">
		<input class="btn btn-light" type="submit" value="보내기">
	</div>
</form>
	
</div>
</div>
</div>

<script type="text/javascript">
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	function sendRequest(){
		var memberId = $('#receiverNickname').val();
		var sendMemberId = $('#sendMemberId').val();
		console.log('ajax요청');
		$.ajax({
			type:'post',
			url:'/guteam/sse/message/'+memberId,
			beforeSend : function(xhr) {
		        xhr.setRequestHeader(header, token);
		    },
			data:{'sendMemberId':sendMemberId},
			success:function(result){
				console.log('메시지를 보냈습니다.');
			}
		});
	}
</script>
</body>
</html>