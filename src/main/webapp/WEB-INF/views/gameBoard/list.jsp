<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.paging ul {
	list-style-type: none;
}

.paging li {
	display: inline-block;
}
</style>
<meta charset="UTF-8">
<title>${gameVO.gameName }커뮤니티</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
	<a href="register?gameId=${gameVO.gameId }"><button>글쓰기</button></a>
	<a href="../game/detail?gameId=${gameVO.gameId }&page=1"><button>게임
			정보로 돌아가기</button></a>
	<br>
	<br>
	<form action="list" id="search" method="get">
		<div class="input-group mb-3"
			style="display: inline-block; text-align: center;">
			<c:if test="${empty keywordCriteria}">
				<button class="btn btn-light dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">
					<span class="selectedItem">제목/내용</span>
				</button>
			</c:if>
			<c:if test="${not empty keywordCriteria}">
				<button class="btn btn-light dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">
					<span class="selectedItem">작성자</span>
				</button>
			</c:if>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item"
					onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','keyword');">제목/내용</a></li>
				<li><a class="dropdown-item"
					onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','memberId');">작성자</a></li>
			</ul>
			<input type="hidden" class="keywordCriteria" name="keywordCriteria"
				value="keyword"> <input type="hidden" name="gameId"
				value="${gameVO.gameId }"> <input type="text" name="keyword"
				value="${keyword }" maxlength="30"> <input type="submit"
				value="검색">
		</div>
	</form>
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
	<ul class="paging">
		<c:if test="${pageMaker.hasPrev }">
			<c:if test="${empty keyword }">
				<li><a
					href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}"><button>이전</button></a></li>
			</c:if>
			<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li><a
						href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}"><button>이전</button></a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li><a
						href="list?page=${pageMaker.startPageNo-1 }&gameId=${gameVO.gameId}&keyword=${keyword}"><button>이전</button></a></li>
				</c:if>
			</c:if>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<c:if test="${empty keyword }">
					<li><a href="list?page=${pageLink }&gameId=${gameVO.gameId}"
						style="color: green;">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
					<c:if test="${not empty keywordCriteria }">
						<li><a
							href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}"
							style="color: green;">${pageLink }</a></li>
					</c:if>
					<c:if test="${empty keywordCriteria }">
						<li><a
							href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}"
							style="color: green;">${pageLink }</a></li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<c:if test="${empty keyword }">
					<li><a href="list?page=${pageLink }&gameId=${gameVO.gameId}">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
					<c:if test="${not empty keywordCriteria }">
						<li><a
							href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
					</c:if>
					<c:if test="${empty keywordCriteria }">
						<li><a
							href="list?page=${pageLink }&gameId=${gameVO.gameId}&keyword=${keyword}">${pageLink }</a></li>
					</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<c:if test="${empty keyword }">
				<li><a
					href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}"><button>다음</button></a></li>
			</c:if>
			<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li><a
						href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}&keywordCriteria=${keywordCriteria}"><button>다음</button></a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li><a
						href="list?page=${pageMaker.endPageNo+1 }&gameId=${gameVO.gameId}&keyword=${keyword}"><button>다음</button></a></li>
				</c:if>
			</c:if>
		</c:if>
	</ul>

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
				location.href=url;
			}); // end gameBoardInfo.onclick()
		}); // document
	</script>

</body>
</html>