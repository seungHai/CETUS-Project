<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>  

   <aside>
   <div> 
   	<div class="head">
			<div class="head_inner">
				<div><a href="/board/list?amount=10&pageNum=1"><img src="../resources/images/home.png" style="width: 18px"></a><span style="font-size: 17px;">   > 나의 정보   >   회원 정보 수정</span></div>
			</div>
		<br>
	</div>  
      <!-- <h3 style="margin-bottom: 1%">◎ 내 정보 관리</h3> -->
      <div align="center">
         <table class="tab_face">
            <tr id="tabs">
              <td width="50%"><a href="/info/myInfo?id=${id }" style="color: #1B3274; font-weight: bold;" title="tab1" id="tab1">내 정보</a></td>
                <td><a href="/info/myUpdatePw?id=${id }" style="color: #1B3274; font-weight: bold;" onclick="window.open(this.href, '_password', 'width=500, height=260'); return false;" title="tab2" id="tab2">내 정보 수정</a></td>
            </tr>
         </table>
      </div>
      
      <div class="text_contents">
         <ul class="text_contents_title">
               <li class="text_pw">Cetus는 회원정보 보호를 위해 사이트 이용에 필요한 최소정보만 입력받고 있습니다.</li>
         </ul>
      </div>
      
      <form action="/info/myUpdateEmail" method="post">
      <div>
         <table class="custom-table">
               <tr>
                  <th scope="row" width="30%">아이디</th>
                  <td style="text-align: left;">${user.id }</td>
               </tr>
               <tr>
                  <th scope="row">이메일</th>
                  <td style="text-align: left;">
                  <input type="email" name="email" id="editEmail" autocomplete="useremail" required oninput ="Email()">
                  <!-- <span class="test_email" id="editEmailNotice">이메일을 다시 입력해주세요.</span>
                  <span class="email_li">필수 항목 입니다.</span> -->
                  <span class="email_ok">사용가능한 이메일입니다.</span>
                  <span class="email_already">중복된 이메일 입니다.</span>
                  <span class="email_ll">이메일 형식이 아닙니다 </span>
                  <br>
                  
                  <span class="emailForgot">* 회원정보 분실 시 이메일로 안내해 드립니다.(미완성)</span>
                  </td>
               </tr>
         </table>
      </div>
      <div class="ac">
         <input type="submit" class="btn" value="이메일 수정" onclick="myUpdateGoEmail(this.form);">
      </div>
      <input type="hidden" name="id" value="${user.id }">

      </form>
      
      <div class="text_contents">
         <ul class="text_contents_title">
            <li class="text_pw">비밀번호는 도용방지를 위해 자주 바꾸어 주는것이 좋습니다.</li>
            <li class="text_pw">전화번호, 주민등록번호, 연속된 숫자, 반복 숫자 등 타인이 알아내기 쉬운 비밀번호는 사용을 피하시기 바랍니다.</li>
            <li class="text_pw">영문+숫자 조합 8~16자</li>
         </ul>
      </div>
      
      <form action="/info/myUpdatePass" method="post">
      <div>
         <table class="custom-table">
               <tr>
                  <th scope="row" width="30%">현재 비밀번호</th>
                  <td style="text-align: left;">
                  <input type="password" id="oldPw" onkeyup="oldPass();">
                  
                  <span class="test_pw" id="oldPwNotice">현재 사용 중인 비밀번호를 입력해 주세요.</span>
                  </td>
               </tr>
               <tr>
                  <th scope="row">새 비밀번호</th>
                  <td style="text-align: left;">
                  <input type="password" name="pw" id="newPw" onkeyup="newPass();" maxlength="16">
                  
                  <span class="test_pw" id="newPwNotice">영문+숫자 조합 8~16자로 입력해주세요.</span>
                  </td>
               </tr>
               <tr>
                  <th scope="row">비밀번호 재입력</th>
                  <td style="text-align: left;">
                  <input type="password" name="rpw" id="rnewPw" onkeyup="rnewPass();" maxlength="16">
                  
                  <span class="test_pw" id="rnewPwNotice">비밀번호를 한번 더 입력해주세요.</span>
                  </td>
               </tr>
         </table>
      </div>
      <div class="ac">
         <input type="button" class="btn" value="비밀번호 수정" onclick="myUpdateGoPass(this.form);">
      </div>
      <input type="hidden" name="id" value="${user.id }">
      </form>   
      
    </div>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

