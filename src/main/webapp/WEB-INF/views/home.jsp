<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<c:if test="${empty sessionScope.memberId }">
		<a href="member/login"><button type="button">로그인</button></a>
	</c:if>
	
	<c:if test="${not empty sessionScope.memberId }">
		<a href="member/profiles"><button>나의 프로필</button></a>
		<a href="member/logout"><button type="button">로그아웃</button></a><br><br>
	</c:if>
</body>

</html>
