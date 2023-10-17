<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<h1>댓글 테스트</h1>
	
	<!-- 대충 아래에 댓글 생성 -->
	<section id="CommentGroup">
	
	<div style="text-align : center;">
		<input type="hidden" id="gameBoardId" name="gameBoardId" value=1>
		닉네임 : <input type="text" id="memberId">
		내용 : <input type="text" id="commentContent">
		<button id="commentAddBtn">작성</button>
		
	</div>
	<div style="text-align : center;">
		<ul id="comments"></ul>
	</div>
	</section>
	
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#commentAddBtn').click(function(){
				var gameBoardId = $('#gameBoardId').val();
				var memberId = $('#memberId').val();
				var commentContent = $('#commentContent').val();
				var obj = {
						'gameBoardId' : gameBoardId,
						'memberId' : memberId,
						'commentContent' : commentContent
				}
				
				$.ajax({
					type : 'POST',
					url : 'comments',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(obj),
					success : function(result){
						console.log(result);
						if(result==1){
							alert('댓글 입력 성공');
							getAllComments();
						}
					}
					
				});// end ajax
			})// commentAddBtn
			
			getAllComments();
			function getAllComments(){
				var gameBoardId= $('#gameBoardId').val();
				
				var url = 'comments/all/'+gameBoardId;
				
				$.getJSON(
					url,
					function(data){
					console.log(data);
					
					var memberId = $('#memberId').val();
					var list = '';
					
					$(data).each(function(){
						console.log(this);
						
						var commentDateCreated = new Date(this.commentDateCreated);
						
						list += '<li class="comment_item">'
						+ '<pre>'
						+ '<input type="hidden" id="commentId" value="'+this.commentId+'">'
						+ this.memberId + '&nbsp&nbsp'
						+ '<input type="text" id="commentContent" value="'+this.commentContent+'">'
						+ commentDateCreated + '&nbsp&nbsp'
						+ '<button class="update_comment" >수정</button>'
						+ '<button class="btn_delte" >삭제</button>'
						+ '</pre></li>'
					});//end each
					
					$('#comments').html(list);
					}//end funtion(data)
				);//end .getJSON
				}// end getAllComments()
		
			$('#comments').on('click','.comment_item .update_comment',function(){
			
				var commentId = $(this).prevAll('#commentId').val();
				var commentContent = $(this).prevAll('#commentContent').val();
				
				console.log('댓글Id 및 컨탠츠 이름 : '+commentId+','+commentContent);
				
				$.ajax({
					
				})//end ajax
			}); // end btn_update.on 
		
		});//end document
	</script>
	
	
</body>
</html>