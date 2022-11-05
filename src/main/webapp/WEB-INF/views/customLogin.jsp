<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- <style type="text/css">
*{
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;
}
body {
  background-color: #2C496E;
}
form {
   position:absolute;
  width:300px;
  height:400px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  top:50%;
  left:50%;
  transform: translate(-50%,-50%);
  border-radius: 15px;
  
    /*** Adding in CSS3 ***/
  
    /*** Rounded Corners ***/
  
    /*** Background Gradient - 2 declarations one for Firefox and one for Webkit ***/
  
    /*** Shadow behind the box ***/
    
    }
h2{
  text-align: center;
  margin: 30px;
}
.idForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}
.passForm{
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}
.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.submit {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

input.submit:hover {
  background-position: right;
}
.bottomText {
  text-align: center;
}
</style> -->
<head>
<meta charset="UTF-8">
<script type="text/javascript">
history.go(-1);
</script>
<title>로그인</title>
<body width="100%" height="100%">
   <%-- <form role="form" action="/login" method="post">
      <h2>Cetus Login</h2>
      <div class="idForm">
            <input type="text" class="id" name="username" placeholder="ID" />
        </div>
        <div class="passForm">
           <input type="password" class="pw" name="password" placeholder="PW"/>
        </div>
            <input type="submit" value="login" name="submit" class="submit" />
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
      <div class="bottomText">
      		<div>
	           아이디 기억하기&nbsp;<input name="remember-me" type="checkbox">
	        </div>
            <a href="#">아이디 찾기 </a>
            /
            <a href="#">비밀번호 찾기</a>
      </div>
   </form> --%>
</body>
</html>