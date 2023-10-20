<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 등록하기</title>
</head>
<body>
<form action="register" method="post">
<input type="hidden" name="gameId" value="${gameId }">
memberId = <input type="text" name="memberId" value="${sessionScope.memberId }test" readonly><br>
reviewTitle = <input type="text" name="reviewTitle" autofocus required><br>
rating = <input type="number" min="0" max="10" name="rating" value="5" required><br>
reviewContent = <textarea name="reviewContent" rows="50" cols="100" required></textarea><br>
<input type="submit" value="글 작성 완료하기"><br>
</form>
<a href="list?gameId=${gameId }"><button>커뮤니티로 돌아가기</button></a>
</body>
</html>