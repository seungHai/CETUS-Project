<%@include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript" >
   // 아이디 정규식      
   var regId = /^[0-9a-z]{8,16}$/;       
   // 비밀번호 정규식
   var regPw = /^[0-9a-zA-Z]{8,16}$/;
   // 이메일 정규식
   var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

   var hi =0;
   var be =0;
   
function send(f){
   // 아이디 체크
   if( !regId.exec(f.id.value)){
      alert("아이디를 입력 하세요.");
      f.id.value = '';
      f.id.focus();
      return;
   }
   
   // 비밀번호 체크
   if( !regPw.exec(f.pw.value)){
      alert("비밀번호를 입력 하세요 ");
      f.pw.value = '';
      f.pw.focus();
      return;
   }
   // 비밀번호 확인
   if ( f.pw.value != f.rpw.value){
      alert("비밀번호 확인 해주세요");
      f.rpw.value = '';
      f.rpw.focus();
      return;
   }
   // 이메일 체크
   var email = f.email.value.indexOf("@");
   if(email <1 || email == f.email.value.length-1 || email == -1){
      alert("이메일의 올바른 형식이 아닙니다.");
      return;
   }
   if(hi == 0 ){
      alert("중복된 아이디 입니다");
      return;
   }
   if(be == 0){
      alert("중복된 이메일 입니다");
      return;
   }
   // 14세 이상 동의 체크
   var age_length = $('input:checkbox[name="age"]:checked').length; // 체크된 박스 길이 구하기
   if(age_length == 0){
      alert("14세 이상 회원이 아닙니다.");
      return;
   }
   // 가입 경로 체크
   if(f.root.value==""){
      alert("가입 경로를 체크해주세요.");
      return;
   }
   // 회원가입 약관 동의 유무
   var agree1_length = $('input:checkbox[name="agree1"]:checked').length;
   var agree2_length = $('input:checkbox[name="agree2"]:checked').length;
   if(agree1_length == 0 || agree2_length == 0){
      alert("약관에 동의하셔야합니다.");
      return;
   }
   
   f.action= "/info/membersec"
   f.submit();
   
}

function onkeypw(f){
   
   if(regPw.exec(f.pw.value)){
      document.getElementById("label_pw").innerHTML = "정상 패스워드 입니다.";
      document.getElementById("label_pw").setAttribute("class","b");
   }else{
      document.getElementById("label_pw").innerHTML = "영문+숫자 조합 8~16자로 작성 하십시오";
      document.getElementById("label_pw").setAttribute("class","a");
   }
}

function onkeycpw(f){
   
   if(f.pw.value == f.rpw.value){
      document.getElementById("label_cpw").innerHTML = "패스워드 일치 ";
      document.getElementById("label_cpw").setAttribute("class","b");
   }else{
      document.getElementById("label_cpw").innerHTML = "패스워드 재 확인 ";
      document.getElementById("label_cpw").setAttribute("class","a");
   }
}
function onkeyemail(f){
   
   var list = '${list}';
   var check_email = 'email=' + f.email.value;
   var result_email = list.indexOf(check_email);
   
   if(result_email > 0){
      document.getElementById("label_email").innerHTML = "중복된 이메일 입니다.";
      document.getElementById("label_email").setAttribute("class","a");
      return;
   }else{
      
      if(regEmail.exec(f.email.value)){
         document.getElementById("label_email").innerHTML = "환영합니다.";
         document.getElementById("label_email").setAttribute("class","b");
      }else{
         document.getElementById("label_email").innerHTML = "옳바른 이메일 형식이 아닙니다.";
         document.getElementById("label_email").setAttribute("class","a");
      }
   }
}
   // 아이디 중복 확인 함수
     function checkId(){
            var idVal = $('#id').val();
        $.ajax({
            url:'/info/idCheck',
            type:'post',
            data:{id:idVal},
            datatype: 'text',
            success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다
                  $('.id_li').css("display","none"); 
               if(regPw.exec(idVal)){
                   if(cnt != 1){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
                        $('.id_ok').css("display","inline-block"); 
                        $('.id_already').css("display", "none");
                        $('.id_ll').css("display", "none");
                        hi = 1;
                    } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
                        $('.id_already').css("display","inline-block");
                        $('.id_ok').css("display", "none");
                        $('.id_ll').css("display", "none");
                        hi=0;
                    } 
               }else{
                   $('.id_ll').css("display", "inline-block");
                   $('.id_already').css("display","none");
                     $('.id_ok').css("display", "none");
                     return;
               }
            },
            error:function(){
                alert("에러입니다");
            }
        });
        };
        
        // 이메일 중복 체크 함수
        function checkemail(){
               var emailVal = $('#email').val();
               var emailin = emailVal.indexOf("@");
               
           $.ajax({
               url:'/info/emailCheck',
               type:'post',
               data:{email:emailVal},
               datatype: 'email',
               success:function(tt){ 
                     $('.email_li').css("display","none"); 
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
                           be = 1;
                       } else {
                           $('.email_already').css("display","inline-block");
                           $('.email_ok').css("display", "none");
                           $('.email_ll').css("display", "none");
                           be = 0;
                       } 
                  }
               },
               error:function(){
                   alert("에러입니다");
               }
           });
           };
