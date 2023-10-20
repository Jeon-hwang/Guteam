<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 페이지</title>
</head>
<body>
	<form action="update" method="post">
		<input type="hidden" name="reviewId" value="${reviewVO.reviewId }">
		<input type="hidden" name="gameId" value="${reviewVO.gameId }">
		memberId = <input type="text" name="memberId" value="${sessionScope.memberId }test" readonly><br>
		reviewTitle = <input type="text" name="reviewTitle" value="${reviewVO.reviewTitle }" required><br>
		rating = <input type="number" min="0" max="10" name="rating" value="${reviewVO.rating }" required><br>
		reviewContent =	<textarea name="reviewContent" rows="50" cols="100" required>${reviewVO.reviewContent }</textarea>
		<input type="hidden" name="page" value="${page }">
		<br> <input type="submit" value="글 수정 완료하기"><br>
	</form>
	<a href="list?gameId=${gameId }&page=${page}"><button>커뮤니티로 돌아가기</button></a>
</body>
</html>