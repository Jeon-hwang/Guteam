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
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
<section>
<div id="container">
	<div class="btnAdmin">
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<a href="register" class="btn btn-light">게임등록</a>
	<a href="../discount/update" class="btn btn-light">할인율 수정</a>
	</sec:authorize>
	<c:forEach var="discountVO" items="${discountList }">
	<input type="hidden" value="${discountVO.genre }" id="${discountVO.genre }">
	<input type="hidden" value="${discountVO.discountRate }" class="discountRate">
	</c:forEach>
	</div>
	<div class="formArea">
	<form id="searchGame" class="justify-content-center formSearch" action="/guteam/game/list" method="get">
		<div class="input-group mb-3 ">
		<c:if test="${empty keywordCriteria}">
		<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><span class="selectedItem">이름/장르</span></button>
		</c:if>
		<c:if test="${keywordCriteria=='keyword'}">
		<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><span class="selectedItem">이름/장르</span></button>
		</c:if>
		<c:if test="${keywordCriteria=='price'}">		
		<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><span class="selectedItem">가격</span></button>
		</c:if>
		<ul class="dropdown-menu">
			<li><a class="dropdown-item" onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','keyword');$('#keyword').attr('type','text');">이름/장르</a></li>
			<li><a class="dropdown-item" onclick="$('.selectedItem').html(this.innerText);$('.keywordCriteria').attr('value','price');$('#keyword').attr('type','number');$('#keyword').attr('min','0');">가격</a></li>
		</ul>
		<input type="hidden" id="keywordCriteria" class="keywordCriteria" name="keywordCriteria" value="${keywordCriteria }">
		<input class="form-control" type="text" name="keyword" id="keyword" maxlength="20" value="${keyword }">
		<button class="btn btn-light" id="btnSearch" type="submit"><i class="bi bi-search"></i></button>
		</div>
	</form>
	<div id="keywords" style="width:100%;"></div>
	</div>
	<div class="btnOrderGroup">
		<input type="hidden" class="orderByItem" name="orderBy" value="priceDesc">
		<button type="submit" class="btn btn-secondary orderBy">가격 <i class="bi bi-sort-numeric-down-alt"></i></button>
		<input type="hidden" class="orderByItem" name="orderBy" value="price">
		<button type="submit" class="btn btn-secondary orderBy">가격 <i class="bi bi-sort-numeric-down"></i></button>
		<input type="hidden" class="orderByItem" name="orderBy" value="purchased">
		<button type="submit" class="btn btn-secondary orderBy">구매 <i class="bi bi-sort-numeric-down-alt"></i></button>
		<input type="hidden" class="orderByItem" name="orderBy" value="wishlist">
		<button type="submit" class="btn btn-secondary orderBy">위시리스트 <i class="bi bi-sort-numeric-down-alt"></i></button>
		<input type="hidden" class="orderByItem" name="orderBy" value="rating">
		<button type="submit" class="btn btn-secondary orderBy">평점 <i class="bi bi-sort-numeric-down-alt"></i></button>
	</div>
	
	<div class="listArea">
	<c:forEach varStatus="status" var="vo" items="${gameVOList }">
	<div class="btn gameInfos">
			<div class="gameInfo">
				<div class="imgArea">
				<img class="rounded mx-auto d-block" alt="${vo.gameName }"
					width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
				</div>
				<div class="videoArea" style="display:none;">
				<video class="rounded mx-auto d-block" width="300px" height="300px" autoplay muted loop>
				<source src="/video/${vo.gameId }.mp4">
				</video>
				</div>
				<input type="hidden" class="gameId" value="${vo.gameId }"><br>
				<div class="info">
					<h6>${vo.gameName }</h6> <p class="${vo.genre }">₩ ${vo.price }</p>
					<p>${vo.genre }</p>
					<p>
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
					</p>
				</div>
				<br>
			</div>
		</div>
	</c:forEach>
	</div>
	<div class="paging">
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.hasPrev }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.startPageNo-1 }&keyword=${keyword}&keywordCriteria=${keywordCriteria}&orderBy=${orderBy}">&laquo;</a></li>
		</c:if>
		<c:forEach var="pageLink" begin="${pageMaker.startPageNo }"
			end="${pageMaker.endPageNo }">
			<c:if test="${pageMaker.criteria.page==pageLink }">
					<li class="page-item active"><a class="page-link" href="list?page=${pageLink }&keyword=${keyword}&keywordCriteria=${keywordCriteria}&orderBy=${orderBy}">${pageLink }</a></li>
			</c:if>
			<c:if test="${pageMaker.criteria.page!=pageLink }">
					<li class="page-item"><a class="page-link" href="list?page=${pageLink }&keyword=${keyword}&keywordCriteria=${keywordCriteria}&orderBy=${orderBy}">${pageLink }</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pageMaker.hasNext }">
			<li class="page-item"><a class="page-link" href="list?page=${pageMaker.endPageNo+1 }&keyword=${keyword}&keywordCriteria=${keywordCriteria}">&raquo;</a></li>
		</c:if>
	</ul>
	</div>
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<input type="hidden" id="insertResult" value="${insert_result }">
	<input type="hidden" id="discountResult" value="${discount_result }">
	<script type="text/javascript">
		$(document).ready(function(){
			var selectedItem = $('.selectedItem').html();
			if(selectedItem=='가격'){
				$('#keywordCriteria').attr('value','price');
				$('#keyword').attr('type','number');
				$('#keyword').attr('min','0');
			}else{
				$('#keywordCriteria').attr('value','keyword');
			}
			
			var insertResult = $('#insertResult').val();
			if(insertResult=='success'){
				alert('게임 등록 성공!');
			} 
			var discountResult = $('#discountResult').val();
			if(discountResult=='success'){
				alert('할인 수정 성공!');
			}
			
			$('.gameInfos').on('click', function(){
				var gameId = $(this).find("input").val();
				var prevListUrl = window.location.href.substr(window.location.href.lastIndexOf('/')+1);
				prevListUrl = encodeURIComponent(prevListUrl);
				var url = "detail?gameId="+gameId+"&prevListUrl="+prevListUrl;
				location.href=url;
			}); // end gameInfo.onclick()
			
			$('.gameInfos').on({
				mouseenter: function(){
					var gameId = $(this).find('.gameId').val();
					console.log(gameId);
					$(this).find('.videoArea').attr('style','display:block;');
					$(this).find('.imgArea').attr('style','display:none;');
				},
				mouseleave: function(){
					$(this).find('.videoArea').attr('style','display:none;');
					$(this).find('.imgArea').attr('style','display:block;');
				}
			}); // end gameInfo.onhover()
			
			$('.orderBy').on('click', function(){
				var orderBy = $(this).prev('.orderByItem').attr('value');
				var keyword = $('#keyword').attr('value');
				var keywordCriteria = $('#keywordCriteria').attr('value');
				var queryString = 'keyword='+keyword+'&keywordCriteria='+keywordCriteria+'&orderBy='+orderBy;
				console.log(queryString);	
				var url = 'list?'+queryString;
				location.href=url;
			}); // orderBy.onclick()
			
			$('#keyword').on('keyup', function(){
				var keyword = $(this).val();
				var pattern = /([^0-9a-zA-Z가-힣\x20])/i;		
				if(pattern.test(keyword)||keyword==''){
					$('#keywords').html('');
				}else{
					var url = '/guteam/game/'+keyword;
					$.getJSON(
						url,
						function(data){
							if(data!=''){							
								$('#keywords').html('<span style="color:#fff;">추천 검색어 : </span> &nbsp;&nbsp;');
								$(data).each(function(){
									var keywords = $('#keywords').html();
									keywords += '<span style="color:#fff;cursor:pointer;" class="keywords" onclick="changeKeyword(this);">'+this+'</span> &nbsp;&nbsp;';
									$('#keywords').html(keywords);
								});
							}
						}
					);
				}
			});
			function checkDiscountGenre(){
				var discountRateList = $('html').find('.discountRate');
				var discountGenreList = $('html').find('.discountRate').prev();
				$(discountGenreList).each(function(index){
					var discountGenre = $(this).val();
					var discountRate = $(discountRateList[index]).val();
					console.log(discountGenre+','+discountRate);
					$('.'+discountGenre+'').attr('style','color:#b9ee1a;margin-bottom:5px;');
					$('.'+discountGenre+'').append('<p style="background:#4c6b22;width:50px;text-align:center;margin:auto;margin-bottom:5px;">-'+discountRate*100+'%</p>');
				});
			}
			checkDiscountGenre();
		}); // end document.ready()
		function changeKeyword(keyword){
			var keyword = $(keyword).text();
			$('#keyword').val(keyword);
			$('#searchGame').submit();
		}
	</script>
	
	
</body>
</html>