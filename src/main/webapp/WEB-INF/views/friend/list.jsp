<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
body {
background-color:grey;
padding:20px 80px;
}
h2 {
	margin-top : 0.5rem;
	margin-bottom : 0.5rem;
	vertical-align: middle;
}
.profileImg {
	width : 40px;
	height : 40px;
	border : 1px solid grey;
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : 친구 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div>
<h1><a href="../"><img width="200px" height="50px" src="display?fileName=/logo.png"></a></h1>
</div>
<div>
	<h2><input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />
	나의 친구 목록</h2>
</div>
<form action="../friend/addFriend" method="post">
	<sec:csrfInput/>
	<input type="hidden" name="sendMemberId" id="sendMemberId" value="${vo.memberId }">
	<input type="text" name="receiveMemberId" placeholder="ID 입력" required>
	<input class="btn btn-light" type="submit" value="친구 추가">
</form>

<hr>
<h3>보낸 요청</h3>
<table>
	<tbody>
		<c:forEach var="vo" items="${sendList }">
		<div style="width:100px; hieght:140px; display:inline-block;" class="friendReq">
			<img alt="${vo.memberImageName }" width="100px" height="100px" src="display?fileName=${vo.memberImageName }"> 
			<input type="text" id="toNickname" value="${vo.nickname }" style="width:92px;" readonly>
		</div>
			
		</c:forEach>
	</tbody>
</table>
<hr>
<h3>받은 요청</h3>
<table>
	<tbody>
	<c:forEach var="rvo" items="${receiveList }">
		<div style="width:100px; hieght:140px; display:inline-block;" class="friendReq">
		<form action="../friend/accept" method="post">
		<sec:csrfInput/>
			<img alt="${rvo.memberImageName }" width="100px" height="100px" src="display?fileName=${rvo.memberImageName }"> 
			<input type="text" id="toNickname" value="${rvo.nickname }" style="width:92px;" readonly>
			<input type="hidden" name="memberId" value="${vo.memberId }">
			<input type="hidden" name="friendId" value="${rvo.memberId }">
			<button type="submit" formaction="../friend/accept">수락</button>
			<button type="submit" formaction="../friend/reject">거절</button>
		</form>
		</div>
		
	</c:forEach>
	</tbody>
</table>
<hr>
<h2>친구 목록</h2>
	<c:forEach var="fvo" items="${friendList }">
		<div class="friend" style="display:flex;">
			<input type="image" class="profileImg" alt="${fvo.memberId }" 
				src="display?fileName=${fvo.memberImageName }" readonly />
		<form action="../friend/delete" method="post">
			<sec:csrfInput/>
			<input type="text" id="toNickname" value="${fvo.nickname }" style="width:92px;" readonly>
			<input type="hidden" name="friendId" id="friendId" value="${fvo.memberId }">
			<input type="submit" value="친구삭제">
		</form>
		</div>
	</c:forEach>

<input type="hidden" id="alert" value="${alert }">

<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
			if(result == 'friend'){
				alert('이미 친구인 유저입니다.')
			}else if(result == 'alreadyFrd'){
				alert('먼저 친구 요청 받아 친구가 되었습니다.')
			} else if(result == 'dupl'){
				alert('이미 친구 요청된 아이디입니다.');
			} else if(result=='success'){
				alert('친구요청이 완료되었습니다.');
			} else if(result == 'fail'){
				alert('없는 아이디입니다.');
			} 
	});
</script>
</body>
</html>