//비밀번호 정규식
var regPw = /^[0-9a-zA-Z]{8,16}$/;
// 이메일 정규식
//var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

   var oldPwNotice = $("#oldPwNotice");
   var newPwNotice = $("#newPwNotice");
   var rnewPwNotice = $("#rnewPwNotice");
   var userPw = '${user.pw}';
   var userEmail = '${user.email}';
//   var editEmailNotice =$("#editEmailNotice");
   
   var principal = null;
   // 권한이 있는지 먼저 물어본다.
   <sec:authorize access="isAuthenticated()">
   principal = '<sec:authentication property="principal.username"/>'; //인증 안되었을때 그냥쓰면 에러남
   </sec:authorize>
   
   $("#tab1").on("click", function(e){
      e.preventDefault();
      if(principal == null){
         alert("로그인 후 이용가능합니다.");
      }else{
         location.href = '/info/myInfo?id=' + principal;
      }
   });
   
   $("#tab2").on("click", function(e){
      e.preventDefault();
      if(principal == null){
         alert("로그인 후 이용가능합니다.");
      }else{
         location.href = '/info/myUpdate?id=' + principal;
      }
   });

   $(function(){
      oldPwNotice.attr("hidden","hidden");
      newPwNotice.attr("hidden","hidden");
      rnewPwNotice.attr("hidden","hidden");
//      editEmailNotice.attr("hidden","hidden");
   });
   
   // 현재 비밀번호 확인
   function oldPass() {
      if($("#oldPw").val().length > 0){
         oldPwNotice.removeAttr("hidden","hidden");
      }else{
         oldPwNotice.attr("hidden","hidden");
      }
      if($("#oldPw").val() == userPw){
         oldPwNotice.html("비밀번호가 일치합니다.");
      }else{
         oldPwNotice.html("현재 사용 중인 비밀번호를 입력해 주세요.");
      }    
   }
   // 새로운 비밀번호 확인
   function newPass() {
      if($("#newPw").val().length > 0){
         newPwNotice.removeAttr("hidden","hidden");
      }
      if($("#newPw").val() == userPw){
         newPwNotice.html("기존 비밀번호로 변경할 수 없습니다.");
      }else{
         if($("#newPw").val().length == 0){
            newPwNotice.attr("hidden","hidden");
         }else if($("#newPw").val().length > 7){
            if(!regPw.exec($("#newPw").val())){
               newPwNotice.html("영문+숫자 조합 8~16자로 입력해주세요.");
            }
            newPwNotice.html("사용가능한 비밀번호입니다.");
         }else{
            newPwNotice.html("영문+숫자 조합 8~16자로 입력해주세요.");
         }
      }
   }
   // 새로운 비밀번호 재확인
   function rnewPass() {
      if($("#rnewPw").val().length > 0){
         rnewPwNotice.removeAttr("hidden","hidden");
      }else{
         rnewPwNotice.attr("hidden","hidden");
      }
      if($("#rnewPw").val() == $("#newPw").val()){
         rnewPwNotice.html("비밀번호가 일치합니다.");
      }else{
         rnewPwNotice.html("비밀번호가 일치하지 않습니다.");
      }
   }
   
   
   function myUpdatePass(f) {
      if(oldPwNotice.html() != "비밀번호가 일치합니다."){
         alert("현재 비밀번호와 일치하지 않습니다.");
         oldPwNotice.attr("hidden","hidden");
         newPwNotice.attr("hidden","hidden");
         rnewPwNotice.attr("hidden","hidden");
//         editEmailNotice.attr("hidden","hidden");
         f.reset();
         return;
      }
      if(newPwNotice.html() != "사용가능한 비밀번호입니다."){
         alert("사용할 수 없는 비밀번호입니다.");
         oldPwNotice.attr("hidden","hidden");
         newPwNotice.attr("hidden","hidden");
         rnewPwNotice.attr("hidden","hidden");
//         editEmailNotice.attr("hidden","hidden");
         f.reset();
         return;
      }
      if(rnewPwNotice.html() != "비밀번호가 일치합니다."){
         alert("비밀번호가 일치하지 않습니다.");
         oldPwNotice.attr("hidden","hidden");
         newPwNotice.attr("hidden","hidden");
         rnewPwNotice.attr("hidden","hidden");
//         editEmailNotice.attr("hidden","hidden");
         f.reset();
         return;
      }
      
      f.submit();
   }
   
    function myUpdateGoPass(f) {
      if($("#oldPw").val() == "" || $("#newPw").val() == "" || $("#rnewPw").val() == ""){
         alert("입력란을 모두 작성하세요.");
         oldPwNotice.attr("hidden","hidden");
         newPwNotice.attr("hidden","hidden");
         rnewPwNotice.attr("hidden","hidden");
         
         f.reset();
         return;
      }
       if( !regPw.exec(f.newPw.value)){
          alert("영문+숫자 조합 8~16자로 입력해주세요.");
          return;
       }
      f.submit();
   }
   
   // 이메일 확인
   function Email() {
      var emailVal = $("#editEmail").val();
      var emailin = emailVal.indexOf("@");
      // 이메일 확인
//      if(emailVal.length > 0){
//         editEmailNotice.removeAttr("hidden","hidden");
//      }
      
//      if(emailVal.length == 0){
//         editEmailNotice.attr("hidden","hidden");
//      }else{
//         if(!regEmail.exec(emailVal)){
//            editEmailNotice.html("이메일의 올바른 형식이 아닙니다.");
//         }else{
//            editEmailNotice.html("사용가능한 이메일입니다.");
//         }
//      }
      
      // 이메일 중복 체크 함수
      $.ajax({
            url:'/info/emailCheck',
            type:'post',
            data:{email:emailVal},
            datatype: 'email',
            success:function(tt){ 
                  /* $('.email_li').css("display","none");  */
               if(emailin <1 || emailin == emailVal.length-1 || emailin == -1){
                   $('.email_ll').css("display", "inline-block");
                   $('.email_already').css("display","none");
                     $('.email_ok').css("display", "none");
                     return;
               }else{
                   if(tt != 1){ 
                        $('.email_ok').css("display","inline-block"); 
                        $('.email_already').css("display", "none");
                        $('.email_ll').css("display", "none");
                    } else {
                        $('.email_already').css("display","inline-block");
                        $('.email_ok').css("display", "none");
                        $('.email_ll').css("display", "none");
                    } 
               }
            },
            error:function(){
                alert("에러입니다");
            }
        });
      
   }
   
   function myUpdateEmail(f) {
      if(editEmailNotice.html() != "사용가능한 이메일입니다."){
         alert("이메일의 올바른 형식이 아닙니다.");
         oldPwNotice.attr("hidden","hidden");
         newPwNotice.attr("hidden","hidden");
         rnewPwNotice.attr("hidden","hidden");
         editEmailNotice.attr("hidden","hidden");
         f.reset();
         return;
      }
      
      f.submit();
   }
   
   </script>
    
    </aside>
   
