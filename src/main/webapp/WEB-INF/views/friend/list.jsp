<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GUTEAM : 친구 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
.profileImg {
	width : 40px;
	height : 40px;
	border : 1px solid grey;
}
</style>
</head>
<body>
<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />

<div>
	<h2>나의 친구 목록</h2>
</div>
<form action="../friend/addFriend" method="post">
	<sec:csrfInput/>
	<input type="hidden" name="sendMemberId" id="sendMemberId" value="${vo.memberId }">
	<input type="text" name="receiveMemberId" placeholder="ID 입력" required>
	<input type="submit" value="친구 추가">
</form>

<hr>
<h3>보낸 요청</h3>
<table>
	<tbody>
		<c:forEach var="vo" items="${sendList }">
		<div style="width:100px; hieght:140px; display:inline-block;" class="friendReq">
			<img alt="${vo.memberImageName }" width="100px" height="100px" src="display?fileName=${vo.memberImageName }"> 
			<input type="text" id="toNickname" value="${vo.nickname }">
		</div>
			
		</c:forEach>
	</tbody>
</table>
<hr>
<h3>받은 요청</h3>
	<%-- <table>
	<tbody>
		<c:forEach var="vo" items="${receiveList }">
			<tr>
				<td><input type="image" class="profileImg" alt="${vo.memberId }" 
					src="display?fileName=${vo.memberImageName }" readonly /></td>
				<td></td>
			</tr>
		</c:forEach>
	</tbody>
	</table> --%>
<hr>
<h2>친구 목록</h2>
<%-- <table>
	<tbody>
		<c:forEach var="vo" items="${friendList }">
			<tr>
				<td><input type="image" class="profileImg" alt="${vo.memberId }" 
					src="display?fileName=${vo.memberImageName }" readonly /></td>
				<td></td>
			</tr>
		</c:forEach>
	</tbody>
</table> --%>
<input type="hidden" id="alert" value="${alert }">

<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
			if(result == 'dupl'){
				alert('이미 친구 요청된 아이디입니다.');
			} else if(result=='success'){
				alert('친구요청이 완료되었습니다.');
			}else if(result == 'fail'){
				alert('요청에 실패하였습니다.');
			}
	});
</script>
</body>
</html>