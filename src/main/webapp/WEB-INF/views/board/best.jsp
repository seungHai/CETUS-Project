<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css" />
<style type="text/css">
	.button{
		text-align: right;
	}
	h3{
		color: #000080;
	}
	.re-btn{
	    width: 13%;
	    font-size: 12px;
	    font-weight: 700;
	    text-transform: capitalize;
	    height: calc(2.2rem + 3px) !important;
	    border-radius:0;
	    background-color: #dde8f7;
	    border-color: #dde8f7;
	    color: #000080;
	}
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
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
		$(function(){
			var result = "${result}";
			var amount = "${pageMaker.cri.amount}";		// 전역변수로 선언
			var pageNum = "${pageMaker.cri.pageNum}";	// 전역변수로 선언
			
			if(result != ''){
				check(result);
			}
			$(".paginate_button a").click(function(e){
				// <a> 클릭시 페이지 이동이 이루어지지 않게 하기 위해
				// 기존에 설정된 이벤트 해제
				e.preventDefault();
				var nextPageNum = $(this).attr("href");	// 이동할 페이지 이름
				location.href="/board/best?amount="+amount+"&pageNum=" + nextPageNum;
			});
			$(".nGet").on("click",function(e){
				e.preventDefault();
				var nno = $(this).attr("href");
				location.href="/customerCenter/nGet?amount="+amount+"&pageNum=" + pageNum + "&nno=" + nno;
			});
		});
		
		history.replaceState(null,null,null);
		
		function check(result){
			if(result === '' || history.state){
				return;
			}
			
			if(result == 'success'){
				alert("처리가 완료되었습니다.");
			}else if(parseInt(result) > 0){
				alert("게시글이 등록되었습니다.");
			}
		}
	</script>
<aside>
	<div class="mainBanner">
		<img alt="배너" src="/resources/images/best/topBanner.png">
	</div>
   <div>
      <table class="custom-table">
         <thead>
            <tr>
               <th>순위</th>
               <th>아이디</th>
               <th>제목</th>
               <th>분류</th>
               <th>소분류</th>
               <th>용량</th>
               <th>조회수</th>
               <th>작성일</th>
               <th>추천수</th>
               <th>가격</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach items="${list }" var="board" varStatus="i">
               <tr>
                  <td><c:out value="${(pageMaker.cri.pageNum -1)*10 + i.count }" /></td>
                  <td><c:out value="${board.id }" /></td>
                  <td><a class="move" href="/board/get?bno=${board.bno }" onclick="window.open(this.href, '_blank', 'width=815, height=810'); return false;"> ${board.title } </a></td>
                  <c:forEach var="cboard" items="${clist}">
						<c:if test="${cboard.catecode eq board.catecoderef || empty board.catecoderef}">
							<td>${cboard.catename }</td>
						</c:if>
						<c:if test="${cboard.catecode eq board.catecode }">
							<td>${cboard.catename }</td>
						</c:if>
					</c:forEach>
                  <c:choose>
					<c:when test="${board.filesize gt 1000000 }">
						<td><fmt:formatNumber value="${board.filesize div 1000000 }" pattern=".00"/>MB</td>
					</c:when>
					<c:otherwise>
						<td><fmt:formatNumber value="${board.filesize div 1000 }" pattern=".00"/>KB</td>
					</c:otherwise>
					</c:choose>
                  <td><c:out value="${board.hit }" /></td>
                  <td><c:out value="${board.update_date }" /></td>
                  <td><c:out value="${board.recomendCount }" /></td>
                  <td><c:out value="${board.price }" /></td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
         <form id="actionForm" action="/board/list" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
         </form>
   </div>
   <hr>
   <!-- pageing 처리 -->
		<div class="paginate">
		<div class="page_wrap">
 				<div class="page_nation">
			<ul class="pagination">
				<%-- <c:if test="${pageMaker.prev }">
					<li class="paginate_button">
						<a class="arrow prev" href="${pageMaker.startPage-1 }"></a>
					</li>
				</c:if> --%>
				<c:choose>
					<c:when test="${pageMaker.endPage gt 10 }">
						<c:forEach var="num" begin="${pageMaker.startPage }" end="10" step="1">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
								<a class="${pageMaker.cri.pageNum == num ? 'active':''}" href="${num }">${num }</a>&nbsp; <!-- 여기에 버튼 이벤트건다. -->
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" step="1">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active':''}">
								<a class="${pageMaker.cri.pageNum == num ? 'active':''}" href="${num }">${num }</a>&nbsp; <!-- 여기에 버튼 이벤트건다. -->
							</li>
						</c:forEach>
					</c:otherwise>				
				</c:choose>
				<%-- <c:if test="${pageMaker.next }">
					<li class="paginate_button">
						<a class="arrow next" href="${pageMaker.endPage+1 }"></a>
					</li>
				</c:if> --%>
			</ul>
		</div>
		</div>
		</div>
		<!-- pageing 처리 -->
   <%-- <a href="/board/register?pageNum=${pageMaker.cri.pageNum }&amount=${pageMaker.cri.amount }" onclick="window.open(this.href, '_blank', 'width=815, height=810'); return false;"><button id="regBtn" class="re-btn" type="button">게시글 작성</button></a> --%>
   
</aside>



<%@include file="../include/footer.jsp" %>