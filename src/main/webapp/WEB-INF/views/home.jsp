<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<jsp:include page="style.jsp"></jsp:include>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>Welcome to Guteam</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal" var="principal"/>
<input type="hidden" id="memberId" value="${principal.username }">
</sec:authorize>
<header>
	<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
	<input type="hidden" id="alert" value="${alert }">
	<div class="auth">
	<sec:authorize access="isAnonymous()">
			<a href="/guteam/member/login?targetURL=" id="btnLogin"><button type="button" class="btn btn-light">로그인</button></a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
			<!-- 여기에 프로필 사진과 닉네임 캐시 표현하시면 됩니다. -->
			<a href="/guteam/chat" type="button" class="btn btn-light">채팅방 입장</a>
			<a href="/guteam/member/profiles"><button type="button" class="btn btn-light">나의 프로필</button></a>
			<a href="/guteam/wishList/myWishList"><button type="button" class="btn btn-light">나의 위시리스트</button></a>
			<a href="/guteam/purchased/myPurchased"><button type="button" class="btn btn-light">나의 보유 게임</button></a>
			<button id="recentlyViewed" type="button" class="btn btn-light">최근 조회한 게임</button>
			<form action="/guteam/member/logout" method="post" style="display:flex;">
			<sec:csrfInput/>
			<input type="submit" class="btn btn-light" value="로그아웃"></form>
			<br><br>
	</sec:authorize>
	</div>
</header>	
	<aside id="recentlyViewedGames" class="today-viewed">
	</aside>
	
<script type="text/javascript">
	$(document).ready(function(){
		console.log(location.href);
		var btnLogin = $('#btnLogin').attr('href');
		$('#btnLogin').attr('href', btnLogin+location.href);
		var result = $('#alert').val();
			if(result == 'success'){
				alert('회원 탈퇴가 완료되었습니다!');
			}
			else if(result == 'fail'){
				alert('요청에 실패하였습니다.');
			}
			
		$('#recentlyViewed').on('click', function(){
			var memberId = $('#memberId').attr('value');
			var url = '/guteam/game/list-ajax/'+memberId;
			if($(this).html()=='최근 조회한 게임'){
				$(this).html('닫기');
				var list = '<button class="btn btn-light close" onclick="doclick()">닫기</button>';
				
				$.getJSON(
						url,
						function(data){
							console.log(data);
							if(data.recentlyViewedGameVOList.length==0){
								list = '<button class="btn btn-light close" onclick="doclick()">최근 조회한 게임이 없습니다</button>';
							}else{
								$(data.recentlyViewedGameVOList).each(function(index,vo){
									list += '<div class="btn btn-secondary" onclick="gameDetail(this)" style="margin:5px; width:330px; height:500px;">'
											+'<div class="gameInfo">'
											+'<img class="rounded mx-auto d-block" alt="'+this['gameImageName']+'" width="300px" height="300px"'
											+'	src="/guteam/game/display?fileName='+this['gameImageName']+'"> <input type="hidden" class="gameId" value="'+this['gameId']+'"> <br>'
											+'<div style="font-size: 1em;">	name : '+this['gameName']+'<br> price : '+this['price']+'<br>'
											+'genre : '+this['genre']
											+'<br> releaseDate : '+ dateformat(new Date(this['releaseDate']))
											+'<br> rating : ';
											var rating = $(data.recentlyViewedRatingList[index]);
											rating = rating[0];
												if(rating!=0){
													var fullStar;
													for(fullStar=1; fullStar<=rating/2; fullStar++){
														list+='<i class="bi bi-star-fill"></i>';
													}
													if(rating%2==1){
														list+='<i class="bi bi-star-half"></i>';
													}
													var star;
													for(star=1; star<=5-(rating/2); star++){
														list+='<i class="bi bi-star"></i>';
													}
												}
											list += '</div><br></div></div>';
								});// end each
							}
								$('#recentlyViewedGames').html(list);
						}
						
					);// end getJSON()

			}else{
				$(this).html('최근 조회한 게임');
				$('#recentlyViewedGames').html('');
			}

		});  // end recentlyViewedbtn.onclick()

	}); // end document.ready()

	
	function dateformat(date){
		var dateform = date.getFullYear() + '년' + ( (date.getMonth()+1) <= 9 ? "0"+(date.getMonth()+1) : (date.getMonth()+1) )
									 + '월' + ( (date.getDate()) <= 9 ? "0" + (date.getDate()) : (date.getDate()) ) + '일';
		return dateform;
	} // end dateformat()
	
	function doclick(){
		$('#recentlyViewed').click();
	} // end doclick()
	
	function gameDetail(obj){
		var gameId = $(obj).find('.gameId').attr('value');
		location.href='/guteam/game/detail?gameId='+gameId;
	}
	
</script>
<sec:authorize access="isAuthenticated()">
	<script type="text/javascript">
	connect();
	function connect(){
		var memberId = $('#memberId').val();
		console.log(memberId);
		var sse = new EventSource("/guteam/sse/connect/"+memberId);
		sse.addEventListener(memberId, e => {
			makeNoti(e.data);
		});
	
	}
	function makeNoti(sendMemberId){
		if(Notification.permission == 'denied' || Notification.permission ==='default'){
			alert("알림이 차단된 상태입니다. 알림 권한을 허용해주세요.");
		}else{
			var noti = sendMemberId.substr(sendMemberId.lastIndexOf('\n')+1);
			sendMemberId = sendMemberId.substr(0,sendMemberId.lastIndexOf('\n'));
			console.log(noti);
			var notify = '';
			if(noti=='friendRequest'){
				notify = '친구 요청이 왔습니다.';				
			}else if(noti=='message'){
				notify = '메시지가 도착했습니다.';
			}
			console.log(notify);
			var notification = new Notification(sendMemberId, {
				body: notify,
				icon: '/guteam/image/logo80.png'
			});
			
			notification.addEventListener("click", () => {
				if(noti=='friendRequest'){
					window.open('/guteam/friend/list');				
				}else if(noti=='message'){
					window.open('/guteam/message/list', '쪽지함', 'width=720, height=500, location=no, toolbars=no, status=no');
				}
			});
		}
	}
	
	function askNotificationPermission(){
		console.log("권한 묻기");
		
		function handlePermission(permission){
			if(!("permission" in Notification)){
				Notification.permission = permission;
			}
		}
	
	
		if(!("Notification" in window)){
			console.log("이 브라우저는 알림을 지원하지 않습니다.");
		}else{
			if(checkNotificationPromise()){
				Notification.requestPermission().then((permission) => {
					handlePermission(permission);
				});
			}else{
				Notification.requestPermission(function (permission) {
					handlePermission(permission);
				});
			}
		}
	}
	
	function checkNotificationPromise(){
		try{
			Notification.requestPermission().then();
		}catch(e){
			return false;
		}
		return true;
	}
	</script>
</sec:authorize>
</body>

</html>
