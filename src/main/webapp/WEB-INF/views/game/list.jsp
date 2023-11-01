<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Guteam Game List</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<div id="container">
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<a href="register"><button class="btn btn-light">게임등록</button></a>
	</sec:authorize>
	<br><br><br>
	<form class="justify-content-center formSearch" action="/guteam/game/list" method="get">
		<div class="input-group mb-3 ">
		<c:if test="${empty keywordCriteria}">
		<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><span class="selectedItem">이름/장르</span></button>
		</c:if>
		<c:if test="${not empty keywordCriteria}">		
		<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><span class="selectedItem">가격</span></button>
		</c:if>
		<ul class="dropdown-menu">
			<li><a class="dropdown-item" onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','keyword');$('#keyword').attr('type','text');">이름/장르</a></li>
			<li><a class="dropdown-item" onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','price');$('#keyword').attr('type','number');$('#keyword').attr('min','0');">가격</a></li>
		</ul>
		<input type="hidden" id="keywordCriteria" class="keywordCriteria" name="keywordCriteria" value="keyword">
		<input class="form-control" type="text" name="keyword" id="keyword" maxlength="20" value="${keyword }">
		<input class="btn btn-light" id="btnSearch" type="submit" value="검색">
		</div>
	</form>
	<div class="btnOrderGroup">
		<input type="hidden" class="orderByItem" name="orderBy" value="priceDesc">
		<input type="submit" class="orderBy" value="가격↑">
		<input type="hidden" class="orderByItem" name="orderBy" value="price">
		<input type="submit" class="orderBy" value="가격↓">
		<input type="hidden" class="orderByItem" name="orderBy" value="purchased">
		<input type="submit" class="orderBy" value="구매순↑">
		<input type="hidden" class="orderByItem" name="orderBy" value="wishlist">
		<input type="submit" class="orderBy" value="위시리스트순↑">
	</div>
	
	<c:forEach varStatus="status" var="vo" items="${gameVOList }">
	<div class="btn btn-secondary" id="gameInfos">
			<div class="gameInfo">
				<img class="rounded mx-auto d-block" alt="${vo.gameName }"
					width="300px" height="300px"
					src="display?fileName=${vo.gameImageName }"> <input
					type="hidden" class="gameId" value="${vo.gameId }"> <br>
				<div class="info">
					name : ${vo.gameName } <br> price : ${vo.price }<br>
					genre : ${vo.genre }<br> releaseDate :
					<fmt:formatDate value="${vo.releaseDate }" pattern="yyyy년 MM월 dd일" />
					<br> rating :
					<c:if test="${ratingList[status.index]!=0 }">
						<c:forEach begin="1" end="${ratingList[status.index]/2 }" step="1">
							<i class="bi bi-star-fill"></i>
						</c:forEach>
						<c:if test="${ratingList[status.index]%2!=0 }">
							<i class="bi bi-star-half"></i>
						</c:if>
						<c:forEach begin="1" end="${5-(ratingList[status.index]/2) }"
							step="1">
							<i class="bi bi-star"></i>
						</c:forEach>
					</c:if>
				</div>
				<br>
			</div>
		</div>
	</c:forEach>
	<div class="paging">
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.hasPrev }">
			<c:if test="${empty keyword }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }">&laquo;</a></li>
			</c:if>
			<c:if test="${not empty keyword }">
			<c:if test="${not empty keywordCriteria }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&laquo;</a></li>
			</c:if>
			<c:if test="${empty keywordCriteria }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&keyword=${keyword}">&laquo;</a></li>
			</c:if>
			</c:if>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<c:if test="${empty keyword }">
					<li class="page-item active"><a class="page-link" href="list?page=${pageLink }">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&keyword=${keyword}" >${pageLink }</a></li>
				</c:if>
				</c:if>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<c:if test="${empty keyword }">
					<li class="page-item"><a class="page-link" href="list?page=${pageLink }">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li class="page-item"><a class="page-link" href="list?page=${pageLink }&keyword=${keyword}&keywordCriteria=${keywordCriteria}">${pageLink }</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li class="page-item"><a class="page-link" href="list?page=${pageLink }&keyword=${keyword}" >${pageLink }</a></li>
				</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<c:if test="${empty keyword }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }">&raquo;</a></li>
			</c:if>
			<c:if test="${not empty keyword }">
			<c:if test="${not empty keywordCriteria }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&raquo;</a></li>
			</c:if>
			<c:if test="${empty keywordCriteria }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&keyword=${keyword}">&raquo;</a></li>
			</c:if>
			</c:if>
		</c:if>
	</ul>
	</div>
	<input type="hidden" id="insertResult" value="${insert_result }">
	<script type="text/javascript">
		$(document).ready(function(){
			var selectedItem = $('.selectedItem').html();
			if(selectedItem=='가격'){
				$('.keywordCriteria').attr('value','price');
				$('#keyword').attr('type','number');
				$('#keyword').attr('min','0');
			}
			
			var insertResult = $('#insertResult').val();
			if(insertResult=='success'){
				alert('게임 등록 성공!');
			} 
			
			$('.gameInfo').on('click', function(){
				var gameId = $(this).find("input").val();
				console.log(gameId);
				var prevListUrl = window.location.href;
				var keyword = $('#keyword').val();
				var url = "detail?gameId="+gameId+"&prevListUrl="+prevListUrl;
				location.href=url;
			}); // end gameInfo.onclick()
			
			$('.orderBy').on('click', function(){
				var orderBy = $(this).prev('.orderByItem').attr('value');
				var keyword = $('#keyword').attr('value');
				var keywordCriteria = $('#keywordCriteria').attr('value');
				var queryString = 'orderBy='+orderBy+'&keyword='+keyword+'&keywordCriteria='+keywordCriteria;
				console.log(queryString);	
				var url = 'list?'+queryString;
				location.href=url;
			}); // orderBy.onclick()
			
		}); // end document.ready()
	</script>
	</div>
	
</body>
</html>