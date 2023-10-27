<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap css -->
<!-- Bootstrap css -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
   crossorigin="anonymous" />
<!-- Bootstrap icons -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
   rel="stylesheet" />
<!-- Bootstrap core JS-->
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style type="text/css">
body {
background-color:grey;
padding:20px 80px;

}

.profileImg {
	width : 100px;
	height : 100px;
	border : 1px solid grey;
}
</style>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>GUTEAM : 로그인</title>
</head>
<body>
	<c:if test="${not empty param }">아이디와 비밀번호를 확인해주세요 </c:if>
	<h1><a href="../"><img width="200px" height="50px" src="display?fileName=/logo.png"></a></h1>
	
	<br>
	<form action="login" method="post">
		ID &nbsp;&nbsp;&nbsp; 
		<input type="text" name="memberId" required />
		<br>
		PW &nbsp;
		<input type="password" name="password" required />
		<input type="hidden" name="targetURL" value=${param.targetURL }>
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