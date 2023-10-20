<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.gameName }</title>
</head>
<body>
<div class="category">
<a href="list">All Games</a> > <a href="list?keyword=${vo.genre }">${vo.genre }</a>
</div>
<img alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
<br>
게임 이름 : ${vo.gameName }
<br>
가격 : ${vo.price }
<br>
장르 : ${vo.genre }
<br>
출시일 : ${vo.releaseDate }
<br>
마지막 업데이트일 : ${vo.updateDate }
<br>
평점 : ${rating } 점
<hr>
<br>
<a href="update?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button>수정하기</button></a>
<br>
<a href="../gameBoard/list?gameId=${vo.gameId }"><button>${vo.gameName } 커뮤니티</button></a>
<br>
<a href="../review/list?gameId=${vo.gameId }"><button>리뷰보기</button></a>
<br>
<a href="${prevListUrl}"><button>리스트로 돌아가기</button></a>
</body>

</html>