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
<title>${gameVO.gameName } 커뮤니티</title>
</head>
<body>
<a href="register?gameId=${gameVO.gameId }"><button>글쓰기</button></a>
<a href="../game/detail?gameId=${gameVO.gameId }&page=1"><button>게임 정보로 돌아가기</button></a>
<br>
<br>
<form action="list" id="search" method="get">
	<input type="hidden" name="gameId" value="${gameVO.gameId }">
	<input type="text" name="keyword" value="${keyword }" maxlength="30">
	<input type="submit" value="검색">
</form>
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
	<c:forEach varStatus="status" var="gameBoardVO" items="${list }">
		<tr>
			<td>${gameBoardVO.gameBoardId }</td>
			<td><a href="detail?gameBoardId=${gameBoardVO.gameBoardId }&page=${pageMaker.criteria.page}&gameId=${gameVO.gameId}">${gameBoardVO.gameBoardTitle }</a></td>
			<td>${nicknameList[status.index] }</td>		
			<td>${gameBoardVO.gameBoardDateCreated }</td>
			<td>${gameBoardVO.commentCnt }</td>
		</tr>
	</c:forEach>

</table>
	<ul>
		<c:if test="${pageMaker.hasPrev }">
			<li><a href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}"><button>이전</button></a></li>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<li><a href="list?page=${pageLink }&gameId=${gameVO.gameId}" style="color: green;">${pageLink }</a></li>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<li><a href="list?page=${pageLink }&gameId=${gameVO.gameId}">${pageLink }</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<li><a href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}"><button>다음</button></a></li>
		</c:if>
	</ul>
	<input type="hidden" id="insertResult" value="${insert_result }">
	<input type="hidden" id="deleteResult" value="${delete_result }">
<br>
<br>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var insertResult = $('#insertResult').val();
			console.log(insertResult);
			if(insertResult=='success'){
				alert('게시글 등록 성공');
			}
			var deleteResult = $('#deleteResult').val();
			if(deleteResult=='success'){
				alert('게시글 삭제 성공');
			}
		}); // document
	</script>

</body>
</html>