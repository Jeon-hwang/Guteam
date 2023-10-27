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
<style type="text/css">
.file-drop {
	width : 100;
	height : 100px;
	border : 1px solid grey;
}
</style>
</head>
<body>
<form action="update" method="post" enctype="multipart/form-data" accept-charset="utf-8">
<sec:csrfInput/>
<input type="hidden" name="prevListUrl" value="${prevListUrl }">
<input type="hidden" name="gameId" value="${vo.gameId }">
게임이름=<input type="text" name="gameName" value="${vo.gameName }" required><br>
가격=<input type="number" name="price" value="${vo.price }" required><br>
장르=<input type="text" name="genre" value="${vo.genre }" required><br>
게임 이미지 = <img class="file-drop" width="100px" height="100px" alt="${vo.gameName }" src="display?fileName=${vo.gameImageName }"><br>
<input type="file" name="file" id="file" accept="image/*" onchange="display(event)">
<input type="hidden" class="gameImageName" name="gameImageName" value="${vo.gameImageName }">
<!-- <img alt="${vo.gameImageName }" src=""> -->
<br>
<input type="submit" value="수정">
</form>
<a href="detail?gameId=${vo.gameId }&prevListUrl=${prevListUrl}"><button>취소</button></a>
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


</body>
</html>