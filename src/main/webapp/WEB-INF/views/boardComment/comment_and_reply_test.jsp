<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<input type="hidden" id="memberId" value=${principal.username }>
	</sec:authorize>
	<!-- 대충 아래에 댓글 생성 -->
	<div id="CommentGroup">
		<input type="hidden" name="gameId" id="gameId" value="${gameId }">
		<input type="hidden" name="page" id="page" value="${page }">
		<input type="hidden" name="gameBoardId" id="gameBoardId" value="${vo.gameBoardId }">
		<sec:authorize access="isAuthenticated()">
		<div class="insertComment">
		<img alt="${principal.username }" id="userProfileImage" src="../member/display?fileName=${memberImageName }" width="50px" height="50px">
		&nbsp&nbsp<textarea id="commentContent" maxlength="33" placeholder="댓글 입력"></textarea>
		<button id="commentAddBtn" class="btn btn-secondary"><i class="bi bi-check"></i></button>
		</div>
		</sec:authorize>
		<sec:authorize access="isAnonymous()">
			<a href="../member/login">로그인을 하셔야 댓글이 작성 가능합니다.	</a>
		</sec:authorize>
		<br>
		<ul id="allComments"></ul>
	</div>
	
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
			
			function elapsedTime(date){ //날짜 비교해서 표시하기 
				var startDate = new Date(date); // 비교할 날짜
				var endDate = new Date(); // 현재 날짜
				
				var diff = (endDate - startDate) / 1000;
				//console.log(endDate-startDate);
				//console.log(diff);
				
				var times = [
					{ name: dateFormat(date), milliSeconds: 60 * 60 * 24},
				    { name: '시간', milliSeconds: 60 * 60 },
				    { name: '분', milliSeconds: 60 },
				  ];
				
				for(var i =0 ; i<times.length;i++){
					var betweenTime = Math.floor(diff/times[i].milliSeconds);
					console.log(betweenTime);
					if(betweenTime > 0 && i == 0){
						console.log("날짜로 출력");
						return times[i].name;
					}else if(betweenTime > 0 && i>0){
						console.log("시간으로 출력");
						return betweenTime+times[i].name+'전';
					}
				}
				//console.log("아직 시간 안댐");
				return "방금 전";
			}
			
			$('#commentAddBtn').click(function(){
				var gameBoardId = $('#gameBoardId').val();
				var commentContent = $('#commentContent').val();
				if(commentContent == '삭제된 댓글입니다.'){
					commentContent = '&nbsp삭제된 댓글입니다.';
				}else if(commentContent.substring(0,9)=='(updated)'){
					commentContent = '&nbsp'+commentContent;
				}
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
							$('#commentCnt').text(parseInt($('#commentCnt').text())+1);
							$('#commentContent').val("");
							$('#commentContent').focus();
						}
					}
					
				});// end ajax
			})// commentAddBtn
			$('#allComments').on('click','.comment_paging .btnPaging',function(){
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
						//console.log(this);
						//console.log(data.nicknameList);
						var nickname = data.nicknameList[varStatus];
						var memberImageName = data.memberImageNameList[varStatus];
						varStatus++;
						var commentDateCreated = new Date(this.commentDateCreated);
						console.log(this.commentContent.replace("(updated)",""));
						if(this.commentContent=="삭제된 댓글입니다."){
						list += '<li class="comment_item">'
								+ '<pre>'
								+ '<input type="hidden" id="commentRow" value="'+commentRow+'">'
								+ '<input type="hidden" id="commentId" value="'+this.commentId+'">'
								+ '<div class="comment_info"><input type="hidden" id="commentContent" value="'+this.commentContent+'"></div>'
								+ '<p>삭제된 댓글입니다.</p>'
								+ '<div class="reply_btn_area">'
								+ '<button class="reply_view_btn" style="display:block"><i class="bi bi-chat-left-dots-fill">'+this.replyCnt+'</i></button>'
								+ '<button class="fold_replies_area" style="display:none">접기</button></div>'
								+ '</pre><ul class="replies_area" id="repliesArea'+commentRow+'"></ul></li>';
						}else{
						list += '<li class="comment_item">'
								+ '<pre>'
								+ '<input type="hidden" id="commentRow" value="'+commentRow+'">'
								+ '<input type="hidden" id="commentId" value="'+this.commentId+'">'
								+ '<img class="commentProfileImg" alt="'+nickname+'" src="../game/display?fileName='+memberImageName+'" width="50px" height="50px" />'
								if(this.commentContent.substring(0,9)=='(updated)'){
						list += '&nbsp&nbsp<div class="comment_info"><span class="commentNickname">'+nickname+'</span>&nbsp&nbsp'
								+ '<span>'+elapsedTime(commentDateCreated)+'(수정 됨)</span>&nbsp&nbsp<br>'
								+ '<span id="commentContentView">'+this.commentContent.replace("(updated)","")+'</span>'
								+ '<input type="hidden" id="commentContent" value="'+this.commentContent.replace("(updated)","")+'" maxlength="33"></div>'
								}else{
						list += '&nbsp&nbsp<div class="comment_info"><span class="commentNickname">'+nickname+'</span>&nbsp&nbsp'
								+ '<span>'+elapsedTime(commentDateCreated)+'</span>&nbsp&nbsp<br>'
								+ '<span id="commentContentView">'+this.commentContent+'</span>'
								+ '<input type="hidden" id="commentContent" value="'+this.commentContent+'" maxlength="33"></div>'
								}
								if(principalMemberId==this.memberId){
						list += '<div class="reply_btn_area">'
								+ '<button class="reply_view_btn" style="display:inline"><i class="bi bi-chat-left-dots-fill">'+this.replyCnt+'</i></button>'
								+ '<button class="fold_replies_area" style="display:none">접기</button>'
								+ '<button class="update_comment" >수정</button>'
								+ '<button class="update_comment_check" style="display:none" >수정확인</button>'
								+ '<button class="delete_comment" >삭제</button></div>'
						
								}else{
						list += '<div class="reply_btn_area">'
								+ '<button class="reply_view_btn" style="display:block"><i class="bi bi-chat-left-dots-fill">'+this.replyCnt+'</i></button>'
								+ '<button class="fold_replies_area" style="display:none">접기</button></div>'
								
								}
						list += '</pre><ul class="replies_area" id="repliesArea'+commentRow+'"></ul></li>';
						}
						console.log('해당 행 번호 : '+commentRow);	
						commentRow++;
					});//end each
					var hasPrev = data.pageMaker.hasPrev;
					var hasNext = data.pageMaker.hasNext;
					var startPageNo = data.pageMaker.startPageNo;
					var endPageNo = data.pageMaker.endPageNo;
						
					list += '<div class="comment_paging">';
						 if(hasPrev){
					list += '<button class="btnPaging" value="'+(startPageNo-1)+'">이전</button>&nbsp&nbsp'; 
						 }
						for(var i = startPageNo ; i<=endPageNo ; i++ ){
								if(nowPage==i){
					list += '<em>'+i+'</em>';									
								}else{
					list += '<button class="btnPaging" value="'+i+'">'+i+'</button>';		
								}
						}
						if(hasNext){
							list += '&nbsp&nbsp<button class="btnPaging" value="'+(endPageNo+1)+'">다음</button>&nbsp&nbsp';		
						}
					list +=	'</div>';
						
					$('#allComments').html(list);
					}//end funtion(data)
				);//end .getJSON
				
				}// end getAllComments()
		
			$('#allComments').on('click','.comment_item .update_comment',function(){ //댓글 수정창 띄우기
				if($(this).is(":visible")){
					$(this).next().css("display","inline");
					$(this).css("display","none");
				}
				$(this).parent().prev().children("#commentContent").prop("type","text");
				$(this).parent().prev().children("#commentContentView").css("display","none");
			});
			
			$('#allComments').on('click','.comment_item .update_comment_check',function(){
			if($(this).is(":visible")){
				$(this).prev().css("display","inline");
				$(this).css("display","none");
			}
				var nowPage = parseInt($('#allComments').children(".comment_paging").children("em").text());
				var commentId = $(this).parent().prevAll('#commentId').val();
				var commentContent = $(this).parent().prevAll('div').children('#commentContent').val();
				
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
			
			$('#allComments').on('click','.comment_item .delete_comment',function(){ // 댓글 삭제
				var commentId = $(this).parent().prevAll('#commentId').val();
				var gameBoardId =  $('#gameBoardId').val();
				var nowPage = parseInt($('#allComments').children(".comment_paging").children("em").text());
				var commentCnt = parseInt($(this).prevAll('.reply_view_btn').children().text());
				console.log(commentCnt);
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
						}else if(result==2){
							alert('완전 삭제');
							$('#commentCnt').text(parseInt($('#commentCnt').text())-1-commentCnt);
							getAllComments(nowPage);
						}
					}	
				});//end ajax
				
			});//end delete.comment.on
			
			$('#allComments').on('click','.comment_item .reply_btn_area .reply_view_btn',function(){
				var commentId = $(this).parent().prevAll('#commentId').val();
				var commentRow = $(this).parent().prevAll('#commentRow').val();
				var url = '../boardComment/replies/all/'+commentId;
				console.log('댓글 ID?'+commentId);
				console.log('몇번째 댓글?'+commentRow);
				if($(this).is(":visible")){
					$(this).next().css("display","inline");
					$(this).css("display","none");
				}
				var commentContent = $(this).parent().prevAll('.comment_info').children('#commentContent').val();
				$.getJSON(
						url,
						function(data){
						console.log(data);
						var nick
						var list = '';
						var repliesArea = '#repliesArea'+commentRow;
						var varStatus = 0; 
						$(data.list).each(function(){
							console.log(this);
		
							var nickname = data.nicknameList[varStatus];
							var memberImageName = data.profileImageNameList[varStatus];
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
							+ '└<img class="replyProfileImg" alt="'+nickname+'" src="../game/display?fileName='+memberImageName+'" width="50px" height="50px" />&nbsp&nbsp'
							+ '<div><input type="hidden" id="replyId" value="'+this.replyId+'">'
							+ '<span class="replyNickname">'+nickname + '</span>&nbsp&nbsp<span>'
							if(this.replyContent.substring(0,9)=='(updated)'){
							list += elapsedTime(replyDateCreated) +' (수정 됨)</span><br>'	
							+ '<input type="hidden" class="replyContent" value="'+this.replyContent.replace('(updated)','')+'" maxlength="33">'
							+ '<span class="replyView">'+this.replyContent.replace('(updated)','') + '</span></div>'
							}else{
							list += elapsedTime(replyDateCreated) +'</span><br>'	
							+ '<input type="hidden" class="replyContent" value="'+this.replyContent+'" maxlength="33">'
							+ '<span class="replyView">'+this.replyContent + '</span></div>'
							}
							if(principalMemberId==this.memberId){
							list += '<button class="update_reply" >수정</button>'
							+ '<button class="update_reply_check" style="display : none" >수정확인</button>'
							+ '<button class="delete_reply" >삭제</button>'
							}
							list += '</li>';
							}
						});//end each
							console.log(principalMemberId);
							if(commentContent == '삭제된 댓글입니다.'){
								list += '<span>삭제된 댓글에는 답글을 달 수 없습니다.</span>';
							}else if(principalMemberId == '' || principalMemberId == null){
								var uri ='/guteam/gameBoard/detail?gameBoardId='+gameBoardId+'&page=${page}&gameId=${gameId}'
								const encoded = encodeURI(uri);
								list += '<a href="../member/login?targetURL=">로그인을 하셔야 답글을 달 수 있습니다</a>';
							}else{
								list += '내용 : <input type="text" name="replyContent" class="replyContent" maxlength="33">' 
								+ '<button class="reply_add_btn" >작성</button>';
							}
					
							$(repliesArea).html(list);
						}//end funtion(data)
						
					);//end .getJSON				
			});// replyView.on
			
			
			$('#allComments').on('click','.comment_item .reply_add_btn',function(){
				//var tagName = $(this).parent().prevAll('#commentId').prop('tagName');
				//console.log(tagName);
				
				var commentId = $(this).parent().prev().children('#commentId').val();	
			
				var replyContent = $(this).prevAll('.replyContent').val();
				if(replyContent == '삭제된 댓글입니다.'){
					replyContent = '&nbsp삭제된 댓글입니다.';
				}else if(replyContent.substring(0,9) == '(updated)'){
					replyContent = '&nbsp';
				}
				var nowPage = parseInt($('#allComments').children(".comment_paging").children("em").text());
				//var replyViewBtnClick = $(this).parent().parent().parent().nextAll(".reply_btn_area").children(".reply_view_btn").prop('tagName');
				var replyViewBtn = $(this).parent().prev().children(".reply_btn_area").children(".reply_view_btn");
				
				
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
							$(replyViewBtn).trigger("click");
							$(replyViewBtn).children().text(parseInt($(replyViewBtn).text())+1);
							$('#commentCnt').text(parseInt($('#commentCnt').text())+1);
						}
					}
				});// end ajax
			});//end reply_add_btn
			
			$('#allComments').on('click','.comment_item .reply_item .update_reply',function(){
				if($(this).is(":visible")){
				$(this).next().css("display","inline");
				$(this).css("display","none");
				}
				$(this).prev().children(".replyContent").prop("type","text");
				$(this).prev().children(".replyView").css("display","none");
			});
			$('#allComments').on('click','.comment_item .reply_item .update_reply_check',function(){
				//var repliesAreaNum = $(this).parent().parent().attr('class');
				//console.log(repliesAreaNum);
				var replyViewBtnClick = $(this).parent().parent().prev().children(".reply_btn_area").children(".reply_view_btn");
				var replyId = $(this).prevAll('div').children('#replyId').val();
				var replyContent = $(this).prevAll('div').children('.replyContent').val();
				
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
			
			$('#allComments').on('click','.comment_item .reply_item .delete_reply',function(){
				var commentContent = $(this).parent().parent().prev().children('.comment_info').children("#commentContent").val();
				console.log("삭제 내용?"+commentContent);
				var commentId = $(this).parent().parent().prev().children("#commentId").val();
				var commentCnt = parseInt($(this).parent().parent().prev().children(".reply_btn_area").children(".reply_view_btn").children().text());
				console.log("댓글 갯수?"+commentCnt);
				var replyId = $(this).prevAll('div').children('#replyId').val();
				var replyViewBtnClick = $(this).parent().parent().prev().children(".reply_btn_area").children(".reply_view_btn");
				console.log('대댓글Id : '+replyId);
				
				$.ajax({
					type : 'DELETE',
					url : '../boardComment/replies/'+replyId+'?commentId='+commentId,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : commentContent,
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result==1){
							alert('삭제 되었습니다!');
							$(replyViewBtnClick).trigger("click");
						}else if(result==2){
							alert('완전 삭제');
							commentCnt = ($('#commentCnt').text()-commentCnt)-1;
							console.log($('#commentCnt').text());
							console.log(commentCnt);
							$('#commentCnt').text(commentCnt);
							getAllComments(1);
							
						}
					}	
				});//end ajax
			});//end delete_reply
			
			$('#allComments').on('click','.comment_item .fold_replies_area',function(){
				console.log('접어버리기');
				$(this).parent().parent().next().html(''); // reply_area 전체 없애기
				if($(this).is(":visible")){	
					$(this).prev().css("display","inline"); // 열기 ㅗㅇ픈
					$(this).css("display","none"); // 접기 없애기
				}
				
			});//end fold_replies_area
			
			 $('#commentContent').on('keyup keydown', function (){
				 	console.log(this.scrollHeight);
				 		
				    if(this.scrollHeight>149){
						$(this).height(148);
						$(this).scrollHeight(this.Height);
				    }else{
				    	$(this).css('height', 'auto');
					    $(this).height(this.scrollHeight);
				    }
			 });

		});//end document
	</script>
</body>
</html>