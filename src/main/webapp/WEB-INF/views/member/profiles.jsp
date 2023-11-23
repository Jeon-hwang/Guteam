<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<meta charset="UTF-8">
<title>GUTEAM : 프로필</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">
body{
	color:white;
}
.totalCash {
	display: flex;
}
.titleP {
	display: flex;
}

#wrap {
    display: flex;
}
#myPrfBox {
	width: 240px;
	display: flex;
	flex-direction: column;
}
.btn_group_detail {
    flex-direction: column;
}
.btn_group_detail .btn {
    margin-left: 0px;
}
#prfMain {
	width: 70%;
	margin-left: 10px;
}
#boardsAndReviewsArea {
	flex-direction: column;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
}
</style>
</head>
<body>
<section>
<div id="wrap">
<div id="myPrfBox">
	<input type="image" class="profileImg" alt="${vo.memberId }" src="display?fileName=${vo.memberImageName }" readonly />
	<div class="titleP">
		<h2>${vo.memberId }님의 프로필</h2>
	</div>
	<div class="totalCash">
		<span>나의 지갑 : ₩&nbsp;${vo.cash }</span>
	</div>
	<div class="btn_group_detail">
		<form action="../payment/kakaoPay" method="post">
		<sec:csrfInput/>
		<input type="number" name="cash" style="width:130px;margin-left: 5px; margin-bottom: 10px;" placeholder="cash" required="required">
		<button id="payMe"class="btn btn-light">캐쉬 충전</button>
		</form>
		<button class="btn btn-light" onclick="popUp();">쪽지함</button>
		<button class="btn btn-light" onclick="frdList();">친구 목록</button>
	</div>
	<div class="btn_group_detail">
			<button class="btn btn-light" onclick="update();">회원 수정</button>
		<form action="delete" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
		<sec:csrfInput/>
			<input type="hidden" name="memberId" id="memberId" value="${vo.memberId }">
			<input type="submit" class="btn btn-light" value="회원 탈퇴">	
		</form>
	</div>
</div><!-- id="myPrfBox" -->
<div id="prfMain">
	<hr>
	<div id="boardsAndReviewsArea" style="display:flex;">
	<div id="boardsArea" style="display:inline-block;">
		<button id="showMyBoards" class="btn btn-light" style="margin-bottom:10px;">내가 쓴 게시글 보기</button>
		<input type="hidden" id="boardPage" value="1">
		<div id="myBoards">
		<table id="myBoardList" style="width:100%;" class="table table-secondary table-hover"></table>
		<div id="boardPaging" class="paging" style="display:inline-block; text-align:left;"></div>
		</div>
	</div>
	<hr>
	<div id="reviewsArea" style="display:inline-block;">
		<button id="showMyReviews" class="btn btn-light" style="margin-bottom:10px;">내가 쓴 리뷰 보기</button>
		<input type="hidden" id="reviewPage" value="1">
		<div id="myReviews">
		<table id="myReviewList" style="width:100%;" class="table table-secondary table-hover"></table>
		<div id="reviewPaging" class="paging" style="display:inline-block; text-align:left;"></div>
		</div>
	</div>
	</div>
	<hr>
	<div id="commentsArea">
		<button id="showMyComments" class="btn btn-light">내가 쓴 댓글 보기</button>
		<button id="closeMyComments" class="btn btn-light" style="display : none">접기</button>
		<div id="myComments">
			<ul id="myCommentsList"></ul>
		</div>
	</div>
</div><!-- id="prfMain" -->

<input type="hidden" id="udp_alert" value="${udp_alert }">
<input type="hidden" id="charge_result" value="${charge_result}">
<input type="hidden" id="amount" value="${info.amount.total }">
<input type="hidden" id="tid" value="${info.tid }">
<input type="hidden" id="approvedAt" value="${info.approved_at }">
<span>
<fmt:formatDate value="${info.approved_at }" pattern="MM-dd HH:mm:ss" />
</span>
</div>

