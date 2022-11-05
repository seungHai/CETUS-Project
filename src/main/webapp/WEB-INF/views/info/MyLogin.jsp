<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style type="text/css">
form {
    width: 250px;
    padding: 20px;
    border: 1px solid #1493fa;
}
form {
    width: 250px;
    padding: 20px;
    border: 1px solid #1493fa;
  
    /*** Adding in CSS3 ***/
  
    /*** Rounded Corners ***/
    -moz-border-radius: 20px;
    -webkit-border-radius: 20px;
  
    /*** Background Gradient - 2 declarations one for Firefox and one for Webkit ***/
    background:  -moz-linear-gradient(19% 75% 90deg,#eae6ec, #1493fa);
    background:-webkit-gradient(linear, 0% 0%, 0% 100%, from(#f3f2cd), to(#7bbfff));
  
    /*** Shadow behind the box ***/
    -moz-box-shadow:0px -5px 300px #270644;
    -webkit-box-shadow:0px -5px 300px #b5deff;
}
input {
    width: 230px;
    background: #8a33c6;
    padding: 6px;
    margin-bottom: 10px;
    border-top: 1px solid #ad64e0;
    border-left: 0px;
    border-right: 0px;
    border-bottom: 0px;
}
input {
    width: 230px;
    background: #ffffff;
    padding: 6px;
    margin-bottom: 10px;
    border-top: 1px solid #ffffff;
    border-left: 0px;
    border-right: 0px;
    border-bottom: 0px;
  
    /*** Adding CSS3 ***/
  
    /*** Transition Selectors - What properties to animate and how long ***/
    -webkit-transition-property: -webkit-box-shadow, background;
    -webkit-transition-duration: 0.25s;
  
    /*** Adding a small shadow ***/
    -moz-box-shadow: 0px 0px 2px #000;
    -webkit-box-shadow: 0px 0px 2px #000;
}
input:hover {
    -webkit-box-shadow: 0px 0px 4px #000;
    background: #d3eaf8;
}
input.submit {
    width: 100px;
    color: #fff;
    text-transform: uppercase;
    text-shadow: #000 1px 1px;
    border-top: 1px solid #f8f2a0;
    margin-top: 10px;
}
input.submit {
    width: 100px;
    color: #fff;
    text-transform: uppercase;
    text-shadow: #000 1px 1px;
    border-top: 1px solid #84a4fc;
    margin-top: 10px;
  
    /*** Adding CSS3 Gradients ***/
    background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#dbf0f8), to(#2596ff));
    background:  -moz-linear-gradient(19% 75% 90deg,#203de0, #ffffff);
}



</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<body>
<div align="center" style="margin-top: 10%">
<form action="login.jsp" method="post">
        <label>아이디</label>
            <input type="text" name="username" />
        <label>비밀번호</label>
            <input type="password" name="password"  />
            <input type="submit" value="로그인" name="submit" class="submit" />
</form>
            <a href="#">아이디 찾기 </a>
            /
            <a href="#">비밀번호 찾기</a>
            </div>
</div>
</body>
</html>