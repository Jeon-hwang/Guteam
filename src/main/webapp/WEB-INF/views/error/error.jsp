<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
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
<h1>오류가 있습니다. 물론 컴퓨터가 아니라 사람에게.</h1>
</div>
<div class="infoArea">
<a class="btn btn-secondary" href="/guteam/game/list">메인 페이지로 돌아가기</a>
</div>
</div>
</section>
<footer>
</footer>
</body>
</html>