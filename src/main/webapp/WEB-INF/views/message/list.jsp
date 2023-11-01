<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.profileImg {
	width : 40px;
	height : 40px;
	border : 1px solid grey;
}
body {
    margin: 0;
    padding: 0;
}
#full {
	width : 703px;
	height : 410px;
}
#leftMenu {
	width : 110px;
	height : 400px;
	float : left;
}
#board-top {
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 580px;
	height : 50px;
	float : left;
}
#main {
	background-color : lightgray;
	width : 580px;
	height : 350px;
	float : left;
}
ul{
	margin: 0px;
    padding-top : 20px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
}
thead {
	background-color : darkgrey;
	text-align : center;
}
th {
	border-left : solid 1px gray;
}
#board-head {
	margin : 5px;
    
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : ${vo.memberId }님의 쪽지함</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<div><img width="110px" height="50px" src="display?fileName=/logo.png"></div>
	<ul>
	<li><a href="../message/register"><button>쪽지 쓰기</button></a></li>
	<br>
	<li><a href="../message/list"><button>받은 쪽지함</button></a></li>
	<li><button>보낸 쪽지함</button></li>
	<li><button>쪽지 보관함</button></li>
	</ul>
</div>
<div id="board-top">
	<button>삭제</button>
</div>
<div id="main">
<table>
	<thead>
	<tr>
		<th style="width: 30px"><label class="chkbox"><input type="checkbox" onclick="allCheck()"></label></th>
		<th style="width: 370px">제목</th>
		<th style="width: 100px">보낸 사람</th>
		<th style="width: 80px">보낸 날짜</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="vo" items="${list }">
	<tr>
		<td style="width: 30px"><label class="chkbox"><input type="checkbox" onclick="oneCheck()" value="${vo.messageId }"></label>></td>
		<td><a href="../message/detail?messageId=${vo.messageId}">${vo.messageTitle }</a></td>
		<td>${vo.sendMemberNickname }</td>
		<fmt:formatDate value="${vo.messageDateCreated }" pattern="MM-dd HH:mm:ss"/>
		<td>${vo.messageDateCreated }</td>
	</tr>
	</c:forEach>
	</tbody>
</table>
	
</div>

</div>
</body>
</html>