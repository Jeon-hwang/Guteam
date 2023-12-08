<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
.flexable{
	display:flex;
}
.flexable div{
	color:#fff;
}
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
<form action="update" method="post" onsubmit="return update();">
	<sec:csrfInput/>
	<sec:authentication property="principal" var="principal"/>
		<input type="hidden" name="reviewId" value="${reviewVO.reviewId }">
		<input type="hidden" name="gameId" value="${reviewVO.gameId }">
		<div class="caption">
		<p>${principal.username }</p>
		</div>
		<div class="flexable"><input type="text" id="title" class="contents" name="reviewTitle" value="${reviewVO.reviewTitle }" required><div class="limitByte">&nbsp;(&nbsp;</div><div class="currentByte">0</div><div class="limitByte">/ 50 )</div></div>
		<br><input id="rating" type="hidden" min="1" max="10" name="rating" value="${reviewVO.rating }">
		<div class="caption">
		<p><i id="1" class="bi bi-star-half"></i>
		<i id="2" class="bi bi-star"></i>
		<i id="3" class="bi bi-star"></i>
		<i id="4" class="bi bi-star"></i>
		<i id="5" class="bi bi-star"></i></p>
		</div>
		<div class="flexable"><p id="content" data-type="reviewContent" contenteditable="true" style="width:450px;height:450px;max-width:761px;max-height:450px; cursor: text;
      border: none; background-color:#2a3f5a; font-size:15px; color:#fff;
      display: block;overflow-y:auto;" class="contents"></p><div class="limitByte">&nbsp;(&nbsp;</div><div class="currentByte">0</div><div class="limitByte">/ 1000 )</div></div><br>
		<input type="hidden" id="reviewContent" name="reviewContent" value="${reviewVO.reviewContent }">
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
			$('#content').html($('#reviewContent').val());
			var rating = $('#rating').val();
			for(var id = 1; id <= rating/2 ; id ++){
				$('#'+id+'').attr('class','bi bi-star-fill');
			}
			for(var id = 5 ; id> rating/2 ; id--){
				$('#'+id+'').attr('class','bi bi-star');
			}
			if(rating%2==1){
				var halfStar = (parseInt(rating)+1)/2;
				$('#'+halfStar+'').attr('class','bi bi-star-half');
			}
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
			$('.contents').each(function(){
				var txt = this.innerHTML;
				if(txt==''){
					txt = $(this).val();
				}
				var currentByte = checkByte(txt);
				$(this).nextAll('.currentByte').text(currentByte);
			});
			$('.contents').on('keyup', function(){
				var limitByte=50;
				var txt = this.innerHTML;
				if(txt==''){
					txt = $(this).val();
				}
				if($(this).attr('id')=='title'){
					limitByte=50;
				}else if($(this).attr('id')=='content'){
					limitByte=1000;
				}
				var currentByte = checkByte(txt);
				$(this).nextAll('.currentByte').text(currentByte);
				if(currentByte>limitByte){
					if($('#'+$(this).attr('data-type')+'OverText').html()==null){
						var newP = document.createElement('p');
						$(newP).attr('style','color:#fff;');
						$(newP).attr('id',$(this).attr('data-type')+'OverText');
						var newText = document.createTextNode('최대 글자수를 초과하였습니다');
						newP.appendChild(newText);
						this.after(newP);			
					}
				}else{
					$('#'+$(this).attr('data-type')+'OverText').remove();
				}
			});
		});
		function update(){
			var reviewContent = $('[data-type="reviewContent"]').html().replaceAll('contenteditable="true"','');
			$('#reviewContent').attr('value',reviewContent);
			if(checkByte($('#title').val())>50){
				$('#title').focus();
				alert('제목 길이가 초과되었습니다.(현재 길이 : '+checkByte($('#title').val())+'byte, 최대 길이 : 50byte)');
				return false;
			}
			if(checkByte($('#reviewContent').val())>1000){
				$('#content').focus();
				alert('본문 길이가 초과되었습니다.(현재 길이 : '+checkByte($('#content').val())+'byte, 최대 길이 : 1000byte)');
				return false;
			}
		}
		
		function checkByte(objHTML){
			var totalByte = 0;
			for(var i = 0 ; i < objHTML.length; i++ ){
				var currentChar = objHTML.charCodeAt(i);
				if(currentChar > 128){
					totalByte+=2;
				}else{
					totalByte++;
				}
			}
			return totalByte;
		}
	</script>
</body>
</html>