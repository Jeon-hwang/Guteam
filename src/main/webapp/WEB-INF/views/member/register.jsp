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
.titleArea {
	justify-content: center;
}
span {
	color:#fff;
	font-weight:bolder;
}
.container {
	width: 450px;
	display: flex;
	flex-direction: column;
    flex-wrap: wrap;
	border: solid snow 5px;
	border-radius: 30px;
    margin-top: 20px;
}

.infoArea {
	margin: 0px;
	display: flex;
    flex-wrap: wrap;
    justify-content: space-evenly;
}
.inputBox {
	height: 45px;
    vertical-align: super;
    font-size: 20px;
}
.selBox {
	width: 365px;
    display: flex;
    justify-content: flex-end;
}
#emailAddress {
	width: 120px;
	height: 30px;
	display: flex;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
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
		<div class="info">
		<form action="register" method="post" id="register">
		<sec:csrfInput/>
			<div class="infoArea">
				<i class="bi bi-person fs-2"></i>
				<input type="text" id="memberId" name="memberId" class="inputBox" placeholder="ID 입력" required />
				<span id="checkOk" style="display:none; color:#10af85;">사용 가능한 아이디입니다.</span>
				<span id="checkNo" style="display:none; color:#e2252b;">아이디가 이미 존재합니다.</span>
				
				<span id="failLength" style="display:none; color:#fff;">ID는 4~12 글자로 입력해 주세요.</span>
				<span id="failKor" style="display:none; color:#fff;">ID는 영어 또는 숫자만 가능합니다.</span>
			</div>
			<br>
			<div class="infoArea">
				<i class="bi bi-file-lock2 fs-2"></i>
				<input type="password" id="pwd" name="password" class="inputBox" placeholder="PW 입력" required />	
				<span id="checkPwd" style="display:none; color:#fff; width: 260px; font-size: 14px;">8자 이상, 최소한 영문, 숫자, 특수기호를 1자씩 사용해 주세요.<br>특수기호 : (!@#$%^&*?.)</span>
			</div>
			<br>
			<div class="infoArea">
				<i class="bi bi-file-lock2-fill fs-2"></i>
				<input type="password" id="pwdCheck" class="inputBox" placeholder="PW 확인" required />
				<span id="checkPwdYes" style="display:none; color:#10af85">비밀 번호가 일치합니다.</span>
				<span id="checkPwdNo" style="display:none; color:#fff">비밀 번호가 일치하지 않습니다.</span>
			</div>
			<br>
			<div class="infoArea">
				<i class="bi bi-person fs-2"></i>
				<input type="text" id="nickname" name="nickname" class="inputBox" placeholder="닉네임" required />
				<span id="checkNickNoGood" style="display:none; color:#e2252b;">올바른 닉네임(영문/숫자/한글만 가능)을 사용해주세요.</span>
				<span id="checkNickNo" style="display:none; color:#e2252b;">사용 중인 닉네임입니다.</span>
				<span id="checkNickY" style="display:none; color:#10af85;">사용 가능한 닉네임입니다.</span>
			</div>
			<br>
			<div class="infoArea">
				<i class="bi bi-envelope fs-2"></i>
				<div>
				<input type="text" name="emailId" id="emailId" class="inputBox" style="width:120px;" required />
				<i class="bi bi-at fs-2"></i>
				<input type="text" name="emailTxt" id="emailTxt" class="inputBox" style="width:122px;" required />
				</div>
				<div class="selBox">
				<select name="emailAddress" id="emailAddress">
					<option id="emailSelf" value="">직접입력</option>
					<option value="naver.com">naver.com</option>
					<option value="gamail.com">gamail.com</option>
					<option value="nate.com">nate.com</option>
					<option value="hanmail.com">hanmail.com</option>
					<option value="guteam.com">guteam.com</option>
				</select>
				</div>
				<div id="emailChk"></div>
				<input type="hidden" id="email" name="email">
			</div>
			<br>
			<div class="infoArea">
				<i class="bi bi-phone fs-2"></i>
				<input type="tel" name="phone" id="phone" class="inputBox" placeholder="휴대폰 번호 입력" required />
				<span id="checkPh" style="display:none;" >연락처를 정확히 입력해 주세요.</span>
			</div>
			<br>
			<div class="infoArea">
				<div class="g-recaptcha" data-sitekey="6LdPLykpAAAAAHv6qvYt_XfpJhIIhZ-Gx4FPK4yC"></div>
			</div>
			<br>
			<input type="hidden" name="memberImageName" value="/default.jpeg">
			<input type="hidden" name="isAdmin" value="N" />
			<div style="width:250px; display:flex; justify-content: flex-end;">
				<input type="submit" class="btn btn-light" value="가입">
			</div>
		</form>
		</div>
</div>
</div>
</section>

<script type="text/javascript">
	$(document).ready(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		// ------ 유효성 검사 ------
		
		// id 길이
		function idLength(str) {
			  return (str.length >= 4 && str.length <= 12);
			}
		// id 영어 숫자만
		function idOnly(str) {
			  return /^[A-Za-z0-9][A-Za-z0-9]*$/.test(str);
			}
		// -- id 유효성 --
		$('#memberId').on("change keyup keydown", function() {
			console.log(".onkeyup");
			// 입력시
			if($('#memberId').val().length != 0) {
				// 영어숫자 외 입력?
				if(idOnly($('#memberId').val()) === false) {
					$('#checkOk').hide();
					$('#checkNo').hide();
					$('#failKor').show();
				}
				// id 길이
				else if(idLength($('#memberId').val()) === false) {
					$('#checkOk').hide();
					$('#checkNo').hide();
					$('#failLength').show();
				}
				// 모두 만족시
				else if(idOnly($('#memberId').val()) === true && idLength($('#memberId').val()) === true) {
					$('#failKor').hide();
					$('#failLength').hide();
					console.log("id중복 검사 체크");
					
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
				}
				else {
					$('#failKor').hide();
					$('#failLength').hide();
				}
			}
			// 미입력시
			else {
				// 메시지 가리기
				$('#failKor').hide();
				$('#failLength').hide();
				
				if($('#memberId').val() == '') {
					$('#checkNo').hide();
					$('#checkOk').hide();
					return;
				}
			}
		}); //end #memberId.keyup()
		
		// 비밀번호 검증 (8글자 이상, 영문, 숫자, 특수문자 사용)
		function pwdOnly (str) {
			  return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*?.])[A-Za-z\d!@#$%^&*?.]{8,}$/.test(str);
			}
		// 비밀번호를 확인하는 확인
		function pwdChk (pwd1, pwd2) {
			return pwd1 === pwd2;
		}
		
		// pw 유효성
		$('#pwd').on("change keyup keydown", function() {
			if($('#pwd').val().length != 0) {
				// 비번 검증
				if(pwdOnly($('#pwd').val()) === false) {
					console.log(pwdOnly($('#pwd').val()));
					$('#checkPwd').show();
				}
				else if(pwdOnly($('#pwd').val()) === true){
					console.log(pwdOnly($('#pwd').val()));
					$('#checkPwd').hide();
				}
				else {
					$('#checkPwd').hide();
				}
			}
			// 미입력시
			else {
				$('#checkPwd').hide();
			}
		}); //end #password.keyup()
		
		// pw 확인
		$('#pwdCheck').on("change keyup keydown", function(){
			if($('#pwdCheck').val().length != 0) {
				if(pwdChk($('#pwd').val(), $('#pwdCheck').val())) {
					$('#checkPwdNo').hide();
					$('#checkPwdYes').show();
				} else {
					$('#checkPwdYes').hide();
					$('#checkPwdNo').show();
				}
			} else {
				$('#checkPwdYes').hide();
				$('#checkPwdNo').show();
			}
		}); //end #pwdChk.keyup()
		
		// 닉네임 길이
		function nickLength(str) {
			  return (str.length >= 1 && str.length <= 10);
		}
		
		// 닉네임 중복 체크
		$('#nickname').blur(function(){
			console.log("nickname중복 검사 체크")
			// id 미입력
			if($('#nickname').val() == '') {
				alert('닉네임을 입력해 주세요.');
				$('#checkNickNo').hide();
				$('#checkNickY').hide();
				return;
			}
			
			var nickname = $('#nickname').val();
			console.log('nickname = ' + nickname);
			
			var pattern = /([^0-9a-zA-Z가-힣!@#\$%\^&\*_\-+~`\x20])/i;
			if(nickLength(nickname) == false) {
				alert("닉네임은 2 ~ 10글자로 지어주세요.")
				$('#checkNickNoGood').show();
				$('#checkNickY').hide();
			} else {
				if(pattern.test(nickname)){
					$('#checkNickNoGood').show();
					return;
				}else{
					$('#checkNickNoGood').hide();
				}
				
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
							$('#checkNickNo').show();
							$('#checkNickY').hide();// 닉넴 중복
						} else {
							$('#checkNickNo').hide();
							$('#checkNickY').show();
						}
					}
				}); //end ajax
				
				
			}
			
		}); //end nickname.blur()
		
		// email 선택옵션
		$('#emailAddress').on("change keyup keydown", function(){
			var val = $(this).val();
			var front = $('#emailId').val();
			console.log(val);
			if(!val == '') {
				$('#emailTxt').val(val);
				$('#emailTxt').attr('readonly','readonly');
			}else{
				$('#emailTxt').on('change keyup keydown',function(){
					var val = $(this).val();
					var front = $('#emailId').val();
					var domain = $('#emailTxt').val().substr(($('#emailTxt').val().lastIndexOf('.'))+1);
					if($('#emailTxt').val().indexOf('.')==-1|| $('#emailTxt').val().indexOf('.')==0 || domain.length<2){
						$('#emailChk').html('<span>올바른 이메일 형식이 아닙니다.</span>');
					}else{
						$('#emailChk').html('');
					}
					$('#email').val(front + "@" + val);
					console.log("email? = " + $('#email').val());
				});
				$('#emailTxt').removeAttr('readonly');
				return;
			}
			var domain = $('#emailTxt').val().substr(($('#emailTxt').val().lastIndexOf('.'))+1);
			if($('#emailTxt').val().indexOf('.')==-1|| $('#emailTxt').val().indexOf('.')==0 || domain.length<2){
				$('#emailChk').html('<span>올바른 이메일 형식이 아닙니다.</span>');
			}else{
				$('#emailChk').html('');
			}
			$('#email').val(front + "@" + val);
			console.log("email? = " + $('#email').val());
		}); //end #emailAddress.on()
		
		// email 검증
		$('#emailTxt').on('change keyup keydown blur', function(){
			var domain = $('#emailTxt').val().substr(($('#emailTxt').val().lastIndexOf('.'))+1);
			if($('#emailTxt').val().indexOf('.')==-1|| $('#emailTxt').val().indexOf('.')==0 || domain.length<2){
				$('#emailChk').html('<span>올바른 이메일 형식이 아닙니다.</span>');
			}else{
				$('#emailChk').html('');
			}
		});
		
		
		// 폰번호 유효성
		function phoneOnly(val){
			return /^(?=.*[0-9])[0-9]{11,11}$/.test(val);				
		} 
		$('#phone').on("change keyup keydown", function(){
			var regExp = /^010-([0-9]{4})-([0-9]{4})$/;
			var phone = $('#phone').val().replaceAll('-','');
			if(phone.length>3&&phone.length<=7){
				console.log(phone);
				var firstNum = phone.substr(0,3);
				var midNum = phone.substr(3);
				console.log('first:'+firstNum+', mid:'+midNum);
				$('#phone').val(firstNum+'-'+midNum);
			}else if(phone.length>7){
				console.log(phone);
				var firstNum = phone.substr(0,3);
				var midNum = phone.substr(3,4);
				var lastNum = phone.substr(7,4);
				console.log('first:'+firstNum+', mid:'+midNum+', last:'+lastNum);
				$('#phone').val(firstNum+'-'+midNum+'-'+lastNum);
			}
			if(!phoneOnly(phone)){
				console.log('번호아님');
				$('#checkPh').show();
			}
			phone = $('#phone').val();
			if(regExp.test(phone)){
				$('#checkPh').hide();
			} else {
				$('#checkPh').show();
				console.log('why');
			}
			var pattern = /[^0-9-]/g;		
			if(pattern.test(phone)){
				phone=phone.replaceAll(pattern,'');
				$('#phone').val(phone);
			}
		}); //end #phone.on()
		
		
		// 유효성 미검증시, submit 막기
		$('#register').submit(function(e){
			 $.ajax({
				url: '../member/verifyRecaptcha',
				type: 'post',
				data: {
					recaptcha: $("#g-recaptcha-response").val()
				},
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
				success: function(data) {
					switch (data) {
						case 0: 
							console.log("자동 가입 방지 봇 통과");
							break;
						case 1: 
							alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
							return false;
						case -1: 
							alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
							return false;
					}
				}
			}); //end ajax()
			
			
			var autofocusAt = '';
			var checkOk = $('#checkOk').is(':visible');
			if(checkOk==false){
				autofocusAt='#memberId';
			}
			var checkPwd = $('#checkPwd').is(':visible'); // hide
			if(checkPwd==true){
				autofocusAt='#pwd';
			}
			var checkPwdYes = $('#checkPwdYes').is(':visible');
			if(checkPwdYes==false){
				autofocusAt='#pwdCheck';
			}
			var checkNickY = $('#checkNickY').is(':visible');
			if(checkNickY==false){
				autofocusAt='#nickname';
			}
			var checkEmail = $('#emailChk').html();
			if(checkEmail!=''){
				autofocusAt='#emailTxt';
			}
			var checkPh = $('#checkPh').is(':visible'); // hide
			if(checkPh==true){
				autofocusAt='#phone';
			}
			if(autofocusAt==''){				
				return true;
			}else{
				console.log(autofocusAt);
				$(autofocusAt).focus();
				return false;
			}
		});
	}); //end document
	
</script>
</body>

</html>