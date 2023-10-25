<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 창</title>
</head>
<body>
	<div id="memberInfo">
	<input type="hidden" id="memberId" value="${memberVO.memberId }">
	보유 캐쉬 : <span id="myCash">${memberVO.cash }</span>
	</div>
	
	<div class="game_info_area">
	<input type="hidden" id="gameId" value="${gameVO.gameId }">
	<div class="gameinfo">
		<p>게임제목 : ${gameVO.gameName }<br></p>
		<p>${gameVO.price }</p>
		<p>${gameVO.gameImageName }</p>
	</div>
		
	</div>
	<button id="purchaseNow">구매하기</button>
	<script type="text/javascript">
		$(document).ready(function(){
			var memberId = $('#memberId').val();
			var gameId = $('#gameId').val();
			$('#purchaseNow').click(function(){
				$.ajax({
					
				});//end ajax
			});// end purchaseNow.click
			
		});// end document
	</script>
</body>
</html>