<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${gameVO.gameName } 리뷰</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
<section>
<div id="wrap">
<c:if test="${purchased==1 }">
<c:if test="${writedReviewId==0 }">
<a href="register?gameId=${gameVO.gameId }"><button class="btn btn-light">리뷰 쓰기</button></a>
</c:if>
<c:if test="${writedReviewId!=0 }">
<a href="update?reviewId=${writedReviewId }&page=${pageMaker.criteria.page}"><button class="btn btn-light">리뷰 수정하기</button></a>
</c:if>
</c:if>
<a href="../game/detail?gameId=${gameVO.gameId }&page=1"><button class="btn btn-light">게임 정보로 돌아가기</button></a>
<br>
<br>
<form class="justify-content-center formSearch" action="list" method="get">
<div class="input-group mb-3">
<input class="form-control" id="keyword" type="text" value="${param.keyword }" name="keyword">
<input type="hidden" id="gameId" name="gameId" value="${gameVO.gameId }">
<button class="btn btn-light" id="btnSearch" type="submit"><i class="bi bi-search"></i></button>
</div>
</form>
<div class="btnOrderGroup">
<input type="hidden" class="orderByItem" name="orderBy" value="thumbUpCnt">
<button type="submit" class="btn btn-secondary orderBy">추천수<i class="bi bi-sort-numeric-down-alt"></i></button>
</div>
<table class="table table-secondary table-hover">
	<thead>
		<tr>
			<th width="58px">글 번호</th>
			<th width="300px">제목</th>
			<th width="80px">작성자</th>
			<th width="150px">작성일</th>
			<th width="120px">평점</th>
			<th width="50px">추천수</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach varStatus="status" var="reviewVO" items="${reviewList }">
	<input type="hidden" class="url" value="detail?reviewId=${reviewVO.reviewId }&page=${pageMaker.criteria.page}&gameId=${gameVO.gameId}">
		<tr class="reviewInfo">
			<td>${reviewVO.reviewId }</td>
			<td>${reviewVO.reviewTitle }</td>
			<td>${nicknameList[status.index] }</td>		
			<td><fmt:formatDate	value="${reviewVO.reviewDateCreated }" pattern="yyyy년 MM월 dd일" /></td>
			<td>
				<c:forEach begin="1" end="${reviewVO.rating/2 }" step="1">
				<i class="bi bi-star-fill"></i>
				</c:forEach>
				<c:if test="${reviewVO.rating%2==1 }">
				<i class="bi bi-star-half"></i>
				</c:if>
				<c:forEach begin="1" end="${5-(reviewVO.rating/2) }" step="1">
				<i class="bi bi-star"></i>
				</c:forEach>
			</td>
			<td>${reviewVO.thumbUpCount }</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="paging">
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.hasPrev }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&laquo;</a></li>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}" >${pageLink }</a></li>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<li class="page-item"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&raquo;</a></li>
		</c:if>
	</ul>
</div>
<input type="hidden" id="insertResult" value="${insert_result }">  
<input type="hidden" id="deleteResult" value="${delete_result }">
</div>
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
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
		$('.reviewInfo').on('click',function(){
			var url = $(this).prev('.url').attr('value');
			console.log(url);
			location.href=url;
		}); // reviewInfo.onclick()
		
		$('.orderBy').on('click', function(){
			var gameId = $('#gameId').attr('value');
			var orderBy = $(this).prev('.orderByItem').attr('value');
			var keyword = $('#keyword').attr('value');
			var queryString = 'gameId='+gameId+'&orderBy='+orderBy+'&keyword='+keyword;
			console.log(queryString);	
			var url = 'list?'+queryString;
			location.href=url;
		}); // orderBy.onclick()
	});
</script>

</body>
</html>