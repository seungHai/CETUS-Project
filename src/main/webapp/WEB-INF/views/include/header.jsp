<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐거운 세상! CETUS</title>
<script type="text/javascript" src="/resources/js/sub_category.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/header.css" />
<!-- 구글 웹폰트 start-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<!-- 구글 웹폰트 end-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

   var principal = null;
   // 권한이 있는지 먼저 물어본다.
   <sec:authorize access="isAuthenticated()">
   principal = '<sec:authentication property="principal.username"/>'; //인증 안되었을때 그냥쓰면 에러남
   </sec:authorize>

   $(function(){
      var catecode = 0;
      var amount = "${pageMaker.cri.amount}";      // 전역변수로 선언
      var pageNum = "${pageMaker.cri.pageNum}";   // 전역변수로 선언
      
      if(principal != null){
    	// 유저 포인트 정보 불러오기 ajax
			$.ajax({
				url : "/userPoint",
				type : "post",
				dataType : "json",
				success : function(result){
					//alert(result.cash);
					var str = "";
					str += "<h3 style='color: black;'>보유잔액 : ";
					str += result.cash;
					str += "P</h3>";
					$("#myPoint").html(str);
				}
			});
      }
      
      $(".catemenu").mouseenter(function(){
         catecode = $(this).attr("href");
         if(catecode == 1){
        	 $(".sub").html("");
         }else{
            subCateService.get(catecode, function(result){
               var str ="";
               for(var i=0; i<result.length; i++){
                  str += "<li><a class='catemenu' href=/board/listSubAction?pageNum=1&amount=10&catecoderef=";
                  str += result[i].catecode;
                  str += ">";
                  str += result[i].catename;
                  str += "</a></li>";
               }
               $(".sub").html(str);
            });
         }
      });
      
      $(".catemenu").on("click",function(e){
         e.preventDefault();
         catecode = $(this).attr("href");
         if(catecode == 1){
            location.href="/board/list?amount=10&pageNum=1";
         }else{
            location.href ="/board/listAction?pageNum=1&amount=10&catecode=" +catecode;
            subCateService.get(catecode, function(result){
            });
         }
      });
      
      $("#category1").change(function(){
         $("#cate").attr("disabled","disabled");
         var catecode = $(this).val();
         //alert(catecode);
         subCateService.get(catecode, function(result){
            var str ="";
            for(var i=0; i<result.length; i++){
               str += "<option value=";
               str += result[i].catecode;
               str += ">";
               str += result[i].catename;
               str += "</option>";
            }
            $("#category2").html(str);
         }); 
      });
      
      $("#myInfomation").on("click", function(e){
         e.preventDefault();
         if(principal == null){
            alert("로그인 후 이용가능합니다.");
         }else{
            location.href = '/info/myInfo';
         }
      });
      
      $(".loginAccess").on("click", function(e){
         e.preventDefault();
         alert("로그인 후 이용가능합니다.");
      });
      
      /* $("#myPointCheck").on("click",function(){
    	// 유저 포인트 정보 불러오기 ajax
			$.ajax({
				url : "/userPoint",
				type : "post",
				dataType : "json",
				success : function(result){
					//alert(result.cash);
					var str = "";
					str += "<h3 style='color: black;'>보유잔액 : ";
					str += result.cash;
					str += "P</h3>";
					$("#myPoint").html(str);
				}
			});
      }); */
      
   });
   
   function login() {
      location.href = "/customLogin";
   }
   
   function join(){
      location.href = "/info/myinsert?pageNum=1&amount=10";
   }
   function searchGo(f) {
      var cate1 = $("#category1").on("click option").val();
      if(cate1 == ''){
         alert("분류를 선택해주세요.");
         return;
      }
      var cate2 = $("#category2").on("click option").val();
      if(cate2 == ''){
         alert("소분류를 선택해주세요.");
         return;
      }
      
      var search_key = $("input[name=search]").val();
      if(search_key == ''){
         alert("검색어를 입력해주세요");
         return;
      }
      
      f.submit();
   }
</script>
</head>
<body>
		
   <div class="wrap">
   <sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.username" var="pusername"/>
   </sec:authorize>
   <div id="nav_menu">
      <ul>
      <sec:authorize access="isAuthenticated()">
         <li><a id="logout" href="/customLogout" alt="logout">로그아웃</a></li>
         <li><b>${pusername }</b>님 환영합니다.</li>
       </sec:authorize>
         <li><a href="#" id="myInfomation">내정보</a></li>
	         <sec:authorize access="isAnonymous()">
	         	<li><a href="#" class="loginAccess">충전샵</a></li>
	         </sec:authorize>
	         <sec:authorize access="isAuthenticated()">
	         	<li><a href="/board/charge">충전샵</a></li>
	         </sec:authorize>
      </ul>
   <a class="catemenu" href="1" alt="CETUS"><img src="/resources/images/header/mainLogo.png" class="mainLogo"></a>
   </div>
