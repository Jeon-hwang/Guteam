<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
</style>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/views/home.jsp" />
<style type="text/css">
	body{
		display:block;
		color : white;
	}

	.game_item{
		display : flex;
		justify-content: space-between;
	}
	
</style>
<title>나의 구매내역</title>
</head>
<body>
	
	
	<h2>나의 게임 목록</h2>
	<sec:authentication property="principal" var="principal"/>
	<input type="hidden" id="memberId" value="${principal.username }">
	<div id="myGameArea">
		<ul id="games"></ul>
	</div>
	
	<jsp:include page="../footer.jsp" />
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

	        return date.getFullYear() + '-' + month + '-' + day;
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
						 + '<img alt="'+this.gameName+'" width="250px" height="150px"'
						 + 'src="../game/display?fileName='+this.gameImageName+'">'
						 + '<input type="hidden" class="gameImageName" value="'+this.gameImageName+'">'
						 + '<a href=../game/detail?gameId='+this.gameId+'><span id="gameName">'+this.gameName+'</span></a>'
						 + '<span class="genre">'+this.genre+'</span>'
						 + '<div class="active_game">'
						 + '<span class="purchasedDate">구매 일자 : '+dateFormat(purchaseDate)+'</span><br>'
						 if(this.endService=='N'){
							 if(checkGame(this.gameImageName)==0){
						list += '<button class="download_btn"><a href="'
							 + 'download'+this.gameImageName+'">다운로드</a></button><br>';
							 }else{
						list += '<button class="run_game">실행</button><br>';
							 }
						 }else{
							 list += '<p>서비스 종료된 게임입니다.</p>';
						 }
					list += '</div>'
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
			getGameList();
		});// end games.on
		
		function checkGame(gameImageName){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var result = 0;
			console.log(gameImageName);
			$.ajax({
				type : 'GET' ,
				url : 'check'+gameImageName ,
				headers : {
					'Content-Type' : 'application/json'
				} ,
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    } ,
			    async : false ,
			    success : function(data){
			    	console.log(data);
			    	if(data=="Y"){
			    		result = 1;
			    	}    
			    }
			}); //end ajax
			return result;
		}
		
		$('#games').on('click','.game_item .active_game .run_game',function(){
			console.log("게임실행 확인");
			var imageName = $(this).parent().prevAll('.gameImageName').val();
			window.open("runningGame"+imageName, "게임", "width=750px,height=750px,scrollbars=yes");
		});
		
	});// end document
	
	</script>
</body>
</html>