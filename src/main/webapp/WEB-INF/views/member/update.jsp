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
	<form action="update" method="post" enctype="multipart/form-data">
	<sec:csrfInput/>
		<div class="info">
			<input type="hidden" name="memberId" value="${vo.memberId }" />
			<input type="hidden" name="password" value="${vo.password }" />
			
			<span>닉네임 :&nbsp;&nbsp;
				<input type="text" name="nickname" value="${vo.nickname }" required />
			</span>
			<br>
			<br>
			<span>이메일 :&nbsp;&nbsp;
				<input type="text" name="email" value="${vo.email }" required />
			</span>
			<br>
			<br>
			<span>연락처 :&nbsp;&nbsp;
				<input type="text" name="phone" value="${vo.phone }" required />
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