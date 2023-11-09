<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"/>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>GUTEAM : 로그인</title>
</head>
<body>
	<c:if test="${param.error==1 }">아이디와 비밀번호를 확인해주세요 </c:if>
	<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
	<br>
	<form action="login" method="post">
		ID &nbsp;&nbsp;&nbsp; 
		<input type="text" name="memberId" required />
		<br>
		PW &nbsp;
		<input type="password" name="password" required />
		<input type="hidden" name="referer" value="${referer }">
		<input type="hidden" name="targetURL" value="${param.targetURL }">
		<sec:csrfInput/>
		<br>
		<br>
		<a href="register"><button type="button" class="btn btn-light"> 회원 가입</button></a>
		<input class="btn btn-light" type="submit" value="로그인">
	</form>
	<input type="hidden" id="alert" value="${alert }">
	
<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
			if(result == 'success'){
			alert('가입 성공!');
		}

	});
</script>

</body>
</html>