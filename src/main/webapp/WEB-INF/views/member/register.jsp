<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<meta charset="UTF-8">
<title>GUTEAM : 회원 가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
	<h2>회원 가입</h2>

	<form action="register" method="post">
	<sec:csrfInput/>
		<div>
			아이디 :
			<input type="text" id="memberId" name="memberId" placeholder="ID 입력" required />
			<span id="checkOk" style="display:none; color:green; text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;">사용 가능한 아이디입니다.</span>
			<span id="checkNo" style="display:none; color:red; text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;" >아이디가 이미 존재합니다.</span><br>
			비번 :&nbsp;&nbsp;&nbsp;
			<input type="password" name="password" placeholder="PW 입력" required /><br>
			닉네임 :
			<input type="text" id="nickname" name="nickname" placeholder="닉네임" required />
			<span id="nickCheckNo" style="display:none; color:red; text-shadow: -1px 0 #000, 0 1px #000, 1px 0 #000, 0 -1px #000;" >사용 중인 닉네임입니다.</span><br>
			이메일 :
			<input type="text" name="email" required /><br>
			연락처 :
			<input type="text" name="phone" required /><br>
			<input type="hidden" name="memberImageName" value="/default.jpeg">
			<input type="hidden" name="isAdmin" value="N" />
			<input type="submit" value="가입">
		</div>
	</form>
</div>
</div>
</section>

<script type="text/javascript">
	$(document).ready(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		// ID 중복 검사
		// 검사 후 id 변경시, 재검사
		$('#memberId').blur(function(){
			console.log("id중복 검사 체크")
			// id 미입력
			if($('#memberId').val() == '') {
				alert('아이디를 입력해 주세요.')
				$('#checkNo').hide();
				$('#checkOk').hide();
				return;
			}
			
			var memberId = $('#memberId').val();
			console.log('memberId = ' + memberId);
			
			$.ajax({
				type : 'POST',
				url : "../member/checkId",
				data : {memberId : memberId},
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
				success : function(result) {
					console.log("중복? " + result);
					if(result != 'fail'){
						$('#checkOk').hide();
						$('#checkNo').show(); //id 중복
					} else {
						$('#checkNo').hide();
						$('#checkOk').show(); //id 사용가능
					}
				}
			}); //end ajax
			
		}); //end memberId.blur()
		
		// 닉네임 중복 체크
		$('#nickname').blur(function(){
			console.log("nickname중복 검사 체크")
			// id 미입력
			if($('#nickname').val() == '') {
				alert('닉네임을 입력해 주세요.')
				$('#nickCheckNo').hide();
				return;
			}
			
			var nickname = $('#nickname').val();
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
						$('#nickCheckNo').show(); // 닉넴 중복
					} else {
						$('#nickCheckNo').hide();
					}
				}
			}); //end ajax
			
		}); //end nickname.blur()
		
	}); //end document
	
</script>
</body>

</html>