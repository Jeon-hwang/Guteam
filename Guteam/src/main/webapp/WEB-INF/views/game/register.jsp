<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 등록</title>
</head>
<body>
<h1>게임 등록</h1>
<br>
관리자로 로그인 해야만 볼 수 있는 창<br>
<hr>
<form action="register" method="post"><br>
game_name : <input type="text" autofocus="autofocus" name="gameName" required="required"><br> 
price : <input type="number" name="price" required="required"><br>
genre : <input type="text" name="genre" required><br>
game_image : 비동기로 구현할 예정<br>
<input type="submit" value="등록"><br>
</form>
</body>
</html>