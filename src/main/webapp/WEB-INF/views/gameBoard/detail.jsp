<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>${vo.gameBoardTitle }</title>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style type="text/css">
.tag{
	background-color:#cee0ff;
	color:#050505;
	cursor:pointer;		
}
.ui-dialog-buttonset button{
	margin-right:8px;
	color: #6c757d;
    border-color: #6c757d;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: white;
    background-color: rgba(103, 112, 123, 0.2);
    border-width: var(--bs-border-width);
    border-color: rgba(103, 112, 123, 0.2);
    border-radius: var(--bs-border-radius);
    box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15),0 1px 1px rgba(0, 0, 0, 0.075);
    display: inline-block;
    text-align: center;
    text-decoration: none;
    vertical-align: middle;
    cursor: pointer;
    user-select: none;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.ui-dialog-buttonset button:hover{
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}
.ui-dialog-buttonset, .ui-helper-clearfix{
	background-color:#d0e0f9;
	background:#d0e0f9;
}
.ui-dialog-title, .ui-widget-header{
	background-color: #6c757d;
	background:#6c757d;
	color:#fff;
}
.ui-dialog-titlebar-close{
	display:none;
}
.ui-dialog-buttonpane ui-widget-content ui-helper-clearfix{
	display:flex;
	justify-content:space-around;
}
.ui-dialog-buttonset{
	width:100%;
	display:flex;
	justify-content:space-around;
}
</style>
</head>

<body>
<section>
	<div id="wrap">
	<div id="dialog" title="information"></div>
	<div class="board-box">
	<div class="boardTitle">
	<p>제목 : ${vo.gameBoardTitle }</p>
	<p> <i class="bi bi-person-circle"></i>  ${nickname}  <i class="bi bi-calendar3"></i>
	  <fmt:formatDate value="${vo.gameBoardDateCreated }" pattern="yyyy년 MM월 dd일" /> </p>
	</div>
	<hr>
	<input type="hidden" id="boardContent" value='${vo.gameBoardContent }'>
	<div class="boardContent">
	<p id="content"></p>
	</div>
	<div class="btn_group_detail">
	<sec:authentication property="principal" var="principal"/>
	<sec:authorize access="isAuthenticated()">
	<c:if test="${vo.deleted=='N' }">
	<c:if test="${principal.username==vo.memberId }">
	<a href="update?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}">
	<button class="btn btn-light" >게시글 수정하기</button></a>
	<form class="inline-form" onsubmit="return confirm('정말로 삭제하시겠습니까?');" action="updateDeleted" method="post">
		<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
		<sec:csrfInput/>
		<input type="submit" class="btn btn-light"  value="게시글 삭제하기">
	</form>
	</c:if>
	</c:if>
	</sec:authorize>
	<br>
	<a href="list?gameId=${gameId }&page=${page}"><button class="btn btn-light" >커뮤니티로 돌아가기</button></a>
	</div>
	<input type="hidden" id="updateResult" value="${update_result }">
	<div class="commentArea">
	<i class="bi bi-chat-left-dots-fill"></i> <span id="commentCnt">${vo.commentCnt }</span>
	<jsp:include page="../boardComment/comment_and_reply_test.jsp" />
	</div>
	</div>
	</div>
	</section>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			$('#content').html($('#boardContent').val());
			var updateResult = $('#updateResult').val();
			if (updateResult == 'success') {
				alert('게시글 정보 수정 성공');
			}
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$('.tag').on('click',function(event){
				var mpX = event.pageX;
				var mpY = event.pageY;
				$.ajax({
					url:'/guteam/member/nick/'+$(this).text(),
					method:'post',
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					success:function(data){
						var info = '<img class="tagProfileImg" alt="'+data.nickname+'" src="../game/display?fileName='+data.memberImageName+'" width="100px" height="100px" /><br>'
						+'<p><i class="bi bi-person-square"></i> : ' + data.nickname + '</p>'
						+ '<p><i class="bi bi-envelope"></i> : '+ data.email+'</p>'
						+ '<p><i class="bi bi-phone-vibrate"></i> : '+ data.phone+'</p>';
						$('#dialog').html(info);
						$('#dialog').dialog({
							resizable : false,
							buttons:{
								"닫기":function(){
									$(this).dialog("close");
								}
							}
						});
						$('#ui-id-1').text(data.memberId);
						$('.ui-widget-header').attr('style','background:#6c757d;');
						$('.ui-widget-content').attr('style','background:#d0e0f9;');
						$('#dialog').parent().attr('style','border:none;background-color:#d0e0f9;display:inline-block;position:absolute;left:'+mpX+'px;top:'+mpY+'px;');
						$('#dialog').parent().on('mouseleave',function(){
							$('#dialog').dialog('close');
						});
						
					}
				});
			});
		});// document
		
	</script>
</body>
</html>