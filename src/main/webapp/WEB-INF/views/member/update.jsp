<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
span {
	color:#fff;
	font-weight:bolder;
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : 회원 정보 수정</title>
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
<div class="container">
	<div class="titleArea">
		<h2>회원 정보 수정</h2>
	</div>
	<form action="update" method="post" enctype="multipart/form-data" id="update">
	<sec:csrfInput/>
		<div class="info">
			<input type="hidden" name="memberId" value="${vo.memberId }" />
			<input type="hidden" name="password" value="${vo.password }" />
			
			<span>닉네임 :&nbsp;&nbsp;
				<input type="text" name="nickname" id="nickname" value="${vo.nickname }" required />
				<span id="checkNickNoGood" style="display:none; color:#e2252b;">올바른 닉네임(영문/숫자/한글만 가능)을 사용해주세요.</span>
				<span id="checkNickNo" style="display:none; color:#e2252b;">사용 중인 닉네임입니다.</span>
				<span id="checkNickY" style="display:none; color:#10af85;">사용 가능한 닉네임입니다.</span>
			</span>
			<br>
			<br>
			<span>이메일 :&nbsp;&nbsp;
				<input type="text" name="email" id="email" value="${vo.email }" required />
			</span>
			<br>
			<br>
			<span>연락처 :&nbsp;&nbsp;
				<input type="text" name="phone" id="phone" value="${vo.phone }" required />
			</span>
			<br>
			<br>
			<span>
				프로필 사진
			</span>
			<br>
			<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly /><br>
			<input type="file" name="file" id="file" accept="image/*" onchange="display(event)" /><br>
			<input type="hidden" id="memberImageName" name="memberImageName" value="${vo.memberImageName }">
			<input type="hidden" name="isAdmin" value="N" />
			<div style="width:250px; display:flex; justify-content: flex-end;">
				<input type="submit" value="수정" />
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
		// 닉네임 길이
		function nickLength(str) {
			  return (str.length >= 1 && str.length <= 10);
		}
		
		// 닉네임 중복 체크
		$('#nickname').blur(function(){
			console.log("nickname중복 검사 체크")
			// 미입력
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
		
		// email 유효성 검사
		$('#email').on('blur', function(){
			var pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
			var email = $('#email').val();
			console.log(email);
		    if(pattern.test(email) === false) { 
		    	alert("이메일형식이 올바르지 않습니다.");
		    	
		    }
			
		});
		
		// 폰번호 유효성 검사
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
		$('#update').submit(function(e){
			var autofocusAt = '';
			
			var checkNickY = $('#checkNickY').is(':visible');
			if(checkNickY==false){
				autofocusAt='#nickname';
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
	
	function display(event){
       var reader = new FileReader();
       reader.onload = function(event){
          $('.profileImg').attr('src', event.target.result);
       }
       reader.readAsDataURL(event.target.files[0]);
       console.log(event.target.result);
    }; // display

</script>
</body>
</html>