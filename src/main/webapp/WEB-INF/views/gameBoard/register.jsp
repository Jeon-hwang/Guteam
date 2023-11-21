<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<meta charset="UTF-8">
<title>글 작성</title>
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
<h1>게시글 작성</h1>
</div>
<sec:authentication property="principal" var="principal"/>
<div class="formArea">
<div class="info">
<div class="caption">
<p>memberId = </p>
<p>boardTitle = </p>
<p>baordContent = </p>
</div>
<div class="inputArea">
<form action="register" method="post">
<input type="hidden" name="gameId" value="${gameId }">
<input type="text" name="memberId" value="${principal.username }" readonly><br>
<input type="text" class="banedDeleted" name="gameBoardTitle" autofocus required ><br>
<textarea name="gameBoardContent" class="banedDeleted" rows="20" cols="100" required></textarea><br>
<sec:csrfInput/>
<input type="submit" class="btn btn-secondary" value="글 작성 완료하기"><br>
</form>
<a class="btn btn-secondary" href="list?gameId=${gameId }">커뮤니티로 돌아가기</a>
</div>
</div>
</div>
</div>
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
	var deleted = '삭제된 게시글';
	$(document).ready(function(){
		$('.banedDeleted').on('focusout', function(){
			var text = $(this).val();
			if(text.length > 0) {
				if(text.match(deleted)){
					text = text.replace(deleted,"");
				}
				$(this).val(text);
			}
		}).on('keyup',function(){
			$(this).val($(this).val().replace(deleted,""));
		}); // end banedDeleted.onFocusout(); // end banedDeleted.onKeyup();
	}); // end document.ready()
</script>
</body>
</html>