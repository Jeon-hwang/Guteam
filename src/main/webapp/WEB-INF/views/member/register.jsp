<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GUTEAM : 회원 가입</title>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<style type="text/css">
span {
	color:#fff;
	font-weight:bolder;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
<section>
<div id="wrap">
<div class="container">
	<div class="titleArea">
		<h2>회원 가입</h2>
	</div>
	<form action="register" method="post">
	<sec:csrfInput/>
		<div class="info">
			<div>
				<span>아이디 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="memberId" name="memberId" placeholder="ID 입력" required /></span>
				<span id="checkOk" style="display:none; color:#10af85;">사용 가능한 아이디입니다.</span>
				<span id="checkNo" style="display:none; color:#e2252b;">아이디가 이미 존재합니다.</span>
			</div>
			<br>
			<div>
				<span>비밀번호 :&nbsp;<input type="password" name="password" placeholder="PW 입력" required /></span>
			</div>
			<br>
			<div>
				<span>닉네임 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="nickname" name="nickname" placeholder="닉네임" required /></span>
				<span id="nickCheckNo" style="display:none; color:#e2252b;">사용 중인 닉네임입니다.</span>
			</div>
			<br>
			<div>
				<span>이메일 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="email" required /></span> 
			</div>
			<br>
			<div>
				<span> 연락처 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="phone" required /></span>
			</div>
			<br>
			<input type="hidden" name="memberImageName" value="/default.jpeg">
			<input type="hidden" name="isAdmin" value="N" />
			<div style="width:250px; display:flex; justify-content: flex-end;">
				<input type="submit" class="btn btn-light" value="가입">
			</div>
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