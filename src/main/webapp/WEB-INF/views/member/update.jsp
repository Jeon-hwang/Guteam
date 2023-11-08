<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>

<meta charset="UTF-8">
<title>GUTEAM : 회원 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
</div>
</div>
</section>

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