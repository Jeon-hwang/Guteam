<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/style.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.js" type="text/javascript"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<style type="text/css">
.tag{
		background-color:#cee0ff;
		color:#050505;
		cursor:pointer;
}
.contents{
	user-select: text;
    white-space: pre-wrap;
    word-break: break-word;
    font:15px Arial;
}
#tag-container {
     position: relative;
     display: flex;
     flex-wrap:wrap;
}
#tag-list {
     display: none;
     position: absolute;
     background-color: #f1f1f1;
     border: 1px solid #ccc;
     max-height: 150px;
     overflow-y: auto;
     width: 200px;
}

#tag-list div {
   padding: 10px;
   cursor: pointer;
}

#tag-list div:hover {
    background-color: #ddd;
}
.ui-dialog-buttonset button{
	margin-right:8px;
	color: #6c757d;
   border-color: #6c757d;
   font-size: 1rem;
   font-weight: 400;
   line-height: 1.5;
   color: white;
   background-color: rgba(103, 112, 123, 0.2);
   border-width: var(--bs-border-width);
   border-color: rgba(103, 112, 123, 0.2);
   border-radius: var(--bs-border-radius);
   box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15),0 1px 1px rgba(0, 0, 0, 0.075);
   display: inline-block;
   text-align: center;
   text-decoration: none;
   vertical-align: middle;
   cursor: pointer;
   user-select: none;
   transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.ui-dialog-buttonset button:hover{
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}
.ui-dialog-buttonset, .ui-helper-clearfix{
	background-color:#d0e0f9;
	background:#d0e0f9;
}
.ui-dialog-title, .ui-widget-header{
	background-color: #6c757d;
	background:#6c757d;
	color:#fff;
}
.ui-dialog-titlebar-close{
	display:none;
}
.ui-dialog-buttonpane ui-widget-content ui-helper-clearfix{
	display:flex;
	justify-content:space-around;
}
.ui-dialog-buttonset{
	width:100%;
	display:flex;
	justify-content:space-around;
}
</style>
<title>${vo.gameBoardTitle } 글 수정하기</title>
</head>
<body>
<header>
<div class="logo">
	<img alt="guteam" src="${pageContext.request.contextPath}/image/logo80.png" onclick="location.href='/guteam/game/list'">
	</div>
</header>
<section>
<div id="wrap">
<div id="dialog" title="information"></div>
<div class="titleArea">
<h1>게시글 수정</h1>
</div>
<div class="formArea">
<div class="info">
<div class="caption">
<p>제목 : </p>
<p>작성자 : </p>
<p>내용 : </p>
</div>

<div id="tag-container" class="inputArea">
<sec:authentication property="principal" var="principal"/>
<form action="update" method="post" onsubmit="update();">
<sec:csrfInput/>
<input type="hidden" name="page" value="${page }">
<input id="gameId" type="hidden" name="gameId" value="${gameId }">
<input type="hidden" name="gameBoardId" value="${vo.gameBoardId }">
<p data-type="gameBoardTitle" contenteditable="true" style="width:296px;height:24px;max-width:296px;max-height:24px; cursor: text;
      border: none; background-color:#2a3f5a; font-size:15px; color:#fff;
      display: block;" class="contents"></p>
<input type="hidden" name="gameBoardTitle" id="gameBoardTitle" value='${vo.gameBoardTitle }'>
<div class="caption">
<p>${principal.username }</p>
</div>
<p data-type="gameBoardContent" contenteditable="true" style="width:761px;height:450px;max-width:761px;max-height:450px; cursor: text;
      border: none; background-color:#2a3f5a; font-size:15px; color:#fff;
      display: block;" class="contents"></p>
