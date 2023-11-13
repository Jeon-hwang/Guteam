<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.profileImg {
	width : 40px;
	height : 40px;
	border : 1px solid grey;
}
.cen {
	text-align : center;
}
.title {
	padding-left : 10px;
}
.btn {
	margin : 1px;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
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
ul {
	margin: 0px;
    padding-top : 20px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
   	text-align : center;
}
li {
	display : inline-block;
}
thead {
	background-color : darkgrey;
	text-align : center;
}
th {
	border-left : solid 1px gray;
}
td {
	border-left : solid 1px darkgray;	
	border-bottom : solid 1px darkgray;
}
#board-head {
	margin : 5px;
    
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : ${vo.memberId }님의 쪽지 보관함</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png">

	<ul>
	<li><a href="../message/write"><button class="btn btn-light">쪽지 쓰기</button></a></li>
	<br>
	<br>
	<li><a href="../message/list"><button class="btn btn-light">받은 쪽지함</button></a></li>
	<li><a href="../message/sent"><button class="btn btn-light">보낸 쪽지함</button></a></li>
	<li><a href="../message/msgBox"><button class="btn btn-light">쪽지 보관함</button></a></li>
	</ul>
</div>
<div id="board-top">
	<button class="btn btn-light" onclick="deleteMsg()">삭제</button>
</div>
<div id="main">
<table>
	<thead>
	<tr>
		<th class="cen" style="width: 30px"><label class="chkbox"><input type="checkbox" name="allChk" id="allChk"></label></th>
		<th style="width: 350px">제목</th>
		<th style="width: 100px">보낸/받은 사람</th>
		<th style="width: 100px">보낸/받은 날짜</th>
	</tr>
	</thead>
	
	<tbody>
	<c:forEach var="svo" items="${list }">
	<tr>
		<td class="cen" style="width: 30px"><label class="chkbox"><input type="checkbox" name="msgIdChk" id="msgIdChk" value="${svo.messageId }"></label></td>
		<td class="title"><a href="../message/detail?receiveMsgId=${svo.messageId}&page=${pageMaker.criteria.page}&box=${svo.fromTo}">${svo.fromTo}${svo.title }</a></td>
		<td class="cen" style="white-space: nowrap;">${svo.fromToNickname }</td>
		<td style="font-size: 10pt;"><fmt:formatDate value="${svo.dateCreated }" pattern="MM-dd HH:mm:ss" /></td>
	</tr>
	</c:forEach>
	</tbody>
</table>
<ul>
	<c:if test="${pageMaker.hasPrev }">
		<li><a href="list?page=${pageMaker.startPageNo - 1}">이전</a></li>
	</c:if>
	<c:forEach begin="${pageMaker.startPageNo }" end="${pageMaker.endPageNo }" var="num">
		<li><a href="list?page=${num }">${num }</a></li>
	</c:forEach>
	<c:if test="${pageMaker.hasNext }">
		<li><a href="list?page=${pageMaker.endPageNo + 1 }">다음</a></li>
	</c:if>
</ul>
</div>
</div>
<input type="hidden" id="alert" value="${alert }">

<script type="text/javascript">
	$(document).ready(function(){
		var result = $('#alert').val();
		if(result == 'send'){
			alert('쪽지를 전송하였습니다.');
		}
	}); //end document
	
	// 체크박스 전체 선택 (전체 선택 후 체크 하나 해제시 전체박스 체크해제)
	$(function(){
		var rowCnt = $('input[name="msgIdChk"]').length;
		console.log(rowCnt);
		
		$('#allChk').click(function(){
			var chkArr = $('input[name="msgIdChk"]');
			console.log(chkArr);
			for(var i=0; i<chkArr.length; i++){
				chkArr[i].checked = this.checked;
				console.log(chkArr.eq(i).val());
			}
		});
		
		$('input[name="msgIdChk"]').click(function(){
			if($('input[name="msgIdChk"]:checked').length == rowCnt) {
				$('input[name="allChk"]')[0].checked = true;
				console.log($('input[name="allChk"]')[0].checked);
			} else {
				$('input[name="allChk"]')[0].checked = false;
				console.log($('input[name="allChk"]')[0].checked);
			}
		});
	});
	
	// 쪽지 삭제 기능
	function deleteMsg() {
		var msgArr = [];
		var msgList = $('input[name="msgIdChk"]:checked');
		var sendRecv = 'receive';
		console.log(msgList); // jQuery.fn.init(8)
		for(var i=0; i<msgList.length; i++) {
			if(msgList[i].checked){
				msgArr.push(msgList[i].value);
			}
		}
		if(msgArr.length == 0) {
			alert("삭제할 쪽지를 선택해 주세요.");
		} else {
			console.log(msgArr);
			var reAlr = confirm("선택한 쪽지를 삭제합니다.");
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			// 쪽지 삭제(ajax)
			$.ajax({
				type : 'DELETE',
				url : '../message/delete/'+sendRecv,
				contentType: 'application/json',
				data : JSON.stringify(msgArr),
				beforeSend : function(xhr) {
			        xhr.setRequestHeader(header, token);
			    },
				success : function(result){
					console.log(result);
					if(result == 1) {
						alert("삭제가 완료되었습니다.")
						location.href='list';
					}else{
						alert("삭제 실패");
					}
				}
				
			}); //end .ajax(삭제)
		}
	} //end deleteMsg()
</script>

</body>
</html>