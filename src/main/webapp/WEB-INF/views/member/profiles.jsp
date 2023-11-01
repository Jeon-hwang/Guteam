<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../style.jsp"></jsp:include>
<style type="text/css">
.profileImg {
	width : 50px;
	height : 50px;
	border : 1px solid grey;
}
</style>
<meta charset="UTF-8">
<title>GUTEAM : 프로필</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />
<h2>${vo.memberId }님의 프로필</h2>
	<div>
		<button onclick ="popUp();">쪽지함</button>
		<a href="addCash"><button>캐쉬 충전</button></a>
		<a href="../friend/list"><button>친구 목록</button></a>
	</div>
	<br>
	<div>
		<form action="delete" method="post">
		<sec:csrfInput/>
			<a href="update"><button type="button">회원 수정</button></a>
			<input type="hidden" name="memberId" id="memberId" value="${vo.memberId }">
			<input type="submit" value="회원 탈퇴">	
		</form>
		<hr>
		<div id="commentsArea">
			<button id="showMyComments">내가 쓴 댓글 보기</button>
			<button id="closeMyComments" style="display : none">접기</button>
			<div id="myComments">
				<ul id="myCommentsList"></ul>
			</div>
		</div>
	</div>
<input type="hidden" id="alert" value="${alert }">
	
<script type="text/javascript">
	function popUp(){
		window.open('../message/list', '쪽지함', 'width=715px,height=425px,scrollbars=yes');
	};
	
	$(document).ready(function(){
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
		
		var result = $('#alert').val();
			if(result == 'success'){
				alert('회원정보가 수정되었습니다!');
			}
			else if(result == 'fail'){
				alert('요청에 실패하였습니다.');
			}
			
			function showMyComments(page){
				//console.log("클릭확인");
				var nowPage = page;
				var memberId = $('#memberId').val();
				var url = '../boardComment/comments/'+memberId+'?page='+nowPage;
				var list = '';

				$.getJSON(
					url,
					function(data){						
						console.log(data);
					
						$(data.list).each(function(){
						var createdDate = new Date(this.createdDate);
						
						list += '<li class="comment_reply_item">'
							 +  '<span><a href="/guteam/gameBoard/detail?gameBoardId='+this.boardId+'&page=1&gameId='+this.gameId+'">'+this.content+'</a></span>'
							 +	'<span>'+dateFormat(createdDate)+'</span>'
							 +  '</li>';
						
						}); //end data.each
						var hasPrev = data.pageMaker.hasPrev;
						var hasNext = data.pageMaker.hasNext;
						var startPageNo = data.pageMaker.startPageNo;
						var endPageNo = data.pageMaker.endPageNo;
						
						list += '<div class="comment_paging">';
						if(hasPrev){
							list += '<button class="paging" value="'+(startPageNo-1)+'">이전</button>&nbsp&nbsp'; 
						}
						for(var i = startPageNo ; i<=endPageNo ; i++ ){
							if(nowPage==i){
								list += '<em>'+i+'</em>';									
							}else{
								list += '<button class="paging" value="'+i+'">'+i+'</button>';		
							}
						}
						if(hasNext){
							list += '&nbsp&nbsp<button class="paging" value="'+(endPageNo+1)+'">다음</button>&nbsp&nbsp';		
						}
						list +=	'</div>';
						
						$('#myCommentsList').html(list);
					}
				);//end getJson
			}
			
			$('#showMyComments').click(function(){
				$('#showMyComments').css("display","none");
				$('#closeMyComments').css("display","block");
				showMyComments(1);
			});//end showMyComments
			
			$('#closeMyComments').click(function(){
				$('#showMyComments').css("display","block");
				$('#closeMyComments').css("display","none");
				$('#myCommentsList').html('');
				
			});
			
			$('#myCommentsList').on('click','.comment_paging .paging',function(){
				var clickPage = $(this).val();
				console.log("선택한 페이지 :"+clickPage);
				showMyComments(clickPage);
			})
	});
</script>
</body>
</html>

