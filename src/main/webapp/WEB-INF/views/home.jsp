<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
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
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
body {
background-color:grey;
padding:20px 80px;

}
</style>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>Welcome to Guteam</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<input type="hidden" id="alert" value="${alert }">
	<div class="auth" style="display:inline-block; margin-right: 50px; float:right;">
	<sec:authorize access="isAnonymous()">
			<a href="/guteam/member/login"><button type="button" class="btn btn-light">로그인</button></a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
			<a href="/guteam/member/profiles"><button type="button" class="btn btn-light">나의 프로필</button></a>
			<a href="/guteam/wishList/myWishList"><button type="button" class="btn btn-light">나의 위시리스트</button></a>
			<a href="/guteam/purchased/myPurchased"><button type="button" class="btn btn-light">나의 보유 게임</button></a>
			<form action="/guteam/member/logout" method="post" style="display:inline;">
			<sec:csrfInput/>
			<input type="submit" class="btn btn-light" value="로그아웃"></form>
			<br><br>
	</sec:authorize>
	</div>
	
	
	
<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
			if(result == 'success'){
				alert('회원 탈퇴가 완료되었습니다!');
			}
			else if(result == 'fail'){
				alert('요청에 실패하였습니다.');
			}
	});
</script>
</body>

</html>
