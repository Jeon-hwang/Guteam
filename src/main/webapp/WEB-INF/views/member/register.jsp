<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap css -->
<!-- Bootstrap css -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
   crossorigin="anonymous" />
<!-- Bootstrap icons -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
   rel="stylesheet" />
<!-- Bootstrap core JS-->
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js">
</script>
<style type="text/css">
body {
background-color:grey;
padding:20px 80px;

}

.profileImg {
	width : 100px;
	height : 100px;
	border : 1px solid grey;
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : 회원 가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
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
						$('#btnCheck').hide();
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
				
			}); //end click()
			
		}); //end document
		
	</script>
</body>

</html>