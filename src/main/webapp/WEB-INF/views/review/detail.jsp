<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${reviewVO.reviewTitle }</title>
</head>
<body>
제목 : ${reviewVO.reviewTitle }<br>
작성자 : ${reviewVO.memberId }<br>
작성일 : ${reviewVO.reviewDateCreated}<br>
평점 : ${reviewVO.rating}<br>
내용 : ${reviewVO.reviewContent }<br>
추천 수 : ${reviewVO.thumbUpCount }<br>
<a href="update?reviewId=${reviewVO.reviewId }"><button>수정</button></a><form style="display:inline-block;" action="delete" method="post"><input type="hidden" name="reviewId" value="${reviewVO.reviewId }"><input type="hidden" name="gameId" value="${gameVO.gameId }"><input type="submit" value="삭제"></form><br>
<button>추천/취소하기</button>
<a href="list?gameId=${reviewVO.gameId }"><button>${gameVO.gameName } 리뷰 목록으로 돌아가기</button></a>

</body>
</html>