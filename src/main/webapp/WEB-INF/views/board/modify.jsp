<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src = "${path}/ckeditor/ckeditor.js"></script>
<meta charset="UTF-8">
<title>즐거운 세상! CETUS</title>
<link rel="stylesheet" type="text/css" href="/resources/css/register.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	
	$(function(){
		   var bno = '<c:out value = "${board.bno}"/>';
		  
			$.getJSON("/board/getAttachList", {bno : bno}, function(arr){
				console.log(arr);
				var str = " ";
				$(arr).each(function(i, attach){
					
					//img type
					if(attach.fileType){
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						
						str += "<li data-path = '" + attach.uploadPath + "' data-uuid = '" + attach.uuid + "'data-filename = '"
						+ attach.fileName + "' data-type = '" + attach.fileType+"' ><div>";
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str + "</li>";
					}else {
						str += "<li data-path = '" + attach.uploadPath + "' data-uuid = '" + attach.uuid + "' data-filename = '"
						+ attach.fileName + "'data-type'" + attach.fileType + "'><div>";
						str += "<img src = '/resources/images/get/fileIcon.png' style='width:15px;'>";
						str += "<span>" + attach.fileName + "</span><br/>";
						str += "</div>";
						str + "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			});
	});
});
</script>
</head>
<body>
		<div id="upload_form">
			
			 <form action="/board/modify" method="post">

				<!--분류 start-->
				<p class="pop_tit">컨텐츠 수정하기</p>
				<div class="upload_form_con">
					<table>
						<tbody>
						<tr class="upload_tit">
							<th>제목</th>
							<td>
								<input name="title" id="chgitem" type="text" value="${board.title }" tabindex="1" onfocus="this.style.background=&#39;#f8f8f8 url()&#39;" onkeyup="title_strlength();" style="">
							</td>
						</tr>
						<tr class="uploader_tit">
							<th>등록자</th>
							<td>
								 ${board.id}
               						<input type="hidden" name="id" class="input" value="${board.id}">
             						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
							</td>
						</tr>
						<tr class="upload_folder">
							<th>파일/폴더</th>
		                     <td class="uploadResult">
			                    	<ul>
			                    	</ul>
		                    </td>
						</tr>
						<tr>
							<th>포인트</th>
							<td class="data_point">
								<ul>
									<li>${board.price}<span>P</span></li>
								</ul>
							</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td class="reg_date">
								<ul>
									<li>${board.reg_date}</li>
								</ul>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
            <tr>
               <td class="content" colspan="2" >
               		<textarea rows="50" cols="100" name="content" id="description">${board.content }</textarea>
                     <script type="text/javascript">
                           CKEDITOR.replace("description",{
                           }); 
                        // ckEditer 이미지창 설정 수정
                          CKEDITOR.on('dialogDefinition', function (ev) {
                             var dialogName = ev.data.name;
                             var dialog = ev.data.definition.dialog;
                             var dialogDefinition = ev.data.definition;
                             if (dialogName == 'image') {
                                dialog.on('show', function (obj) {
                                   this.selectPage('Upload'); //업로드텝으로 시작
                                });
                                dialogDefinition.removeContents('advanced'); // 자세히탭 제거
                                dialogDefinition.removeContents('Link'); // 링크탭 제거
                             }
                          });
                     </script>
               </td>
            </tr>
					</tbody></table>
					<div class="pop_send_btn">
						<button type="submit" class="myButton-blue" data-oper="submit">완료</button>
						<input type="hidden" name="pageNum" value="${cri.pageNum }">
            			<input type="hidden" name="amount" value="${cri.amount }">
            			<input type="hidden" name="bno" value="${board.bno}">
            			<input type="hidden" name="price" value="${board.price }">
			            <input type="hidden" name="filesize" value="1">
            			<button type="button" onclick="location.href='/remove.do'" class="myButton-white">닫기</button>
					</div>

				</div>
			</form>
			
		</div>
<script type="text/javascript">
	/* $(function() {
		var pageNum = "${cri.pageNum}";
		var amount = "${cri.amount}";
		var f = $("form");

		$("button").click(
				function(e) { // 버튼 클릭 이벤트
					// 버튼 타입 클릭시 submit() 이벤트와 click() 이벤트를 동시에 진행할 수 있다.
					// e.preventDefault() 메소드를 이용하여 기존에 설정된 이벤트 해제(submit)
					e.preventDefault();
					var oper = $(this).data("oper");
					if (oper == 'list') {
						location.href = "/board/list?pageNum=" + pageNum
								+ "&amount=" + amount;
					} else if (oper == "modify") {
						f.submit();
					}

				});
	});
	
	
	function reload(){
	    window.opener.location.reload();
	    window.close();
	}
 */
</script>
</body>

</html>