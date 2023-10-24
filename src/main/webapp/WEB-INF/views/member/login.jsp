<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>GUTEAM : 로그인</title>
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
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
		<input type="submit" value="로그인">
	</form>
	<input type="hidden" id="onAlert" value="${on_alert }">
	
<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#onAlert').val();
			if(result == 'success'){
			alert('가입 성공!');
		}
	});
</script>
</body>
</html>