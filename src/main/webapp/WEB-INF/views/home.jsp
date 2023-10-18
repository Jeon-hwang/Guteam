<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Welcome to Guteam</title>
</head>
<body>
<form action="game/list" method="get">
<input type="text" name="keyword" id="keyword" maxlength="20">
<input type="submit" value="검색">
<a href="member/login"><input type="button" value="로그인"></a>

</form>


</body>
</html>
