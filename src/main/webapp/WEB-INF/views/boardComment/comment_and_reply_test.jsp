<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글창</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<input type="hidden" id="memberId" value=${principal.username }>
	</sec:authorize>
	<h1>댓글 테스트</h1>
	
	<!-- 대충 아래에 댓글 생성 -->
	<section id="CommentGroup">
	
	<div style="text-align : center;">
		<input type="hidden" name="gameId" id="gameId" value="${gameId }">
		<input type="hidden" name="page" id="page" value="${page }">
		<input type="hidden" name="gameBoardId" id="gameBoardId" value="${vo.gameBoardId }">
		<sec:authorize access="isAuthenticated()">
		내용 : <input type="text" id="commentContent">
		<button id="commentAddBtn">작성</button>
		</sec:authorize>
		<sec:authorize access="isAnonymous()">
			<a href="../member/login">로그인을 하셔야 댓글이 작성 가능합니다.	</a>
		</sec:authorize>
	</div>
	<div style="text-align : center;">
		<ul id="comments"></ul>
	</div>
	</section>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var principalMemberId = $('#memberId').val();
			
			function dateFormat(date) {
		        var month = date.getMonth() + 1;
		        var day = date.getDate();
		        var hour = date.getHours();
		        var minute = date.getMinutes();	
		        var second = date.getSeconds();

		        month = month >= 10 ? month : '0' + month;
		        day = day >= 10 ? day : '0' + day;
		        hour = hour >= 10 ? hour : '0' + hour;
		        minute = minute >= 10 ? minute : '0' + minute;
		        second = second >= 10 ? second : '0' + second;

		        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
		}
			
			$("#commentContent").keydown(function(keyNum){
				//현재의 키보드의 입력값을 keyNum으로 받음
				if(keyNum.keyCode == 13){ 

					$('#commentAddBtn').click();	
				}
			});// end commentContent.keydown
			
			$('#comments').on('keydown','.comment_item .replyContent',function(keyNum){
				if(keyNum.keyCode == 13){ 
					
					$(this).next().click();	
				}
			});// end replyContent.keydown
			
			
			
			$('#commentAddBtn').click(function(){
				var gameBoardId = $('#gameBoardId').val();
				var commentContent = $('#commentContent').val();
				var obj = {
						'gameBoardId' : gameBoardId,
						'memberId' : principalMemberId,
						'commentContent' : commentContent
				}
				
				$.ajax({
					type : 'POST',
					url : '../boardComment/comments',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(obj),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						console.log(result);
						if(result==1){
							alert('댓글 입력 성공');
							getAllComments(1);
						}
					}
					
				});// end ajax
			})// commentAddBtn
			$('#comments').on('click','.comment_paging .paging',function(){
				var clickPage = $(this).val();
				console.log("선택한 페이지 :"+clickPage);
				getAllComments(clickPage);
			})
			getAllComments(1);
			function getAllComments(nowPage){
				var gameBoardId= $('#gameBoardId').val();
				var page = nowPage;
				
				var url = '../boardComment/comments/all/'+gameBoardId+'?page='+page;
				
				$.getJSON(
					url,
					function(data){
					console.log(data);
					
					var memberId = $('#memberId').val();
					var list = '';
					var commentRow = 1;
					var varStatus = 0;
					$(data.list).each(function(){
						console.log(this);
						console.log(data.nicknameList);
						var nickname = data.nicknameList[varStatus];
						varStatus++;
						var commentDateCreated = new Date(this.commentDateCreated);
						
						if(this.commentContent=="삭제된 댓글입니다."){
						list += '<li class="comment_item">'
								+ '<pre>'
								+ '<input type="hidden" id="commentRow" value="'+commentRow+'">'
								+ '<input type="hidden" id="commentId" value="'+this.commentId+'">'
								+ '<input type="hidden" id="commentContent" value="'+this.commentContent+'">'
								+ '<p>삭제된 댓글입니다.('+this.replyCnt+')</p>'
								+ '<div class="reply_btn_area">'
								+ '<button class="reply_view_btn" style="display:block">답글보기</button>'
								+ '<button class="fold_replies_area" style="display:none">접기</button></div>'
								+ '<div class="replies_area'+commentRow+'"></div>'
								+ '</pre></li>';
						}else{
						list += '<li class="comment_item">'
								+ '<pre>'
								+ '<input type="hidden" id="commentRow" value="'+commentRow+'">'
								+ '<input type="hidden" id="commentId" value="'+this.commentId+'">'
								+ '<span>'+nickname+'</span> :&nbsp&nbsp'
								+ '<span id="commentContentView">'+this.commentContent+'('+this.replyCnt+')</span>&nbsp&nbsp&nbsp&nbsp'
								+ '<input type="hidden" id="commentContent" value="'+this.commentContent+'">&nbsp&nbsp&nbsp&nbsp'
								+ '<span>'+dateFormat(commentDateCreated)+'</span>&nbsp&nbsp'
								if(principalMemberId==this.memberId){
						list += '<button class="update_comment" >수정</button>'
								+ '<button class="update_comment_check" style="display:none" >수정확인</button>'
								+ '<button class="delete_comment" >삭제</button>'
								}
						list += '<div class="reply_btn_area">'
								+ '<button class="reply_view_btn" style="display:block">답글보기</button>'
								+ '<button class="fold_replies_area" style="display:none">접기</button></div>'
								+ '<div class="replies_area'+commentRow+'"></div>'
								+ '</pre></li>';
						}
						console.log('해당 행 번호 : '+commentRow);	
						commentRow++;
					});//end each
					var hasPrev = data.pageMaker.hasPrev;
					var hasNext = data.pageMaker.hasNext;
					var startPageNo = data.pageMaker.startPageNo;
					var endPageNo = data.pageMaker.endPageNo;
						
						list += '<div class="comment_paging">'
							 if(hasPrev){
						list += '<button class="paging" value="'+(startPageNo-1)+'">이전</button>&nbsp&nbsp' 
							 }
							for(var i = startPageNo ; i<=endPageNo ; i++ ){
								if(nowPage==i){
						list += '<em>'+i+'</em>'									
								}else{
						list += '<button class="paging" value="'+i+'">'+i+'</button>'		
							}
							}
							if(hasNext){
								list += '&nbsp&nbsp<button class="paging" value="'+(endPageNo+1)+'">다음</button>&nbsp&nbsp'		
							}
						list +=	'</div>'
					$('#comments').html(list);
					}//end funtion(data)
				);//end .getJSON
				
				}// end getAllComments()
		
			$('#comments').on('click','.comment_item .update_comment',function(){ //댓글 수정창 띄우기
				if($(this).is(":visible")){
					$(this).next().css("display","inline");
					$(this).css("display","none");
				}
				$(this).prevAll("#commentContent").prop("type","text");
				$(this).prevAll("#commentContentView").css("display","none");
			});
				
			$('#comments').on('click','.comment_item .update_comment_check',function(){
			if($(this).is(":visible")){
				$(this).next().css("display","block");
				$(this).css("display","none");
			}
				var nowPage = parseInt($('#comments').children(".comment_paging").children("em").text());
				var commentId = $(this).prevAll('#commentId').val();
				var commentContent = $(this).prevAll('#commentContent').val();
				
				console.log('댓글Id 및 컨탠츠 이름 : '+commentId+','+commentContent);
				
				$.ajax({
					type : 'PUT',
					url : '../boardComment/comments/'+commentId,
					headers : {
						'Content-Type' : 'application/json'
					},
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					data : commentContent,
					success : function(result){
						if(result ==1){
							alert('수정 되었습니다!');
							getAllComments(nowPage);
						}
					}
				})//end ajax
			}); // end btn_update.on 
			
			$('#comments').on('click','.comment_item .delete_comment',function(){ // 댓글 삭제
				var commentId = $(this).prevAll('#commentId').val();
				var gameBoardId =  $('#gameBoardId').val();
				var nowPage = parseInt($('#comments').children(".comment_paging").children("em").text());
				
				console.log('댓글Id 및 게시판판 id: '+commentId+','+gameBoardId);
				$.ajax({
					type : 'DELETE',
					url : '../boardComment/comments/'+commentId,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : gameBoardId,
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							alert('삭제 되었습니다!');
							getAllComments(nowPage);
						}
					}	
				});//end ajax
				
			});//end delete.comment.on
			
			
			$('#comments').on('click','.comment_item .reply_btn_area .reply_view_btn',function(){
				var commentId = $(this).parent().prevAll('#commentId').val();
				var commentRow = $(this).parent().prevAll('#commentRow').val();
				var url = '../boardComment/replies/all/'+commentId;
				console.log('댓글 ID?'+commentId);
				console.log('몇번째 댓글?'+commentRow);
				if($(this).is(":visible")){
					$(this).next().css("display","block");
					$(this).css("display","none");
				}
				var commentContent = $(this).parent().prevAll('#commentContent').val();
				$.getJSON(
						url,
						function(data){
						console.log(data);
						var nick
						var list = '';
						var repliesArea = '.replies_area'+commentRow;
						var varStatus = 0; 
						$(data.list).each(function(){
							console.log(this);
		
							var nickname = data.nicknameList[varStatus];
							varStatus++;
							var replyDateCreated = new Date(this.replyDateCreated);
							if(this.replyContent=="삭제된 댓글입니다."){
							list += '<li class="reply_item">'
							+ '<input type="hidden" id="replyId" value="'+this.replyId+'">'
							+ '<input type="hidden" id="replyContent" value="'+this.replyContent+'">'
							+ '<span>삭제된 댓글입니다.</span>'	
							+ '</li>';
							}else {
							list += '<li class="reply_item">'
							+ '<input type="hidden" id="replyId" value="'+this.replyId+'">'
							+ nickname + ':&nbsp&nbsp'	
							+ '<input type="hidden" class="replyContent" value="'+this.replyContent+'">&nbsp&nbsp'
							+ '<span id="replyView">'+this.replyContent + '</span>&nbsp&nbsp'
							+ dateFormat(replyDateCreated) + '&nbsp&nbsp'
							if(principalMemberId==this.memberId){
							list += '<button class="update_reply" >수정</button>'
							+ '<button class="update_reply_check" style="display : none" >수정확인</button>'
							+ '<button class="delete_reply" >삭제</button>'
							}
							list += '</li>';
							}
						});//end each
							if(commentContent == '삭제된 댓글입니다.'){
								list += '<span>삭제된 댓글에는 답글을 달 수 없습니다.</span>';
							}else if(principalMemberId == ''){
								var uri ='/guteam/gameBoard/detail?gameBoardId='+gameBoardId+'&page=${page}&gameId=${gameId}'
								const encoded = encodeURI(uri);
								list += '<a href="../member/login?targetURL=">로그인을 하셔야 답글을 달 수 있습니다</a>';
							}else{
								list += '내용 : <input type="text" name="replyContent" class="replyContent">' 
								+ '<button class="reply_add_btn" >작성</button>';
							}
					
						
						
							$(repliesArea).html(list);
						}//end funtion(data)
						
					);//end .getJSON
				
				
								
			});// replyView.on
			
			
			$('#comments').on('click','.comment_item .reply_add_btn',function(){
				//var tagName = $(this).parent().prevAll('#commentId').prop('tagName');
				//console.log(tagName);
				
				var commentId = $(this).parent().prevAll('#commentId').val();	
			
				var replyContent = $(this).prevAll('.replyContent').val();
				var nowPage = parseInt($('#comments').children(".comment_paging").children("em").text());
				//var replyViewBtnClick = $(this).parent().parent().parent().nextAll(".reply_btn_area").children(".reply_view_btn").prop('tagName');
				var replyViewBtnClick = $(this).parent().prevAll(".reply_btn_area").children(".reply_view_btn");
				console.log('강제클릭태그 이름: '+replyViewBtnClick.prop('tagName'));
				console.log('대댓글쪽 현재 페이지'+nowPage);
				console.log("댓글id, 회원id, 대댓내용 :"+ commentId+", "+memberId+", "+replyContent);
				var obj = {
						'commentId' : commentId,
						'memberId' : principalMemberId,
						'replyContent' : replyContent
				}
				
				$.ajax({
					type : 'POST',
					url : '../boardComment/replies',
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(obj),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						//console.log(result);
						if(result==1){
							
							alert('대댓글 입력 성공');
						//	getAllComments(nowPage);
							$(replyViewBtnClick).trigger("click");
						}
					
					}
					
				});// end ajax
				
			});//end reply_add_btn
			
			
			
			$('#comments').on('click','.comment_item .reply_item .update_reply',function(){
				if($(this).is(":visible")){
				$(this).next().css("display","inline");
				$(this).css("display","none");
				}
				$(this).prevAll(".replyContent").prop("type","text");
				$(this).prevAll("#replyView").css("display","none");
			});
			$('#comments').on('click','.comment_item .reply_item .update_reply_check',function(){
				//var repliesAreaNum = $(this).parent().parent().attr('class');
				//console.log(repliesAreaNum);
				var replyViewBtnClick = $(this).parent().parent().prevAll(".reply_btn_area").children(".reply_view_btn");
				var replyId = $(this).prevAll('#replyId').val();
				var replyContent = $(this).prevAll('.replyContent').val();
				
				console.log('대댓글Id 및 내용 : '+replyId+','+replyContent);
				
				$.ajax({
					type : 'PUT',
					url : '../boardComment/replies/'+replyId,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : replyContent,
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result ==1){
							alert('수정 되었습니다!');
							$(replyViewBtnClick).trigger("click");
						}
					}
				})//end ajax
			});// end update_reply
			
			$('#comments').on('click','.comment_item .reply_item .delete_reply',function(){
				
				var replyId = $(this).prevAll('#replyId').val();
				var replyViewBtnClick = $(this).parent().parent().prevAll(".reply_btn_area").children(".reply_view_btn");
				console.log('대댓글Id 및 게시판판 id: '+replyId);
				$.ajax({
					type : 'DELETE',
					url : '../boardComment/replies/'+replyId,
					headers : {
						'Content-Type' : 'application/json'
					},
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							alert('삭제 되었습니다!');
							$(replyViewBtnClick).trigger("click");
						}
					}	
				});//end ajax
			});//end delete_reply
			
			$('#comments').on('click','.comment_item .fold_replies_area',function(){
				console.log('접어버리기');
				$(this).parent().next().html('');
				if($(this).is(":visible")){
					$(this).prev().css("display","block");
					$(this).css("display","none");
				}
				
			});//end fold_replies_area
		});//end document
	</script>
	
	
</body>
</html>