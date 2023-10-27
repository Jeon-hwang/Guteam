<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<meta charset="UTF-8">
<title>${vo.gameBoardTitle } 글 수정하기</title>
</head>
<body>
<sec:authentication property="principal" var="principal"/>
<form action="update" method="post">
<sec:csrfInput/>
<input type="hidden" name="page" value="${page }">
<input type="hidden" name="gameId" value="${gameId }">
<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
제목 : <input type="text" name="gameBoardTitle" value="${vo.gameBoardTitle }" required><br>
작성자 : <input type="text" value="${principal.username }" readonly> <br>
내용 : <textarea name="gameBoardContent" rows="50" cols="100" required>${vo.gameBoardContent }</textarea>
<br>
<input style="inline-block;" type="submit" value="수정하기">
</form>
<a href="detail?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}"><button>돌아가기</button></a>
</body>
</html>