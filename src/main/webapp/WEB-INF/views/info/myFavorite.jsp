<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>  
<style>
   .remove{
      border: none;
      background-color: #1b3274;
      color: white;
      width: 40px;
      height: 21px;
      font-size: 4px;
      margin-right: 1%;
   }
</style>
   <aside>
   <form method="post" id="removeForm">
   <div>   
         <!-- <div style="margin-bottom: 1%">◎찜한자료</div> -->
         <div align="center">
         <ul id="tabs">
             <li><a class="active" href="/info/myFavorite?pageNum=${pageMaker.cri.pageNum }&amount=${pageMaker.cri.amount }" title="tab1" id="tab1">내찜한자료</a></li>
             <li><a href="/info/myFavorite2?pageNum=${pageMaker.cri.pageNum }&amount=${pageMaker.cri.amount }" title="tab2" id="tab2">찜순위</a></li>
         </ul>
         <table>
            <tr style="border: #fff">
               <td style="border: #fff; width: 20%;"><img src="/resources/images/Favorite.png"></td>
               <td style="border: #fff"><label style="color: #0101DF; font-weight: bold ">원하는 컨텐츠 창에서 찜하기 버튼을 누르신 후 내려받으시면 편리합니다.</label>
               <br>
               <label style="font-size: 10px">▶</label> 찜하기 서비스의 정보는 서버에 저장되기 떄문에 다른 컴퓨터에서 보시더라도
                <br>&nbsp;&nbsp; 
               확인이 가능하며, 언제 어디서든 내려받기를 이용하실 수 있습니다.</td>
            </tr>
         </table>
         
         </div>   
         <div style="float:right; margin-bottom: 1%">
            <button type="button" class="remove">삭제</button>
         </div>
      <table class="custom-table">
         <tr>
            <th style="width: 5%; text-align: center">
               <input type="checkbox" id="select-all">
            </th>
            <th style="width: 15%; text-align: center">카테고리</th>
            <th style="width: 55%; text-align: center">제목</th>
            <th style="width: 15%; text-align: center">용량</th>
            <th style="width: 15%; text-align: center">가격</th>
         </tr>
         
         <c:forEach items="${Paginglist }" var = "lis" >
               <tr>
                  <td>
                     <input type="checkbox" name="favorch" value="${lis.bno }" class="select_remove" style="text-align: center">
                  </td>
                  
                  <c:forEach var="cboard" items="${clist}">
                  <c:if test="${cboard.catecode eq lis.carte || empty lis.carte}">
                     <td style="text-align: center">${cboard.catename }</td>
                  </c:if>
               </c:forEach>
               
                  <td style="text-align: left"><a href="/board/get?bno=${lis.bno }" onclick="window.open(this.href, '_blank', 'width=815, height=810'); return false;">${lis.title }</a></td>
                    <c:choose>
               <c:when test="${lis.filesize gt 1000000 }">
                  <td><fmt:formatNumber value="${lis.filesize div 1000000 }" pattern=".00"/>MB</td>
               </c:when>
               <c:otherwise>
                  <td><fmt:formatNumber value="${lis.filesize div 1000 }" pattern=".00"/>KB</td>
               </c:otherwise>
               </c:choose>
                  <td style="text-align: center">${lis.cash }</td>
               </tr>
            </c:forEach>
      </table>
    </div>
    </form>
    
    
    
    
    <!-- 찜한목록 페이징 처리 구간 -->
  <div class="paginate">
      <div class="page_wrap">
             <div class="page_nation">
         <ul class="pagination">
            <c:if test="${pageMaker.prev }">
               <li class="paginate_button">
                  <a class="arrow prev" href="${pageMaker.startPage-1 }"></a>
               </li>
            </c:if>
            <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
               <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
                  <a class="${pageMaker.cri.pageNum == num ? 'active':''}" href="${num }">${num }</a>&nbsp; <!-- 여기에 버튼 이벤트건다. -->
               </li>
            </c:forEach>
            <c:if test="${pageMaker.next }">
               <li class="paginate_button">
                  <a class="arrow next" href="${pageMaker.endPage+1 }"></a>
               </li>
            </c:if>
         </ul>
      </div>
      </div>
      </div>
    
    </aside>
    
    
   
   <script type="text/javascript">
      
   <!-- 선택된 항목없이 삭제 눌렀을경우 방지  -->
    $(".remove").click(function(f){
       //alert($("input:checkbox[name=favorch]:checked").val());
      if($("input:checkbox[name=favorch]:checked").length == 0){
          alert("삭제할 항목을 선택해주세요.");
          return;
       }else{
         $("#removeForm").attr("action","/info/remove?pageNum="+${pageMaker.cri.pageNum }+"&amount="+${pageMaker.cri.amount }).submit();
       } 
   });
    
    
    
    <!-- all 체크 박스 선택시 전부 채크 하는 메소드 -->
   document.getElementById('select-all').onclick = function() {
       var checkboxes = document.getElementsByName('favorch');
       for (var checkbox of checkboxes) {
           checkbox.checked = this.checked;
       }
   }
   
   $(function(){
      var result = "${result}";
      var amount = "${pageMaker.cri.amount}";      // 전역변수로 선언
      var pageNum = "${pageMaker.cri.pageNum}";   // 전역변수로 선언
      
      if(result != ''){
         check(result);
      }
      $(".paginate_button a").click(function(e){
         // <a> 클릭시 페이지 이동이 이루어지지 않게 하기 위해
         // 기존에 설정된 이벤트 해제
         e.preventDefault();
         var nextPageNum = $(this).attr("href");   // 이동할 페이지 이름
         location.href="/info/myFavorite?amount="+amount+"&pageNum=" + nextPageNum;
      });
      $(".nGet").on("click",function(e){
         e.preventDefault();
         var nno = $(this).attr("href");
         location.href="/customerCenter/nGet?amount="+amount+"&pageNum=" + pageNum + "&nno=" + nno;
      });
   });
   
   </script>
   
