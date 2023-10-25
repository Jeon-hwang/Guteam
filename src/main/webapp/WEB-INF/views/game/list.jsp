<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
ul {
	list-style-type: none;
	text-align: center;
}

.paging li {
	display: inline-block;
	
}
.bi {
	color:#ffc100;
}
</style>
<meta charset="UTF-8">
<title>Guteam Game List</title>
</head>
<body>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<a href="register"><button>게임등록</button></a>
	</sec:authorize><jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
	<br><br><br>
	<form action="/guteam/game/list" method="get" >
		<div class="input-group mb-3" style=" display:inline-block; text-align:center;">
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
		<input type="hidden" class="keywordCriteria" name="keywordCriteria" value="keyword">
		<input class="form-control" style=" display:inline-block;width:300px; background-color: var(--bs-primary-border-subtle);" type="text" name="keyword" id="keyword" maxlength="20">
		<input class="btn btn-light form-control" style=" display:inline-block; text-align:center;width:80px;" type="submit" value="검색">
		</div>
	</form>
	
	<br>
	<c:forEach varStatus="status" var="vo" items="${list }">
	<div class="btn btn-outline-primary" style="margin:5px; width:330px; height:500px; display:inline-block; ">
		<div class="gameInfo">
		<img class="rounded mx-auto d-block" alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
		<input type="hidden" class="gameId" value="${vo.gameId }">
		<br>
		<div style="font-size: 1em;">
		name : ${vo.gameName } <br>
		price : ${vo.price }<br>
		genre : ${vo.genre }<br>
		releaseDate : <fmt:formatDate value="${vo.releaseDate }" pattern="yyyy년 MM월 dd일"/>  <br>
		rating : 
		<c:if test="${ratingList[status.index]!=0 }">
		<c:forEach begin="1" end="${ratingList[status.index]/2 }" step="1">
			<i class="bi bi-star-fill"></i>
		</c:forEach>
		<c:if test="${ratingList[status.index]%2!=0 }">
			<i class="bi bi-star-half"></i>
		</c:if>
		<c:forEach begin="1" end="${5-(ratingList[status.index]/2) }" step="1">
			<i class="bi bi-star"></i>
		</c:forEach>
		</c:if>
		</div>
		<br>
		</div>
	</div>
	</c:forEach>
	<ul class="paging">
		<c:if test="${pageMaker.hasPrev }">
			<li><a href="list?page=${pageMaker.startPageNo-1 }"><button>이전</button></a></li>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
				<c:if test="${empty keyword }">
					<li><a href="list?page=${pageLink }" style="color: green;">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li><a href="list?page=${pageLink }&keyword=${keyword}&keywordCriteria=price" style="color: green;">${pageLink }</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li><a href="list?page=${pageLink }&keyword=${keyword}" style="color: green;">${pageLink }</a></li>
				</c:if>
				</c:if>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
				<c:if test="${empty keyword }">
					<li><a href="list?page=${pageLink }">${pageLink }</a></li>
				</c:if>
				<c:if test="${not empty keyword }">
				<c:if test="${not empty keywordCriteria }">
					<li><a href="list?page=${pageLink }&keyword=${keyword}&keywordCriteria=price">${pageLink }</a></li>
				</c:if>
				<c:if test="${empty keywordCriteria }">
					<li><a href="list?page=${pageLink }&keyword=${keyword}" >${pageLink }</a></li>
				</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<li><a href="list?page=${pageMaker.endPageNo+1 }"><button>다음</button></a></li>
		</c:if>
	</ul>
	
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
			
		}); // end document.ready()
	</script>
</body>
</html>