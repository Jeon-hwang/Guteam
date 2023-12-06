<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.gradient-border {
	width: 100%;
  --borderWidth: 5px;
  background: #1D1F20;
  position: relative;
  border-radius: var(--borderWidth);
}
.gradient-border:after {
  content: '';
  position: absolute;
  top: calc(-1 * var(--borderWidth));
  left: calc(-1 * var(--borderWidth));
  height: calc(100% + var(--borderWidth) * 2);
  width: calc(100% + var(--borderWidth) * 2);
  background: linear-gradient(60deg, #f79533, #f37055, #ef4e7b, #a166ab, #5073b8, #1098ad, #07b39b, #6fba82);
  border-radius: calc(1.5 * var(--borderWidth));
  z-index: -1;
  animation: animatedgradient 5s ease alternate infinite;
  background-size: 300% 300%;
}


@keyframes animatedgradient {
	0% {
		background-position: 0% 50%;
	}
	50% {
		background-position: 100% 50%;
	}
	100% {
		background-position: 0% 50%;
	}
}
.formArea {
	justify-content: flex-end;
}
}
</style>
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
	<div class="gradient-border">
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
			alert('로그인에 실패하였습니다. 아이디와 비밀번호를 확인해 주세요.');
		}else if(result == 'deleted'){
			alert('탈퇴한 아이디 입니다.');
		}

	});
</script>

</body>
</html>