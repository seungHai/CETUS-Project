<%@include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type ="text/css">
   #a{
      text-align: center;
      margin: auto;
      padding-top: 20%;
      color: red;
   }
   /* aside{
      background-image: url(/resources/images/환영합니다.png);
      object-fit: cover;
   } */
</style>
<aside>

<script src="https://tistory4.daumcdn.net/tistory/3134841/skin/images/confetti_v2.js"></script>

<style>
   canvas{z-index:10;pointer-events: none;position: fixed;top: 0;transform: scale(1.1);}
</style>

<div class="buttonContainer">
   <button class="canvasBtn" id="stopButton" style="display: none;">Stop Confetti</button>
   <button class="canvasBtn" id="startButton" style="display: none;">Drop Confetti</button>    
</div>
<br><br><br><br><br><br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;
<img  src="../resources/images/환영합니다.png">
<br><br>
<h1 style="text-align: center; font-size: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cetus 회원가입을 환영합니다.</h1>
<br><br><br><br>
<canvas id="canvas"></canvas>
</aside>
<%@include file="../include/footer.jsp" %>