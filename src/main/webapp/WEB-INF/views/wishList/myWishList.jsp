<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>

<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<style type="text/css">
	body{
		width : 1000px;
		margin : auto;
	}
	.wish_list li{
		display : flex;
		justify-content: space-between;
	}
</style>
<title>위시리스트</title>
</head>
<body>
<sec:authentication property="principal" var="principal"/>
	<h1><a href="../">Guteam</a></h1>
	<h2>${principal.username}님의 위시리스트</h2>
	<input type="hidden" id="memberId" value=${principal.username }>
	<div class="wish_list_area">
		<ul class="wish_list">
		</ul>
	</div>
	<div class="price_area">
		<p>선택한 게임 총 가격 : ￦<span id="totalPrice">0</span></p>
		<form action="myWishList" method="post">
		<sec:csrfInput/>
		<input type="hidden" id="gameIdInput" name="gameIds" value="">
		<input type="hidden" id="totalPriceInput" name="totalPriceInput" value="">
		<input type="submit" id="submit" value="선택한 게임 구매">
		</form>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			showWishList();
			var checkGameId = [];
			var gameIdInput = $('#gameIdInput');
			var totalPriceInput = $('#totalPriceInput');
			
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
								list +=	'<li class="wish_list_item">'
									 + '<input type="hidden" id="gameId" value='+this.gameId+'>'
									 + '<input type="checkbox" id="listCheck">'
									 + '<img alt="'+this.gameName+'" width="100px" height="100px"'
									 + 'src="../game/display?fileName='+this.gameImageName+'">'
									 + '<a href=../game/detail?gameId='+this.gameId+'><span id="gameName">'+this.gameName+'</span></a>'
									 + '<span id="genre">'+this.genre+'</span>'
									 + '<span id="showPrice">￦'+this.price+'</span>'
									 + '<input type="hidden" id="price" value='+this.price+'>'
									 + '<div class="buy_or_remove">'
									 + '<button id="buyBtn">구매</button>'
									 + '<button id="removeWishList">X</button></div>'
									 + '</li>'
									 + '<hr>';
							});//end data.each
							
							$('.wish_list').html(list);
							
						});// end getJSON
			}//end showWishList()
			$('.wish_list').on('click','.wish_list_item .buy_or_remove #removeWishList',function(){
				var gameId = $(this).parent().prevAll('#gameId').val();
				var memberId = $('#memberId').val();
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				var name = $("#userName").val();
				$.ajax({
					type : 'DELETE',
					url : memberId,
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
							alert('위시리스트 제거 성공');
							showWishList();
						}
					}
				});// end ajax
			});//end removeWishList.click
			
			$('.wish_list').on('click','.wish_list_item #listCheck',function(){
				var price = parseInt($(this).nextAll('#price').val());
				var totalPrice = parseInt($('#totalPrice').text());
				var gameId = $(this).prevAll('#gameId').val();
				if($(this).is(':checked')){
					//console.log("체크 수행 확인!");
					//console.log("가격? "+price);
					totalPrice += price;
					checkGameId.push(gameId);
					//console.log(checkGameId);
				}else{
					totalPrice  -= price;
					checkGameId = checkGameId.filter((element) => element != gameId);
					//console.log(checkGameId);
				}
				$(totalPriceInput).attr('value',totalPrice);
				$(gameIdInput).attr('value',checkGameId);
				console.log($(totalPriceInput).attr('value'));
				console.log($(gameIdInput).attr('value'));
				$('#totalPrice').html(totalPrice);
			});// end wish_list_item.on
			
			$('#allBuy').click(function(){
				console.log("전체 구매버튼 클릭");
				console.log(checkGameId);
				
			});
		}); // end document
	</script>
</body>
</html>