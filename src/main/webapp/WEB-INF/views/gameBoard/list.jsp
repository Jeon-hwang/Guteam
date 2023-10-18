<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
ul {
	list-style-type: none;
}

li {
	display: inline-block;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<meta charset="UTF-8">
<title>${gameId } 커뮤니티</title>
</head>
<body>
<a href="register?gameId=${gameId }"><button>글쓰기</button></a>
<table>
	<thead>
		<tr>
			<th width="58px">글 번호</th>
			<th width="300px">제목</th>
			<th width="80px">작성자</th>
			<th width="150px">작성일</th>
			<th width="58px">댓글 수</th>
		</tr>
	</thead>
	<c:forEach varStatus="status" var="vo" items="${list }">
		<tr>
			<td>${vo.gameBoardId }</td>
			<td><a href="detail?gameBoardId=${vo.gameBoardId }&page=${pageMaker.criteria.page}&gameId=${gameId}">${vo.gameBoardTitle }</a></td>
			<td>${nicknameList[status.index] }</td>		
			<td>${vo.gameBoardDateCreated }</td>
			<td>${vo.commentCnt }</td>
		</tr>
	</c:forEach>

</table>
	<ul>
		<c:if test="${pageMaker.hasPrev }">
			<li><a href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameId}"><button>이전</button></a></li>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<li><a href="list?page=${pageLink }&gameId=${gameId}" style="color: green;">${pageLink }</a></li>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<li><a href="list?page=${pageLink }&gameId=${gameId}">${pageLink }</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<li><a href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameId}"><button>다음</button></a></li>
		</c:if>
	</ul>
<br>
<br>


</body>
</html>