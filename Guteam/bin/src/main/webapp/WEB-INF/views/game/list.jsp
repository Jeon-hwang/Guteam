<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Guteam Game List</title>
</head>
<body>
<c:forEach var="vo" items="${list }">
name : ${vo.gameName } <br>
price : ${vo.price }<br>
genre : ${vo.genre }<br>
releaseDate : ${vo.releaseDate }<br><br>
<!-- <img alt="${vo.gameName }" src=""><br> -->
</c:forEach>
</body>
</html>