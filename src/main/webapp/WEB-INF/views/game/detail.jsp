<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>${vo.gameName }</title>
</head>
<body>
<div class="category">
<a href="list">All Games</a> > <a href="list?keyword=${vo.genre }">${vo.genre }</a>
</div>
<img alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
<br>
게임 이름 : ${vo.gameName }
<br>
가격 : ${vo.price }
<br>
장르 : ${vo.genre }
<br>
출시일 : ${vo.releaseDate }
<br>
마지막 업데이트일 : ${vo.updateDate }
<br>
평점 : ${rating } 점
<hr>
<input type="hidden" id="gameId" value=${vo.gameId }>
<br>
<a href="update?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button>수정하기</button></a>
<br>
<a href="../gameBoard/list?gameId=${vo.gameId }"><button>${vo.gameName } 커뮤니티</button></a>
<br>
<a href="../review/list?gameId=${vo.gameId }"><button>리뷰보기</button></a>
<br>
<a href="${prevListUrl}"><button>리스트로 돌아가기</button></a>

<input type="hidden" id="updateResult" value="${update_result }">

<br>

<div class="wish_list_btn_area">
	<button id="addWishList">위시리스트에 추가</button>
	<button id="removeWishList" style="display : none">이미 위시리스트에 추가 되어 있습니다.</button>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		var updateResult = $('#updateResult').val();
		console.log(updateResult);
		if(updateResult=='success'){
			alert('게임 정보 수정 성공');
		}
		$('#addWishList').click(function(){
			var gameId = $('#gameId').val();
			var memberId = '${sessionScope.memberId }';
			var obj = {
					'gameId' : gameId,
					'memberId' : memberId
			}
			
			$.ajax({
				type : 'POST',
				url : '../wishList',
				headers : {
					'Content-Type' : 'application/json'
				},
				data : JSON.stringify(obj),
				success : function(result){
					console.log(result);
					if(result==1){
						alert('위시리스트 추가 성공');
						removeWishListOn();
					}
				}
			});// end ajax
		}); // end add_wish_list.click
		removeWishListOn();
		function removeWishListOn(){
			var gameId = $('#gameId').val();
			var memberId = '${sessionScope.memberId }';
			
			var url = '../wishList/find/'+memberId+'?gameId='+gameId;
			$.getJSON(
					url,
					function(data){
						console.log(data);
						if(data != null){
							$('#addWishList').css("display","none");
							$('#removeWishList').css("display","inline");
						}
					});//end JSON
					
		}//end removeWishListOn()
		
		$('#removeWishList').click(function(){
			var gameId = $('#gameId').val();
			var memberId = '${sessionScope.memberId }';
			
			$.ajax({
				type : 'DELETE',
				url : '../wishList/'+memberId,
				headers : {
					'Content-Type' : 'application/json'
				},
				data : gameId,
				success : function(result){
					console.log(result);
					if(result==1){
						alert('위시리스트 제거 성공');
						$('#addWishList').css("display","inline");
						$('#removeWishList').css("display","none");
					}
				}
			});// end ajax
		});//end removeWishList.click
	});// document

</script>
</body>

</html>