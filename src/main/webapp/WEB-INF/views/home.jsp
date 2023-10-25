<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Guteam</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<input type="hidden" id="alert" value="${alert }">
	<div class="auth" style="display:inline-block; margin-right: 50px; float:right;">
	<sec:authorize access="isAnonymous()">
			<a href="/guteam/member/login"><button type="button">로그인</button></a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
			<a href="/guteam/member/profiles"><button>나의 프로필</button></a>
			<a href="/guteam/wishList/myWishList"><button>나의 위시리스트</button></a>
			<a href="/guteam/wishList/myWishList"><button>나의 보유 게임</button></a>
			<form action="/guteam/member/logout" method="post" style="display:inline;">
			<sec:csrfInput/>
			<input type="submit" value="로그아웃"></form>
			<br><br>
	</sec:authorize>
	</div>
	<br><br><br>
	<form action="/guteam/game/list" method="get" style=" display:block; text-align:center;">
		<input style="width:300px;" type="text" name="keyword" id="keyword" maxlength="20">
		<input type="submit" value="검색">
	</form>
	
	
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
