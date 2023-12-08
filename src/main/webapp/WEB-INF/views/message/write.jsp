<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.logoImg {
	display:flex;
	width: 70px;
	height: 70px;
	margin: 25px;
}
#full {
	display:flex;
	width : 750px;
	height : 420px;
}
#leftMenu {
	display:flex;
	flex-direction: column;
	width : 120px;
	height : 400px;
}
#m-board {
	display:flex;
	flex-direction: column;
}
#m-board h2{
	margin: 0px;
	padding-top:8px;
	color: #e5e5dc;
}
#board-top {
	display:flex;
	flex-wrap: wrap;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 590px;
	height : 50px;
}
#main {
	display: flex;
    flex-flow: column wrap;
    flex-direction: row;
    justify-content: space-around;
    align-content: flex-start;
    background-color: #666666;
    width: 590px;
    height: 350px;
}
#board-btm {
	display:flex;
	justify-content: flex-end;
	padding-right: 5px;
}
#messageTitle {
	width: 495px;
}
#messageContent {
	display:flex;
	justify-content: center;
	align-item: center;
	width: 495px;
	height: 227px;
	margin: 0px;
	padding: 0px;
	resize:none;
	
	background-color: #FFFFFFFF;
	color: #000;
	border: 1px solid grey;
}
.sendInfo {
	text-align : center;
}
ul.left{
	margin: 0px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
   	text-align : center;
   	display: flex;
   	flex-direction: column;
}
ul.left li {
	display : inline-block;
}
.btn {
	margin : 1px;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
}
body {
    margin: 0;
    padding: 0;
}
table {
	width: 100%;
}
thead {
	width: 100%;
	background-color : #bcc2e5;
	text-align : center;
}
th {
	border-left : solid 1px gray;
}
tr {
	height: 35px;
}
td {
	color: #e5e5dc;
	border: solid 1px #bcc2e5;	
	
}
#receiverNickname {
	width:200px;
}
#searchIds {
	position: absolute;
  	list-style:none;
  	z-index: 1000; /* 다른 요소 위에 표시되도록 z-index 설정 */
  	background-color: white; /* 배경색 설정 */
  	border: 1px solid #ccc; /* 테두리 설정 */
  	padding: 5px;
  	display: none; /* 초기에는 숨김 상태로 설정 */
  	color: black;

}
</style>
<meta charset="UTF-8">
<title>GUTEAM : ${vo.memberId }님의 쪽지함</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<img class="logoImg" alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" >
	<ul class="left">
	<li><a href="../message/write"><button class="btn btn-light">쪽지 쓰기</button></a></li>
	<br>
	<br>
	<li><a href="../message/list"><button class="btn btn-light">받은 쪽지함</button></a></li>
	<li><a href="../message/sent"><button class="btn btn-light">보낸 쪽지함</button></a></li>
	<li><a href="../message/msgBox"><button class="btn btn-light">쪽지 보관함</button></a></li>
	</ul>
</div>
<div id="m-board">
	<h2>${vo.memberId }님의 쪽지 쓰기</h2>

<div id="main">
<form action="write" method="post" onsubmit="return sendRequest();">
<sec:csrfInput/>
<table>
	<tbody>
		<tr>
			<td class="sendInfo">보낼 닉네임</td>
			<td>
			<c:if test="${empty receiveMemberId }">
				<input type="text" name="receiveMemberNickname" id="receiverNickname" placeholder="닉네임 또는 아이디 검색" required>
				<span id="checkNickNo" style="display:none; color:#ff335a; font-weight:bold">닉네임이 일치하지 않습니다.</span>
				<ul id="searchIds"></ul>
			</c:if>
			<c:if test="${not empty receiveMemberId }">
				<input type="hidden" name="receiveMemberId" id="receiverId" value="${receiveMemberId }">
				<input type="hidden" name="receiveMemberNickname" id="receiveNickname" value="${receiveMemberNickname }">
				${receiveMemberNickname }
			</c:if>
			</td>
		</tr>
		<tr>
			<td class="sendInfo">제 목</td>
			<td>
			<input type="text" name="messageTitle" id="messageTitle" value="${messageTitle }" required>
			</td>
		</tr>
		<tr>
			<td class="sendInfo">내 용</td>
			<td>
			<textarea name="messageContent" id="messageContent" required>${messageContent }</textarea><!-- 밑부분 70px -->
			</td>
		</tr>
		
	</tbody>
</table>
		
<div id="board-btm">
	<input type="hidden" name="sendMemberId" id="sendMemberId" value="${vo.memberId }">
	<input type="hidden" name="sendMemberNickname" id="sendMemberNickname" value="${vo.nickname }">
	<input class="btn btn-light" type="submit" value="보내기">
</div>
</form>
	
</div>
</div>
</div>
<input type="hidden" id="alert" value="${alert }">

