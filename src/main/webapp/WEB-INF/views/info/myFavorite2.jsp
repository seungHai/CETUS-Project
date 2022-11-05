<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>  

   <aside>
   <div>
         <!-- <div style="margin-bottom: 1%">◎찜한자료</div> -->
         <div align="center">
         <ul id="tabs">
             <li><a href="/info/myFavorite?pageNum=1&amount=${pageMaker.cri.amount }" title="tab1" id="tab1">내찜한자료</a></li>
             <li><a class="active" href="/info/myFavorite2?pageNum=${pageMaker.cri.pageNum }&amount=${pageMaker.cri.amount }" id="tab2" title="tab2">찜순위</a></li>
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
         
         <br><br>
      <table class="custom-table">
         <tr style="width: 15%; background-color: #e0e0e0;">
            <th style="width: 8%; text-align: center">순위</th>
            <th style="width: 15%; text-align: center">카테고리</th>
            <th style="width: 57%; text-align: center">제목</th>
            <th style="width: 10%; text-align: center">용량</th>
            <th style="width: 10%; text-align: center">가격</th>
         </tr>
         
         <c:forEach items="${list }" var="board" varStatus="i">
         <tr>
         <td style="text-align: center"><c:out value="${(pageMaker.cri.pageNum -1)*7 + i.count }" /></td>
             <c:forEach var="cboard" items="${clist}">
                  <c:if test="${cboard.catecode eq board.catecoderef || empty board.catecoderef}">
                     <td style="text-align: center">${cboard.catename }</td>
                  </c:if>
               </c:forEach>
               
            <td><a class="move" href="/board/get?bno=${board.bno }" onclick="window.open(this.href, '_blank', 'width=815, height=810'); return false;"> ${board.title } </a></td>
                    <c:choose>
					<c:when test="${board.filesize ge 1000000 }">
						<td><fmt:formatNumber value="${board.filesize div 1000000 }" pattern=".00"/>MB</td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="${board.filesize div 1000 }" pattern=".00"/>KB</td>
					</c:otherwise>
					</c:choose>
            <td style="text-align: center"><c:out value="${board.price }" /></td>
         </tr>
         </c:forEach>
      </table>
    </div>
    <hr>
    <div>
    	&nbsp;
    </div>
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
                  <a class="${pageMaker.cri.pageNum == num ? 'active':''}" href="/info/myFavorite2?pageNum=${num }&amount=7">${num }</a>&nbsp; <!-- 여기에 버튼 이벤트건다. -->
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
#favorite{
   font-weight: bold;
}

#logout{
	visibility: collapse;
}

</style>
<%@include file="../include/footer.jsp" %>