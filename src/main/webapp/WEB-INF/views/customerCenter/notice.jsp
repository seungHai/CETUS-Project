<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>
<style type="text/css">
	.custom-table{
		width: 96.5%;
		margin-left: 13px;
	}
	
	.contentlength{
		width: 50%;
	}
	.button{
		text-align: right;
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
	.re-btn{
	    width: 13%;
	    font-size: 12px;
	    font-weight: 700;
	    text-transform: capitalize;
	    height: 35px !important;
	    border-radius:5px;
	    background-color: #1b3274;
	    color: white;
	    margin-right: 15px;
	    margin-top: 15px;
	    cursor: pointer;
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
	background-color:#1B3274;
	color:#fff;
	border:1px solid #1B3274;
}
#notice{
	font-weight: bold;
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
				location.href="/customerCenter/notice?amount="+amount+"&pageNum=" + nextPageNum;
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
		
		function nRegisterGo() {
			var amount = "${pageMaker.cri.amount}";		
			var pageNum = "${pageMaker.cri.pageNum}";	
			location.href="/customerCenter/nRegister?amount="+amount+"&pageNum=" + pageNum;
		}
	</script>
	<aside>
	<div>
	<div class="button">
	<h3 class="head">※ 공지사항</h3>
	 <sec:authorize access="isAuthenticated()">
     <sec:authentication property="principal.username" var="pusername"/>
     <c:choose>
     	<c:when test="${pusername eq 'admin'}">
			<input class="re-btn" type="button" value="글쓰기" onclick="nRegisterGo();">
     	</c:when>
     </c:choose>
     </sec:authorize>
	<hr>
	<br>
	</div>
		<table class="custom-table">
			<thead>
				<tr>
					<th>#번호</th>
					<th class="contentlength">제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="nboard" items="${nlist }">
				<tr>
					<td>${nboard.nno }</td>
					<td style="text-align: left;"><a class="nGet" href="${nboard.nno }">${nboard.ntitle }</a></td>
					<td>${nboard.nwriter }</td>
					<td>${nboard.nreg_date }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<hr>
		<br>
		<!-- pageing 처리 -->
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
		<!-- pageing 처리 -->
	</div>
	</aside>
<%@include file="../include/footer.jsp" %>