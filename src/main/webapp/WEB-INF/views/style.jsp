<!-- Bootstrap css -->
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
body {
background-color:grey;
padding:20px 80px;
}

a{
color:inherit;
text-decoration:none;
}
a:visited{
color:inherit;
text-decoration:none;
}
.category a:hover{
display:inline-block;
font:bolder;
font-size:18px;
text-decoration:underline;
color:skyblue;
transform: translateY(-2px);
transition: 1s;
}
.btn{
padding-bottom: 10px;
}
.bi {
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
	content-align:center;
	item-align:center;
	text-align:center;
}
.page-item .page-link{
	background-color:#e9ecef;
	color:black;
}
.active .page-link{
	background-color:#6c757d;
	border-color:#e9ecef; 
	color:white;
}
.btnOrderGroup{
	display:flex;
	margin-left:10px;
	text-align:left;
	margin-bottom:10px;
}
.btnOrderGroup input{
	margin-right:8px;
	color: #6c757d;
    border-color: #6c757d;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: var(--bs-body-color);
    background-color: white;
    border-width: var(--bs-border-width);
    border-color: transparent;
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
.btnOrderGroup input:hover{
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
.right{
	background-color:#6c757d;
	position : fixed;
	display:inline-block;
	float: right;
	margin-right:0px;
	padding: 3px 1px 1px 2px;
	overflow-y:scroll;
	top:0;
	bottom:0;
	right:0;
}
.right div{
	display:block;
}
.dropdown-toggle{
	margin-right:4px;
}
#btnSearch{
	width:120px;
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
#gameInfos{
	margin:5px; 
	width:330px; 
	height:500px; 
	display:inline-block;
}
.gameInfo .info{
	font-size: 1em;
}
.file-drop{
	width:300px; 
	height:300px; 
	border : 1px solid grey;
}
</style>