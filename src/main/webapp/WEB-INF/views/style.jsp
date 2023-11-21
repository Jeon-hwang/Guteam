<link rel="icon" href="${pageContext.request.contextPath}/image/guteam_logo_white.png" type="image/x-icon"/>
<!-- Bootstrap css --><!-- http://localhost:8080/guteam/ -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
   crossorigin="anonymous" />
<!-- Bootstrap icons -->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
   rel="stylesheet" />
<!-- Bootstrap core JS-->
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
#thumbUp .btn-success{
	background-color: #198754;
}
#thumbDown .btn-danger{
	background-color: #dc3545;
}
aside{
	visibility: none;
}
section{
	width:100%;
	min-height: 750px;
}
header{
	width:100%;
	height:120px;
	background-color:#151b22;
	box-shadow: 0 0 7px 0 rgba( 0, 0, 0, 0.75 );
	padding:10px 10px;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
}
.board-box hr{
	margin: 1px 1px;
}
header .logo{	
	width:30%;
	height:100%;
	justify-content: flex-start;
	align-items: center;
}
.logo img{
	margin:10px 100px;
	cursor:pointer;
}
#friendsOwnGame{
	width:30%;
	color:#fff;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	flex-wrap: wrap;
	}
#friendsOwnGame ul {
	height:90%;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	justify-content:flex-start;
	align-items:flex-start;
}
#friendsOwnGame ul li{
	align-items:flex-start;
	list-style:none;
	width:50px;
	height:50px;
	justify-content:flex-start;
	}
.textOwner{
	width:240px;
	height:20px;
}
#preview{
	z-index: 99;
	position:absolute;
	border:1px solid #ccc;
	background:#333;
	padding:5px;
	display:none;
	color:#fff;
}
header .auth{
	width:70%;
	height:100%;
	justify-content: flex-end;
	align-items: center;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	margin-right: 50px; 
}
.table th, .table td{
	background-color: #0d131b;
	color:#fff;
	border-color:#5c5c5f;
}
.table tr:hover td{
	background-color: #5c5c5f;
	color:black;
	cursor: pointer;
}
.detail-box{
	display:flex;
	width:100%;
	height:100%;
	margin-bottom: 30px;
}
#detailInfo img{
	border-color:transparent;
	border-width:0.2px;
	border-radius: 20px;
}
.detail-box .infoArea{
	padding: 10px 10px;
	background-color: #2a475e;
	border-color:#2a475e;
	border-width:0.2px;
	border-radius: 20px;
}
.detail-box .boardInfo{
	width:100%;
	padding: 10px 10px;
	background-color: #2a475e;
	border-color:#2a475e;
	border-width:0.2px;
	border-radius: 20px;
}
.detail-box .infoArea .bi{
	color:#ffc100;
}
.detail-box .btn_group_detail{
	width:100%;
}
.info h1{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	flex-wrap: wrap;
	width:70%;
	color:#fff;
}
.titleArea{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	color:#fff;
	padding:20px 100px;
}
#recentlyViewedGames{
	display:none;
}
#recentlyViewedGames p{
	margin-bottom:10px;
}
body {
	width:100%;
	height:100%;
	display:flex;
	flex-wrap:wrap;
	background-color:#1b2838;
}
#wrap{
	padding:10px 20%;
	min-height: 100%;
}
.infoArea{
	margin-left:40px;
	color:#fff;
}
.commentArea{
	color:#fff;
	width: 100%;
	margin : auto;
}
.insertComment{
	display:flex;
	align-items:center;
}
.insertComment input, button{
	margin-left: 5px;
}
.comment_item{
	word-wrap:break-word;
	white-space:normal;
	width : 100%;
}

.comment_info, .reply_btn_area{
	display : inline;
}
.comment_info,.reply_info{
	width : 70%;
}

.comment_item pre{
	white-space:normal;
	display:flex;
	flex-wrap:wrap;
}


.comment_item pre .reply_btn_area{
	margin-left: auto;
	padding-left: 10px;
}

