<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta charset="UTF-8">
<style type="text/css">
	body{
		width : 1000px;
		margin : auto;
	}
	.game_item{
		display : flex;
		justify-content: space-between;
	}
</style>
<title>나의 구매내역</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
	<sec:authentication property="principal" var="principal"/>
	
	<a href="../"><h1>Guteam</h1></a>
	<h2>나의 게임 목록</h2>
	<input type="hidden" id="memberId" value="${principal.username }">
	<div id="myGameArea">
		<ul id="games"></ul>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function(){
		var memberId = $('#memberId').val();
		getGameList();	
		function dateFormat(date) {
	        var month = date.getMonth() + 1;
	        var day = date.getDate();
	        var hour = date.getHours();
	        var minute = date.getMinutes();	
	        var second = date.getSeconds();

	        month = month >= 10 ? month : '0' + month;
	        day = day >= 10 ? day : '0' + day;
	        hour = hour >= 10 ? hour : '0' + hour;
	        minute = minute >= 10 ? minute : '0' + minute;
	        second = second >= 10 ? second : '0' + second;

	        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
		}
		function getGameList(){
			var url = "all/"+memberId;
		
			$.getJSON(
				url,
				function(data){
				console.log(data);
				var list='';
				var principalMemberId = $('#memberId').text();
				var i = 0;
				$(data.gameList).each(function(){
				
					var purchaseDate = new Date(data.purchasedList[i].purchaseDate);
					i++;
					list += '<li class="game_item">'
						 + '<img alt="'+this.gameName+'" width="100px" height="100px"'
						 + 'src="../game/display?fileName='+this.gameImageName+'">'
						 + '<input type="hidden" class="gameImageName" value="'+this.gameImageName+'">'
						 + '<a href=../game/detail?gameId='+this.gameId+'><span id="gameName">'+this.gameName+'</span></a>'
						 + '<span class="genre">'+this.genre+'</span>'
						 + '<div class="active_game">'
						 + '<button class="download_btn"><a href="'
						 + 'download'+this.gameImageName+'">다운로드</a></button><br>'
						 + '<button class="active_game" style="display : none">실행</button><br>'
						 + '<span class="purchasedDate">구매 일자 : '+dateFormat(purchaseDate)+'</span>'
						 + '</div>'
						 + '</li><hr>';
						 
				}); // end data.each
					$('#games').html(list);
				}
			); // end getJSON*/
		}// end getGameList()
		$('#games').on('click','.game_item .active_game .download_btn',function(){
			console.log("클릭");
			var imageName = $(this).parent().prevAll('.gameImageName').val();
			console.log(imageName);
		});// end games.on
		var hi = checkGame("2023/10/23/s_035022_leage.jpg");
		console.log(hi);
		function checkGame(gameImageName){
			var result=0; 
			console.log(gameImageName);
			var url = 'check/'+gameImageName;
			$.getJSON(
				 url,
				 function(data){
					 console.log("제이슨성공?");
					 console.log(data);
					 if(data.data=='Y'){
						result=1;
					 }
				 }
			);// end getJSON
			return result;
		}//end checkGame()
	});// end document
	</script>
</body>
</html>