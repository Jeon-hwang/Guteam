<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>${vo.gameName }</title>
<style type="text/css">
	#friendsOwnGame{
		float : right;
	}
	#friendsOwnGame ul li{
		float : right;
	}
	
	#preview{
			z-index: 99;
			position:absolute;
			border:1px solid #ccc;
			background:#333;
			padding:5px;
			display:none;
			color:#fff;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<div class="category">
<a href="list">All Games</a> > <a href="list?keyword=${vo.genre }">${vo.genre }</a>
</div>

<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
<sec:authentication property="principal" var="principal"/>
<input type="hidden" id="username" value="${principal.username }">
</sec:authorize>
<img alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
<sec:authorize access="isAuthenticated()">
<div id="friendsOwnGame">
이 게임을 가지고 있는 친구
<ul id="friendsList"></ul>
</div>	
</sec:authorize>
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
<div id="btn_group_detail">
<sec:authorize access="hasRole('ROLE_ADMIN')">
<a href="update?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button class="btn btn-light">수정하기</button></a>
<br>
</sec:authorize>
<a href="../gameBoard/list?gameId=${vo.gameId }"><button class="btn btn-light">${vo.gameName } 커뮤니티</button></a>
<br>
<a href="../review/list?gameId=${vo.gameId }"><button class="btn btn-light">리뷰보기</button></a>
<br>
<a href="${prevListUrl}"><button class="btn btn-light">리스트로 돌아가기</button></a>

<input type="hidden" id="updateResult" value="${update_result }">

<br>
<sec:authorize access="isAuthenticated()">
<div class="wish_list_btn_area">
	<button  class="btn btn-light" id="addWishList">위시리스트에 추가</button>
	<button  class="btn btn-light" id="removeWishList" style="display : none">이미 위시리스트에 추가 되어 있습니다.</button>
	<p id="alreadyOwnGame" style="display : none">이미 보유한 게임입니다.</p> 
	<form id="buyown" action="../purchased/purchaseWindow" method="get">
		<sec:csrfInput/>
		<input type="hidden" id="gameIdInput" name="gameIds" value="${vo.gameId }">
		<input type="submit" id="submit" value="게임 구매">
	</form>
</div>
</sec:authorize>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		var updateResult = $('#updateResult').val();
		if(updateResult=='success'){
			alert('게임 정보 수정 성공');
		}
		var xOffset = 10;
        var yOffset = 30;
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var gameId = $('#gameId').val();
		var memberId = $('#username').val();
		
		$('#addWishList').click(function(){
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
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
				success : function(result){
					console.log(result);
					if(result==1){
						alert('위시리스트 추가 성공');
						checkMyGame();
					}
				}
			});// end ajax
		}); // end add_wish_list.click
		checkMyGame();
		function checkMyGame(){
			var firstUrl = "../purchased/find/"+memberId+'?gameId='+gameId;
			var secondUrl = '../wishList/find/'+memberId+'?gameId='+gameId;
			$.getJSON(
					firstUrl,
					function(data){
						console.log(data);
						if(data == null){
					
						 }else{ // 게임을 보유하고 있을경우
						$('#alreadyOwnGame').css("display","inline");
						$('#addWishList').css("display","none");
						$('#buyown').css("display","none");
					 }
			});//end firstJson 
			
			$.getJSON(
					secondUrl,
					function(gameData){
						console.log(gameData);
						if(gameData != null){
							$('#addWishList').css("display","none");
							$('#removeWishList').css("display","inline");
						}
			});//end secondJson					
		}//end removeWishListOn()
		$('#removeWishList').click(function(){
			
			$.ajax({
				type : 'DELETE',
				url : '../wishList/'+memberId,
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
						$('#addWishList').css("display","inline");
						$('#removeWishList').css("display","none");
					}
				}
			});// end ajax
		});//end removeWishList.click
		showGameOwnFriend();
		function showGameOwnFriend(){
				var url = "../purchased/findFriends/"+memberId+'?gameId='+gameId;
				var list = '';
				$.getJSON(
					url,
					function(data){
					
						$(data.imageNameList).each(function(index){
							//console.log(data.friendIdList[index]);
							//console.log("인덱스가 나오나?"+index);
							list += '<li class="profileImg">' 
								 + '<img alt="'+data.friendIdList[index]+'" width="50px" height="50px" title="'+data.friendIdList[index]+'" src="display?fileName='+this+'">'
								 + '</li>';
						});
						$('#friendsList').html(list);
					}
					
				);//end getJSON
				
		}// end showGameOwnFriend()
		
		$('#friendsOwnGame').on('mouseover','#friendsList .profileImg',function(e){
			//console.log('오리자');
			 var image_data = $(this).children().data("image");
			// console.log('확인!'+$(this).children().attr('alt'));
			 $("body").append("<p id='preview'><img src='"+ $(this).children().attr("src") +"' width='100px' />"+ $(this).children().attr('alt') +"</p>");
			 $("#preview")
	            .css("top",(e.pageY - xOffset) + "px")
	            .css("left",(e.pageX + yOffset) + "px")
	            .fadeIn("fast");
		});//end profileImg.mouseover 
		$('#friendsOwnGame').on('mouseout','#friendsList .profileImg',function(){
			//console.log('내리자');
			$("#preview").remove();
		});//end profileImg.mouseover 
	});// document

</script>
</body>
</html>