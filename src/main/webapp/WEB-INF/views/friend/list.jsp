<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>

<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>GUTEAM : 친구 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<header>
<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
</header>
<section>
<div id="wrap">
<div class="detail-box">
<div>
	<h2><input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />
	나의 친구 목록</h2>
</div>
<form action="../friend/addFriend" method="post" onsubmit="sendRequest();">
	<sec:csrfInput/>
	<input type="hidden" name="sendMemberId" id="sendMemberId" value="${vo.memberId }">
	<input type="text" name="receiveMemberId" id="receiveMemberId" placeholder="ID 입력" required>
	<input class="btn btn-light" type="submit" value="친구 추가">
</form>
<hr>
<h3>보낸 요청</h3>
<table>
	<tbody>
		<c:forEach var="vo" items="${sendList }">
		<div style="width:100px; hieght:140px; display:inline-block;" class="friendReq">
			<img alt="${vo.memberImageName }" width="100px" height="100px" src="display?fileName=${vo.memberImageName }"> 
			<input type="text" id="toNickname" value="${vo.nickname }" style="width:92px;" readonly>
		</div>
			
		</c:forEach>
	</tbody>
</table>
<hr>
<h3>받은 요청</h3>
<table>
	<tbody>
	<c:forEach var="rvo" items="${receiveList }">
		<div style="width:100px; hieght:140px; display:inline-block;" class="friendReq">
		<form action="../friend/accept" method="post">
		<sec:csrfInput/>
			<img alt="${rvo.memberImageName }" width="100px" height="100px" src="display?fileName=${rvo.memberImageName }"> 
			<input type="text" id="toNickname" value="${rvo.nickname }" style="width:92px;" readonly>
			<input type="hidden" name="memberId" value="${vo.memberId }">
			<input type="hidden" name="friendId" value="${rvo.memberId }">
			<button type="submit" formaction="../friend/accept">수락</button>
			<button type="submit" formaction="../friend/reject">거절</button>
		</form>
		</div>
		
	</c:forEach>
	</tbody>
</table>
<hr>
<h2>친구 목록</h2>
	<c:forEach var="fvo" items="${friendList }">
		<div class="friend" style="display:flex;">
			<input type="image" class="profileImg" alt="${fvo.memberId }" 
				src="display?fileName=${fvo.memberImageName }" readonly />
		<form action="../friend/delete" method="post">
			<sec:csrfInput/>
			<input type="text" id="toNickname" value="${fvo.nickname }" style="width:92px;" readonly>
			<input type="hidden" name="friendId" id="friendId" value="${fvo.memberId }">
			<input type="submit" value="친구삭제">
		</form>
		</div>
	</c:forEach>

<input type="hidden" id="alert" value="${alert }">
</div>
</div>
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>

<script type="text/javascript">
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$(document).ready(function(){
		var result = $('#alert').val();
			if(result == 'friend'){
				alert('이미 친구인 유저입니다.')
			}else if(result == 'alreadyFrd'){
				alert('먼저 친구 요청 받아 친구가 되었습니다.')
			} else if(result == 'dupl'){
				alert('이미 친구 요청된 아이디입니다.');
			} else if(result=='success'){
				alert('친구요청이 완료되었습니다.');
			} else if(result == 'fail'){
				alert('없는 아이디입니다.');
			} 
	});
	function sendRequest(){
		var memberId = $('#receiveMemberId').val();
		var sendMemberId = $('#sendMemberId').val();
		console.log('ajax요청');
		$.ajax({
			type:'post',
			url:'/guteam/sse/friendRequest/'+memberId,
			beforeSend : function(xhr) {
		        xhr.setRequestHeader(header, token);
		    },
			data:{'sendMemberId':sendMemberId},
			success:function(result){
				console.log('친구 요청을 보냈습니다.');
			}
		});
	}
	
</script>
</body>
</html>