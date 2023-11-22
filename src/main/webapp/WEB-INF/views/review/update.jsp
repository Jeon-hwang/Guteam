<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
.caption .bi {
	color:#ffc100;
	cursor:pointer;
}
</style>
<meta charset="UTF-8">
<title>리뷰 수정 페이지</title>
</head>
<body>
<header>
<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
</header>
<section>
<div id="wrap">
<div class="titleArea">
<h1>리뷰 수정</h1>
</div>
<div class="formArea">
<div class="info">
<div class="caption">
<p>memberId = </p>
<p>reviewTitle = </p>
<p>rating = </p>
<p>reviewContent = </p>
</div>
<div class="inputArea">
<form action="update" method="post">
	<sec:csrfInput/>
	<sec:authentication property="principal" var="principal"/>
		<input type="hidden" name="reviewId" value="${reviewVO.reviewId }">
		<input type="hidden" name="gameId" value="${reviewVO.gameId }">
		<div class="caption">
		<p>${principal.username }</p>
		</div>
		<input type="text" name="reviewTitle" value="${reviewVO.reviewTitle }" required><br>
		<input id="rating" type="hidden" min="1" max="10" name="rating" value="${reviewVO.rating }">
		<div class="caption">
		<p><i id="1" class="bi bi-star-half"></i>
		<i id="2" class="bi bi-star"></i>
		<i id="3" class="bi bi-star"></i>
		<i id="4" class="bi bi-star"></i>
		<i id="5" class="bi bi-star"></i></p>
		</div>
		<textarea name="reviewContent" rows="20" cols="100" required>${reviewVO.reviewContent }</textarea>
		<input type="hidden" name="page" value="${page }"><br>
		<input type="submit" class="btn btn-secondary" value="글 수정 완료하기">
	</form>
	<a href="list?gameId=${reviewVO.gameId }&page=${page}" class="btn btn-secondary">커뮤니티로 돌아가기</a>
</div>
</div>
</div>	
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.bi').on('click',function(e){
				var x = e.clientX-e.currentTarget.offsetLeft;
				if(x<8){
					var num = $(this).attr('id');
					for(var id = 1; id < num ; id ++){
						$('#'+id+'').attr('class','bi bi-star-fill');
					}
					$(this).attr('class','bi bi-star-half');
					for(var id = 5; id>num; id--){
						$('#'+id+'').attr('class','bi bi-star');
					}
					$('#rating').attr('value',num*2-1);
				}else{
					var num = $(this).attr('id');
					for(var id = 1; id <= num ; id ++){
						$('#'+id+'').attr('class','bi bi-star-fill');
					}
					for(var id = 5; id>num; id--){
						$('#'+id+'').attr('class','bi bi-star');
					}
					$('#rating').attr('value',num*2);
				}
			});
			
		});
	</script>
</body>
</html>