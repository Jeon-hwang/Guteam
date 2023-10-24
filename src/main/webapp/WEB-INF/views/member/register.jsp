<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GUTEAM : 회원 가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<h2>회원 가입</h2>

	<form action="register" method="post">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
		<div>
			아이디 :
			<input type="text" id="memberId" name="memberId" placeholder="ID 입력" required />
			<span id="checkOk" style="display:none; color:green;">사용 가능한 아이디입니다.</span>
			<span id="checkNo" style="display:none; color:red;" >아이디가 이미 존재합니다.</span><br>
			비번 :&nbsp;&nbsp;&nbsp;
			<input type="password" name="password" placeholder="PW 입력" required /><br>
			닉네임 :
			<input type="text" name="nickname" placeholder="닉네임" required /><br>
			이메일 :
			<input type="text" name="email" required /><br>
			연락처 :
			<input type="text" name="phone" required /><br>
			<input type="hidden" name="memberImageName" value="/default.jpeg">
			<input type="hidden" name="isAdmin" value="N" />
			<input type="submit" value="가입">
		</div>
	</form>
	
	<script type="text/javascript">
		$('document').ready(function(){
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
				console.log(memberId);
				
				$.ajax({
					type : 'POST',
					url : "../member/checkId",
					data : {memberId : memberId},
					success : function(result) {
						$('#btnCheck').hide();
						console.log("성공? " + result);
						if(result != 'fail'){
							$('#checkOk').hide();
							$('#checkNo').show(); //id 중복
						} else {
							$('#checkNo').hide();
							$('#checkOk').show(); //id 사용가능
						}
					}
				}); //end ajax
				
			}); //end click()
			
		}); //end document
		
	</script>
</body>

</html>