<style type="text/css">
.paginate_button{
      display: inline-block;
   }
   .page_wrap {
   text-align:center;
   font-size:0;
 }
.page_nation {
   display:inline-block;
}
.page_nation .none {
   display:none;
}
.page_nation a {
   display:block;
   margin:0 3px;
   border:1px solid #e6e6e6;
   width:28px;
   height:28px;
   line-height:28px;
   text-align:center;
   background-color:#fff;
   font-size:13px;
   color:#999999;
   text-decoration:none;
}
.page_nation .arrow {
   border:1px solid #ccc;
}
.page_nation .pprev {
   background:#f8f8f8 url('../resources/images/page_pprev.png') no-repeat center center;
   margin-left:0;
}
.page_nation .prev {
   background:#f8f8f8 url('../resources/images/page_prev.png') no-repeat center center;
   margin-right:7px;
}
.page_nation .next {
   background:#f8f8f8 url('../resources/images/page_next.png') no-repeat center center;
   margin-left:7px;
}
.page_nation .nnext {
   background:#f8f8f8 url('../resources/images/page_nnext.png') no-repeat center center;
   margin-right:0;
}
.page_nation a.active {
   background-color:#42454c;
   color:#fff;
   border:1px solid #42454c;
}
main.container-fluid {
  min-height: 100%;
}

section.row {
  padding: 20px;
  padding-bottom: 100px;
}



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
#tabs a.active, 
#tabs a.active::after,
#tabs a:hover,
#tabs a:hover::after,
#tabs a:focus,
#tabs a:focus::after{
  background: #fff;
}

/*  
#tabs a:hover,
#tabs a:hover::after,
#tabs a:focus,
#tabs a:focus::after{
  background: #fff;
} */
 
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
}

#logout{
	visibility: collapse;
}

</style>
<%@include file="../include/footer.jsp" %>