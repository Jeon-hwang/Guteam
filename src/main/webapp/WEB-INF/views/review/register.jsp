<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<meta charset="UTF-8">
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
<form action="register" method="post">
<sec:csrfInput/>
<input type="hidden" name="gameId" value="${gameId }">
<input type="text" name="memberId" value="${principal.username }" readonly><br>
<input type="text" name="reviewTitle" autofocus required><br>
<input type="number" min="0" max="10" name="rating" value="5" required><br>
<textarea name="reviewContent" rows="20" cols="100" required></textarea><br>
<input type="submit" class="btn btn-secondary" value="글 작성 완료하기"><br>
</form>
<a href="list?gameId=${gameId }" class="btn btn-secondary">리뷰로 돌아가기</a>
</div>
</div>
</div>
</div>
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</body>
</html>