<style type="text/css">


aside{
    font-size: 12px;
    line-height: 14px;
    color: black;
    font-weight: normal;
    letter-spacing: 0px;
    font-style: normal;
    text-decoration: none;
    }
    
/*  h3 {
    float: left;
    color: #000080;
    display: block;
    font-size: 17px;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
    padding-bottom: 10px;
 } */
 
 .head_inner {
 	margin-top: 10px;
 }
 .head_p {
 	font-size: 16px;
 	font-weight: bold;
 }
 
.ac{
   text-align: center;
   padding-top: 13px;
}

.btn{
   position: relative;
    border: none;
    display: inline-block;
    padding: 7px 30px;
    border-radius: 5px;
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
    background-color: #1B3274;
   color: #fff;
   height: 30px;
   font-size: 12px;
   width: 136px;
}

.btn:hover{
   cursor: pointer;
}

    
/* body, p, h1, h2, h3, h4, h5, h6, ul, ol, li, dl, dt, dd, table, th, td, form, fieldset, legend, input {
    margin: 0;
    padding: 0;
} */ 

/*    .email_li{color : red; font-size: 0.8em; font-weight: bold; display: inline-block;}
 */ 
    .email_ok{color:blue; font-size: 0.8em; font-weight: bold; display: none;}
   .email_already{color: red; font-size: 0.8em; font-weight: bold; display: none;}
   .email_ll{color : red; font-size: 0.8em; font-weight: bold; display: none;}
   
   
