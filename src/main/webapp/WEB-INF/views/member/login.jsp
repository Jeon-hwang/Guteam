<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>GUTEAM : 로그인</title>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
<section>

<div id="wrap">
	<c:if test="${param.error==1 }">아이디와 비밀번호를 확인해주세요 </c:if>
	<br>
	<div class="titleArea">
		<h1>Log in</h1>
	</div>
	<div id="container">
	<div class="formArea">
	<form action="login" method="post">
		<div class="info">
			<h5 style="color:#fff; font-weight:bolder ">ID &nbsp;&nbsp;&nbsp;&nbsp;</h5>
			<div class="inputArea">
				<input type="text" name="memberId" required />
			</div>
		</div>
		<div class="info">
			<h5 style="color:#fff; font-weight:bolder ">PW &nbsp;</h5>
			<div class="inputArea">
				<input type="password" name="password" required />
			</div>
		</div>
		
		<input type="hidden" name="referer" value="${referer }">
		<input type="hidden" name="targetURL" value="${param.targetURL }">
		<sec:csrfInput/>
		<br>
		<div style="display:inline-flex; flex-direction:row;">
			<a href="register"><button type="button" class="btn btn-light"> 회원 가입</button></a>
			<input class="btn btn-light" type="submit" value="로그인">
		</div>
	</form>
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

	});
</script>

</body>
</html>