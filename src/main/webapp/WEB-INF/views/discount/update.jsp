<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
<title>장르별 할인</title>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
</head>
<body>
<header>
	<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
</header>
<section>
	<div id="wrap">
	<div class="titleArea">
	<h1>할인율 적용하기</h1>
	</div>
	<div class="formArea">
	<form action="update" method="post" onsubmit="return check();">
	<sec:csrfInput/>
		<div class="input-group mb-3 ">
			<button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"><span class="selectedItem">선택</span></button>
			<ul class="dropdown-menu">
			<c:forEach items="${genreList }" var="genre">
			<li><a class="dropdown-item" onclick="$('.selectedItem').html(this.innerText);$('.genre').attr('value',this.innerText);">${genre }</a></li>
			</c:forEach>
			</ul>
			<input type="hidden" id="genre" class="genre" name="genre" value="미선택">
			<input class="form-control" type="number" name="discountRate" id="discountRate" maxlength="5" step="0.05" max="0.5" min="0" required="required">
			<button class="btn btn-light" type="submit"><i class="bi bi-clipboard-check"></i></button>
		</div>
	</form>
	<div class="infoArea">
		<p>현재 적용된 할인</p>
		<c:forEach items="${discountList }" var="vo">
		<p><span class="genre">${vo.genre }</span> <i class="bi bi-asterisk"></i> ${vo.discountRate }<button class="btn btn-secondary deleteDiscount"><i class="bi bi-trash"></i></button></p>
		</c:forEach>
	</div>
	</div>
	</div>
	<input type="hidden" id="discountResult" value="${discount_result }">
</section>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function(){
			var discountResult = $('#discountResult').val();
			if(discountResult=='fail'){
				alert('할인 적용 실패!');
			}
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$('.deleteDiscount').on('click', function(){
				var genre = $(this).parent().children('.genre').text();
				console.log(genre);
				$.ajax({
					type : 'post',
					url : '/guteam/discount/'+genre,
					headers : {
						'Content-Type' : 'application/json'
					},
					data : JSON.stringify(genre),
					beforeSend : function(xhr) {
				        xhr.setRequestHeader(header, token);
				    },
					success : function(result){
						if(result=='success'){
							alert('삭제 성공');
							location.href="update";
						}
					}
				}); // end ajax()
			});// end deleteDiscount.onclick()
			
		}); // end document.ready()
		function check(){
			var genre = $('#genre').val();
			if(genre=='미선택'){
				alert('장르를 선택해주세요');
				return false;
			}else{
				return true;
			}
		}
	</script>
</body>
</html>