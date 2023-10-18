<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.gameBoardTitle }</title>
</head>
<body>
제목 : ${vo.gameBoardTitle }<br>
작성자 : ${vo.memberId}<br>
내용 : ${vo.gameBoardContent }<br>
작성일 : ${vo.gameBoardDateCreated }<br>
댓글 수 : ${vo.commentCnt }<br>
<hr>
<a href="update?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}"><button>게시글 수정하기</button></a>
<form action="updateDeleted" method="post">
<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
<input type="submit" value="게시글 삭제하기">
</form>
<br>
<a href="list?gameId=${gameId }&page=${page}"><button>커뮤니티로 돌아가기</button></a>
</body>
</html>