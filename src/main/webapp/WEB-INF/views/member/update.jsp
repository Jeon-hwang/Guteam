<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
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
<title>GUTEAM : 회원 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<h1>${vo.memberId }님의 회원 정보</h1>
	<form action="update" method="post" enctype="multipart/form-data">
	<sec:csrfInput/>
		<div>
			<input type="hidden" name="memberId" value="${vo.memberId }" />
			<input type="hidden" name="password" value="${vo.password }" />
			
			닉네임 :
			<input type="text" name="nickname" value="${vo.nickname }" required /><br>
			이메일 :
			<input type="text" name="email" value="${vo.email }" required /><br>
			연락처 :
			<input type="text" name="phone" value="${vo.phone }" required /><br><br>
			프로필 사진 <br>
			<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly /><br>
			<input type="file" name="file" id="file" accept="image/*" onchange="display(event)" /><br>
			<input type="hidden" id="memberImageName" name="memberImageName" value="${vo.memberImageName }">
			<input type="hidden" name="isAdmin" value="N" />
			<input type="submit" value="수정" />
		</div>
	</form>
	
	<script type="text/javascript">
		
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