<br>
    <!-- 헤더 부분 --> 
    <header>
    <sec:authorize access="isAnonymous()">
      <div class="login">
         <form role="form" action="/login" method="post">
	        <input type="text" class="id" name="username" placeholder="아이디" />
	        <input type="password" class="pw" name="password" placeholder="비밀번호"/>
	        <button type="submit" value="login" name="submit" class="submit">로&nbsp;그&nbsp;인</button>
	        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
      		<div>
	           <input name="remember-me" type="checkbox">&nbsp;<span class="remember-id">아이디저장</span>&nbsp;<span class="find-id">아이디</span><span class="find">/</span><span class="find-pw">비번찾기</span>
	        </div>
            <!-- <a href="#">아이디 찾기 </a>
            /
            <a href="#">비밀번호 찾기</a> -->
   			</form>
         <button type="button" class="newMember" onclick="join();">무&nbsp;료&nbsp;회&nbsp;원&nbsp;가&nbsp;입</button>
      </div>
   </sec:authorize>
   <sec:authorize access="isAuthenticated()">
      <div class="login">
         <h3 style="color: black;"> ${pusername }님 환영합니다.</h3>
         <div id="myPoint">
	         <h3 style="color: black;">보유잔액 : </h3>
	         <!-- <button id="myPointCheck">잔액 확인하기</button> -->
         </div><br>
         <button class="logout-btn" type="button" onclick="location.href='/info/myInfo';" >내&nbsp;정보&nbsp;보기</button>
      </div>
   </sec:authorize>
   <div class="menu">
       <div class="search-sec">
         <form action="/board/search">
            <select name="category1" id="category1" class="search-slt">
               <option id="cate" value="">::분류선택::</option>
               <c:forEach var="cat1" items="${clist }">
                  <c:if test="${cat1.catecode % 100 eq 0 }">
                     <option value="${cat1.catecode }">${cat1.catename }</option>
                  </c:if>
               </c:forEach>
            </select>
            
            <select name="category2" id="category2" class="search-slt">
               <option value="">::소분류선택::</option>
            </select>
            
            <input type="text" placeholder="제목을 입력하세요." name="search" class="search-sltinput">
            <input type="button" value="검색" class="wrn-btn" onclick="searchGo(this.form);">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
               <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
            
         </form>
      </div>
        <div>
      <ul class="nav">
      <li><a class="catemenu" href="1">전체</a></li>
         <c:forEach var="cat1" items="${clist }">
            <c:if test="${cat1.catecode % 100 eq 0 }">
               <li>
                  <a class="catemenu" href="${cat1.catecode }">${cat1.catename }</a>
               </li>
            </c:if>
         </c:forEach>
      </ul>
      <div class="submenuPlace">
         <ul id="subCate" class="sub">
         </ul>
	  </div>
   </div>
   </div>
    </header>
        <!-- 본문 부분 -->
         <!-- 1. section 내부에 article --> 
         <!-- 2. article 내부에 section --> 
         <section>
         <div>
         	<div class="main_noti">
					<div>
						<span class="noticeList"><b>공지사항</b></span> <a href="/customerCenter/notice?pageNum=1&amount=10"><img
							src="/resources/images/header/btn_more.gif" alt="전체보기" /></a>
					</div>
					<ul class="noticeList2">
						<li><a href="/customerCenter/nGet?amount=10&pageNum=1&nno=450">[공지] 외국어 사용 PC ..</a></li>
						<li><a href="/customerCenter/nGet?amount=10&pageNum=1&nno=449">[공지] 저작권 위반 게시물..</a></li>
						<li><a href="/customerCenter/nGet?amount=10&pageNum=1&nno=448">[공지] 불법성인물 등록 및..</a></li>
						<li><a href="/customerCenter/nGet?amount=10&pageNum=1&nno=441">[공지] EBS 컨텐츠 유통..</a></li>
					</ul>
				</div>
         </div>
           <div id="admin-sidebar" class="col-md-2 p-x-0 p-y-3">
                <ul class="sidenav admin-sidenav list-unstyled">
                    <a href="/board/best?pageNum=1&amount=10"><img src="/resources/images/header/top100.png"></a>
                    <sec:authorize access="isAuthenticated()">
                    <a href="/info/downloadFile?pageNum=1&amount=7"><img src="/resources/images/header/myDown.png"></a>
                    <a id="favorite" href="/info/myFavorite?pageNum=1&amount=7"><img src="/resources/images/header/loveCho.png"></a>
                    <a href="/board/register?pageNum=${pageMaker.cri.pageNum }&amount=${pageMaker.cri.amount }" onclick="window.open(this.href, '_blank', 'width=815, height=810'); return false;"><img src="/resources/images/header/register.png"></a>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                       <a class="loginAccess" href="#"><img src="/resources/images/header/myDown.png"></a>
                       <a class="loginAccess" href="/info/myFavorite?pageNum=1&amount=7"><img src="/resources/images/header/loveCho.png"></a>
                       <a href="/resources/fakeHtml/question.html" target="_blank"><img src="/resources/images/header/question.png"></a>
                    </sec:authorize>
                   <!--  <a href="/board/self_auth"><li>성인인증</li></a> -->      
                      <div class="hyungi">
                      </div>
              <div class="bg">
             <!--  <a href="https://www.asus.com/kr/"><video muted autoplay loop>
                <source src="../resources/images/Network.mp4" type="video/mp4">
              </video></a> -->
              <a href="https://www.google.com/search?q=%EC%A0%95%EA%B7%BC%EC%A4%80&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiLyMfNjrj1AhVPE6YKHYtHBjkQ_AUoAXoECAEQAw&biw=1463&bih=751&dpr=1.75#imgrc=wJ8TYUUMcI_nfM"><video muted autoplay loop>
                <source src="../resources/images/LHK.mp4" type="video/mp4">
              </video></a>
              <a href="https://www.instagram.com/seunghy.joe/?utm_medium=copy_link"><video muted autoplay loop>
                <source src="../resources/images/football.mp4" type="video/mp4">
              </video></a>
              <a href="#"><video muted autoplay loop>
                <source src="../resources/images/sky.mp4" type="video/mp4">
              </video></a>
				</div>            
                </ul>
            </div>
         </section>