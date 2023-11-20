<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

</head>
<body>
	<h1>카카오 페이 테스트 예제</h1>
	
<!-- 
	kakaoPay API
	아래는 클라이언트-서버-카카오(외부서버) 이 3개가 값을 주고 받는 과정입니다.
	
		** 과정
		결제요청준비 -> 결제 요청 -> 결제 승인

		1. 클라이언트에서 서버로 주문관련정보를 Post로 던진다.
		2. 서버는 controller에서 그 값을 받아 카카오 승인요청url로 던져준다.
		3. 카카오는 승인과 동시에 다음 결제과정의 url과 tid(결제코드)을 서버로 던져주고 서버는 클라이언트에 url을 던진다.
		4. 클라언트는 그 url로 qr코드 결제 화면에 접근한다.
		5. 결제처리가 되면 카카오에서 우리 서버 controller의 결제 url로 token값을 보내준다.
		6. 서버는 그 토큰과 처음에 받았던 tid로 결제승인을 요청하고 결재승인 정보를 받아온다.
		7. 주문성공페이지 url을 클라이언트에 보내고 클라이언트는 그 페이지를 서버에 요청한다.
		8. 서버가 주문완료 페이지를 클라이언트에 보내준다. 
		
		JS - ee9525481aa34d1160da9b4e2fa1b6f0
		admin - 2e7146bdfd1c57aff884a560be0d3af7
		REST API - 784bdb584ac5b2744a9ceb0d7b3a73c1
		
		
		*** cors(Cross-Origin Resource Sharing) 유의하자
		 - 웹페이지에서 ajax를 동일서버에 요청하는 건 괜찮지만 외부서버에 요청하는 순간
		 동일 origin이 아니기때문에 이 요청을 거부하는 보안관련 이슈가 생깁니다.
		 
		
-->
	

<button id="payMe">결제하기</button>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#payMe').click(function(){
			$.ajax({
				url:'../payment/kakaoPay',
				dataType: 'json',
				success: function(data){
					console.log("성공");
					alert(data.next_redirect_pc_url);
					window.open(data.next_redirect_pc_url);
					
				},
				error: function(error){
					console.log("실패");
					alert(error);
				}
			}); //end ajax
		}); //end #payMe.click()
	}); //end document
</script>

</body>
</html>