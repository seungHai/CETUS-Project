<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src = "${path}/ckeditor/ckeditor.js"></script>
<style type="text/css">
	textarea {
		resize: none;
		height: 370px;
	}
	.nRegister{
		width: 95%;
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
	    margin-top: 15px;
	    cursor: pointer;
	}
	#notice{
		font-weight: bold;
	}
</style>
<script type="text/javascript">
	$(function(){
		
		$("button").on("click",function(){
			var oper = $(this).data("oper");
			var amount = "${cri.amount}";		// 전역변수로 선언
			var pageNum = "${cri.pageNum}";	// 전역변수로 선언
			
			if(oper == 'list'){
				var choice = confirm("목록으로 이동하시겠습니까??"); // 예 아니오 누를수있는 함수 리턴값은 boolean
				if(choice){
					location.href="/customerCenter/notice?amount="+amount+"&pageNum="+pageNum;
				}else {
					return;
				}
			}else {
				var f = $("#myForm");
				
				var ntitle = $('#myForm [name=ntitle]').val();
				/* var ncontent = CKEDITOR.instances.description.getData(); */
				var ncontent = $('#myForm [name=ncontent]').val();
				var nwriter = $('#myForm [name=nwriter]').val();
				
				if(ntitle == ''){
					alert("제목을 입력하세요!!");
					return;
				}
				if(ncontent == ''){
					alert("내용을 입력하세요!!");
					return;
				}
				if(nwriter == ''){
					alert("작성자를 입력하세요!!");
					return;
				}
			}
			
			if(oper == 'nRegister'){
				var choice = confirm("등록 하시겠습니까??"); // 예 아니오 누를수있는 함수 리턴값은 boolean
				if(choice){
					f.action = "/customerCenter/nRegister";
					f.submit();
				}else {
					return;
				}
			}
		})
	});
</script>
	<aside>
	<form id="myForm" method="post">
	 <sec:authorize access="isAuthenticated()">
	     <sec:authentication property="principal.username" var="pusername"/>
	 </sec:authorize>
	<div class="button">
	<h3 class="head">◎ 공지사항 등록</h3>
		<button type="button" class="re-btn" data-oper="nRegister" style="margin-right: -5px;">작성하기</button>&nbsp;&nbsp;
		<input type="reset" class="re-btn" value="다시작성" style="margin-right: -5px;">&nbsp;&nbsp;
		<button type="button" class="re-btn" data-oper="list" style="margin-right: 15px;">목록으로 이동</button>	
	<hr>
	</div>
		<br>
		<table class="custom-table">
			<tbody>
				<tr>
					<th>제목</th>
					<td><input class="nRegister" type="text" name="ntitle"> </td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea class="nRegister" rows="15" cols="30" name="ncontent" id="description"></textarea>
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						${pusername }
						<input type="hidden" name="nwriter" value="${pusername }"> 
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<input type="hidden" name="pageNum" value="${cri.pageNum }">
	    <input type="hidden" name="amount" value="${cri.amount }">
	</form>
</aside>
<%@include file="../include/footer.jsp" %>