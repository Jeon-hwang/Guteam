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
		<input type="hidden" id="gameBoardId" name="gameBoardId" value=2>
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
					var commentRow = 1;
					$(data).each(function(){
						console.log(this);
						
						var commentDateCreated = new Date(this.commentDateCreated);
						
						list += '<li class="comment_item">'
						+ '<pre>'
						+ '<input type="hidden" id="commentRow" value="'+commentRow+'">'
						+ '<input type="hidden" id="commentId" value="'+this.commentId+'">'
						+ this.memberId + '&nbsp&nbsp'
						+ '<input type="text" id="commentContent" value="'+this.commentContent+'">'
						+ commentDateCreated + '&nbsp&nbsp'
						+ '<button class="update_comment" >수정</button>'
						+ '<button class="delete_comment" >삭제</button>'
						+ '<br><button class="reply_view_btn">답글보기</button>'
						+ '<div class="replies_area'+commentRow+'"></div>'
						+ '</pre></li>';
						console.log('해당 행 번호 : '+commentRow);	
						commentRow++;
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
					type : 'PUT',
					url : 'comments/'+commentId,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : commentContent,
					success : function(result){
						if(result ==1){
							alert('수정 되었습니다!');
							getAllComments();
						}
					}
				})//end ajax
			}); // end btn_update.on 
			
			$('#comments').on('click','.comment_item .delete_comment',function(){
				
				var commentId = $(this).prevAll('#commentId').val();
				var gameBoardId =  $('#gameBoardId').val();
				console.log('댓글Id 및 게시판 id: '+commentId+','+gameBoardId);
				$.ajax({
					type : 'DELETE',
					url : 'comments/'+commentId,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : gameBoardId,
					success : function(result){
						if(result==1){
							alert('삭제 되었습니다!');
							getAllComments();
						}
					}	
				});//end ajax
				
			});//end delete.comment.on
			
			$('#comments').on('click','.comment_item .reply_view_btn',function(){
				var commentId = $(this).prevAll('#commentId').val();
				var commentRow = $(this).prevAll('#commentRow').val();
				var url = 'replies/all/'+commentId;
				console.log('댓글 ID?'+commentId);
				console.log('몇번째 댓글?'+commentRow);
				$.getJSON(
						url,
						function(data){
						console.log(data);
						
						var list = '';
						var repliesArea = '.replies_area'+commentRow;
						
						$(data).each(function(){
							console.log(this);
							
							var replyDateCreated = new Date(this.replyDateCreated);
							
							list += '<li class="reply_item">'
							+ '<input type="hidden" id="replyId" value="'+this.replyId+'">'
							+ this.memberId + '&nbsp&nbsp'
							+ '<input type="text" id="replyContent" value="'+this.replyContent+'">'
							+ replyDateCreated + '&nbsp&nbsp'
							+ '<button class="update_reply" >수정</button>'
							+ '<button class="delete_reply" >삭제</button>'
							+ '</li>';
							
						});//end each
							list += '아이디 : <input type="text" name="replyMemberId" id="replyMemberId">'
									+ '내용 : <input type="text" name="replyContent" id="replyContent">'
									+ '<button class="reply_add_btn" >작성</button>';
							console.log(list);				
							$(repliesArea).html(list);
						}//end funtion(data)
						
					);//end .getJSON
				
				
								
			});// replyView.on
			
			
			$('#comments').on('click','.comment_item .reply_add_btn',function(){
				//var tagName = $(this).parent().prevAll('#commentId').prop('tagName');
				//console.log(tagName);
				var commentId = $(this).parent().prevAll('#commentId').val();	
				var memberId = $(this).prevAll('#replyMemberId').val();
				var replyContent = $(this).prevAll('#replyContent').val();
				console.log("댓글id, 회원id, 대댓내용 :"+ commentId+", "+memberId+", "+replyContent);
				var obj = {
						'commentId' : commentId,
						'memberId' : memberId,
						'replyContent' : replyContent
				}
				
				$.ajax({
					type : 'POST',
					url : 'replies',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(obj),
					success : function(result){
						console.log(result);
						if(result==1){
							alert('대댓글 입력 성공');
							getAllComments();
						}
					}
				});// end ajax
			});//end reply_add_btn
			
			
		});//end document
	</script>
	
	
</body>
</html>