#CommentGroup li{
	list-style: none;
}
.update_comment, .update_comment_check, .reply_view_btn, .fold_replies_area, .delete_comment, .reply_add_btn, .comment_paging .btnPaging, .update_reply, .update_reply_check, .delete_reply{
	background-color:rgba(103, 112, 123, 0.2);
	border-color:rgba(103, 112, 123, 0.2);
	color:#e5e4dc;
	margin-right:5px;
	height:40px;
	margin-bottom: 5px;
}
.update_comment:hover, .update_comment_check:hover, .reply_view_btn:hover, .fold_replies_area:hover, .delete_comment:hover, .reply_add_btn:hover, .comment_paging .btnPaging:hover, .delete_reply:hover, .update_reply:hover, .update_reply_check:hover{
	color:black;
	background-color: #a0c5db;
	transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.commentArea input[type="text"]{
	width: 90%;
	height : 56px;
	margin: 10px 0 10px 0;
	border:none;
	background-color:#2a3f5a;
	color:#fff;
}
#detailInfo{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	color:#fff;
	flex-wrap:wrap;
}
.board-box{
	display:block;
	flex-wrap:wrap;
}
.boardTitle, .boardContent{
	background-color: #0d131b;
	color:#8c8b8a;
	white-space:normal;
	width:100%;
	word-wrap: break-word;
}
.boardTitle{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	justify-content: space-between;
}
.wrapper{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	flex-direction: column;
}
footer{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	flex-wrap:wrap;
	background-color:#171a21;
	width:100%;
	height:100px;
	justify-content: center;
	color:#969eab;
}
footer .hrArea{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	width:100%;
	justify-content: center;
}
.hrArea hr{
	color:#969eab;
	justify-content:center;
	width:60%;
}
footer .content{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	justify-content: center;
	align-items: center;
}
.content img{
	margin-right : 20px;
}
a{
color:inherit;
text-decoration:none;
}
.category{
	height:40px;
	width:100%;
	color:#fff;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
}
.category a{
	color:#fff;
}
.category a:hover{
display:inline-block;
font:bolder;
font-size:18px;
text-decoration:underline;
color:skyblue;
transform: translateY(-4px);
transition: 0.3s;
}
.gameInfo .bi {
	color:#ffc100;
}
.reviewInfo .bi{
	color:#ffc100;
}
.reviewInfo:hover .bi{
	color:black;
}
#thumbUp .bi{
	color:black;
}
#thumbDown .bi{
	color:black;
}
.dropdown-item:hover{
	cursor:pointer;
	background-color:#a0c5db;
	color:#000;
}
#container {
	display:flex;
	flex-wrap: wrap;
}
.formArea{
	display:flex;
	padding:10px 100px;
	width:100%;
	flex-wrap: wrap;
}
.formArea from{
	display:flex;
	flex-wrap: wrap;
	width:100%;
}
.justify-content-center{
	width:100%;
	display:flex;
}
.justify-content-center .btn{
	justify-content: center;
}
.formArea .info{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	width:800px;
	flex-wrap:wrap;
}
.formArea .caption{
	align-items: flex-start;
	width:25%;
}
.caption p {
	color:#fff;
	margin-bottom:28px;
}
.formArea .inputArea{
	align-items: flex-start;
	width:60%;
}
.form-control{
	height:40px;
	border:none;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	background-color:#2a3f5a;
	color:#fff;
}
.form-control:active{
	background-color:#a0c5db;
	color:black;
}
.inputArea input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0;
}
.inputArea input[type="text"]{
	width: 300px;
	margin-bottom: 1px;
	border:none;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	background-color:#2a3f5a;
	color:#fff;
}
.messageFormArea input{
	width:400px;
	margin-bottom: 1px;
	border:none;
	background-color:#2a3f5a;
	color:#fff;
}
.messageFormArea input:focus{
	background-color:#a0c5db;
	color:black;	
	border: none;
}
.inputArea input[type="number"]{
	width: 300px;
	margin-bottom: 1px;
	border:none;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	background-color:#2a3f5a;
	color:#fff;
}
.inputArea input[type="password"]{
	width: 300px;
	margin-bottom: 1px;
	border:none;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	background-color:#2a3f5a;
	color:#fff;
}
formArea input:focus{
	background-color:#a0c5db;
	color:black;	
	border: none;
}
.btnAdmin{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	justify-content:flex-end;
	margin:20px 100px;
	width:100%;
}
.btnOrderGroup{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	margin-left:100px;
	text-align:left;
	margin-bottom:10px;
}

