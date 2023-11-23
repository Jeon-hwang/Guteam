<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>GUTEAM : 로그인</title>

</head>
<body>
<header>
<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
</div>
</header>

<section>
<div id="wrap">
	<c:if test="${param.error==1 }">아이디와 비밀번호를 확인해주세요 </c:if>
	<br>
	<div class="titleArea">
		<h1>Log in</h1>
	</div>

<div class="formArea">
<div class="info">
	<div class="caption">
		<p style="color:#fff; font-weight:bolder ">ID</p>
		<p style="color:#fff; font-weight:bolder ">PW</p>
	</div>	
	
<div class="inputArea">
	<form action="login" method="post">
		<input type="text" name="memberId" required /><br>
		<input type="password" name="password" required /><br>
		<input type="hidden" name="referer" value="${referer }">
		<input type="hidden" name="targetURL" value="${param.targetURL }">
		<sec:csrfInput/>
		<br>
		<div style="width:300px; display:flex; justify-content: flex-end;">
			<a href="register"><button type="button" class="btn btn-light"> 회원 가입</button></a>
			<input class="btn btn-light" type="submit" value="로그인">
		</div>
	</form>
</div>
</div>
</div>
	<input type="hidden" id="alert" value="${alert }">
</div>
</section>	
<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
		if(result == 'success'){
			alert('가입 성공!');
		}
		else if(result == 'loginFail') {
			console.log("아ㅋㅋ 틀렸다고~");
			alert('로그인에 실패하였습니다. 아이디와 비밀번호를 확인해 주세요.');
		}

	});
</script>

</body>
</html>