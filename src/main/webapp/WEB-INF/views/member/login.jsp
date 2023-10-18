<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Guteam : 로그인</title>
</head>
<body>
	<h1>GUTEAM</h1>
	<a href="register">회원 가입</a>
	<form action="login" method="post">
		ID &nbsp;&nbsp;&nbsp; 
		<input type="text" name="memberId" required />
		<br>
		PW &nbsp;
		<input type="password" name="password" required />
		<input type="hidden" name="targetURL" value=${param.targetURL }>
		<input type="submit" value="로그인">

	</form>
	
	
</body>
</html>