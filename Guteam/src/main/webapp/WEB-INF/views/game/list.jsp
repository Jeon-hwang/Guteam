<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<style type="text/css">
ul {
	list-style-type: none;
}

li {
	display: inline-block;
}
</style>
<meta charset="UTF-8">
<title>Guteam Game List</title>
</head>
<body>
	<a href="register"><button>게임등록</button></a>
	<br>
	<input type="hidden" id="page" value="${pageMaker.criteria.page }">
	<c:forEach var="vo" items="${list }">
	<div class="gameInfo" style="display:inline-block;">
		<img alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
		<input type="hidden" class="gameId" value="${vo.gameId }">
		<br>
		name : ${vo.gameName } <br>
		price : ${vo.price }<br>
		genre : ${vo.genre }<br>
		releaseDate : ${vo.releaseDate }<br>
		<br>
		<!-- <img alt="${vo.gameName }" src=""><br> -->
	</div>
	</c:forEach>
	<ul>
		<c:if test="${pageMaker.hasPrev }">
			<li><a href="list?page=${pageMaker.startPageNo-1 }"><button>이전</button></a></li>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<li><a href="list?page=${pageLink }" style="color: green;">${pageLink }</a></li>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<li><a href="list?page=${pageLink }">${pageLink }</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<li><a href="list?page=${pageMaker.endPageNo+1 }"><button>다음</button></a></li>
		</c:if>
	</ul>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.gameInfo').on('click',  function(){
				var gameId = $(this).find("input").val();
				var page = $('#page').val();
				var url = "detail?gameId="+gameId+"&page="+page;
				location.href=url;
			});
		}); // document
	</script>
</body>
</html>