<input type="hidden" name="gameBoardContent" id="gameBoardContent" value='${vo.gameBoardContent }'>
<br>
<input class="btn btn-secondary" type="submit" value="수정하기">
</form>
<div id="tag-list"></div>
<a href="detail?gameBoardId=${vo.gameBoardId }&page=${page}&gameId=${gameId}" class="btn btn-secondary">돌아가기</a>
</div>
</div>
</div>
</div>
</section>
<canvas id="textCanvas" style="display: none;font-size:15px; "></canvas>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
<script type="text/javascript">
	var deleted = '삭제된 게시글';
	$(document).ready(function(){
		$('[data-type="gameBoardContent"]').html($('#gameBoardContent').attr('value'));
		$('[data-type="gameBoardTitle"]').html($('#gameBoardTitle').attr('value'));
		$('.tag').on('DOMCharacterDataModified ',function(){
			$(this).removeClass();
		}).on('click',function(event){
			var mpX = event.pageX;
			var mpY = event.pageY;
			$.ajax({
				url:'/guteam/member/nick/'+$(this).text(),
				method:'post',
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success:function(data){
					var info = '<img class="tagProfileImg" alt="'+data.nickname+'" src="../game/display?fileName='+data.memberImageName+'" width="100px" height="100px" /><br>'
					+'<p><i class="bi bi-person-square"></i> : ' + data.nickname + '</p>'
					+ '<p><i class="bi bi-envelope"></i> : '+ data.email+'</p>'
					+ '<p><i class="bi bi-phone-vibrate"></i> : '+ data.phone+'</p>';
					$( "#dialog" ).html(info);
					$( "#dialog" ).dialog({
						resizable : false,
						buttons:{
							"닫기":function(){
								$(this).dialog("close");
							}
						}
					});
					mpY = mpY - $('#dialog').parent().height();
					$('.ui-widget-header').attr('style','background:#6c757d;');
					$('.ui-widget-content').attr('style','background:#d0e0f9;');
					$('#dialog').parent().attr('style','border:none;background-color:#d0e0f9;display:inline-block;position:absolute;left:'+mpX+'px;top:'+mpY+'px;');
				}
			});
		});
		$('.contents').on('focusout', function(){
			var text = $(this).val();
			if(text.length > 0) {
				if(text.match(deleted)){
					text = text.replace(deleted,"");
				}
				this.val(text);
			}
		}).on('keyup',function(){
			$(this).val($(this).val().replace(deleted,""));
		}); // end banedDeleted.onFocusout(); // end banedDeleted.onKeyup();
	}); // end document.ready()
	var keyword='';
	var htmlIndex=0;
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	function update(event){
		var gameBoardTitle = $('[data-type="gameBoardTitle"]').html().replaceAll('contenteditable="true"','');
		var gameBoardContent = $('[data-type="gameBoardContent"]').html().replaceAll('contenteditable="true"','');
		$('#gameBoardTitle').attr('value',gameBoardTitle);
		$('#gameBoardContent').attr('value',gameBoardContent);
		var gameId = $('#gameId').val();
		if(gameBoardTitle==''||gameBoardContent==''||gameId==''){
			alert('빈 칸 없이 입력해주세요');
			return false;
		}
	}
	function getNodeAtCursor() {
		  var selection = window.getSelection();
		 
			
		  if (selection.rangeCount > 0) {
		    var range = selection.getRangeAt(0);
		    // 여기에서 node 변수를 사용하여 현재 커서 위치에 있는 노드에 접근합니다.
		    var content = range.commonAncestorContainer.data;
		  }
		}
	function getNodeAtKeyup(){
		var selection = window.getSelection();
		$('.currentDiv').removeClass();
		$('#currentDiv').removeAttr('id');
		if(selection!=null&&selection.rangeCount>0){
			var range = selection.getRangeAt(0);
			console.log(range);
			var content = range.commonAncestorContainer.nodeValue;
			if(content!=null&&content.indexOf('@')!=-1){
				var div = range.commonAncestorContainer.parentElement;
				var currentDiv = div;
				if($(div).attr('class')!='contents'){			
					$(div).attr('class','currentDiv');
				}else{
					$(div).attr('id','currentDiv');
				}
				content = $(currentDiv).text();
				var top = div.offsetTop+24;
				var index = 0;
				htmlIndex = range.startOffset;
				var htmlInDiv = range.commonAncestorContainer.parentNode.innerHTML;
				var previousSibling = range.commonAncestorContainer.previousSibling;
				while(previousSibling){
					if (previousSibling.nodeType === Node.TEXT_NODE) {
						console.log('prevIndex='+previousSibling.length);
						console.log('index='+index);
						index+=previousSibling.length;
						htmlIndex+=previousSibling.length;
					}
					previousSibling = previousSibling.previousSibling;
				}
				$(range.commonAncestorContainer).prevAll().each(function(){
					index+=$(this).text().length;
					htmlIndex+=this.outerHTML.length;
				});
				console.log('index:'+index);
				console.log('htmlIndex:'+htmlIndex);
				content = content.substr(0,range.startOffset+index);
				var myText = content.substr(0,content.lastIndexOf('@'));
				var computedStyle = window.getComputedStyle(div);
				var font = computedStyle.getPropertyValue('font');
				if(font==''){
					computedStyle = window.getComputedStyle(div.parentNode);
					font = computedStyle.getPropertyValue('font');
				}
				var left = measureTextWidth(myText, font);
				var keyword = content.substr(content.lastIndexOf('@'));
				console.log(keyword);
				htmlBeforeTag = htmlInDiv.substr(0,htmlIndex-keyword.length);
				htmlNextTag = htmlInDiv.substr(htmlIndex);
				console.log('htmlBeforeTag,htmlNextTag:'+htmlBeforeTag,htmlNextTag);
				
				if(keyword.length>1){
					$.getJSON(
							'/guteam/tag/'+keyword.substr(1),
							function(data){
								console.log(data);
								$('#tag-list').html('');
								if(data.length!=0){
									$(data).each(function(){
										$(this).each(function(){
											$('#tag-list').append('<div class="tagList" onclick="changeTag(this);"><img class="tagProfileImg" alt="'+this.nickname+'" src="../game/display?fileName='+this.memberImageName+'" width="50px" height="50px" />'+this.nickname+'</div>');
										});
									});
									$('#tag-list').append('<div id="keyword" style="display:none;">'+keyword+'</div>');
									console.log(left,top);
									$('#tag-list').attr('style','margin-left:'+left+'px;margin-top:'+top+'px;');
									$('#tag-list').show();
								}else{
									$('#tag-list').hide();
								}
							}
						);
				}
			}else{
				$('#tag-list').hide();
				$('#tag-list').html('');
			}
		}
	}
	function measureTextWidth(text, font) {
		  var canvas = document.getElementById('textCanvas');
		  var context = canvas.getContext('2d');
		  context.font = font;

		  // 텍스트의 너비를 측정하여 반환
		  return context.measureText(text).width;
	}
	function changeTag(tag){
		console.log(tag);
		keyword=$('#keyword').text();
		console.log(keyword);
		var currentDiv = $('.currentDiv');
		if(currentDiv.length==0){
			currentDiv = $('#currentDiv');
		}
		console.log($(currentDiv).text());
		var changeHtml = htmlBeforeTag +'<span class="tag" contenteditable="true">'+$(tag).text()+'</span> '+htmlNextTag;
		$(currentDiv).html(changeHtml);
		$('.tag').on('DOMCharacterDataModified ',function(){
			$(this).removeClass();
		}).on('click',function(event){
			var mpX = event.pageX;
			var mpY = event.pageY;
			$.ajax({
				url:'/guteam/member/nick/'+$(this).text(),
				method:'post',
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success:function(data){
					var info = '<img class="tagProfileImg" alt="'+data.nickname+'" src="../game/display?fileName='+data.memberImageName+'" width="100px" height="100px" /><br>'
					+'<p><i class="bi bi-person-square"></i> : ' + data.nickname + '</p>'
					+ '<p><i class="bi bi-envelope"></i> : '+ data.email+'</p>'
					+ '<p><i class="bi bi-phone-vibrate"></i> : '+ data.phone+'</p>';
					$('#dialog').html(info);
					$('#dialog').dialog({
						resizable : false,
						buttons:{
							"닫기":function(){
								$(this).dialog("close");
							}
						}
					});
					$('#ui-id-1').text(data.memberId);
					$('.ui-widget-header').attr('style','background:#6c757d;');
					$('.ui-widget-content').attr('style','background:#d0e0f9;');
					$('#dialog').parent().attr('style','border:none;background-color:#d0e0f9;display:inline-block;position:absolute;left:'+mpX+'px;top:'+mpY+'px;');
					$('#dialog').parent().on('mouseleave',function(){
						$('#dialog').dialog('close');
					});
				}
			});
		});
		$('#tag-list').hide();
		
		$(currentDiv).focus();
	}

		$('.contents').on('mouseup', getNodeAtCursor);
		$('.contents').on('keyup', getNodeAtKeyup);

</script>
</body>
</html>