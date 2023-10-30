<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<jsp:include page="style.jsp"></jsp:include>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>Welcome to Guteam</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<input type="hidden" id="alert" value="${alert }">
	<div class="auth" style="display:inline-block; margin-right: 50px; float:right;">
	<sec:authorize access="isAnonymous()">
			<a href="/guteam/member/login?targetURL=" id="btnLogin"><button type="button" class="btn btn-light">로그인</button></a>
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
		console.log(location.href);
		var btnLogin = $('#btnLogin').attr('href');
		$('#btnLogin').attr('href', btnLogin+location.href);
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