.btnOrderGroup .btn-secondary, .today-viewed .close{
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
.btnOrderGroup input:hover, .today-viewed .close:hover{
	color: #fff;
	background-color: #6c757d;
	border-color: #6c757d;
}
.btn_group_detail{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
}
.btn_group_detail .btn{
	margin-bottom: 10px;
	margin-right: 5px;
}
.btn_group_detail .inline-form{
	display:inline-flex;
}
.today-viewed{
	background-color:#1b2838;
	position : fixed;
	display:block;
	margin-right:0px;
	padding: 3px 1px 1px 2px;
	overflow-y:scroll;
	top:0;
	bottom:0;
	right:0;
}
.today-viewed div{
	display:block;
}
.today-viewed .btn:hover{
	background-color: #a0c5db;
}
.dropdown-toggle{
	margin-right:4px;
}
#btnSearch{
	width:30px;
	color:#fff;
}
#keyword{
	width:300px;
	margin-right:4px;
}
.formSearch{
	width:50%;
	margin:auto;
	display:flex;
}
.formSearch .input-group{
	flex-wrap: nowrap;
	display:flex;
	align-items: stretch;
}
.formSearch .dropdown-toggle{
	background-color:#2a3f5a;
	border:none;
	color:white;
}
.formSearch .dropdown-toggle:active{
	background-color:#a0c5db;
	color:black;
}
.input-group b{
	color:#fff;
	font-size: 25px;
	background-color: #2a3f5a;
	height:40px;
}
.listArea{
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	flex-wrap: wrap;
	justify-content:center;
	width:100%;
}
.paging{
	width:100%;
	display:flex;
	text-overflow:ellipsis;overflow:hidden;white-space:nowrap;
	justify-content: center;
}
.show{
	background-color:#2a3f5a;
	border:none;
	color:white;
}
.dropdown-item{
	background-color:#2a3f5a;
	border:none;
	color:white;
}
.dropdown-item:focus{
	background-color:#2a3f5a;
	border:none;
	color:white;
}
.formSearch #keyword{
	background-color:#2a3f5a;
	border:none;
	color:white;
}
.formSearch #keyword:focus{
	background-color:#a0c5db;
	color:black;
}
.formSearch #btnSearch{
	background-color:#1b2838;
	border:none;
	color:#fff;
}
.gameInfos{
	margin:5px; 
	width:330px; 
	height:500px; 
	display:inline-block;
	background-color:#2a475e;
	color:#fff;
	border:none;
}
.gameInfos:hover{
	background-color:#a0c5db;
	color:black;
}

