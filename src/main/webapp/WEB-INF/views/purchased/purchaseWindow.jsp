<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
<jsp:include page="../home.jsp" />
<style type="text/css">
	main{
		width : 1000px;
		margin : auto;
		color : white;
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
	<main>
	<div id="waitingForPurchase">
	<h2>구매 확인</h2>
	<br>
	나의 보유금 : <span id="myCash">${memberVO.cash }</span> 
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
			<c:if test="${vo.endService=='N' }">
				<tr>
					<td class="order"><input type="hidden" class="gameId" value="${vo.gameId }">${status.count }</td>
					<td><img alt="${vo.gameName}" width="100px" height="100px"
						src = "../game/display?fileName=${vo.gameImageName }"></td>
					<td class="gameName">${vo.gameName }<span class="gameOwn"></span></td>
					<td class="price">${vo.price }</td>
					<td>${vo.genre }</td>
				</tr>
			</c:if>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<br><br>
	<div id="totalPriceArea">
		전체 가격 : <span id="totalPrice">0</span>
	</div>
	<div id='btnArea'>
	<button id="buyNow" class="btn btn-light">구매 확정</button>
	<button id="cancle" class="btn btn-light">취소</button>
	</div>
	<input type="hidden" id="memberId" value=${principal.username }>
	<input type="hidden" id="memberEmail" value=${memberVO.email }>
	<input type="hidden" id="memberPhone" value=${memberVO.phone }>
	</main>
	<jsp:include page="../footer.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function(){
			var memberId = $('#memberId').val();
			var cash = parseInt($('#myCash').text());
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			totalPrice();
			checkPurchasedGame();
			function checkPurchasedGame(){
				var gameIds = $('.gameId');
				var list= '';
				$(gameIds).each(function(){
					console.log($(this).val());
					var gameOwnSpan = $(this).parent().nextAll('.gameName').children('.gameOwn');
					console.log($(gameOwnSpan).prop('tagName'));
					gameId = $(this).val();

					$.ajax({
						type : 'GET',
						url :"find/"+memberId+'?gameId='+gameId,
						headers : {
							'Content-Type' : 'application/json'
						},
						beforeSend : function(xhr) {
					        xhr.setRequestHeader(header, token);
					    },
						success : function(data){
							if(data == 1){
								console.log(data);
								console.log('됐나여');
								list = '<div style="font-size: 70%; color:red ;word-break:break-all;">이미 가지고 있는 게임입니다</div>';
								$(gameOwnSpan).html(list);
								$('#buyNow').attr('disabled',true);
							}
						} 
					}); //end ajax
				});// end each;
			}//end checkPurchasedGame
			
			$('#buyNow').click(function(){
				var gameIdArr = $('.gameId');
				var gameIds = [];
				var priceArr = [];
				
				 // 현재 보유금이지만 나중에는 내가 직접 정할수 있게끔
				var totalPrice = parseInt($('#totalPrice').text());
			
				/*var gameNameArr = $('.gameName');
	        	var gameName = '';
	        	if(gameNameArr.length>1){
	        		gameName = gameNameArr.first().text()+"외 "+(gameNameArr.length-1)+'개';
	        	}else{
	        		gameName = gameNameArr.text();
	        	}
	        	console.log("게임 이름 :"+ gameName);*/

				if(cash<totalPrice){ // 보유금이 총금액보다 모자랄 경우
					totalPrice = totalPrice-cash; // 일단은 보유금에서 깎지만 나중에 선택할 수 있게 한다.
					alert('보유한 금액이 모자랍니다.');
					requestPay(totalPrice);
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
						url : 'buy/'+memberId,
						headers : {
							'Content-Type' : 'application/json'
						},
						beforeSend : function(xhr) {
					        xhr.setRequestHeader(header, token);
					    },
					    data : gameId,
					    success : function(result){
							console.log(result);
							if(result==1){
								alert("구매완료!");
								location.href = "myPurchased";
							}else{
								alert("잘못된 구매경로입니다.");
								$.ajax({
			    					type : 'PUT',
			    					url : 'cashUpdate/'+memberId,
			    					data : JSON.stringify(cash),
			    					headers : {
			    						'Content-Type' : 'application/json'
			    					},
			    					beforeSend : function(xhr) {
			    				        xhr.setRequestHeader(header, token);
			    				    },
			    					success : function(result){
			    						if(result==1){
			    							location.href = "myPurchased"
			    						}
			    					}	
			    				});//end ajax
								;
							}
						}
						
					});//end ajax
				}
				}
			});// end buyNow.click
			
			$('#cancle').click(function(){
				location.href = "../"
			});// end cancle.click
			// --------------------------------- 결제시스템 -------------------------------
	        var IMP = window.IMP; 
	        IMP.init("imp54014882");  // 스토어 id 입력
	      	
	        var today = new Date();   
	        var hours = today.getHours(); // 시
	        var minutes = today.getMinutes();  // 분
	        var seconds = today.getSeconds();  // 초
	        var milliseconds = today.getMilliseconds();
	        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
	        

	        function requestPay(totalPrice) {
	        	var gameNameArr = $('.gameName');
	        	var gameName = '';
	        
	        	if(gameNameArr.length>1){
	        		gameName = gameNameArr.first().text()+"외 "+(gameNameArr.length-1)+'개';
	        	}else{
	        		gameName = gameNameArr.text();
	        	}
	        	var price = 0;
	        	
	            IMP.request_pay({
	                pg : 'kakaopay', // 결제수단은 카카오 페이만 
	                merchant_uid: "GT"+makeMerchantUid, // 고유 결제 번호 중복되면 결제 안됨 
	                name : gameName, // 이름
	                amount : totalPrice, //최종 가격
	                buyer_email :  $('#memberEmail').val(),
	                buyer_name : memberId,
	                buyer_tel : $('#memberPhone').val(),
	            }, function (rsp) { // callback
	                if (rsp.success) {
	                    console.log(rsp);
	                    cash = totalPrice+cash;
	                   
	                    $.ajax({
	    					type : 'PUT',
	    					url : 'cashUpdate/'+memberId,
	    					data : JSON.stringify(cash),
	    					headers : {
	    						'Content-Type' : 'application/json'
	    					},
	    					beforeSend : function(xhr) {
	    				        xhr.setRequestHeader(header, token);
	    				    },
	    					success : function(result){
	    						if(result==1){
	    							 $('#buyNow').click();
	    						}
	    					}	
	    				});//end ajax
	                } else {
	                    console.log(rsp);
	                }
	            });
	        }
			
		});//end document
		function totalPrice(){
			var totalPrice = parseInt($('#totalPrice').text());
			var price = $('.price');
			console.log(price);
			price.each(function(){
				 totalPrice = totalPrice + parseInt($(this).text());
			});
			$('#totalPrice').html(totalPrice);
		}
	</script>
</body>
</html>