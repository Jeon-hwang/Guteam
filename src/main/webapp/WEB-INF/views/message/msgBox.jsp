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
.logoImg {
	display:flex;
	width: 70px;
	height: 70px;
	margin: 25px;
}
#full {
	display:flex;
	width : 750px;
	height : 420px;
}
#leftMenu {
	display:flex;
	flex-direction: column;
	width : 120px;
	height : 400px;
}
#m-board {
	display:flex;
	flex-direction: column;
}
#board-top {
	display:flex;
	flex-wrap: wrap;
	padding-top : 5px;
	padding-left : 5px;
	padding-right : 5px;
    padding-bottom : 5px;
	width : 590px;
	height : 50px;
}
#main {
	display: flex;
    flex-flow: column wrap;
    flex-direction: row;
    justify-content: space-around;
    align-content: flex-start;
    background-color: #666666;
    width: 590px;
    height: 350px;
}
#board-btm {
	display: flex;
}
#board-btm li {
	color: #e5e5dc;
}
ul.left{
	margin: 0px;
    padding-left : 10px;
    padding-right : 10px;
    padding-bottom : 0px;
   	list-style : none;
   	text-align : center;
   	display: flex;
   	flex-direction: column;
}
li {
	display : inline-block;
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
table {
	width: 100%;
}
thead {
	width: 100%;
	background-color : #bcc2e5;
	text-align : center;
}
th {
	border-left : solid 1px gray;
}
tr {
	height: 35px;
}
td {
	color: #e5e5dc;
	border: solid 1px #bcc2e5;	
	
}
.td {
	text-align : center;
	white-space: nowrap;
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : ${vo.memberId }님의 쪽지 보관함</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<div id="full">
<div id="leftMenu">
<img class="logoImg" alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" >
	<ul class="left">
	<li><a href="../message/write"><button class="btn btn-light">쪽지 쓰기</button></a></li>
	<br>
	<br>
	<li><a href="../message/list"><button class="btn btn-light">받은 쪽지함</button></a></li>
	<li><a href="../message/sent"><button class="btn btn-light">보낸 쪽지함</button></a></li>
	<li><a href="../message/msgBox"><button class="btn btn-light">쪽지 보관함</button></a></li>
	</ul>
</div>
<div id="m-board">
<div id="board-top">
	<button class="btn btn-light" onclick="deleteMsg()">삭제</button>
</div>
<div id="main">
<table>
	<thead>
	<tr>
		<th style="width: 5%"><label class="chkbox"><input type="checkbox" name="allChk" id="allChk"></label></th>
		<th style="width: 55%">제목</th>
		<th style="width: 24%">보낸/받은 사람</th>
		<th style="width: 16%; font-size: 10pt">보낸/받은 날짜</th>
	</tr>
	</thead>
	
	<tbody>
	<c:forEach var="svo" items="${list }">
	<tr>
		<td class="td" style="width: 30px"><label class="chkbox"><input type="checkbox" name="msgIdChk" class="here" id="msgIdChk" value="${svo.messageId }"></label></td>
		<td style="padding-left : 10px;" ><a href="../message/detail?messageId=${svo.messageId}&page=${pageMaker.criteria.page}"  class="wtf" >${svo.fromTo}${svo.title }</a></td>
		<td class="td" style="white-space: nowrap;">${svo.fromToNickname }</td>
		<td style="font-size: 10pt;"><fmt:formatDate value="${svo.dateCreated }" pattern="MM-dd HH:mm:ss" /></td>
	</tr>
	</c:forEach>
	</tbody>
</table>
<div id="board-btm">
<ul>
	<c:if test="${pageMaker.hasPrev }">
		<li><a href="msgBox?page=${pageMaker.startPageNo - 1}">이전</a></li>
	</c:if>
	<c:forEach begin="${pageMaker.startPageNo }" end="${pageMaker.endPageNo }" var="num">
		<li><a href="msgBox?page=${num }">${num }</a></li>
	</c:forEach>
	<c:if test="${pageMaker.hasNext }">
		<li><a href="msgBox?page=${pageMaker.endPageNo + 1 }">다음</a></li>
	</c:if>
</ul>
</div>
</div>
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
		console.log("게시물 수 : " +rowCnt);
		
		$('#allChk').click(function(){
			var chkArr = $('input[name="msgIdChk"]');
			console.log(chkArr);
			for(var i=0; i<chkArr.length; i++){
				chkArr[i].checked = this.checked;
				console.log(chkArr.eq(i).val());
			}
		});
		
		$('input[name="msgIdChk"]').click(function(){
			var sndRcv = $(this).closest('tr').find('.wtf').text();
			    console.log(sndRcv);
			if($('input[name="msgIdChk"]:checked').length == rowCnt) {
				$('input[name="allChk"]')[0].checked = true;
				console.log("전부체크" + $('input[name="allChk"]')[0].checked);
			} else {
				$('input[name="allChk"]')[0].checked = false;
				console.log("체크" + $('input[name="allChk"]')[0].checked);
			}
		});
	});
	
	
	
	// 쪽지 삭제 기능
	function deleteMsg() { 
		var msgArr = [];
		var sendRecv= "";
		var msgList = $('input[name="msgIdChk"]:checked'); // 체크한 게시물
		var sndRcv = msgList.closest('tr').find('.wtf').text();
	    console.log(sndRcv);
		var str = sndRcv.substr(1,2); // *substring과 substr의 인덱스 조건 차이 분명히 알기
		console.log(str);
		
		if(str === '보낸'){
			console.log("보낸 아님?");
			sendRecv='send';
		}else if(str === '받은') {
			console.log("받은 아님?");
			sendRecv='receive';
		}else {
			console.log("왜 못 받는거야 ㅡㅡ");
		}
		console.log(sendRecv);
		/* var links = document.querySelectorAll('a.wtf');
		console.log(links);
		
		links.forEach(link => {
			  var fromToValue = link.getAttribute('data-from-to');
			  console.log("fromToValue = " + fromToValue);
			  
			}); */
			
		console.log(msgList.val());// jQuery.fn.init(8)
		for(var i=0; i<msgList.length; i++) {
			if(msgList[i].checked){
				console.log("msgList[i].value="+msgList[i].value);
				msgArr.push(msgList[i].value);
			}
		}
		if(msgArr.length == 0) {
			alert("삭제할 쪽지를 선택해 주세요.");
		} else {
			console.log("msgArr="+msgArr);
			var reAlr = confirm("선택한 쪽지를 삭제합니다.");
			if (reAlr) {
			    console.log("삭제되었습니다.");
			} else {
			    console.log("삭제가 취소되었습니다.");
			}
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
						location.href='msgBox';
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