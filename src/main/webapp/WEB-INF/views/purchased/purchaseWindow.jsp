<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
	body{
		width : 1000px;
		margin : auto;
	}
	#waitingForPurchase{
		width : 1000px;
		margin : auto;
		margin-top: 100px;
	}
	table{
		width : 1000px;
		margin : auto;
		text-align: center;
	}
	#btnArea{
		float: right;
	}
</style>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta charset="UTF-8">
<title>구매 창</title>
</head>
<body>
	
	<sec:authentication property="principal" var="principal"/>
	<div id="waitingForPurchase">
	<h2>구매 확인</h2>
	<br>
	나의 보유금 : <span id="myCash">${cash }</span> 
	<table>
		<thead>
			<tr>
				<th style="width : 60px">순번</th>
				<th style="width : 100px">이미지</th>
				<th style="width : 200px">제목</th>
				<th style="width : 120px">가격</th>
				<th style="width : 100px">장르</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${list }" varStatus="status">
				<tr>
					<td class="order"><input type="hidden" class="gameId" value="${vo.gameId }">${status.count }</td>
					<td><img alt="${vo.gameName}" width="100px" height="100px"
						src = "../game/display?fileName=${vo.gameImageName }"></td>
					<td>${vo.gameName }</td>
					<td class="price">${vo.price }</td>
					<td>${vo.genre }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<br><br>
	<div id="totalPriceArea">
		전체 가격 : <span id="totalPrice">0</span>
	</div>
	<div id='btnArea'>
	<button id="buyNow">구매 확정</button>
	<button id="cancle">취소</button>
	</div>
	<input type="hidden" id="memberId" value=${principal.username }>
		
	<script type="text/javascript">
		$(document).ready(function(){
			var memberId = $('#memberId').val();
			
			$(window).on('load',function totalPrice(){
				var totalPrice = parseInt($('#totalPrice').text());
				var price = $('.price');
				console.log(price);
				price.each(function(){
					 totalPrice = totalPrice + parseInt($(this).text());
				});
				$('#totalPrice').html(totalPrice);
			});// end load(totalPrice)
			
			$('#buyNow').click(function(){
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var gameIdArr = $('.gameId');
				var gameIds = [];
				var priceArr = [];
				
				var cash = parseInt(($('#myCash').text()));
				var totalPrice = parseInt($('#totalPrice').text());
				
				console.log(cash);
				if(cash<totalPrice){
					alert('보유한 금액이 모자랍니다.');
				}else{
		
				gameIdArr.each(function(){
					gameIds.push($(this).val());
					var price = parseInt($(this).parent().nextAll('.price').text());
					console.log("price? "+price);
					priceArr.push(price);
				});
		
				for(var i=0;i<gameIds.length;i++){
					var gameId = gameIds[i];
					var price = priceArr[i];
					console.log(price);


					$.ajax({
						type : 'POST',
						url : 'buy/'+memberId+'?price='+price,
						headers : {
							'Content-Type' : 'application/json'
						},
						data : gameId,
						beforeSend : function(xhr) {
					        xhr.setRequestHeader(header, token);
					    },
					    success : function(result){
							console.log(result);
							if(result==1){
								alert("구매완료!");
								location.href = "myPurchased";
							}else{
								alert("잘못된 구매경로입니다.");
								location.href = "myPurchased";
							}
						}
						
					});//end ajax
				}
				}
			});// end buyNow.click
			
			$('#cancle').click(function(){
				location.href = "../"
			});// end cancle.click
			
			
		});//end document
	</script>
</body>
</html>