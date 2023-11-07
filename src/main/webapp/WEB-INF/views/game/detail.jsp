<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>${vo.gameName }</title>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
</head>
<body>
	<section>
	<div id="wrap">
	<div class="detail-box">
	<div class="info">
	<div class="category">
	<a href="list">All Games</a> &nbsp; <i class="bi bi-caret-right-fill"></i> &nbsp; <a href="list?keyword=${vo.genre }">${vo.genre }</a>
	</div>
	<div id="detailInfo">
	<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
	<sec:authentication property="principal" var="principal"/>
	<input type="hidden" id="username" value="${principal.username }">
	</sec:authorize>
	<div id="gameImageArea">
	<img alt="${vo.gameName }" width="300px" height="300px" src="display?fileName=${vo.gameImageName }">
	</div>
	<div class="infoArea">
	<br>
	게임 이름 : ${vo.gameName }
	<br>
	가격 : ${vo.price }
	<br>
	장르 : ${vo.genre }
	<br>
	출시일 : <fmt:formatDate value="${vo.releaseDate }" pattern="yyyy년 MM월 dd일" />
	<br>
	마지막 업데이트일 :<fmt:formatDate value="${vo.updateDate }" pattern="yyyy년 MM월 dd일" /> 
	<br>
	평점 : <c:if test="${rating==0 }">
		<i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
		</c:if>
		<c:if test="${rating!=0 }">
			<c:forEach begin="1" end="${rating/2 }" step="1">
				<i class="bi bi-star-fill"></i>
			</c:forEach>
			<c:if test="${rating%2!=0 }">
				<i class="bi bi-star-half"></i>
			</c:if>
			<c:forEach begin="1" end="${5-(rating/2) }"
				step="1">
				<i class="bi bi-star"></i>
			</c:forEach>
		</c:if>
	</div>
	</div>
	</div>
	<input type="hidden" id="gameId" value=${vo.gameId }>
	<br>
	<sec:authorize access="isAuthenticated()">
	<div id="friendsOwnGame">
	<div class="textOwner">
	이 게임을 가지고 있는 친구 
	</div>
	<ul id="friendsList">
	</ul>
	</div>	
	</sec:authorize>
	</div>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	<div class="btn_group_detail">
	<a href="update?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button class="btn btn-light">수정하기</button></a>
	</div>
	</sec:authorize>
	<div class="btn_group_detail">
	<a href="../gameBoard/list?gameId=${vo.gameId }"><button class="btn btn-light">${vo.gameName } 커뮤니티</button></a>
	<a href="../review/list?gameId=${vo.gameId }"><button class="btn btn-light">리뷰보기</button></a>
	</div>
	<div class="btn_group_detail">
	<a href="${prevListUrl}"><button class="btn btn-light">리스트로 돌아가기</button></a>
	
	<input type="hidden" id="updateResult" value="${update_result }">
	
	<br>
	<sec:authorize access="isAuthenticated()">
	<div class="wish_list_btn_area">
		<button  class="btn btn-light" id="addWishList">위시리스트에 추가</button>
		<button  class="btn btn-light" id="removeWishList" style="display : none">이미 위시리스트에 추가 되어 있습니다.</button>
		<p id="alreadyOwnGame" style="display : none">이미 보유한 게임입니다.</p> 
		<form id="buyown" action="../purchased/purchaseWindow" method="get">
			<sec:csrfInput/>
			<input type="hidden" id="gameIdInput" name="gameIds" value="${vo.gameId }">
			<input type="submit" class="btn btn-light" id="submit" value="게임 구매">
		</form>
	</div>
	</sec:authorize>
	</div>
	</div>
	</section>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		<script type="text/javascript">
			$(document).ready(function(){
			   showWishList();
			   var checkGameId = [];
			   var gameIdInput = $('#gameIdInput');
			   var totalPriceInput = $('#totalPriceInput');
			   
			   function showWishList(){
				  var memberId = $('#memberId').val();
				  console.log(memberId);
				  var list = '';
				  var url = 'all/'+memberId;
				  $.getJSON(
						url,
						function(data){
						   console.log(data);
						   $(data).each(function(){
							  console.log(this);
							  list +=   '<li class="wish_list_item">'
								  + '<input type="hidden" class="gameId" value='+this.gameId+'>'
								  + '<input type="checkbox" class="listCheck">'
								  + '<img alt="'+this.gameName+'" width="100px" height="100px"'
								  + 'src="../game/display?fileName='+this.gameImageName+'">'
								  + '<span id="gameName"><a href=../game/detail?gameId='+this.gameId+'>'+this.gameName+'</a></span>'
								  + '<span class="genre">'+this.genre+'</span>'
								  + '<span class="showPrice">￦'+this.price+'</span>'
								  + '<input type="hidden" class="price" value='+this.price+'>'
								  + '<div class="buy_or_remove">'
								  + '<button class="oneBuyBtn">구매</button>'
								  + '<button class="removeWishList">X</button></div>'
								  + '</li>'
								  + '<hr>';
						   });//end data.each
						   
						   $('.wish_list').html(list);
						   
						});// end getJSON
			   }//end showWishList()
			   $('.wish_list').on('click','.wish_list_item .buy_or_remove .removeWishList',function(){
				  var gameId = $(this).parent().prevAll('.gameId').val();
				  var memberId = $('#memberId').val();
				  var token = $("meta[name='_csrf']").attr("content");
				  var header = $("meta[name='_csrf_header']").attr("content");
				  $.ajax({
					 type : 'DELETE',
					 url : memberId,
					 headers : {
						'Content-Type' : 'application/json'
					 },
					 data : gameId,
					 beforeSend : function(xhr) {
						  xhr.setRequestHeader(header, token);
					  },
					 success : function(result){
						console.log(result);
						if(result==1){
						   alert('위시리스트 제거 성공');
						   showWishList();
						}
					 }
				  });// end ajax
			   });//end removeWishList.click
			   
			   $('.wish_list').on('click','.wish_list_item .listCheck',function(){
				  var price = parseInt($(this).nextAll('.price').val());
				  var totalPrice = parseInt($('#totalPrice').text());
				  var gameId = $(this).prevAll('.gameId').val();
				  if($(this).is(':checked')){
					 //console.log("체크 수행 확인!");
					 console.log("가격? "+price);
					 totalPrice += price;
					 checkGameId.push(gameId);
					 //console.log(checkGameId);
				  }else{
					 totalPrice  -= price;
					 checkGameId = checkGameId.filter((element) => element != gameId);
					 //console.log(checkGameId);
				  }
				  $(gameIdInput).attr('value',checkGameId);
				  console.log($(gameIdInput).attr('value'));
				  if($(gameIdInput).attr('value')!=''){
				  
					 $("#submit").removeAttr("disabled");
				  
				  }else{
					 $('#submit').attr("disabled",'disabled');
				  }
				  $('#totalPrice').html(totalPrice);
			   });// end wish_list_item.on
			   
			   $('#allBuy').click(function(){
				  console.log("전체 구매버튼 클릭");
				  console.log(checkGameId);
				  
			   });
			   
			   $('.wish_list').on('click','.wish_list_item .oneBuyBtn',function(){
				  
				  var gameId = $(this).parent().prevAll('.gameId').val();
				  console.log("gmaeId="+gameId);
				  
				  location.href = "../purchased/purchaseWindow?gameIds="+gameId;
			   }); // end oneBuyBtn
			   
			}); // end document
		 </script>
	  </body>
	  </html>