<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<style type="text/css">
.bi {
	color:#ffc100;
}
</style>
<head>
<meta charset="UTF-8">
<title>${gameVO.gameName } 리뷰</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<a href="register?gameId=${gameVO.gameId }"><button>글쓰기</button></a>
<a href="../game/detail?gameId=${gameVO.gameId }&page=1"><button>게임 정보로 돌아가기</button></a>
<br>
<br>
<table>
	<thead>
		<tr>
			<th width="58px">글 번호</th>
			<th width="300px">제목</th>
			<th width="80px">작성자</th>
			<th width="150px">작성일</th>
			<th width="120px">평점</th>
		</tr>
	</thead>
	<c:forEach varStatus="status" var="reviewVO" items="${list }">
		<tr>
			<td>${reviewVO.reviewId }</td>
			<td><a href="detail?reviewId=${reviewVO.reviewId }&page=${pageMaker.criteria.page}&gameId=${gameVO.gameId}">${reviewVO.reviewTitle }</a></td>
			<td>${nicknameList[status.index] }</td>		
			<td>${reviewVO.reviewDateCreated }</td>
			<td>
				<c:forEach begin="1" end="${reviewVO.rating/2 }" step="1">
				<i class="bi bi-star-fill"></i>
				</c:forEach>
				<c:if test="${reviewVO.rating%2!=0 }">
				<i class="bi bi-star-half"></i>
				</c:if>
				<c:forEach begin="1" end="${5-(reviewVO.rating/2) }" step="1">
				<i class="bi bi-star"></i>
				</c:forEach>
			</td>
		</tr>
	</c:forEach>
</table>
<input type="hidden" id="insertResult" value="${insert_result }">  
<input type="hidden" id="deleteResult" value="${delete_result }">
<script type="text/javascript">
	$(document).ready(function(){
		var insertResult = $('#insertResult').val();
		if(insertResult=='success'){
			alert('리뷰 등록 성공');
		}
		var deleteResult = $('#deleteResult').val();
		if(deleteResult=='success'){
			alert('리뷰 삭제 성공');
		}
		
	});
</script>

</body>
</html>