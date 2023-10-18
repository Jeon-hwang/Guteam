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
		<button type="button" id="btn_login">로그인</button>
	</c:if>
	
	<c:if test="${not empty sessionScope.memberId }">
		<button type="button" id="btn_logout">로그아웃</button>
	</c:if>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#btn_login').click(function(){
				var target = encodeURI('/guteam/member/login');
				location = target;
			});
			$('#btn_logout').click(function(){
				location = '/guteam/member/logout';
			})
		}); //end document
	</script>
</body>

</html>

