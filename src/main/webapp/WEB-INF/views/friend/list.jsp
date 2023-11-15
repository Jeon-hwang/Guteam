<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/home.jsp"></jsp:include>
<style type="text/css">
.btn {
	margin: 0px 3px 0px 3px;
	padding: 3px 3px 3px 3px;
}
.subTitle{
	margin-left: 40px; 
	color: #fff;
}
.hrArea hr {
	width: 100%
}

.nameLvl {
	background-color: rgb(103, 112, 123);
	border-color: rgba(103, 112, 123, 0.2);
	color: lightgray;
	resize: none;
	height: 30px;
	margin-top: 2px;
	margin-right: 5px;
	margin-bottom: 5px;
	border-radius: 6px;
}
.div_flex{
	display: flex;
}
.frdListArea {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
	width: 100%;
	margin-left:40px;
	color: #fff;
}

.friend {
	margin: 5px;
	margin-right: 15px;
	display: flex;
	flex-flow: column wrap;
	align-content: flex-start;
	justify-content: space-between;
	align-items: flex-end;
	height: 100px;
}

.profileImg {
	display: flex;
}
.friendReq{
	width: 110px; 
	hieght: 140px; 
	display: block;
}
.nameList {
	background-color: rgb(103, 112, 123);
	border-color: rgba(103, 112, 123, 0.2);
	color: lightgray;
	width: 150px;
	max-width: 148px; 
	border-radius: 6px;
	margin: 5px 5px; 
	display:flex; 
	flex-wrap: wrap;
	cursor:pointer;
}
.margin_left{
	
}
#toNickname {
	width: 100px;
	rows: 5;
	cols: 3;
	wrap: soft;
}
</style>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>GUTEAM : 친구 목록</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>

	<section>
		<div id="wrap">
			<div class="infoArea">
				<div class="div_flex">
					<input type="image" class="profileImg" alt="${vo.memberId }"
						src="display?fileName=${vo.memberImageName }" readonly />
					<h2>나의 친구 목록</h2>
					<form action="../friend/addFriend" method="post"
						onsubmit="sendRequest();">
						<sec:csrfInput />
						<input type="hidden" name="sendMemberId" id="sendMemberId"
							value="${vo.memberId }"><br>
						<br> <input type="text" name="receiveMemberId"
							id="receiveMemberId" placeholder="ID 입력" required> <input
							class="btn btn-light" type="submit" value="친구 추가">
					</form>
				</div>
			</div>
			<div class="info">
				<div>
					<div class="hrArea">
						<hr>
					</div>
					<div class="infoArea">
						<h3>보낸 요청</h3>
						<table>
							<tbody>
								<c:forEach var="svo" items="${sendList }">
									<div class="friendReq">
										<form action="../friend/accept" method="post">
											<sec:csrfInput />
											<img alt="${svo.memberImageName }" width="100px"
												height="100px"
												src="display?fileName=${svo.memberImageName }">
											<textarea id="toNickname" class="nameLvl" readonly>${svo.nickname }</textarea>
											<input type="hidden" name="memberId" value="${vo.memberId }">
											<input type="hidden" name="friendId" value="${svo.memberId }">
											<button type="submit" class="btn btn-light"
												formaction="../friend/cancel">요청취소</button>
										</form>
									</div>

								</c:forEach>
							</tbody>
						</table>
					</div>
					<br>
					<div class="hrArea">
						<hr>
					</div>
					<div class="infoArea">
						<h3>받은 요청</h3>
						<table>
							<tbody>
								<c:forEach var="rvo" items="${receiveList }">
									<div class="friendReq">
										<form action="../friend/accept" method="post">
											<sec:csrfInput />
											<img alt="${rvo.memberImageName }" width="100px"
												height="100px"
												src="display?fileName=${rvo.memberImageName }">
											<textarea id="toNickname" class="nameLvl" readonly>${rvo.nickname }</textarea>
											<input type="hidden" name="memberId" value="${vo.memberId }">
											<input type="hidden" name="friendId" value="${rvo.memberId }">
											<button type="submit" class="btn btn-light"
												formaction="../friend/accept">수락</button>
											<button type="submit" class="btn btn-light"
												formaction="../friend/reject">거절</button>
										</form>
									</div>

								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="hrArea">
						<hr>
					</div>
					<h3 class="subTitle">친구 목록</h3>
					<div class="frdListArea" >
						<table>
							<tbody>
								<c:forEach var="fvo" items="${friendList }">
									<div class="friend">
											<input type="image" class="profileImg" alt="${fvo.memberId }"
											src="display?fileName=${fvo.memberImageName }" readonly />
												<div class="nameList">
												<span>
												${fvo.nickname }
												</span>
												</div>
											<form action="../friend/delete" method="post">
											<sec:csrfInput />
											<input type="hidden" name="friendId" class="friendId"
												value="${fvo.memberId }">
											<button type="submit" class="btn btn-light"
												formaction="../friend/delete">친구삭제</button>
										</form>
									</div>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<input type="hidden" id="fnd_alert" value="${fnd_alert }">
			</div>
		</div>
	</section>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>

	<script type="text/javascript">
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$(document).ready(function() {
			var result = $('#fnd_alert').val();
			if (result == 'friend') {
				alert('이미 친구인 유저입니다.')
			} else if (result == 'alreadyFrd') {
				alert('먼저 친구 요청 받아 친구가 되었습니다.')
			} else if (result == 'dupl') {
				alert('이미 친구 요청된 아이디입니다.');
			} else if (result == 'success') {
				alert('친구요청이 완료되었습니다.');
			} else if (result == 'fail') {
				alert('없는 아이디입니다.');
			}
			$('.profileImg').on('click',function(){
				var friendId = $(this).nextAll('.friendId').val();
				console.log(friendId);
			});
			$('.nameList').on('click',function(){
				var friendId = $(this).nextAll('.friendId').val();
				console.log(friendId);
			});

		});
		function sendRequest() {
			var memberId = $('#receiveMemberId').val();
			var sendMemberId = $('#sendMemberId').val();
			console.log('ajax요청');
			$.ajax({
				type : 'post',
				url : '/guteam/sse/friendRequest/' + memberId,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data : {
					'sendMemberId' : sendMemberId
				},
				success : function(result) {
					console.log('친구 요청을 보냈습니다.');
				}
			});
		}
	</script>
</body>
</html>