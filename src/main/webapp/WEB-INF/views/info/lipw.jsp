<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
	
		$(function(){
			var principal = null;
			// 권한이 있는지 먼저 물어본다.
			<sec:authorize access="isAuthenticated()">
			principal = '<sec:authentication property="principal.username"/>'; //인증 안되었을때 그냥쓰면 에러남
			</sec:authorize>
			
			opener.parent.location='/info/myUpdate'; 
			window.close();
			
		});
	</script>
</body>
</html>