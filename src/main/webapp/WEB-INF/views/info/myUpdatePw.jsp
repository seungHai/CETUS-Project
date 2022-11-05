<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="wrap">
	
	<div class="title">◎ 비밀번호 확인</div>
	<hr>
	<div class="con1">회원정보 보호를 위해 비밀번호를 입력해 주세요.</div>
	<hr>
	<form onsubmit="return false">
	<div class="con2">
		비밀번호
		&nbsp;<input type="password" name="pw" class="pw" placeholder="비밀번호를 입력해주세요">
	</div>
	<hr>
	<div class="cmd">
		<input type="button" class="btn btn1" value="확인" onclick="pwCheck(this.form);">
		&nbsp;&nbsp;
		<button type="button" class="btn btn2" onclick="location.href='/board/li'">취소</button>
	</div>
	
	</form>
</div>
	
</body>
<script type="text/javascript">

	var userPw = '${user.pw}';
	
	function pwCheck(f) {

		if(f.pw.value == ""){
			alert("비밀번호를 입력하세요.");
			return;
		}else if(f.pw.value != userPw){
			alert("비밀번호가 다릅니다.");
			return;
		}
		f.action="/info/lipw";
		f.submit();
	}
	
</script>

<style type="text/css">

.wrap{
	font-family: "paybooc-Light", sans-serif;
}
.title{
    min-height: 40px;
    color: #fff;
    background-color: #1B3274;
    padding: 10px 15px;
    box-sizing: border-box;
    font-weight: bold;
    margin-top: 15px;
    font-size: 19px;
}
.con1{
	text-align:center;
	font-size: 15px;
	margin: 20px;
}
.con2{
	margin: 14px;
	text-align:center;
	font-size: 15px;
}
.pw{
	width: 350px;
	height: 27px;
}
.cmd{
	margin: 18px;
	text-align: center;
}
.btn{
	position: relative;
    border: none;
    display: inline-block;
    padding: 11px 29px;
    border-radius: 5px;
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
}
.btn1:hover{
	cursor: pointer;
}
.btn2:hover{
	cursor: pointer;
}
.btn1{
	background-color: #1B3274;
	color: #fff;
}
.btn2{
	background-color: #1B3274;
    color: #fff;
}

</style>
</html>