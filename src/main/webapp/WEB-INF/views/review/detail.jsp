<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>${reviewVO.reviewTitle }</title>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
<section>
	<div id="wrap">
	<div class="board-box">
	<div class="boardTitle">
	<p>제목 : ${reviewVO.reviewTitle }</p>
	<p><i class="bi bi-person-circle"></i> ${nickname }
	<i class="bi bi-calendar3"></i> <fmt:formatDate value="${reviewVO.reviewDateCreated}" pattern="yyyy년 MM월 dd일" /></p>
	</div>
	<div class="boardContent">
	<p>평점 : <c:forEach begin="1" end="${reviewVO.rating/2 }" step="1">
				<i class="bi bi-star-fill"></i>
				</c:forEach>
				<c:if test="${reviewVO.rating%2==1 }">
				<i class="bi bi-star-half"></i>
				</c:if>
				<c:forEach begin="1" end="${5-(reviewVO.rating/2) }" step="1">
				<i class="bi bi-star"></i>
				</c:forEach></p>
	추천 수 : <div id="thumbUpCount">${reviewVO.thumbUpCount }</div>
	</div>
	<div class="boardContent">
	내용 : ${reviewVO.reviewContent }<br>
	</div>
<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
<sec:authentication property="principal" var="principal"/>
<input type="hidden" id="reviewId" value="${reviewVO.reviewId }">
<input type="hidden" id="memberId" value="${principal.username }">
</sec:authorize>
</div>
<div class="btn_group_detail">
<c:if test="${principal.username==reviewVO.memberId }">
<a href="update?reviewId=${reviewVO.reviewId }&page=${page}"><button class="btn btn-light" >수정</button></a>
<form class="inline-form" action="delete" onsubmit="return confirm('정말로 삭제하시겠습니까?');" method="post">
<sec:csrfInput/>
<input type="hidden" name="reviewId" value="${reviewVO.reviewId }">
<input type="hidden" name="gameId" value="${gameVO.gameId }">
<input class="btn btn-light" type="submit" value="삭제"></form>
</c:if>
</div>
<div class="btn_group_detail">
<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
<c:if test="${principal.username!=reviewVO.memberId }">
<button type="button" id="thumbUp" class="btn btn-light" value="${thumbVO.upDown }"><i class="bi bi-hand-thumbs-up"></i></button>
<button type="button" id="thumbDown" class="btn btn-light" value="${thumbVO.upDown }"><i class="bi bi-hand-thumbs-down"></i></button>
</c:if>
</sec:authorize>
</div>
<div class="btn_group_detail">
<a href="list?gameId=${reviewVO.gameId }&page=${page}"><button class="btn btn-light">${gameVO.gameName } 리뷰 목록으로 돌아가기</button></a>
</div>
</div>
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<input type="hidden" id="updateResult" value="${update_result }">

<script type="text/javascript">
	$(document).ready(function(){
		var updateResult = $('#updateResult').val();
		if(updateResult=='success'){
			alert('리뷰 수정 성공');
		}
		
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		var thumbUp = $('#thumbUp');
		var thumbDown = $('#thumbDown');
		var memberId = $('#memberId').attr('value');
		var reviewId = $('#reviewId').attr('value');
		
		
		if($(thumbUp).attr('value')==1){
			$(thumbUp).attr('class','btn btn-success');
		}else if($(thumbDown).attr('value')==-1){
			$(thumbDown).attr('class','btn btn-danger');
		}
		
		$(thumbUp).on('click', function(){
			console.log('thumbUp click');
			var ThumbVO = {
					'memberId' : memberId,
					'reviewId' : reviewId,
					'upDown' : 1
				};
			
			if($(thumbUp).attr('value')==1){
				$.ajax({
					type : 'delete',
					url : '/guteam/thumb',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(ThumbVO),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value','');
							$(thumbUp).attr('class','btn btn-light');
							$(thumbDown).attr('value','');
							$(thumbDown).attr('class','btn btn-light');
							$('#thumbUpCount').html(parseInt($('#thumbUpCount').html())-1);
						}
					}
				}); // end ajax
			}else if($(thumbUp).attr('value')==-1){
				$.ajax({
					type : 'put',
					url : '/guteam/thumb',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(ThumbVO),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value',1);
							$(thumbDown).attr('value',1);
							$(thumbUp).attr('class','btn btn-success');
							$(thumbDown).attr('class','btn btn-light');
							$('#thumbUpCount').html(parseInt($('#thumbUpCount').html())+1);
						}
					}
				}); // end ajax
			}else {
				$.ajax({
					type : 'post',
					url : '/guteam/thumb',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(ThumbVO),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value',1);
							$(thumbDown).attr('value',1);
							$(thumbUp).attr('class','btn btn-success');
							$(thumbDown).attr('class','btn btn-light');
							$('#thumbUpCount').html(parseInt($('#thumbUpCount').html())+1);
						}
					}
				}); // end ajax
			}
		}); // thumbUp.onclick
		
		$(thumbDown).on('click', function(){
			console.log('thumbDown click');			
			var ThumbVO = {
					'memberId' : memberId,
					'reviewId' : reviewId,
					'upDown' : -1
				};
			
			if($(thumbDown).attr('value')==-1){
				$.ajax({
					type : 'delete',
					url : '/guteam/thumb',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(ThumbVO),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value','');
							$(thumbUp).attr('class','btn btn-light');
							$(thumbDown).attr('value','');
							$(thumbDown).attr('class','btn btn-light');
							
						}
					}
				}); // end ajax
			}else if($(thumbDown).attr('value')==1){
				$.ajax({
					type : 'put',
					url : '/guteam/thumb',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(ThumbVO),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							$(thumbDown).attr('value',-1);
							$(thumbDown).attr('class','btn btn-danger');
							$(thumbUp).attr('value',-1);
							$(thumbUp).attr('class','btn btn-light');
							$('#thumbUpCount').html(parseInt($('#thumbUpCount').html())-1);
						}
					}
				}); // end ajax
			}else{
				$.ajax({
					type : 'post',
					url : '/guteam/thumb',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(ThumbVO),	
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							$(thumbDown).attr('value',-1);
							$(thumbUp).attr('value',-1);
							$(thumbDown).attr('class','btn btn-danger');
							$(thumbUp).attr('class','btn btn-light');
							
						}
					}
				}); // end ajax
			}
		}); // thumbDown.onclick
	}); // document.ready

</script>
</body>
</html>