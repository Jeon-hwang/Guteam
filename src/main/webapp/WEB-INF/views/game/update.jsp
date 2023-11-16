<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token }"/>
<meta name="_csrf_header" content="${_csrf.headerName }"/>
<title>${vo.gameName } 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
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
<h1>${vo.gameName } 수정</h1>
</div>
<div class="formArea">
<form action="update" method="post" enctype="multipart/form-data" accept-charset="utf-8" >
<sec:csrfInput/>
<div class="info">
<div class="caption">
<p>게임이름 = </p>
<p>가격 = </p>
<p>장르 = </p>
<p>게임 이미지 = </p>
</div>
<div class="inputArea">
<input type="hidden" name="prevListUrl" value="${prevListUrl }">
<input type="hidden" id="gameId" name="gameId" value="${vo.gameId }">
<input type="text" id="gameName" name="gameName" value="${vo.gameName }" required><br>
<input type="number" name="price" value="${vo.price }" required><br>
<input type="text" name="genre" value="${vo.genre }" required><br>
<img class="file-drop" width="300px" height="300px" alt="${vo.gameName }" src="display?fileName=${vo.gameImageName }"><br>
<input type="file" name="file" id="file" accept="image/*" onchange="display(event)">
<label for="file" class="btn btn-secondary"><i class="bi bi-file-earmark-arrow-up-fill"></i></label>
<input type="hidden" class="gameImageName" name="gameImageName" value="${vo.gameImageName }">
<!-- <img alt="${vo.gameImageName }" src=""> -->
<br>
<input id="submit" type="submit" class="btn btn-secondary" value="수정">
</div>
</div>
</form>
<div class="justify-content-center">
<a href="detail?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button class="btn btn-secondary">취소</button></a>
</div>
</div>
</div>
</section>

<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
		$(document).ready(function(){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$('.file-drop').on('dragenter dragover', function(event){
				event.preventDefault();
				console.log('drag 테스트');
			}); 
			$('.file-drop').on('drop', function(event){
				event.preventDefault();
				
				var formData = new FormData();
				
				var files = event.originalEvent.dataTransfer.files;
				var gameId = $('#gameId').attr('value');
				var i = 0 ;
				for(i = 0 ; i < files.length; i++){
					console.log(files[i]);
					formData.append("files",files[i]);
					formData.append("gameId",gameId);
				$.ajax({
					type : 'post',
					url : '/guteam/game/upload-ajax',
					data : formData,
					processData : false,
					contentType : false,
					beforeSend : function(xhr){
						xhr.setRequestHeader(header, token);
					},
					success : function(data){
						console.log(data);
						$('.file-drop').attr('src', 'display?fileName='+data);
						$('.gameImageName').attr('value', data);
					}
				
				});// ajax
				}
			}); // file-drop.drop
			
		});// document.ready
		function display(event){
			var reader = new FileReader();
			reader.onload = function(event){
				if(event.target.result.indexOf('video')==-1){
					$('.file-drop').attr('src', event.target.result);						
				}else{
					$('.file-drop').attr('style','display:none;');
					$('#submit').attr('value','동영상 업로드');
				}
			}
			reader.readAsDataURL(event.target.files[0]);
			console.log(event.target);
			console.log(event.target.result);
		}; // display
	</script>


</body>
</html>