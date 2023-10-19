<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GUTEAM : 회원 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<h1>${vo.memberId }님의 회원 정보</h1>
	<form action="update" method="post" enctype="multipart/form-data">
		<div>
			<input type="hidden" name="memberId" value="${vo.memberId }">
			<input type="hidden" name="password" value="${vo.password }">
			
			닉네임 :
			<input type="text" name="nickname" value="${vo.nickname }" required /><br>
			이메일 :
			<input type="text" name="email" value="${vo.email }" required /><br>
			연락처 :
			<input type="text" name="phone" value="${vo.phone }" required /><br><br>
			프로필 사진 <br>
			<input type="file" name="memberImageName"><br>
			<input type="hidden" name="isAdmin" value="N" />
			<input type="submit" value="수정">
		</div>
	</form>
</body>
</html>