<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GUTEAM : 프로필</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
.profileImg {
	width : 50px;
	height : 50px;
	border : 1px solid grey;
}
</style>
</head>
<body>
<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />
<h2>${vo.memberId }님의 프로필</h2>
	<div>
		<a href="addCash"><button>캐쉬 충전</button></a>
		<a href="../friend/list"><button>친구 목록</button></a>
	</div>
	<br>
	<div>
		<form action="delete" method="post">
		<sec:csrfInput/>
			<a href="update"><button type="button">회원 수정</button></a>
			<input type="hidden" name="memberId" id="memberId" value="${vo.memberId }">
			<input type="submit" value="회원 탈퇴">	
		</form>
	</div>
<input type="hidden" id="alert" value="${alert }">
	
<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
			if(result == 'success'){
				alert('회원정보가 수정되었습니다!');
			}
			else if(result == 'fail'){
				alert('요청에 실패하였습니다.');
			}
	});
</script>
</body>
</html>