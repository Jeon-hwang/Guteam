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
<title>게임 등록</title>
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
<h1>게임 등록</h1>
</div>
<div class="formArea">
<form action="register" method="post" enctype="multipart/form-data" accept-charset="utf-8"><br>
<sec:csrfInput/>
<div class="info">
<div class="caption">
<p>game_name : </p>
<p>price : </p>
<p>genre : </p>
<p>game_image : </p>
</div>
<div class="inputArea">
<input type="text" autofocus="autofocus" name="gameName" required="required"><br> 
<input type="number" name="price" required="required"><br>
 <input type="text" name="genre" required><br>
<img class="file-drop" width="300px" height="300px" src="display?fileName=basic.png"><br>
<div class="input-group mb-3">
<input type="file" class="form-control" id="file" name="file" accept="image/*" onchange="display(event)">
<label for="file" class="btn btn-secondary"><i class="bi bi-file-earmark-arrow-up-fill"></i></label>
</div>
<input type="hidden" class="gameImageName" name="gameImageName" value="basic.png">
<input type="submit" class="btn btn-secondary" value="등록"><br>
</div>
</div>
</form>
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
				
				var i = 0 ;
				for(i = 0 ; i < files.length; i++){
					console.log(files[i]);
					formData.append("files",files[i]);
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
				$('.file-drop').attr('src', event.target.result);
			}
			reader.readAsDataURL(event.target.files[0]);
			console.log(event.target.result);
		}; // display
	</script>

</form>
</body>
</html>