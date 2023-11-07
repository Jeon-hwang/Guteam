<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="style.jsp"></jsp:include>
<meta charset="UTF-8" >
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>실시간 채팅방</title>
</head>
<body>
<header>
	<div class="logo">
		<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
</header>
<section>
	<div id="wrap">
	<div class="titleArea">
	<h4>구팀 실시간 채팅방</h4>
	</div>
	<div class="chatArea px-3" id="chat">
	
	</div>
	<div class="messageFormArea">
	<form id="chatForm">
		<input type="text" id="message" required="required"/>
		<button class="btn btn-secondary"><i class="bi bi-chat-quote"></i></button>
	</form>
	</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		$("#message").val('').focus();
		$("#chatForm").submit(function(event){
			event.preventDefault();
			sock.send($("#message").val());
			$("#message").val('').focus();
		});
	});
	
	var sock = new SockJS("/guteam/echo");
	sock.onmessage = function(e){		
		$("#chat").append(e.data +'<span class="time">('+dateFormat(new Date(e.timeStamp))+')</span></div>'+"<br/>");
		$('.chatArea').scrollTop($('.chatArea').prop('scrollHeight'));
	}
	
	sock.onclose = function(){
		$("#chat").append("연결 종료");
	}
	
	function dateFormat(date) {
        var hour = date.getHours();
        var minute = date.getMinutes();	
        var second = date.getSeconds();

        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;
        second = second >= 10 ? second : '0' + second;

        return hour + ':' + minute + ':' + second;
	}
</script>
</body>
</html>