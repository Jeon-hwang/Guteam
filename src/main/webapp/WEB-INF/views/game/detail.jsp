<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>${vo.gameName }</title>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
	<c:forEach var="discountVO" items="${discountList }">
	<input type="hidden" value="${discountVO.genre }" id="${discountVO.genre }">
	<input type="hidden" value="${discountVO.discountRate }" class="discountRate">
	</c:forEach>
	<section>
	<div id="wrap">
	<div class="detail-box">
	<div class="info">
	<div class="category">
	<a href="list">All Games</a> &nbsp; <i class="bi bi-caret-right-fill"></i> &nbsp; <a href="list?keyword=${vo.genre }&keywordCriteria=keyword">${vo.genre }</a>
	</div>
	<div id="detailInfo">
	<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
	<sec:authentication property="principal" var="principal"/>
	<input type="hidden" id="username" value="${principal.username }">
	</sec:authorize>
	<div id="gameImageArea">
	<img alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
	</div>
	<div class="infoArea">
	<br>
	게임 이름 : ${vo.gameName }
	<br>
	<c:if test="${vo.endService=='N' }">
	가격 : <span class="${vo.genre }">${vo.price }</span>
	</c:if>
	<c:if test="${vo.endService=='Y' }">
	서비스 종료된 게임입니다.
	</c:if>
	<br>
	장르 : ${vo.genre }
	<br>
	출시일 : <fmt:formatDate value="${vo.releaseDate }" pattern="yyyy년 MM월 dd일" />
	<br>
	마지막 업데이트일 : <fmt:formatDate value="${vo.updateDate }" pattern="yyyy년 MM월 dd일" /> 
	<br>
	평점 : <c:if test="${rating==0 }">
		<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
		</c:if>
		<c:if test="${rating!=0 }">
			<c:forEach begin="1" end="${rating/2 }" step="1">
				<i class="bi bi-star-fill"></i>
			</c:forEach>
			<c:if test="${rating%2!=0 }">
				<i class="bi bi-star-half"></i>
			</c:if>
			<c:forEach begin="1" end="${5-(rating/2) }"
				step="1">
				<i class="bi bi-star"></i>
			</c:forEach>
		</c:if>
	</div>
	</div>
	</div>
	<input type="hidden" id="gameId" value=${vo.gameId }>
	<br>
	<sec:authorize access="isAuthenticated()">
	<div id="friendsOwnGame">
	<div class="textOwner">
	이 게임을 가지고 있는 친구 
	</div>
	<ul id="friendsList">
	</ul>
	</div>	
	</sec:authorize>
	</div>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div class="btn_group_detail">
	<a href="update?gameId=${vo.gameId }&prevListUrl=" id="btnUpdate"><button class="btn btn-light">수정하기</button></a>
	<a href="updateVideo?gameId=${vo.gameId }&prevListUrl=" id="btnUpdateVideo"><button class="btn btn-light">영상업로드</button></a>
	<c:if test="${vo.endService=='N' }">
	<form action="endService?gameId=${vo.gameId }" method="post" onsubmit="return confirm('정말 서비스 종료하시겠습니까?')">
	<sec:csrfInput/>
	<button class="btn btn-light">서비스 종료하기</button>
	</form>
	</c:if>
	</div>
	</sec:authorize>
	<div class="btn_group_detail">
	<a href="../gameBoard/list?gameId=${vo.gameId }"><button class="btn btn-light">${vo.gameName } 커뮤니티</button></a>
	<a href="../review/list?gameId=${vo.gameId }"><button class="btn btn-light">리뷰보기</button></a>
	</div>
	<div class="btn_group_detail">
	<a id="prevListUrl" href="${prevListUrl}"><button class="btn btn-light">리스트로 돌아가기</button></a>
	<input type="hidden" id="updateResult" value="${update_result }">
	<input type="hidden" id="updateVideoResult" value="${update_video_result }">
	<br>
	<c:if test="${vo.endService=='N' }">
	<div class="wish_list_btn_area">
		<button  class="btn btn-light" id="addWishList">위시리스트에 추가</button>
		<button  class="btn btn-light" id="removeWishList" style="display : none">이미 위시리스트에 추가 되어 있습니다.</button>
		<p id="alreadyOwnGame" style="display : none">이미 보유한 게임입니다.</p> 
		<form id="buyown" action="../purchased/purchaseWindow" method="get">
			<sec:csrfInput/>
			<input type="hidden" id="gameIdInput" name="gameIds" value="${vo.gameId }">
			<input type="submit" class="btn btn-light" id="submit" value="게임 구매">
		</form>
	</div>
	</c:if>
	<c:if test="${vo.endService=='Y' }">
	<p style="color:#fff;"> 서비스 종료된 게임입니다. </p>
	</c:if>
	</div>
	</div>
	</section>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		var updateResult = $('#updateResult').val();
		var updateVideoResult = $('#updateVideoResult').val();
		if(updateResult=='success'){
			alert('게임 정보 수정 성공'); 	
		}
		if(updateVideoResult=='success'){
			alert('비디오 삽입 성공');
		}
		if(updateVideoResult=='wrong_ext'){
			alert('비디오 형식이 잘못되었습니다.(현재 mp4만 업로드 가능합니다.)');
		}
		if(updateVideoResult=='not_changed'){
			alert('업로드하기 버튼을 눌렀지만, 파일을 선택하지 않았습니다.');
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
					}else{
						alert('이미 추가 되었습니다.');
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
						if(data == 1){ // 게임을 보유하고 있을경우
						$('#alreadyOwnGame').css("display","inline");
						$('#addWishList').css("display","none");
						$('#buyown').css("display","none");
					 }
			});//end firstJson 
			
			$.getJSON(
					secondUrl,
					function(gameData){
						console.log(gameData);
						if(gameData == 1){
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
					}else{
						alert("이미 제거 되었습니다.");
						$('#addWishList').css("display","inline");
						$('#removeWishList').css("display","none");
					}
				}
			});// end ajax
		});//end removeWishList.click
		showGameOwnFriend();
		function showGameOwnFriend(){
				var url = "../purchased/findFriends/"+memberId+'?gameId='+gameId;
				var list = $('#friendsList').html();
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
		
		$('#friendsOwnGame').on('mousemove','#friendsList .profileImg',function(e){
            $("#preview")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px");
        });
		
		var prevListUrl = $('#prevListUrl').attr('href');
		prevListUrl = decodeURIComponent(prevListUrl);
		$('#prevListUrl').attr('href', prevListUrl);
		var updateUrl = $('#btnUpdate').attr('href');
		prevListUrl = encodeURIComponent(prevListUrl);
		$('#btnUpdate').attr('href', updateUrl+prevListUrl);
		var updateVideoUrl = $('#btnUpdateVideo').attr('href');
		$('#btnUpdateVideo').attr('href', updateVideoUrl + prevListUrl);
		if(prevListUrl==''){
			$('#prevListUrl').attr('href', 'list');
		}
		
		function checkDiscountGenre(){
			var discountRateList = $('html').find('.discountRate');
			var discountGenreList = $('html').find('.discountRate').prev();
			$(discountGenreList).each(function(index){
				var discountGenre = $(this).val();
				var discountRate = $(discountRateList[index]).val();
				console.log(discountGenre+','+discountRate);
				$('.'+discountGenre+'').attr('style','color:#b9ee1a;margin-bottom:5px;');
				$('.'+discountGenre+'').append(' <span style="background:#4c6b22;width:50px;text-align:center;margin:auto;margin-bottom:5px;margin-left:50px;">-'+discountRate*100+'%</span>');
			});
		}
		checkDiscountGenre();
	});// document
	</script>
	  </body>
	  </html>