</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
	function popUp(){
	   popupWin =  window.open('../message/list', '쪽지함', 'resizable');		
	   popupWin.resizeTo(750, 500);
	   popupWin.onresize = (_=>{
		   popupWin.resizeTo(750, 500);
		})
	};
	function frdList(){
		location.href = "../friend/list";
	}
	function update(){
		location.href = "update";
	}
	
	$(document).ready(function(){
		var chargeResult = $('#charge_result').val();
		if(chargeResult=='success'){
			var amount = $('#amount').val()+'원';
			var tid = $('#tid').val();
			var approvedAt = $('#approvedAt').nextAll('span').text();
			console.log(approvedAt);
			alert(' 충전 성공 \n'+'일시 : '+approvedAt+'\n 충전 캐쉬 : ' + amount + '\n tid : ' + tid);
		}
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
		
		var result = $('#udp_alert').val();
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
							 +  '<span class="commentAndReplyContent"><a href="/guteam/gameBoard/detail?gameBoardId='+this.boardId+'&page=1&gameId='+this.gameId+'">';
							if(this.content.substring(0,9)=='(updated)'){
						list += this.content.replace('(updated)','');		
							}else{
						list +=	this.content;
							}
						list +=	'</a></span>'
							 +	'<span class="commentsDate">'+dateFormat(createdDate)+'</span>'
							 +  '</li>';
						
						}); //end data.each
						var hasPrev = data.pageMaker.hasPrev;
						var hasNext = data.pageMaker.hasNext;
						var startPageNo = data.pageMaker.startPageNo;
						var endPageNo = data.pageMaker.endPageNo;
						
						list += '<div class="comment_paging_area">';
						if(hasPrev){
							list += '<button class="comment_paging" value="'+(startPageNo-1)+'">이전</button>&nbsp&nbsp'; 
						}
						for(var i = startPageNo ; i<=endPageNo ; i++ ){
							if(nowPage==i){
								list += '<em>'+i+'</em>';									
							}else{
								list += '<button class="comment_paging" value="'+i+'">'+i+'</button>';		
							}
						}
						if(hasNext){
							list += '&nbsp&nbsp<button class="comment_paging" value="'+(endPageNo+1)+'">다음</button>&nbsp&nbsp';		
						}
						list +=	'</div>';
						
						$('#myCommentsList').html(list);
					}
				);//end getJson
	
			} //end showMyComments
			
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
			
			$('#myCommentsList').on('click','.comment_paging_area .comment_paging',function(){
				var clickPage = $(this).val();
				console.log("선택한 페이지 :"+clickPage);
				showMyComments(clickPage);
			});
			
			$('#showMyBoards').on('click', function(){
				var page = $('#boardPage').attr('value');
				var memberId = $('#memberId').val();
				var url = '../gameBoard/list-ajax/'+memberId+'?page='+page;
				var list = '';
				if($('#showMyBoards').text()=="내가 쓴 게시글 보기"){
					
				$.getJSON(
					url,
					function(data){
						console.log(data);
						if(data.list.length!=0){
							list = '<thead>'
							+'<tr><th whidth="10.7%">no</th>'
							+'<th width="26.78%">제목</th>'
							+'<th width="26.78%">내용</th>'
							+'<th width="35.7%">작성일</th></thead><tbody>';
						}
						$(data.list).each(function(){
							console.log(this);
							var createdDate = new Date(this.gameBoardDateCreated);
							var title = this.gameBoardTitle;
							if(title.length>20){
								title = title.substr(0, 20) + '…';
							}
							var content = this.gameBoardContent;
							if(content.length>20){
								content = content.substr(0, 20) + '…';
							}
							if(this.gameBoardContent!="삭제된 게시글 입니다"){
								list += '<tr class="gameBoardInfo" onclick="boardInfoClick('+this.gameBoardId+','+this.gameId+')">'
									 +  '<td>' + this.gameBoardId+'</td>'
									 +  '<td>'+title+'</td>'
									 +  '<td>'+content+'</td>'
									 +	'<td>'+dateFormat(createdDate)+'</td>'
									 +  '</tr>';
								}
						}); // end data.each
						if(data.list.length!=0){
							list += '</tbody>';
						}
						console.log(data.pageMaker);
						var pages = '';
						pages+='<ul class="pagination justify-content-center">';
						if(data.pageMaker.hasPrev){
							pages+='<li class="page-item"><a class="page-link" onclick="boardPageChange('+(data.pageMaker.startPageNo-1)+')">&laquo;</li>';
						}
						for(var i=data.pageMaker.startPageNo; i<=data.pageMaker.endPageNo; i++){
							if(i==page){
								pages+='<li class="page-item active"><a class="page-link" onclick="boardPageChange('+i+')">'+i+'</li>';
							}else{
								pages+='<li class="page-item"><a class="page-link" onclick="boardPageChange('+i+')">'+i+'</li>';							
							}
						}
						if(data.pageMaker.hasNext){
							pages+='<li class="page-item"><a class="page-link" onclick="boardPageChange('+(data.pageMaker.endPageNo+1)+')">&raquo;</li>';
						}
						pages+='</ul>';
						
						$('#myBoardList').html(list);
						$('#showMyBoards').text('닫기');
						$('#boardPaging').html(pages);
					}
				); // end getJSON()
				}else{
					$('#showMyBoards').text('내가 쓴 게시글 보기')
					$('#myBoardList').html('');
					$('#boardPaging').html('');
				}
			}); // end showMyBoards.onclick()
			
			$('#showMyReviews').on('click', function(){
				var page = $('#reviewPage').attr('value');
				var memberId = $('#memberId').val();
				var url = '../review/lis	t-ajax/'+memberId+'?page='+page;
				var list = '';
				if($('#showMyReviews').text()=="내가 쓴 리뷰 보기"){
				$.getJSON(
					url,
					function(data){
						console.log(data);
						if(data.list.length!=0){
							list = '<thead>'
							+'<tr><th whidth="8.45%">no</th>'
							+'<th width="21.12%">제목</th>'
							+'<th width="21.12%">내용</th>'
							+'<th width="21.12%">평점</th>'
							+'<th width="28.169%">작성일</th></thead><tbody>';
						}
						$(data.list).each(function(){
							console.log(this);
							var createdDate = new Date(this.reviewDateCreated);
							var title = this.reviewTitle;
							if(title.length>20){
								title = title.substr(0, 20) + '…';
							}
							var content = this.reviewContent;
							if(content.length>20){
								content = content.substr(0, 20) + '…';
							}
							list += '<tr class="reviewInfo" onclick="reviewInfoClick('+this.reviewId+','+this.gameId+')">'
								 +  '<td>' + this.reviewId+'</td>'
								 +  '<td>'+title+'</td>'
								 +  '<td>'+content+'</td>'
								 +  '<td>';
							for(var i=1; i<=this.rating/2; i++){
								list+='<i class="bi bi-star-fill"></i>';
							}
							if(this.rating%2==1){
								list+='<i class="bi bi-star-half"></i>';
							}
							for(var i=1; i<=5-(this.rating/2); i++){
								list+='<i class="bi bi-star"></i>';
							}
							list +=	'</td>'
								 +	'<td>'+dateFormat(createdDate)+'</td>'
								 +  '</tr>';
							
						}); // end data.each
						if(data.list.length!=0){
							list += '</tbody>';
						}
						console.log(data.pageMaker);
						var pages = '';
						pages+='<ul class="pagination justify-content-center">';
						if(data.pageMaker.hasPrev){
							pages+='<li class="page-item"><a class="page-link" onclick="reviewPageChange('+(data.pageMaker.startPageNo-1)+')">&laquo;</li>';
						}
						for(var i=data.pageMaker.startPageNo; i<=data.pageMaker.endPageNo; i++){
							if(i==page){
								pages+='<li class="page-item active"><a class="page-link" onclick="reviewPageChange('+i+')">'+i+'</li>';
							}else{
								pages+='<li class="page-item"><a class="page-link" onclick="reviewPageChange('+i+')">'+i+'</li>';							
							}
						}
						if(data.pageMaker.hasNext){
							pages+='<li class="page-item"><a class="page-link" onclick="reviewPageChange('+(data.pageMaker.endPageNo+1)+')">&raquo;</li>';
						}
						pages+='</ul>';
						
						$('#myReviewList').html(list);
						$('#showMyReviews').text('닫기');
						$('#reviewPaging').html(pages);
					}
				); // end getJSON()
				}else{
					$('#showMyReviews').text('내가 쓴 리뷰 보기')
					$('#myReviewList').html('');
					$('#reviewPaging').html('');
				}
			}); // end showMyBoards.onclick()
			
			
	}); //end document.ready()
	
	function boardInfoClick(gameBoardId,gameId){
		location.href="/guteam/gameBoard/detail?gameBoardId=" + gameBoardId + "&page=1&gameId=" + gameId;
	}
	
	function reviewInfoClick(reviewId,gameId){
		location.href="/guteam/review/detail?reviewId=" + reviewId + "&page=1&gameId=" + gameId;
	}
	
	function boardPageChange(page){
		$('#boardPage').attr('value',page);
		$('#showMyBoards').text('내가 쓴 게시글 보기');
		$('#showMyBoards').click();
	}
	
	function reviewPageChange(page){
		$('#reviewPage').attr('value',page);
		$('#showMyReviews').text('내가 쓴 리뷰 보기');
		$('#showMyReviews').click();
	}
	
</script>
</body>
</html>