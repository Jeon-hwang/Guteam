<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
</head>
<body>
<sec:authentication property="principal" var="principal"/>
<form action="register" method="post">
<sec:csrfInput/>
<input type="hidden" name="gameId" value="${gameId }">
memberId = <input type="text" name="memberId" value="${principal.username }" readonly><br>
boardTitle = <input type="text" name="gameBoardTitle" autofocus required><br>
baordContent = <textarea name="gameBoardContent" rows="50" cols="100" required></textarea><br>
<input type="submit" value="글 작성 완료하기"><br>
</form>
<a href="list?gameId=${gameId }"><button>커뮤니티로 돌아가기</button></a>
</body>
</html>