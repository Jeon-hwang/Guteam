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
	<form action="game/list" method="get">
		<input type="text" name="keyword" id="keyword" maxlength="20">
		<input type="submit" value="검색">
	</form>
	<sec:authorize access="isAnonymous()">
			<a href="member/login"><button type="button">로그인</button></a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
			<a href="member/profiles"><button>나의 프로필</button></a>
			<form action="member/logout" method="post" style="display:inline;">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
			<input type="submit" value="로그아웃"></form>
			<a href="wishList/myWishList"><button>나의 위시리스트</button></a>
			<a href="wishList/myWishList"><button>나의 보유 게임</button></a><br><br>
	</sec:authorize>
	
	
	

</body>

</html>
