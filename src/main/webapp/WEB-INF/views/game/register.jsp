<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 등록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" ></script>
</head>
<body>
<h1>게임 등록</h1>
<br>
관리자로 로그인 해야만 볼 수 있는 창<br>
<hr>
<form action="register" method="post" enctype="multipart/form-data"><br>
game_name : <input type="text" autofocus="autofocus" name="gameName" required="required"><br> 
price : <input type="number" name="price" required="required"><br>
genre : <input type="text" name="genre" required><br>
game_image : <img class="file-drop" width="200px" height="200px" src="display?fileName=basic.png"><br>
<input type="file" id="file" name="file" accept="image/*" onchange="display(event)">
<input type="hidden" class="gameImageName" name="gameImageName" value="basic.png">
<br>
<input type="submit" value="등록"><br>
<script type="text/javascript">
$(document).ready(function(){
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