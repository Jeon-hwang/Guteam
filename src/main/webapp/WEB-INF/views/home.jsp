<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Guteam</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<form action="game/list" method="get">
		<input type="text" name="keyword" id="keyword" maxlength="20">
		<input type="submit" value="검색">
	</form>
	
	<c:if test="${empty sessionScope.memberId }">
		<a href="member/login"><button type="button">로그인</button></a>
	</c:if>
	
	<c:if test="${not empty sessionScope.memberId }">
		<a href="member/update"><button type="button">회원수정</button></a>
		<a href="member/logout"><button type="button">로그아웃</button></a><br><br>
		<form action="member/delete" method="post">
			<input type="hidden" name="memberId" id="memberId" value="${sessionScope.memberId }">
			<input type="submit" value="회원탈퇴">	
		</form>
	</c:if>
	
	<!-- <script type="text/javascript">
		$(document).ready(function(){
			$('#memberId').click(function(){
				var msg = confirm(${memberId} + '님, 정말로 탈퇴 하시겠습니까?');
				if(msg == true){
					console.log("성공");
				}
				
			}); //end .click()
			
		}); //end document
	</script> -->
</body>

</html>
