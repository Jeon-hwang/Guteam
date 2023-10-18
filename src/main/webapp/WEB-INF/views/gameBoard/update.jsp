<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.gameBoardTitle } 글 수정하기</title>
</head>
<body>
<form action="update" method="post">
<input type="hidden" name="page" value="${page }">
<input type="hidden" name="gameId" value="${gameId }">
<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
<input type="text" name="gameBoardTitle" value="${vo.gameBoardTitle }" required><br>
<textarea name="gameBoardContent" rows="50" cols="100" required>${vo.gameBoardContent }</textarea>
<br>
<input type="submit" value="수정하기">
</form>
<a href="">돌아가기</a>
제목 : ${vo.gameBoardTitle }<br>
작성자 : ${vo.memberId}<br>
내용 : ${vo.gameBoardContent }<br>
작성일 : ${vo.gameBoardDateCreated }<br>
댓글 수 : ${vo.commentCnt }<br>
</body>
</html>