<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	location.href="/board/list?amount=10&pageNum=1";
});
</script>
</head>
<body>
	<h1>Logout Page</h1>
	<!-- 버튼 눌러서 로그아웃 시킬거라 form태그 추가 -->
	<form action="/customLogout" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="submit" value="전송">
	</form>
</body>
</html>