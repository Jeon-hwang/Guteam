<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<style type="text/css">
	.wishList li{
		display : flex;
		justify-content: space;
	}
</style>
<title>위시리스트</title>
</head>
<body>
<sec:authentication property="principal" var="principal"/>
	<h1>${principal.username}님의 위시리스트</h1>
	<input type="hidden" id="memberId" value="${principal.username}">
	<div class="wishListArea">
		<ul class="wishList">
		<!-- 	<c:forEach varStatus="status" var="vo" items="${list }">
			
				<li><img alt="${vo.gameName }" width="100px" height="100px"
					src="display?fileName=${vo.gameImageName }"></li>
				
				<li>게임 이름 : ${vo.gameName }</li>
				
				<li>가격 : ${vo.price }</li>
				
				<li>장르 : ${vo.genre }</li>
				
				<li>마지막 업데이트일 : ${vo.updateDate }</li>
				
				<button id="delete">삭제</button>
			</c:forEach>
			 -->
		</ul>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			showWishList();
			
			function showWishList(){
				var memberId = $('#memberId').val();
				console.log(memberId);
				var list = '';
				var url = 'all/'+memberId;
				$.getJSON(
						url,
						function(data){
							console.log(data);
							$(data).each(function(){
								console.log(this);
								list +=	'<li><img alt="'+this.gameName
									 + '" width="100px" height="100px"'
									 + 'src="../game/display?fileName='+this.gameImageName+'"></li>'
									 + '<li><span class="game_name">'+this.gameName+'</span></li>'
									 + '<li><span class="genre">'+this.genre+'</span><br>'
									 + '<span class="price">'+this.price+'</span></li>'
							});//end data.each
							
							$('.wishList').html(list);
							
						});// end getJSON
			}
		}); // end document
	</script>
</body>
</html>