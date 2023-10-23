<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>
<style type="text/css">
.btn_clicked {
	background-color:lightblue;
	color:white;
	border:0.8px;
	border-radius:2px;
	border-color:yellow;
}
</style>
<meta charset="UTF-8">
<title>${reviewVO.reviewTitle }</title>
</head>
<body>
<input type="hidden" id="reviewId" value="${reviewVO.reviewId }">
<input type="hidden" id="memberId" value="${sessionScope.memberId }test">
제목 : ${reviewVO.reviewTitle }<br>
작성자 : ${reviewVO.memberId }<br>
작성일 : ${reviewVO.reviewDateCreated}<br>
평점 : ${reviewVO.rating}<br>
내용 : ${reviewVO.reviewContent }<br>
추천 수 : <div id="thumbUpCount">${reviewVO.thumbUpCount }</div><br>
<a href="update?reviewId=${reviewVO.reviewId }&page=${page}"><button>수정</button></a><form style="display:inline-block;" action="delete" method="post"><input type="hidden" name="reviewId" value="${reviewVO.reviewId }"><input type="hidden" name="gameId" value="${gameVO.gameId }"><input type="submit" value="삭제"></form><br>
<button type="button" id="thumbUp" class="" value="${thumbVO.upDown }">추천</button>
<button type="button" id="thumbDown" class="" value="${thumbVO.upDown }">비추</button>
<a href="list?gameId=${reviewVO.gameId }&page=${page}"><button>${gameVO.gameName } 리뷰 목록으로 돌아가기</button></a>
<input type="hidden" id="updateResult" value="${update_result }">
<script type="text/javascript">
	$(document).ready(function(){
		var updateResult = $('#updateResult').val();
		if(updateResult=='success'){
			alert('리뷰 수정 성공');
		}
		
		
		var thumbUp = $('#thumbUp');
		var thumbDown = $('#thumbDown');
		var memberId = $('#memberId').attr('value');
		var reviewId = $('#reviewId').attr('value');
		
		
		if($(thumbUp).attr('value')==1){
			$(thumbUp).attr('class','btn_clicked');
		}else if($(thumbDown).attr('value')==-1){
			$(thumbDown).attr('class','btn_clicked');
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
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value','');
							$(thumbUp).attr('class','');
							$(thumbDown).attr('value','');
							$(thumbDown).attr('class','');
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
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value',1);
							$(thumbDown).attr('value',1);
							$(thumbUp).attr('class','btn_clicked');
							$(thumbDown).attr('class','');
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
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value',1);
							$(thumbDown).attr('value',1);
							$(thumbUp).attr('class','btn_clicked');
							$(thumbDown).attr('class','');
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
					success : function(result){
						if(result==1){
							$(thumbUp).attr('value','');
							$(thumbUp).attr('class','');
							$(thumbDown).attr('value','');
							$(thumbDown).attr('class','');
							
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
					success : function(result){
						if(result==1){
							$(thumbDown).attr('value',-1);
							$(thumbDown).attr('class','btn_clicked');
							$(thumbUp).attr('value',-1);
							$(thumbUp).attr('class','');
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
					success : function(result){
						if(result==1){
							$(thumbDown).attr('value',-1);
							$(thumbUp).attr('value',-1);
							$(thumbDown).attr('class','btn_clicked');
							$(thumbUp).attr('class','');
							
						}
					}
				}); // end ajax
			}
		}); // thumbDown.onclick
	}); // document.ready

</script>
</body>
</html>