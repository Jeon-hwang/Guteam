<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<form action="/friendReq/addFriend" method="post">
	<input type="hidden" name="memberId" id="memberId" value="${sessionScope.memberId }">
	<input type="text" name="friendId" placeholder="ID 입력" required>
	<input type="submit" value="친구추가">

</form>
<hr>
<h3>보낸 요청</h3>
<hr>
<h3>받은 요청</h3>
<hr>
<h2>친구 목록</h2>
<table>
	<tbody>
		<c:forEach var="vo" items="${list }">
			<tr>
				<td><input type="image" class="profileImg" alt="${vo.memberId }" 
					src="display?fileName=${vo.memberImageName }" readonly /></td>
				<td></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>