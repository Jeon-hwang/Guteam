<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${gameVO.gameName }커뮤니티</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
	<a href="register?gameId=${gameVO.gameId }"><button	class="btn btn-light">글쓰기</button></a>
	<a href="../game/detail?gameId=${gameVO.gameId }&page=1"><button class="btn btn-light">게임 정보로 돌아가기</button></a>
	<br>
	<br>
	<form action="list" id="search" method="get">
		<div class="d-flex input-group mb-3" style="display: inline-block; text-align: center; width:60%; margin:auto;">
			<c:if test="${empty keywordCriteria}">
				<button class="btn btn-light dropdown-toggle" type="button"	data-bs-toggle="dropdown" aria-expanded="false" style="margin-right:4px;">
					<span class="selectedItem">제목/내용</span>
				</button>
			</c:if>
			<c:if test="${not empty keywordCriteria}">
				<button class="btn btn-light dropdown-toggle" type="button"	data-bs-toggle="dropdown" aria-expanded="false" style="margin-right:4px;">
					<span class="selectedItem">작성자</span>
				</button>
			</c:if>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item"
					onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','keyword');">
					제목/내용</a></li>
				<li><a class="dropdown-item"
					onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','memberId');">
					작성자</a></li>
			</ul>
			<input type="hidden" id="keywordCriteria" class="keywordCriteria" name="keywordCriteria" value="keyword"> 
			<input type="hidden" id="gameId" name="gameId" value="${gameVO.gameId }"> 
			<input class="form-control w-25" type="text" id="keyword" name="keyword" value="${keyword }" maxlength="30" style="margin-right:4px;"> 
			<input class="btn btn-light form-control" type="submit" value="검색">
		</div>
	</form>
	<div class="btnOrderGroup">
	<input type="hidden" class="orderByItem" name="orderBy" value="commentCnt">
	<input type="submit" class="orderBy" value="댓글수↑">
	</div>
	<table class="table table-secondary table-hover">
		<thead>
			<tr>
				<th width="58px">글 번호</th>
				<th width="300px">제목</th>
				<th width="180px">작성자</th>
				<th width="150px">작성일</th>
				<th width="58px">댓글 수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach varStatus="status" var="gameBoardVO" items="${list }">
				<input type="hidden" class="url"
					value="detail?gameBoardId=${gameBoardVO.gameBoardId }&page=${pageMaker.criteria.page}&gameId=${gameVO.gameId}">
				<tr class="gameBoardInfo">
					<td>${gameBoardVO.gameBoardId }</td>
					<td>${gameBoardVO.gameBoardTitle }</td>
					<td>${nicknameList[status.index] }</td>
					<td><fmt:formatDate
							value="${gameBoardVO.gameBoardDateCreated }"
							pattern="yyyy년 MM월 dd일" /></td>
					<td>${gameBoardVO.commentCnt }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="paging">
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.hasPrev }">
			<c:if test="${empty keyword }">
				<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}">&laquo;</a></li>
			</c:if>
			<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&laquo;</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}">&laquo;</a></li>
				</c:if>
			</c:if>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<c:if test="${empty keyword }">
					<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
					<c:if test="${not empty keywordCriteria }">
						<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
					</c:if>
					<c:if test="${empty keywordCriteria }">
						<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}">${pageLink }</a></li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<c:if test="${empty keyword }">
					<li class="page-item"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
					<c:if test="${not empty keywordCriteria }">
						<li class="page-item"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
					</c:if>
					<c:if test="${empty keywordCriteria }">
						<li class="page-item"><a class="page-link" href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}">${pageLink }</a></li>
					</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<c:if test="${empty keyword }">
				<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}">&raquo;</a></li>
			</c:if>
			<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&raquo;</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}"><button>&raquo;</button></a></li>
				</c:if>
			</c:if>
		</c:if>
	</ul>
	</div>
	<input type="hidden" id="insertResult" value="${insert_result }">
	<input type="hidden" id="deleteResult" value="${delete_result }">
	<br>
	<br>

	<script type="text/javascript">
		$(document).ready(function() {
			var insertResult = $('#insertResult').val();
			console.log(insertResult);
			if (insertResult == 'success') {
				alert('게시글 등록 성공');
			}
			var deleteResult = $('#deleteResult').val();
			if (deleteResult == 'success') {
				alert('게시글 삭제 성공');
			}

			var selectedItem = $('.selectedItem').text();
			if (selectedItem == '작성자') {
				$('.keywordCriteria').attr('value', 'memberId');
			}

			$('.gameBoardInfo').on('click', function() {
				var url = $(this).prev('.url').attr('value');
				console.log(url);
				location.href = url;
			}); // end gameBoardInfo.onclick()
			
			$('.orderBy').on('click', function(){
				var gameId = $('#gameId').attr('value');
				var orderBy = $(this).prev('.orderByItem').attr('value');
				var keyword = $('#keyword').attr('value');
				var keywordCriteria = $('#keywordCriteria').attr('value');
				var queryString = 'gameId='+gameId+'&orderBy='+orderBy+'&keyword='+keyword+'&keywordCriteria='+keywordCriteria;
				console.log(queryString);	
				var url = 'list?'+queryString;
				location.href=url;
			}); // orderBy.onclick()
		}); // document
	</script>

</body>
</html>