<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<title>${vo.gameBoardTitle }</title>
</head>
<body>
	제목 : ${vo.gameBoardTitle }
	<br> 작성자 : ${vo.memberId}
	<br> 내용 : ${vo.gameBoardContent }
	<br> 작성일 : ${vo.gameBoardDateCreated }
	<br> 댓글 수 : ${vo.commentCnt }
	<br>
	<hr>
	<sec:authorize access="hasRole('USER, ADMIN')">
	<sec:authentication property="principal" var="principal"/>
	<c:if test="${principal.username==vo.memberId }">
	<a href="update?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}">
	<button>게시글 수정하기</button></a>
	<form action="updateDeleted" method="post" style="display:inline;">
		<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
		<sec:csrfInput/>
		<input type="submit" value="게시글 삭제하기">
	</form>
	</c:if>
	</sec:authorize>
	<br>
	<a href="list?gameId=${gameId }&page=${page}"><button>커뮤니티로
			돌아가기</button></a>
	<input type="hidden" id="updateResult" value="${update_result }">
	<jsp:include page="../boardComment/comment_and_reply_test.jsp" />

	<script type="text/javascript">
		$(document).ready(function() {
			var updateResult = $('#updateResult').val();
			if (updateResult == 'success') {
				alert('게시글 정보 수정 성공');
			}
			
		});// document
	</script>
</body>
</html>