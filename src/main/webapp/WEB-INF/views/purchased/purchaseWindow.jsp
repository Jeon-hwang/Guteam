<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta charset="UTF-8">
<title>구매 창</title>
</head>
<body>
	<sec:authentication property="principal" var="principal"/>
	<div id="waitingForPurchase"> 
	<table>
		<thead>
			<tr>
				<th style="width : 60px">순번</th>
				<th style="width : 100px">이미지</th>
				<th style="width : 100px">제목</th>
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
	
	<div id="totalPriceArea">
		전체 가격 : <span id="totalPrice">0</span>
	</div>
	<button id="buyNow">구매 확정</button>
	<input type="hidden" id="memberId" value=${principal.username }>
	
	<script type="text/javascript">
		$(document).ready(function(){
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
				var memberId = $('#memberId').val();
				
				gameIdArr.each(function(){
					gameIds.push($(this).val());
				});
				console.log(gameIds);
					var obj = {
						'memberId' : memberId,
						'gameIds' : '{'+gameIds+'}'
					};
					console.log(obj);
					$.ajax({
						type : 'POST',
						url : 'buy',
						headers : {
							'Content-Type' : 'application/json'
						},
						data : JSON.stringify(obj),
						beforeSend : function(xhr) {
					        xhr.setRequestHeader(header, token);
					    },
					    success : function(result){
							console.log(result);
							if(result==1){
								location.href("../");
							}
						}
						
					});//end ajax
				
			});// end buyNow.click
		});//end document
	</script>
</body>
</html>