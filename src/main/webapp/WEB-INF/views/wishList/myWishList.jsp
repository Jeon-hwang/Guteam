<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../home.jsp" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<style type="text/css">
	body{
		display:block;
		color: white;
	}

</style>
<title>위시리스트</title>
</head>
<body>
<main class="wishListBody">
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="principal"/>
	
	<h2>${principal.username}님의 위시리스트</h2>
	<input type="hidden" id="memberId" value=${principal.username }>
</sec:authorize>
	<div class="wish_list_area">
		<ul class="wish_list">
		</ul>
	</div>
	<div class="price_area">
		<input type="checkbox" id="allCheck" value="전체 선택">
		<p>선택한 게임 총 가격 : ￦<span id="totalPrice">0</span></p>
		<form action="../purchased/purchaseWindow" method="get">
		<sec:csrfInput/>
		<input type="hidden" id="gameIdInput" name="gameIds" value="">
		<input type="submit" id="submit" class="btn btn-light" value="선택한 게임 구매" disabled>
		</form>
		<a href=${referer }><button id="beforePage" class="btn btn-light">이전</button></a>
	</div>
	</main>
	<script type="text/javascript">
		$(document).ready(function(){
			showWishList();
			var checkGameId = [];
			var gameIdInput = $('#gameIdInput');
			var totalPriceInput = $('#totalPriceInput');
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			function checkPurchasedGame(gameId){
				var memberId = $('#memberId').val();
				var result = 0;
				$.ajax({
					type : 'GET',
					async: false, 
					url :"../purchased/find/"+memberId+'?gameId='+gameId,
					headers : {
						'Content-Type' : 'application/json'
					},
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(data){
						console.log("게임 존재 판단 ");
						console.log(data);
						result=data;
					}
				    
				}); //end ajax
				console.log('게임존재판단후 결과 = '+result);
				return result;
			}//end checkPurchasedGame
			
			
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
								console.log(checkPurchasedGame(this.gameId));
								if(this.endService=='Y'){
								list +=	'<li class="wish_list_item">'
									 + '<input type="hidden" class="gameId" value='+this.gameId+'>'
									 + '<input type="checkbox" class="listCheck" disabled>'
									 + '<div class="gameImg"><img alt="'+this.gameName+'" width="100px" height="100px"'
									 + 'src="../game/display?fileName='+this.gameImageName+'"></div>'
									 + '<span id="gameName"><a href=../game/detail?gameId='+this.gameId+'>'+this.gameName+'</a></span>'
									 + '<span class="ownGame">서비스 종료된 게임입니다.</span>'
									 + '<div class="buy_or_remove">'
									 + '<button class="removeWishList">X</button></div>'
									 + '</li>'
									 + '<hr>';
								}else if(checkPurchasedGame(this.gameId)==0){
									list += '<li class="wish_list_item">'
										 + '<input type="hidden" class="gameId" value='+this.gameId+'>'
										 + '<input type="checkbox" class="listCheck">'
										 + '<div class="gameImg"><img alt="'+this.gameName+'" width="100px" height="100px"'
										 + 'src="../game/display?fileName='+this.gameImageName+'"></div>'
										 + '<span id="gameName"><a href=../game/detail?gameId='+this.gameId+'>'+this.gameName+'</a></span>'
										 + '<span class="genre">'+this.genre+'</span>'
										 + '<span class="showPrice">￦'+this.price+'</span>'
										 + '<input type="hidden" class="price" value='+this.price+'>'
										 + '<div class="buy_or_remove">'
										 + '<button class="oneBuyBtn">구매</button>'
										 + '<button class="removeWishList">X</button></div>'
										 + '</li>'
										 + '<hr>';
								}else{
								list += '<li class="wish_list_item">'
									 + '<input type="hidden" class="gameId" value='+this.gameId+'>'
									 + '<input type="checkbox" class="listCheck" disabled>'
									 + '<div class="gameImg"><img alt="'+this.gameName+'" width="100px" height="100px"'
									 + 'src="../game/display?fileName='+this.gameImageName+'"></div>'
									 + '<span id="gameName"><a href=../game/detail?gameId='+this.gameId+'>'+this.gameName+'</a></span>'
									 + '<span class="ownGame">이미 소유한 게임입니다</span>'
									 + '<div class="buy_or_remove">'
									 + '<button class="removeWishList">X</button></div>'
									 + '</li>'
									 + '<hr>';
								}
							});//end data.each
							
							$('.wish_list').html(list);
							
						});// end getJSON
			}//end showWishList()
			$('.wish_list').on('click','.wish_list_item .buy_or_remove .removeWishList',function(){
				var gameId = $(this).parent().prevAll('.gameId').val();
				var memberId = $('#memberId').val();
				console.log('누구십니까');
				console.log(memberId);
				
				$.ajax({
					type : 'DELETE',
					url :'/guteam/wishList/'+memberId,
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
			$('.wish_list').on('change','.wish_list_item .listCheck',function(){
			//$('.wish_list').on('click','.wish_list_item .listCheck',function(){
				var price = parseInt($(this).nextAll('.price').val());
				var totalPrice = parseInt($('#totalPrice').text());
				var gameId = $(this).prevAll('.gameId').val();
				if($(this).is(':checked')){
					//console.log("체크 수행 확인!");
					console.log("가격? "+price);
					totalPrice += price;
					checkGameId.push(gameId);
					//console.log(checkGameId);
				}else{
					totalPrice  -= price;
					checkGameId = checkGameId.filter((element) => element != gameId);
					//console.log(checkGameId);
				}
				$(gameIdInput).attr('value',checkGameId);
				console.log($(gameIdInput).attr('value'));
				if($(gameIdInput).attr('value')!=''){				
					$("#submit").removeAttr("disabled");
				}else{
					$('#submit').attr("disabled",'disabled');
				}
				$('#totalPrice').html(totalPrice);
			});// end wish_list_item.on
			
			$('#allBuy').click(function(){
				console.log("전체 구매버튼 클릭");
				console.log(checkGameId);
				
			});
			
			$('.wish_list').on('click','.wish_list_item .oneBuyBtn',function(){
				
				var gameId = $(this).parent().prevAll('.gameId').val();
				console.log("gmaeId="+gameId);
				
				location.href = "../purchased/purchaseWindow?gameIds="+gameId;
			}); // end oneBuyBtn
			
			$('#allCheck').on('click',function(){
				if($(this).is(":checked")){ // 전체선택을 선택한경우
				    $('.listCheck').each(function(){
						if(!$(this).is(":checked")){
							$(this).click();
						}
				    });//end each
				}else{ // 전체선택을 해제한 경우
				    $('.listCheck').each(function(){
						if($(this).is(":checked")){
							$(this).click();
						}
					});
				}
			});// end allCheck
		}); // end document
	</script>
</body>
</html>