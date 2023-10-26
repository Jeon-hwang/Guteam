<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${gameVO.gameName } 리뷰</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>

<c:if test="${writedReviewId==0 }">
<a href="register?gameId=${gameVO.gameId }"><button class="btn btn-light">리뷰 쓰기</button></a>
</c:if>
<c:if test="${writedReviewId!=0 }">
<a href="update?reviewId=${writedReviewId }&page=${pageMaker.criteria.page}"><button class="btn btn-light">리뷰 수정하기</button></a>
</c:if>
<a href="../game/detail?gameId=${gameVO.gameId }&page=1"><button class="btn btn-light">게임 정보로 돌아가기</button></a>
<br>
<br>
<form action="list" method="get">
<div class="d-flex input-group mb-3" style="display: inline-block; text-align: center; width:60%; margin:auto;">
<input  class="form-control w-25" type="text" value="${keyword }" name="keyword" style="margin-right:5px;">
<input type="hidden" name="gameId" value="${gameVO.gameId }">
<input class="form-control" type="submit" value="검색">
</div>
</form>
<table class="table table-secondary table-hover">
	<thead>
		<tr>
			<th width="58px">글 번호</th>
			<th width="300px">제목</th>
			<th width="80px">작성자</th>
			<th width="150px">작성일</th>
			<th width="120px">평점</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach varStatus="status" var="reviewVO" items="${list }">
	<input type="hidden" class="url" value="detail?reviewId=${reviewVO.reviewId }&page=${pageMaker.criteria.page}&gameId=${gameVO.gameId}">
		<tr class="reviewInfo">
			<td>${reviewVO.reviewId }</td>
			<td>${reviewVO.reviewTitle }</td>
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
	</tbody>
</table>
<div class="paging">
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.hasPrev }">
			<c:if test="${empty keyword }">
			<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}">&laquo;</a></li>
			</c:if>
			<c:if test="${not empty keyword }">
			<c:if test="${not empty keywordCriteria }">
			<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&laquo;</a></li>
			</c:if>
			<c:if test="${empty keywordCriteria }">
			<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}">&laquo;</a></li>
			</c:if>
			</c:if>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<c:if test="${empty keyword }">
					<li class="page-item active"><a style="background-color:#6c757d;border-color:#e9ecef;" class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li class="page-item active"><a style="background-color:#6c757d;border-color:#e9ecef;" class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}" >${pageLink }</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li class="page-item active"><a style="background-color:#6c757d;border-color:#e9ecef;" class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}" >${pageLink }</a></li>
				</c:if>
				</c:if>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<c:if test="${empty keyword }">
					<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}" >${pageLink }</a></li>
				</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<c:if test="${empty keyword }">
			<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}">&raquo;</a></li>
			</c:if>
			<c:if test="${not empty keyword }">
			<c:if test="${not empty keywordCriteria }">
			<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&raquo;</a></li>
			</c:if>
			<c:if test="${empty keywordCriteria }">
			<li class="page-item"><a style="background-color:#e9ecef;color:black;" class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}">&raquo;</a></li>
			</c:if>
			</c:if>
		</c:if>
	</ul>
</div>
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
		
		$('.reviewInfo').on('click',function(){
			var url = $(this).prev('.url').attr('value');
			console.log(url);
			location.href=url;
		}); // reviewInfo.onclick()
	});
</script>

</body>
</html>