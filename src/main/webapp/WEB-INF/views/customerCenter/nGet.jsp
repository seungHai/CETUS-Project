<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<style type="text/css">
	.custom-table{
		width: 96.5%;
		margin-left: 13px;
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
	    margin-top: 15px;
	    cursor: pointer;
	}
	.button{
		text-align: right;
	}
	#notice{
		font-weight: bold;
	}
	.ntablelength{
		width: 25%;
		height: 30px;
		font-size: 13px;
	}
	div.editable {
    width: 720px;
    padding : 0;
    margin : 0;
    height: 380px;
    border: 1px solid #dcdcdc;
    overflow-y: auto;
    text-align: left;
    font-size: 14px;
	}
	.custom-table th,.custom-table td{text-align:left;padding:2px;border:solid 1px #fff}
	table{
		width: 750px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var nno = "${nvo.nno}";
		
		$("button").on("click",function(){
			var oper = $(this).data("oper");
			var amount = "${cri.amount}";		// 전역변수로 선언
			var pageNum = "${cri.pageNum}";	// 전역변수로 선언
			
			if(oper == 'list'){
				var choice = confirm("목록으로 이동하시겠습니까?"); // 예 아니오 누를수있는 함수 리턴값은 boolean
				if(choice){
					location.href="/customerCenter/notice?amount="+amount+"&pageNum=" + pageNum;
				}else {
					return;
				}
			}else if(oper == 'nModify'){
				var choice = confirm("수정하시겠습니까?"); // 예 아니오 누를수있는 함수 리턴값은 boolean
				if(choice){
					location.href="/customerCenter/nModify?amount="+amount+"&pageNum=" + pageNum + "&nno=" + nno;
				}else {
					return;
				}
			}else if(oper == 'nRemove'){
				var choice = confirm("삭제하시겠습니까?"); // 예 아니오 누를수있는 함수 리턴값은 boolean
				if(choice){
					location.href="/customerCenter/nRemove?amount="+amount+"&pageNum=" + pageNum + "&nno=" + nno;
				}else {
					return;
				}
			}
		})
	});
</script>
	<aside>
	<div>
	<div class="button">
		<button class="re-btn" type="button" data-oper="list">목록으로 이동</button>&nbsp;&nbsp;
		 <sec:authorize access="isAuthenticated()">
	     <sec:authentication property="principal.username" var="pusername"/>
	     <c:choose>
	     	<c:when test="${pusername eq 'admin'}">
				<button class="re-btn" type="button" data-oper="nModify" style="margin-right: -5px;">수정</button>&nbsp;&nbsp;
				<button class="re-btn" type="button" data-oper="nRemove" style="margin-right: 15px;">삭제</button>
	     	</c:when>
	     </c:choose>
	     </sec:authorize>
		<hr>
	     <h3 class="head">◎ 제목 : ${nvo.ntitle }</h3>
	</div>
		<table class="custom-table">
			<tbody>
				<tr>
					<th class="ntablelength">글쓴이</th>
					<td class="ntablelength">${nvo.nwriter }</td>
					<th class="ntablelength">날짜</th>
					<td class="ntablelength">${nvo.nreg_date }</td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="editable"><pre>${nvo.ncontent }</pre></div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</aside>
<%@include file="../include/footer.jsp" %>