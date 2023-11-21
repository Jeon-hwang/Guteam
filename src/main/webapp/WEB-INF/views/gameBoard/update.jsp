<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<meta charset="UTF-8">
<title>${vo.gameBoardTitle } 글 수정하기</title>
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
<h1>게시글 수정</h1>
</div>
<div class="formArea">
<div class="info">
<div class="caption">
<p>제목 : </p>
<p>작성자 : </p>
<p>내용 : </p>
</div>
<div class="inputArea">
<sec:authentication property="principal" var="principal"/>
<form action="update" method="post">
<sec:csrfInput/>
<input type="hidden" name="page" value="${page }">
<input type="hidden" name="gameId" value="${gameId }">
<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
<input type="text" class="banedDeleted" name="gameBoardTitle" value="${vo.gameBoardTitle }" required><br>
<div class="caption">
<p>${principal.username }</p>
</div>
<textarea name="gameBoardContent" class="banedDeleted" rows="20" cols="100" required>${vo.gameBoardContent }</textarea>
<br>
<input class="btn btn-secondary" type="submit" value="수정하기">
</form>
<a href="detail?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}" class="btn btn-secondary">돌아가기</a>
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
				this.val(text);
			}
		}).on('keyup',function(){
			$(this).val($(this).val().replace(deleted,""));
		}); // end banedDeleted.onFocusout(); // end banedDeleted.onKeyup();
	}); // end document.ready()
</script>
</body>
</html>