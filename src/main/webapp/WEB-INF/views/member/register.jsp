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
	<form action="register" method="post" id="register">
	<sec:csrfInput/>
		<div class="info">
			<div>
				<span>아이디 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="memberId" name="memberId" placeholder="ID 입력" required /></span>
				<span id="checkOk" style="display:none; color:#10af85;">사용 가능한 아이디입니다.</span>
				<span id="checkNo" style="display:none; color:#e2252b;">아이디가 이미 존재합니다.</span>
				<br>
				<span id="failLength" style="display:none; color:#fff;">ID는 4~12 글자로 입력해 주세요.</span>
				<span id="failKor" style="display:none; color:#fff;">ID는 영어 또는 숫자만 가능합니다.</span>
			</div>
			<br>
			<div>
				<span>비밀번호 :&nbsp;<input type="password" id="pwd" name="password" placeholder="PW 입력" required /></span>
				<br>
				<span id="checkPwd" style="display:none; color:#fff">8자 이상, 최소한 영문, 숫자, 특수기호를 1자씩 사용해 주세요.<br>특수기호 : (!@#$%^&*?.)</span>
			</div>
			<br>
			<div>
				<span>비번확인 :&nbsp;<input type="password" id="pwdCheck" name="password" placeholder="PW 확인" required /></span>
				<span id="checkPwdYes" style="display:none; color:#10af85">비밀 번호가 일치합니다.</span>
				<span id="checkPwdNo" style="display:none; color:#fff">비밀 번호가 일치하지 않습니다.</span>
			</div>
			<br>
			<div>
				<span>닉네임 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="nickname" name="nickname" placeholder="닉네임" required /></span>
				<span id="checkNickNo" style="display:none; color:#e2252b;">사용 중인 닉네임입니다.</span>
				<span id="checkNickY" style="display:none; color:#10af85;">사용 가능한 닉네임입니다.</span>
			</div>
			<br>
			<div>
				<span>이메일 :&nbsp;
					<input type="text" name="emailId" id="emailId" style="width:120px;" required />@</span>
					<input type="text" name="emailTxt" id="emailTxt" style="width:120px;" required />
					<select name="emailAddress" id="emailAddress">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gamail.com">gamail.com</option>
						<option value="nate.com">nate.com</option>
						<option value="hanmail.com">hanmail.com</option>
						<option value="guteam.com">guteam.com</option>
					</select>
					<div id="emailChk"></div>
			</div>
			<br>
			<div>
				<span> 연락처 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="tel" name="phone" id="phone" required /></span>
				<span id="checkPh" style="display:none;" >연락처를 정확히 입력해 주세요.</span>
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
			
		}); //end nickname.blur()
		
		// email 선택옵션
		$('#emailAddress').on("change keyup keydown", function(){
			var val = $(this).val();
			var front = $('#emailId').val();
			$("option:selected", this);
			
			$("option:selected", this).attr("value");
			console.log("val = " + val);
			$('#emailTxt').val(val);
			$('#email').val(front + "@" + val);
		}); //end 
		$('#emailTxt').on('change keyup keydown blur', function(){
			var domain = $('#emailTxt').val().substr(($('#emailTxt').val().lastIndexOf('.'))+1);
			if($('#emailTxt').val().indexOf('.')==-1 || domain.length<2){
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