.page-item .page-link{
	background-color:#2a475e;
	color:white;
	border:none;
}
.active .page-link{
	background-color:#a0c5db;
	color:black;
	border:none;
}
.gameInfo .info{
	font-size: 1em;
}
.file-drop{
	width:300px; 
	height:300px; 
	border : 1px solid grey;
}
.profileImg {
	width : 100px;
	height : 100px;
	border : 1px solid grey;
}
.auth .btn {
	background-color:rgba(103, 112, 123, 0.2);
	border-color:rgba(103, 112, 123, 0.2);
	color:#e5e4dc;
	margin-right:5px;
	height:40px;
}
.auth .btn:hover{
	background-color: #666666;
	transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.btn-secondary {
	background-color:rgba(103, 112, 123, 0.2);
	border-color:rgba(103, 112, 123, 0.2);
	color:#e5e4dc;
	margin-right:5px;
	height:40px;
	margin-bottom: 5px;
}
.btn-light{
	background-color:rgba(103, 112, 123, 0.2);
	border-color:rgba(103, 112, 123, 0.2);
	color:#e5e4dc;
	margin-right:5px;
	height:40px;
	margin-bottom: 5px;
}
textarea{
	background-color: #2a3f5a;
	color:#fff;
	border: none;
}
.chatArea{
	background-color: #2a3f5a;
	width:800px;
	height:500px;
	margin-bottom:10px;
	overflow-y:auto; 
	display:block;
	color:white;
}
.chatArea::-webkit-scrollbar{
	width: 1px;
}
.chatArea .adminChat{
	text-align:center;
}
.chatArea .adminChat .nickname{
	color:#f38c22;
	font-weight:bolder;
}
.chatArea .myChat .message{
	word-break:break-all;
	margin:5px 20px;
	border:1px solid #fff;
	padding:5px 2px;
	border-radius:5px;
	background-color:#a0c5db;
	color:black;
}
.chatArea .yourChat .message{
	word-break:break-all;
	margin:5px 20px;
	border:1px solid #fff;
	padding:5px 2px;
	border-radius:5px;
	background-color:#2a475e;
	color:#fff;
	width:100%;
	text-align:right;
}
.chatArea .adminChat .message{
	word-break:break-all;
	margin:5px 20px;
	border:1px solid #fff;
	padding:5px 2px;
	border-radius:5px;
	background-color:#f38c22;
	color:#c70205;
	width:95%;
	text-align:center;
}
.chatArea .time{
	color:#1b2838;
}
.yourChat .nickname{
	width:100%;
	text-align:right;
}
.yourChat .chatInfo{
	display:flex;
	justify-content:flex-end;
	flex-wrap:wrap;
}
.chatArea .yourChat{
	width:100%;
	display:flex;
	justify-content:flex-end;
}
.chatArea .myChat{
	width:100%;
	display:flex;
	justify-content:flex-start;
}
textarea:focus{
	background-color: #a0c5db;
	color:black;
	border: none;
}
.btn:hover{
	color:black;
	background-color: #a0c5db;
	transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
#CommentGroup{
	margin: auto;
}
#myGameArea{
	display:block;
	width:1000px;	
	margin:auto;
}
#myGameArea a, #myGameArea span, #myGameArea div{
	margin:auto;
}
.wishListBody {
	width:1000px;
	display:absolute;
	margin:auto;	
}
#commentContent, .updateCommentContent,.replyContent,.updateReplyContent{
    min-height: 3rem;
    width : 90%;
    height:auto;
    max-height:148px;
    resize: none;
    }

.commentNickname, .replyNickname{
	font-weight: bold;
	font-size : 16px;
}
.replies_area li{
	display : flex;
	width : 100%;
}
.reply_add_btn{
	display : block;
	margin-top : auto;
	
}
.reply_item div{
	padding-right: 10%;
	margin-bottom: 10px;
}
#commentsArea{
	width : 1280px;
	margin : auto;
}

#myComments{
	width : 100%;
}
.comment_reply_item{
	width : 50%;
	display: flex;	
	justify-content: space-between;
	border-bottom: 0.5px dashed;
	
}
.commentAndReplyContent{
	width: 65%;
	word-wrap: break-word;
}
.commentsDate{
	width : 30%;
}

.replyProfileImg{
	margin-right: 10px;
}

.reply_write_area{
	display:flex;
	margin-bottom: 15px;
}
#myGameArea #games .game_item{
	text-align : center;
	margin: auto;
}

#myGameArea #games .game_item img{
	width : 30%;
}
#myGameArea #games .game_item a,#myGameArea #games .game_item div{
	width : 25%;
}
#myGameArea #games .game_item span{
	width : 20%;
}
.wish_list_area li{
	display : flex;
	justify-content: space-between;
	align-items: center;
	text-align: center;
	margin : auto;
}

.wish_list_area li input{
	width : 5%;
} 

.wish_list_area li .gameImg{
	width : 25%;
}
.wish_list_area li #gameName{
	width : 20%;
}
.wish_list_area li .genre{
	width : 20%;
}
.wish_list_area li .showPrice{
	width : 15%;
}
.wish_list_area li .buy_or_remove{
	width : 15%;
}


</style>