</script>
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
   .head {
   float: left;
    color: #000;
    display: block;
    font-size: 17px;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
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
    margin-top: 0px;
    margin-left: 8px;
    line-height: 18px;
}

.text_contents_title li.text_pw, .text_email {
   margin-top: 40px;
   font-size: 12px;
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


   .a{
      color : red;
      font-size: 0.8em;
      font-weight: bold;
   }
   .b{
      color:blue;
      font-size: 0.8em;
      font-weight: bold;
   }
   .id_li{color : red; font-size: 0.8em; font-weight: bold; display: inline-block;}
   .id_ok{color:blue; font-size: 0.8em; font-weight: bold; display: none;}
   .id_already{color: red; font-size: 0.8em; font-weight: bold; display: none;}
   .id_ll{color : red; font-size: 0.8em; font-weight: bold; display: none;}
   
   .email_li{color : red; font-size: 0.8em; font-weight: bold; display: inline-block;}
   .email_ok{color:blue; font-size: 0.8em; font-weight: bold; display: none;}
   .email_already{color: red; font-size: 0.8em; font-weight: bold; display: none;}
   .email_ll{color : red; font-size: 0.8em; font-weight: bold; display: none;}
</style>
<aside>
<div>
<form method = "post" id="thisForm" name = "myform">
     <h3 class="head">◎ 무료 회원 가입</h3>
     <div class="text_contents">
         <ul class="text_contents_title">
               <li class="text_pw">Cetus는 회원님의 소중한 회원정보 보호를 위하여 Cetus 이용에 필요한 최소정보만 입력 받습니다.</li>
         </ul>
      </div>
   <!-- <div style="text-align: center; color : #FE2EF7">Cetus는 회원님의 소중한 회원정보 보호를 위하여 Cetus 이용에 필요한 최소정보만 입력 받습니다.</div> -->
   <br>
     <hr class="hr1">
     <br>   
     <br>   
   <table id="table1">
   <tr>
      <td id="memu" colspan="2">아이디</td>
      <td>&nbsp;
      <input type="text" id = "id" name="id" autocomplete="username" required oninput = "checkId()" />
      <span class="id_li">필수 항목 입니다.</span>
      <span class="id_ok">사용 가능한 아이디입니다.</span>
   <span class="id_already">중복된 아이디 입니다.</span>
   <span class="id_ll">아이디 : 8~16자(소문자/숫자) </span>
       
      <!-- <input type = "text" name = "id"  onkeyup="onkeyid(this.form);"> -->
      <!-- <label class = "a" id = "label_id">필수 항목 입니다.</label> -->
      </td>
   </tr>
   <tr>
      <td id="memu" colspan="2">비밀번호</td>
      <td>&nbsp;&nbsp;<input type = "password" name = "pw"  onkeyup ="onkeypw(this.form);">
      <label class = "a" id = "label_pw">필수 항목 입니다.</label></td>
   </tr>
   <tr>
      <td id="memu" colspan="2">비밀번호 확인</td>
      <td>&nbsp;&nbsp;<input type = "password" name = "rpw"  onkeyup ="onkeycpw(this.form)">
      <label class = "a" id = "label_cpw">한번 더 입력해주세요.</label></td>
   </tr>
   <tr>
      <td id="memu" colspan="2">이메일</td>
      <td>
      &nbsp;&nbsp;<input type="email" id = "email" name="email" autocomplete="useremail" required oninput = "checkemail()" />
      <span class="email_li">필수 항목 입니다.</span>
      <span class="email_ok">사용 가능한 이메일입니다.</span>
   <span class="email_already">중복된 이메일 입니다.</span>
   <span class="email_ll">이메일 형식이 아닙니다 </span>
      
      </td>
   </tr>
   <tr>
      <td id="memu" colspan="2">가입경로</td>
      <td>
          
         <input type="radio" name="root" value="지인소개">지인소개
         <input type="radio" name="root" value="블로그">블로그
         <input type="radio" name="root" value="SNS">SNS
         <input type="radio" name="root" value="검색">검색
         <input type="radio" name="root" value="무료이용권">무료이용권
      </td>
   </tr>
   
   </table>
   <br>
      <div style="text-align: center" >
      <input type="checkbox" name="age">만 14세이상입니다.<label style="color : red; font-weight : bold"> (필수)</label></div><br>
      
      <br>
      <div style="text-align: center">회원 가입을 원하시면 아래의 서비스 약관을 반드시 읽고 <label style="color : red; font-weight : bold">동의 버튼(필수)</label>을 선택해주세요.</div><br>
      <table>
      <tr >
         <td>
         <textarea rows="7" cols="49" style="resize: none;"readonly="readonly">
&lt;Cetus 이용약관&gt;
제 1 조 [목적]
Cetus 이용약관은 ㈜cetus(이하 회사라 칭합니다)가 제공하는 인터넷서비스인 'www.cetus.com'(이하 총칭하여 서비스라 칭합니다)의 이용조건 및 절차, 서비스 이용에 필요한 제반사항에 대하여 규정함을 목적으로 합니다.
제 2 조 [약관의 효력과 변경]
본 약관은 서비스 화면의 게시를 통하여 공지함으로써 효력이 발생됩니다.
일부 약관 내용은 수정 혹은 변경될 수 있으며, 공지사항을 통해 그 내용을 알립니다.
회원은 변경된 약관에 동의하지 않을 경우 자유로운 권리로 회원탈퇴를 요청할 수 있으며 변경된 약관의 효력발생일 이후 7일 이내에 해지요청을 하지 않을 경우 변경사항에 동의하는 것으로 간주됩니다.
제 3 조 [약관외 준칙]
이 약관에 명시되지 않은 사항에 대하여는 회사의 공지나 관계법령에서 정한 바에 따릅니다.
제 4 조 [회원가입]
회원으로 가입하여 본 서비스의 이용을 희망하는 자가 본 서비스의 [회원가입]메뉴를 통하여 소정양식에 따라 요청하는 개인 인적사항을 제공하여 이용신청을 합니다.
회원 가입시 필요한 소정의 양식은 다음과 같습니다.
① 아이디
② 비밀번호
③ 이메일(자유선택-공지, 비밀번호 찾기등에 필요합니다)
회사는 서비스를 위하여 필요한 최소한의 정보(아이디, 비밀번호)외에 불필요한 회원정보를 요청하지 않습니다.
회사는 본 서비스의 이용을 위한 회원가입에 대하여 기술, 업무수행상의 지장이 있을 경우를 제외하고는 지체없이 이용신청을 승낙합니다.
회원가입은 만 14세 이상부터 할 수 있습니다.
성인컨텐츠의 경우 별도의 성인인증 후에 사용할 수 있습니다.
제 5 조 [회원아이디 관리]
회원아이디 및 비밀번호에 대한 관리책임은 이용자에게 있습니다.
회원아이디는 다음의 경우에 한하여 이용자의 요청 또는 회사의 판단에 의하여 변경 및 회원탈퇴할 수 있습니다.
① 아이디가 회원의 전화번호나 주민등록번호등으로 되어 있어서 사생활 및 정보침해의 우려가 있는 경우
② 타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우
③ 상식적이고 합리적인 사유가 있는 경우
④ Cetus 운영자, 직원 또는 관계자로 오인할 수 있는 경우
제 6 조 [ 서비스의 이용]
본 서비스는 회사의 업무, 기술상의 장애등 특별한 사유가 없는 한 연중무휴 1일 24시간 제공을 원칙으로 합니다.
회사는 서비스의 일부 또는 전부에 대한 이용을 제한할 수 있으며, 이 경우 사전 공지하되 불가항력적인 경우에는 사후에 공지 합니다.
본 서비스의 성인 컨텐츠는 19세 이상의 성인인증자(최초 사용시 1회만 인증 합니다)만 사용할 수 있습니다.
본 서비스 사용에 동의한 회원에 한하여 더 나은 서비스 사용환경 제공을 목적으로 회원의 네트워크 및 PC 자원을 부분적으로 활용할 수 있습니다.
회사는 서비스의 성능, 보안 및 안전성 개선을 목적으로 업데이트를 자동으로 다운로드하여 설치할 수 있습니다.
업데이트에는 버그 수정, 서비스의 기능 향상 및 이전에 설치한 소프트웨어의 업데이트 및 기능 향상(새로운 버전)
이 포함 될 수 있습니다.
회사는 원활한 서비스 제공을 위하여 파일의 최소 정보를 수집할 수 있습니다.
수집 된 정보는 서비스 제공 및 사용자의 편의를 위한 목적으로만 활용됩니다.
제 7 조 [서비스 제공의 중지]
회사는 다음의 경우에 한하여 특정사용자(계정)의 서비스 이용을 제한할 수 있습니다.
① 본인의 실명을 사용하지 않고 타인의 명의를 도용하여 사용한 경우
② 음란물,이적물,불법저작물 등의 배포 및 전시
③ '제 13 조 회원의 의무'에서 규정한 사항에 위배되는 행위를 한 경우
제 8 조 [사이버머니의 구입]
본 서비스에서 사이버머니의 구입은 다음을 통하여 할 수 있습니다.
① 신용카드결제 (국내,해외)
② 핸드폰결제
③ 계좌이체
④ 가상계좌
⑤ ARS결제
⑥ 폰빌결제
⑦ 도서상품권 (북캐시)
⑧ 문화상품권 (해피머니, 컬쳐랜드)
⑨ 마일리지
⑩ OK캐시백
⑪ T캐시
⑫ 틴캐시
⑬ 도토리
제 9 조 [서비스 관리]
회사는 다음 각 항에 해당하는 게시물이나 자료는 사전통지 없이 삭제할 수 있습니다.
① 다른 회원 또는 제3자를 비방하거나 명예를 훼손하는 내용인 경우
② 공공질서 및 미풍양속에 위반되는 내용인 경우
③ 범죄적 행위에 결부된다고 인정되는 내용인 경우
④ 회사의 저작권 혹은 제3자의 저작권 등 기타 지적재산권을 침해하는 경우
⑤ 회원이 음란물을 게재하거나 음란사이트를 링크하는 경우
⑥ 이용자 ID 또는 게임상 사이버 자산의 매매에 관련된 내용인 경우
⑦ 게시판의 성격에 부합하지 않는 게시물의 경우
⑧ 기타 관련법령에 위반된다고 판단되는 경우
회원은 서비스를 이용하여 취득한 정보를 임의가공, 판매하는 행위 등 서비스에 게재된 자료를 상업적인 목적으로 사용할 수 없습니다.
회원은 타인의 저작권 등 지적재산권을 침해하지 않을 의무를 부담하며, 이를 위반하여 발생하는 민, 형사상의 책임은 전적으로 회원 본인이 부담하여야 합니다.
회사는 아래와 같이 불법복제물 복제/전송자에 대한 제재가 가능합니다.
① 경고 : 서비스 부적합 컨텐츠를 업로드 한 전송자(업로더)에게 쪽지 및 이메일 경고문 발송
② 영구취소 : 누적정지 3회 시 전송자(업로더)는 사전고지 없이 판매자 자격 영구취소 처리
③ 회사는 상습적인 침해자를 제재대상자로 간주하여 이에 따라 판매자 자격 영구취소, 캐쉬 환수 등의 제재를 할 수 있습니다.
④ 제재대상자의 자료는 2년 동안 보관합니다
회사는 서비스 제공을 위하여 게시물을 편집 및 가공할 수 있습니다.
제 10 조 [이용자 불만형태별 처리절차 및 처리기간]
이용자 불만형태와 처리절차 및 처리기간은 아래와 같습니다.
불만형태 : 결제, 오류(장애), 이용/연령 제한 등
이용자는 서비스에 불만이 있을 시, 회사의 고객센터, 게시판, 등을 이용하여 24시간 건의할 수 있습니다.
회사는 고객센터, 게시판 등의 이용자 불만사항에 대하여 영업일 기준 최장 24시간 이내 답변 및 조치사항을 회신합니다.
제 11 조 [이용요금]
본 서비스의 제세공과금을 포함한 이용요금은 다음과 같습니다.
① 판매수수료 : 판매등록자격자 준회원과 정회원으로 구분되며, 각각의 수수료가 상이(변경 시 공지를 통해 안내해드립니다.)
② 충전캐시 환불수수료 : 캐시 미사용 시 7일이내 무료 환불(결제 7일 이내 캐시 사용 시 10% 제외 환불, 결제 7일 이후 캐시 사용 시 25% 제외 환불)
③ 수수료 및 이용요금은 회사방침에 따라 변경될 수 있습니다.
④ 문자메시지는 1건당 20원을 받습니다.
⑤ 포인트, 쿠폰의 유효기간은 적립 이후 5년입니다.
⑥ 자유이용권 상품은 사용내역이 없는 경우 환불 또는 취소할 수 있습니다.
제 12 조 [회사의 의무]
회사는 서비스제공과 관련하여 취득한 이용고객의 정보를 타인에게 누설 또는 배포 할 수 없으며 상업적 목적으로 사용할 수 없습니다.
회사는 회원정보를 보호하기 위하여 보안시스템을 구축, 운영하며 "회원정보처리방침"을 공지하고 준수합니다. 또한 회사는 "회원정보처리방침"에 따라 회원 정보를 처리함에 있어 안정성 확보에 필요한 기술적, 관리적 대책을 수립 운영합니다.
회사의 귀책사유로 인하여 회원이 서비스를 이용하지 못할 경우에 회사는 사이버 머니 재충전 통하여 지체없이 손해를 배상합니다.
위 2번 항목과 관련하여 사실확인기간이 3일이상 소요되는 경우는 결과 회신 가능 일자를 회원에게 통지하여야 하며 그 일자는 10일을 넘지 않습니다. 다만 회원과 합의된 경우에는 합의된 내용에 따릅니다.
회사는 회원의 웹 스토리지('필로그'의 '개인자료실'과 '필로그자료실')에 대해서 열람할 수 없습니다.
회사의 의무에 대한 면책사유는 다음과 같습니다.
① 회사외부의 요인, 천재지변등의 불가항력적인 요인, 회원의 고의 또는 과실로 인하여 발생하는 손해
② 회사이외의 타 통신업체가 제공하는 통신서비스의 장애로 인한 경우
③ 회원이 게시 또는 전송한 자료에 대한 책임
④ 회원 상호간 또는 회원과 제3자 상호간의 서비스를 매개로 하여 발생된 손해
⑤ 회원이 회사의 서비스를 통하여 기대되는 이익을 얻지 못하거나 서비스되는 자료의 구매, 또는 이용으로 발생하는 손해
회사는 회원 권리(서비스 안정성, 계정보호 및 악의적 이용 방지 등) 보호를 위해 동일계정의 동시접속을 제한할 수 있습니다.
제 13 조 [회원의 의무]
회원은 아이디와 비밀번호를 관리할 의무를 가지며 회원의 아이디와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 전적으로 회원에게 있습니다.
다른 회원의 계정을 부당하게 사용하는 행위를 하지 않아야 합니다.
회원이 본 서비스를 통하여 게재한 게시물과 컨텐츠의 모든 권리와 책임은 회원에게 있습니다.
회사의 저작권, 제3자의 저작권등 기타 권리를 침해하는 행위는 하지 않아야 합니다.
회원은 서비스를 이용하여 상업적 혹은 Cetus에 위해를 가하는 활동을 할수 없으며, 해당활동의 결과로 인하여 발생된 책임에 대하여 회사는 책임지지 않습니다. 회원은 이와 같은 활동에 대하여 회사에 대한 손해배상 의무를 집니다.
서비스에서 얻은 정보를 회사의 사전승낙 없이 회원의 이용 이외의 목적으로 복제하거나 이를 출판 및 방송 등에 사용하거나 제3자에게 제공하는 행위를 하지 않아야 합니다.
Cetus 캐시를 다른 회원과 현금 거래를 할 수 없으며, 거래 및 거래 시도 시 보유캐시 환수 및 강제 탈퇴됩니다.
회원은 서비스를 이용하면서 타 사이트의 홍보 행위를 하지 않아야 합니다.
회원은 회사의 운영자, 직원 또는 관계자를 사칭하여 쪽지 등을 보내거나 게시물을 등록할 수 없으며 이를 위반 시 회사는 사전공지 없이 삭제할 수 있는 권리를 가지며 삭제된 게시물에 대한 손해는 회사가 책임지지 않습니다.
회원이 게시하는 정보 등으로 인해 발생하는 손실이나 문제는 전적으로 회원 개인의 판단에 따른 책임이며, 회사의 고의가 아닌 한 회사는 이에 대하여 책임지지 않습니다.
회원은 공공질서나 미풍양속에 위배되는 내용과 타인의 저작권을 포함한 지적재산권 및 기타 권리를 침해하는 내용의 게시물로 인해 발생하는 결과에 대한 모든 책임은 회원 본인에게 있습니다.
회원은 아이디와 비밀번호를 제3자에게 양도 공유할 수 없으며, 이를 위반하여 발생되는 모든 결과에 대한 책임은 전적으로 회원에게 있습니다.
제 14 조 [이용자의 회원정보보호]
회사는 회원정보보호에 관한 법령 및 회원정보처리방침에 따라 회원의 회원의 정보를 보호합니다.
회원이 회사의 서비스를 이용하여 저장한 등록정보, 파일 등의 개인자료에 대하여 회사는 회원의 동의 없이 열람하거나 삭제할 수 없습니다.
제 15 조 [거래수익출금정책]
회사는 회원이 보유하고 있는 사이버머니에 대하여 출금요청이 있을 경우 다음과 같은 절차에 의하여 출금해드립니다.
① 회원은 본 서비스 메뉴중 내정보 -> 출금신청 메뉴를 통하여 출금 희망액과 출금에 필요한 계좌정보를 입력합니다.
② 출금신청은 익일 19시에 일괄 처리됩니다.(월요일~금요일 사이에 신청하실 수 있으며 주말(토, 일) 또는 공휴일에는 신청하실 수 없습니다.)
③ 사용자는 출금 신청시 출금 날짜와 은행을 임의로 지정할 수 있습니다.
④ 출금 요청액의 수수료는 없습니다. 단, 2012년 2월 9일 이전 컨텐츠 적립 캐시는 기존 수수료 50%를 유지합니다.
⑤ 출금 요청액의 3.3%가 원천징수 됩니다.
⑥ 은행송금 수수료는 회사 부담입니다.
제 16 조 [회원탈퇴]
회원탈퇴를 희망할 경우 회원본인이 직접 서비스를 통하여 회원탈퇴를 하여야 합니다.
회사는 회원탈퇴 신청이 접수되면 지체없이 이에 응하여 서비스의 이용을 제한합니다.
회사는 탈퇴한 회원의 정보를 상법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관계법령 규정에 의하여 처리합니다.
회원탈퇴 시 해당 회원의 저장자료, 거래내역, 보유 사이버머니 등의 회원정보는 회사의 서버와 백업장비에서 2년 동안 보관합니다.
강제 탈퇴가 된 회원에 한해 재가입 방지를 위해 기본적인 회원정보가 보관되며, 캐시는 환불되지 않습니다.
아래 모든 항목에 해당하는 사유가 확인되면 회사는 회원에게 별도의 통지 없이 탈퇴 처리할 수 있습니다.
① 최종 이용일자로부터 5년동안 접속 내역이 없는 경우
② 위에 항목에 해당하는 회원 중 결제 내역이 없는 경우
제 17 조 [손해배상]
본 서비스중 유료서비스가 회사의 귀책사유로 인하여 데이터의 일부 또는 전체의 손상이 초래된 경우 월 이용료의 100% 를 배상합니다.
기타 손해배상의 방법과 절차등은 관계법령에 따릅니다.
제 18 조 [관할법원 및 준거법]
서비스와 관련하여 분쟁이 발생한 경우 대한민국 민사소송법상의 관할법원에 소를 제기할 수 있습니다.
전항의 경우 준거법은 대한민국 법을 적용합니다.
<부칙>
1. 이 약관은 2017년 6월 14일부터 적용됩니다.
2. 2007년 3월 12일부터 시행되던 종전의 약관은 본 약관으로 대체합니다.
         </textarea>
         </td>
         <td>
         <textarea rows="7" cols="49" style="resize: none" readonly="readonly">
<회원정보 수집 및 이용안내>
1. 수집하는 회원정보 항목
Cetus는 회원가입 및 서비스 제공을 위해 필요한 최소한의 회원정보를 수집하고 있습니다.
회원가입 시 수집하는 회원정보는 회원님의 아이디, 비밀번호입니다.
1) 수집항목
① 필수 수집 항목 : 아이디, 비밀번호
② 선택 수집 항목 : 이메일, 실명, 결제내역
③ 자동 수집 항목 : IP 및 접속일시 등 로그기록, 결제기록, 쿠키
2-1) 회원정보 수집 방법 : 회원가입
외국인의 선택 수집 항목은 이메일, 상담, 팩스로 접수할 수 있음.
2-2) 회원정보 수집 방법 : 선택 수집 항목
개인 맞춤 서비스를 제공하기 위해 수집할 수 있음.
2. 회원정보의 수집 목적
Cetus는 회원의 정보를 다음의 목적을 위해 활용합니다.
회사가 운영하는 회원정보취급방침은 회원에게 제공하는 서비스의 가입 및 이용에 관하여 기술적,관리적 원칙을 수립하여 시행하는 것을 목적으로 합니다.
3. 회원정보의 이용 및 보유기간
회사는 회원정보 수집 및 이용목적이 종료된 후에는 어떠한 경우에도 재생할 수 없는 방법으로 회원의 정보를 모두 파기하며 서면 등으로 수집된 정보 역시 문서분쇄기로 분쇄하거나 소각을 통하여 파기합니다.
1) 보유기간
회원의 정보는 회사의 서비스를 이용하기 위한 목적이 모두 달성된 후 별도의 DB로 이동되며(종이의 경우 별도의 서류함) 회사 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 일정 기간 저장된 후 파기됩니다.
① 계약 또는 청약 철회에 관한 기록(전자상거래 등에서의 소비자보호에 관한 법률) 보존기간 : 5년
② 대금결제 및 재화 등의 공급에 관한 기록(전자상거래 등에서의 소비자보호에 관한 법률) 보존기간 : 5년
③ 소비자의 불만 또는 분쟁처리에 관한 기록(전자상거래 등에서의 소비자보호에 관한 법률) 보존기간 : 3년
④ 방문에 관한 기록(통신비밀보호법) 보존기간 : 3개월
2) 기타
① 회원이 기존에 사용한 아이디는 타 회원들과의 혼선을 방지하기 위해 보존됩니다.
② Cetus의 이용약관 등을 위반하여 이용 정지가 이루어진 회원 정보의 경우 부정 이용을 방지하기 위해 1년 동안 회원 정보를 보관합니다.
         </textarea>
         </td>
      </tr>
      <tr style="border-color: #fff">
         <td style="text-align: right; border-color: #fff">
            <input type="checkbox" name="agree1">동의합니다.
         </td>
         <td style="text-align: right; border-color: #fff" >
            <input type="checkbox" name="agree2" >동의합니다.
         </td>
      </tr>
      </table>
      <br>
      <div style="text-align: center"><input type="button" class="btn" value="회원가입" onclick="send(this.form)"></div>
</form>
</div>
 </aside>  
 <%@include file="../include/footer.jsp" %>