<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
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
<title>리뷰 등록하기</title>
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
<h1>리뷰 작성</h1>
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
<sec:authentication property="principal" var="principal"/>
<form action="register" method="post" onsubmit="return register();">
<sec:csrfInput/>
<input type="hidden" name="gameId" value="${gameId }">
<div class="caption">
<p>${principal.username }</p>
</div>
<div class="flexable"><input type="text" id="title" class="contents" name="reviewTitle" autofocus required><div class="limitByte">&nbsp;(&nbsp;</div><div class="currentByte">0</div><div class="limitByte">/ 50 )</div></div>
<br>
<input id="rating" type="hidden" min="1" max="10" name="rating" value="1">
<div class="caption">
<p><i id="1" class="bi bi-star-half"></i>
<i id="2" class="bi bi-star"></i>
<i id="3" class="bi bi-star"></i>
<i id="4" class="bi bi-star"></i>
<i id="5" class="bi bi-star"></i></p>
</div>
<div class="flexable"><textarea id="content" class="contents" name="reviewContent" rows="20" cols="100" required style="resize:none;"></textarea><div class="limitByte">&nbsp;(&nbsp;</div><div class="currentByte">0</div><div class="limitByte">/ 1000 )</div></div><br>
<input type="submit" class="btn btn-secondary" value="글 작성 완료하기"><br>
</form>
<a href="list?gameId=${gameId }" class="btn btn-secondary">리뷰로 돌아가기</a>
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
			
			$('.contents').on('keyup', function(){
				var txt = this.innerHTML;
				if(txt==''){
					txt = $(this).val();
				}
				var limitByte=50;
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
		function register(){
			if(checkByte($('#title').val())>50){
				$('#title').focus();
				alert('제목 길이가 초과되었습니다.(현재 길이 : '+checkByte($('#title').val())+'byte, 최대 길이 : 50byte)');
				return false;
			}
			if(checkByte($('#content').val())>1000){
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