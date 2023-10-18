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
		<div>
			아이디 :
			<input type="text" id="memberId" name="memberId" placeholder="ID 입력" check_result="fail" required />
			<button type="button" id="btnCheck" >중복확인</button>
			<img id="id_check_success" style="display: none;"><br>
			비번 :&nbsp;&nbsp;&nbsp;
			<input type="password" name="password" placeholder="PW 입력" required /><br>
			닉네임 :
			<input type="text" name="nickname" placeholder="닉네임" required /><br>
			이메일 :
			<input type="text" name="email" required /><br>
			연락처 :
			<input type="text" name="phone" required /><br>
			<input type="hidden" name="memberImageName" value="img">
			<input type="hidden" name="isAdmin" value="N" />
			<input type="submit" value="가입">
		</div>
	</form>
	
	<script type="text/javascript">
	
		// ID 중복 검사
	
		// 검사 후 id 변경시, 재검사
		$('#btnCheck').click(function(){
			// id 미입력
			if($('#memberId').val() == '') {
				alert('아이디를 입력해 주세요.')
				return;
			}
			
			$('#id_check_success').hide();
			$('#btnCheck').show();
			$('#memberId').attr("check_result", "fail");
		})
		
		
		
		var inputId = $('memberId').val();
		
		$.ajax({
			url : "id_check.jsp",
			data : {
				'memberId' : inputId
			},
			
			
		}); //end ajax
		
		
		

	
	</script>
</body>
</html>