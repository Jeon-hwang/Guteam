<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token }"/>
<meta name="_csrf_header" content="${_csrf.headerName }"/>
<title>${vo.gameName } 영상 업로드</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
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
<h1>${vo.gameName } 영상 업로드</h1>
</div>
<div class="formArea">
<form action="updateVideo" method="post" enctype="multipart/form-data" accept-charset="utf-8" >
<sec:csrfInput/>
<div class="info">
<div class="caption">
<p>게임이름 = </p>
<p>가격 = </p>
<p>장르 = </p>
<p>게임 이미지 = </p>
</div>
<div class="inputArea">
<input type="hidden" name="prevListUrl" value="${prevListUrl }">
<input type="hidden" id="gameId" name="gameId" value="${vo.gameId }">
<div class="caption">
<p>${vo.gameName }</p>
<p>￦${vo.price }</p>
<p>${vo.genre }</p>
</div>
<img width="300px" height="300px" alt="${vo.gameName }" src="display?fileName=${vo.gameImageName }"><br>
<input type="file" name="file" id="file" accept="video/mp4" onchange="hider(event)">
<label for="file" id="label" class="btn btn-secondary">파일 찾기<i class="bi bi-file-earmark-arrow-up-fill"></i></label>
<!-- <img alt="${vo.gameImageName }" src=""> -->
<br>
<input id="submit" type="submit" class="btn btn-secondary" value="업로드">
</div>
</div>
</form>
<div class="justify-content-center">
<a href="detail?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button class="btn btn-secondary">취소</button></a>
</div>
</div>
</div>
</section>

<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
		function hider(event){
			var reader = new FileReader();
			reader.onload = function(event){
				if(event.target.result.indexOf('video')==-1){
					alert('잘못된 파일 형식입니다.');		
				}else{
					$('#label').hide();
					//$('#submit').click();
				}
			}
			reader.readAsDataURL(event.target.files[0]);
			console.log(event.target);
			console.log(event.target.result);
		}; // display
	</script>


</body>
</html>