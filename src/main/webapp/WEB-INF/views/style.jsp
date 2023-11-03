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
	flex-wrap: wrap;
	}
#friendsOwnGame ul {
	height:90%;
	display:flex;
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
	margin-right: 50px; 
}
.detail-box{
	display:flex;
	width:100%;
	height:100%;
	margin-bottom: 30px;
}
.detail-box img{
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
.detail-box .infoArea .bi{
	color:#ffc100;
}
.info h1{
	display:flex;
	flex-wrap: wrap;
	width:70%;
	color:#fff;
}
.titleArea{
	display:flex;
	color:#fff;
	padding:20px 100px;
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
}
#detailInfo{
	display:flex;
	color:#fff;
}
.wrapper{
	display:flex;
	flex-direction: column;
}
footer{
	display:flex;
	flex-wrap:wrap;
	background-color:#171a21;
	width:100%;
	height:100px;
	justify-content: center;
	color:#969eab;
}
footer .hrArea{
	display:flex;
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
#thumbUp .bi{
	color:black;
}
#thumbDown .bi{
	color:black;
}
.dropdown-item:hover{
	cursor:pointer;
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
	border:none;
	display:flex;
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
.inputArea input{
	margin-bottom: 1px;
	border:none;
	display:flex;
	background-color:#2a3f5a;
	color:#fff;
}
.inputArea input:focus{
	background-color:#a0c5db;
	color:black;	
}

.btnAdmin{
	display:flex;
	justify-content:flex-end;
	margin:20px 100px;
	width:100%;
}
.btnOrderGroup{
	display:flex;
	margin-left:100px;
	text-align:left;
	margin-bottom:10px;
}

.btnOrderGroup input, .today-viewed .close{
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
.formSearch .dropdown-toggle{
	background-color:#2a3f5a;
	border:none;
	color:white;
}
.formSearch .dropdown-toggle:active{
	background-color:#a0c5db;
	color:black;
}
.listArea{
	display:flex;
	flex-wrap: wrap;
	justify-content:center;
	width:100%;
}
.paging{
	width:100%;
	display:flex;
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
#gameInfos{
	margin:5px; 
	width:330px; 
	height:500px; 
	display:inline-block;
	background-color:#2a475e;
	border:none;
}
#gameInfos:hover{
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
.btn {
	background-color:rgba(103, 112, 123, 0.2);
	border-color:rgba(103, 112, 123, 0.2);
	color:#e5e4dc;
	margin-right:5px;
	height:40px;
}
.btn:hover{
	background-color: #666666;
	transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
</style>