li, ul, ol {
    list-style: none;
}   

input[type="text"] {
    ime-mode: active;
}
input {
    -webkit-border-radius: 0px;
    -webkit-apprearance: none;
    outline: none;
    border: 1px solid #ccc;
    height: 18px;
    line-height: 18px;
}

input, select, button {
    vertical-align: middle;
}

select {
    height: 20px;
    border: 1px solid #999;
}

.emailForgot {
   margin-top: 7px !important;
   display: inline-block !important;
}
    
.tab_face {
   width: 100%;
   height: 32px;
   margin-top: 10px;
}

.text_contents {
   padding-top: 10px !important;
}

.text_contents td {
   padding: 7px 0 7px 10px;
    border-top: 1px solid #dcdcdc;
    color: #4c4c4c;
    line-height: 16px;
    vertical-align: middle;
}

.text_contents_title li {
    margin-top: 10px;
    line-height: 18px;
}

.text_contents_title li.text_pw, .text_email {
   margin-top: 0;
    margin-left: 8px;
}

.text {
   color: #395ec4 !important;
}

strong {
    font-weight: bold;
}

table {
   border-collapse: collapse;
   border-spacing: 0;
   display: table;
   box-sizing: border-box;
    text-indent: initial;
    border-color: grey;
}

tr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
}

.tab_face td.on {
    border: 1px solid #7d99d0;
    background: #82a3e6;
    color: #000;
    font-weight: bold;
}

.tab_face td {
    padding: 6px 7px 5px 5px;
    border: 1px solid #fff;
    text-align: center;
    background-color: #ebeffc;
}

.custom-table {
   table-layout: fixed;
    width: 100%;
    margin-top: 10px;
    border-top: 2px solid #bbc6ef;
    border-bottom: 1px solid #dcdcdc;
    font-size: 12px;
}

.custom-table th {
   padding: 8px 0 6px 0px;
    border-top: 1px solid #dcdcdc;
    border-bottom: 1px solid #dcdcdc;
    background-color: #ebeffc;
    color: #1B3274;
    font-size: 12px;
    text-align: center;
    vertical-align: middle;
}

.custom-table td {
   padding: 7px 0 7px 10px;
    border-top: 1px solid #dcdcdc;
    color: #4c4c4c;
    line-height: 16px;
    vertical-align: middle;
}

.custom-table tr:nth-child(odd) {
    background-color: #f7f7f7;
}


/* 
   #tabs{
  overflow: hidden;
  width: 100%;
  margin: 0;
  padding: 0;
  list-style: none;
}
 
#tabs li{
  float: left;
  margin: 0 .5em 0 0;
}
 
#tabs a{
  position: relative;
  background: #ddd;
  background-image: linear-gradient(to bottom, #fff, #ddd);
  padding: .7em 3.5em;
  float: left;
  text-decoration: none;
  color: #444;
  text-shadow: 0 1px 0 rgba(255,255,255,.8);
  border-radius: 5px 0 0 0;
  box-shadow: 0 2px 2px rgba(0,0,0,.4);
}
 
#tabs a:hover,
#tabs a:hover::after,
#tabs a:focus,
#tabs a:focus::after{
  background: #fff;
}
 
#tabs a:focus{
  outline: 0;
}
 
#tabs a::after{
  content:'';
  position:absolute;
  z-index: 1;
  top: 0;
  right: -.5em;
  bottom: 0;
  width: 1em;
  background: #ddd;
  background-image: linear-gradient(to bottom, #fff, #ddd);
  box-shadow: 2px 2px 2px rgba(0,0,0,.4);
  transform: skew(10deg);
  border-radius: 0 5px 0 0;
}
 
#tabs #current a,
#tabs #current a::after{
  background: #fff;
  z-index: 3;
} */

#logout{
	visibility: collapse;
}

</style>
<%@include file="../include/footer.jsp" %>