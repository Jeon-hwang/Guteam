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
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
	제목 : ${vo.gameBoardTitle }
	<br> 작성자 : ${nickname}
	<br> 내용 : ${vo.gameBoardContent }
	<br> 작성일 : ${vo.gameBoardDateCreated }
	<br> 댓글 수 : ${vo.commentCnt }
	<br>
	<hr>
	<div class="btn_group_detail">
	<sec:authentication property="principal" var="principal"/>
	<sec:authorize access="isAuthenticated()">
	<c:if test="${vo.gameBoardTitle!='삭제된 게시글 입니다' }">
	<c:if test="${principal.username==vo.memberId }">
	<a href="update?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}">
	<button class="btn btn-light" >게시글 수정하기</button></a>
	<form class="inline-form" action="updateDeleted" method="post">
		<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
		<sec:csrfInput/>
		<input type="submit" class="btn btn-light"  value="게시글 삭제하기">
	</form>
	</c:if>
	</c:if>
	</sec:authorize>
	</div>
	<div class="btn_group_detail">
	<br>
	<a href="list?gameId=${gameId }&page=${page}"><button class="btn btn-light" >커뮤니티로 돌아가기</button></a>
	</div>
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