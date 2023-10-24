<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GUTEAM : 프로필</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
.profileImg {
	width : 50px;
	height : 50px;
	border : 1px solid grey;
}
</style>
</head>
<body>
<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />
<h2>${sessionScope.memberId }님의 프로필</h2>
	<div>
		<a href="addCash"><button>캐쉬 충전</button></a>
		<a href="friends"><button>친구 목록</button></a>
	</div>
	<br>
	<div>
		<form action="delete" method="post">
			<a href="update"><button type="button">회원 수정</button></a>
			<input type="hidden" name="memberId" id="memberId" value="${sessionScope.memberId }">
			<input type="submit" value="회원 탈퇴">	
		</form>
	</div>
</body>
</html>