<script type="text/javascript">
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	function sendRequest(){
		console.log("sendRequest");
		var msgContent = $('#messageContent').val();
		var length = new Blob([msgContent]).size;
		console.log("msgContent 길이="+length);
		
		if(length > 1000) {
			alert("보낼 쪽지 글자수가 초과되었습니다.");
			return false;
		} else {
			var memberId = $('#receiverNickname').val();
			var sendMemberId = $('#sendMemberId').val();
			
			// 쪽지 알림
			console.log('ajax요청');
			$.ajax({
				type:'post',
				url:'/guteam/sse/message/'+memberId,
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
				data:{'sendMemberId':sendMemberId},
				success:function(result){
					console.log('메시지를 보냈습니다.');
				}
			}); //end ajax()
			return true;
		}
		
	} //end sendRequest()
	
	$(document).ready(function(){
		var maxIndex=0;
		var index=0;
		var currentKeyword='';
		var result = $('#alert').val();
		if(result == 'sendfail'){
			alert('쪽지 전송에 실패하였습니다.');
		}
		
		// debounce(지연) 함수 정의 - 빠른 속도로 닉네임 검색시, 중복값을 출력해서 사용
		function debounce(func, wait, immediate) {
		    var timeout;
		    return function executedFunction() {
		        var context = this;
		        var args = arguments;
		        var later = function() {
		            timeout = null;
		            if (!immediate) func.apply(context, args);
		        };
		        var callNow = immediate && !timeout;
		        clearTimeout(timeout);
		        timeout = setTimeout(later, wait);
		        if (callNow) func.apply(context, args);
		    };
		}

		// 수신 ID 검색
		// Id 리스트 키보드 선택
		$('#searchIds').on('keyup',function(e){
			// 방향키 위로
			if(e.keyCode==38){
				index-=1;
				if(index<0){
					index=maxIndex;
				}
				if(index==0){
					$('#receiverNickname').focus();
				}else{
					console.log($('#searchIds li')[index-1]);
					$('#searchIds li')[index-1].focus();					
				}
			// 방향키 아래로
			}else if(e.keyCode==40){
				index+=1;
				if(index>maxIndex){
					index=1;
				}
				console.log($('#searchIds li')[index-1]);
				$('#searchIds li')[index-1].focus();
			// 선택 후 엔터
			}else if(e.keyCode==13){
				$('#searchIds li')[index-1].click();
				$('#checkNickNo').hide();
			}
			console.log(index);
		});
		
		
		// input 태그로(키보드)
		$('#receiverNickname').on('keyup', function(e){
			var keyword = $(this).val();
			console.log("search() keyword="+keyword);
			if(e.keyCode==38){
				index-=1;
				if(index<0){
					index=maxIndex;
				}
				if(index==0){
					$('#searchIds').focus();
				}else{
					console.log($('#searchIds li')[index-1]);
					$('#searchIds li')[index-1].focus();
					
				}
				
			}else if(e.keyCode==40){
				index+=1;
				if(index>maxIndex){
					index=1;
				}
				console.log($('#searchIds li')[index-1]);
				$('#searchIds li')[index-1].focus();
			}
			console.log(index);
			if(keyword == '') {
				$('#searchIds').html('');
				$('#searchIds').css('display', 'none');
			}else if(currentKeyword!=keyword){
				var url = '../message/search/'+keyword;
				$.getJSON(
					url,
					function(data) {
						$('#searchIds').html('');
						console.log(data);
						if(data=='') {
							$('#searchIds').css('display', 'none');
						}else {
							maxIndex=data.length;
							$(data).each(function(num,val){
								$('#searchIds').css('display', 'block');
								var searchIds = $('#searchIds').html();
								searchIds += '<li class="memNick" onclick="selectNick(this);" tabindex="-1">'+this+'</li>';
								console.log(this);
								$('#searchIds').html(searchIds);
							}); //end .each()
						}
					}
				); //end getJSON()
				 currentKeyword = keyword;
				index=0;
			}
		}); //end .on'keyup'
		
		// 검색 리스트 가리기
		$('html').on('click',function(e){
			var target = e.target;
			if($(target).attr('id')=='searchIds'||$(target).attr('class')=='memNick'||$(target).attr('id')=='receiverNickname'){
				return;
			}
			$('#searchIds').css('display', 'none');
		});
		$('#messageTitle').on('focus',function(){
			$('#searchIds').css('display', 'none');
		});
		
		// 수신인 체크
		$('#receiverNickname').on('blur', function(){
			console.log("receiverNickname 조회 체크")
			
			var nickname = $('#receiverNickname').val();
			console.log('nickname = ' + nickname);
			
			$.ajax({
				type : 'POST',
				url : "../member/checkNickname",
				data : {nickname : nickname},
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
				success : function(result) {
					console.log("중복? " + result);
					if(result == 'dupl'){
						$('#checkNickNo').hide();
					} else {
						$('#checkNickNo').show();
					}
				}
			}); //end ajax
			
		}); //end nickname.blur()
		
	}); //end document
	
	// List에서 input 태그로(마우스)
	function selectNick(clkMe) {
		var clk = $(clkMe).text();
		console.log("id 클릭 성공?"+clk);
		var nick = clk.split(' ')[0];
		$('#receiverNickname').val(nick);
		$('#checkNickNo').hide();
		$('#searchIds').css('display', 'none');
	}

	/* function keyNavi(event) {
		var selectItem = null;
		var itemList = $('#searchIds li');
		console.log(itemList);
		console.log("keyNavi()");
		if(itemList.length) { // itemList가 있을때
			console.log("itemList있다.");
			if(event.keyCode == 38 || event.keyCode == 40) { // 38: 위로, 40: 아래로
				event.preventDefault(); // 기본 동작 중단
				if(selectItem) {
					selectItem.removeClass('selected');
				}
				var nextItem;
	            if (event.keyCode === 38) {
	                // 위쪽 화살표 키
	                nextItem = selectItem ? selectItem.prev() : itemList.last();
	            } else {
	                // 아래쪽 화살표 키
	                nextItem = selectItem ? selectItem.next() : itemList.first();
	            }
	            
	            if (nextItem.length) {
	            	selectItem = nextItem.addClass('selected');
	                $('#receiverNickname').val(selectItem.text().split(' ')[0]);
	            }
			} else if (event.keyCode === 13 && selectItem) {
	            // Enter 키가 눌렸을 때, 선택 트리거 실행
	            selectNick(selectItem);
			}
		}
	} //end keyNavi() */
	
</script>
</body>
</html>