<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐거운 세상! CETUS</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/get.css" />
<script src="/resources/js/reply.js"></script>
<script src="/resources/js/util.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var principal = null;
	// 권한이 있는지 먼저 물어본다.
	<sec:authorize access="isAuthenticated()">
	principal = '<sec:authentication property="principal.username"/>'; //인증 안되었을때 그냥쓰면 에러남
	</sec:authorize>
	
	$("#btnMyfiles").on("click", function(e){
		   e.preventDefault();
		   
		   var downloadList;
			$("#downloadLists li").each(function(){
				
				var liObj = $(this);
				
				var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
			    
			    if(liObj.data("type")){
			      showImage(path.replace(new RegExp(/\\/g),"/"));
			    }else {
			      //download
			      var url ="/download?fileName="+path;
			    }
			    
				fnCreateIframe(iFrameCnt); // 보이지 않는 iframe 생성, name는 숫자로
	            
	            $("iframe[name=" + iFrameCnt + "]").attr("src", url);
	            iFrameCnt++;
	            fnSleep(1000); //각 파일별 시간 텀을 준다
			});
			alert("다운로드가 완료되었습니다.");
		    location.href="/info/downloadFiles?bno=${board.bno}&carte=${board.catecode }&id=${board.id }&title=${board.title }&filesize=${board.filesize }&cash=${board.price }";
	});
	
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
						str += "<span>" + attach.fileName + "</span>";
						str += "</div>";
						str + "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			});
	});
	
	// 파일 개별 다운로드 코드 (활성화 유무 때문에 남겨둠 지우지 말것)
	
	 /* $(".uploadResult").on("click","li", function(e){
	      if(principal != null){
		    console.log("view image");
		    
		    var liObj = $(this);
		    var liObjhtml = $(this).html();
		    
		    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
		    
		    //alert(path);
		    
		    if(liObj.data("type")){
		      showImage(path.replace(new RegExp(/\\/g),"/"));
		    }else {
		      //download 
		      self.location ="/download?fileName="+path
		    }
	      }else{
	    	  alert("로그인 후 이용 가능합니다.");
	      }
		    
		    
		  }); */
		  
		  function showImage(fileCallPath){
			    
		    //alert(fileCallPath);
		    
		    $(".bigPictureWrapper").css("display","flex").show();
		    
		    $(".bigPicture")
		    .html("<img src='/display?fileName="+fileCallPath+"' >")
		    .animate({width:'100%', height: '100%'}, 1000);
		    
		  }

		  $(".bigPictureWrapper").on("click", function(e){
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){
		      $('.bigPictureWrapper').hide();
		    }, 1000);
		  });
});
</script>
<script type="text/javascript">

	var principal = null;
	// 권한이 있는지 먼저 물어본다.
	<sec:authorize access="isAuthenticated()">
	principal = '<sec:authentication property="principal.username"/>'; //인증 안되었을때 그냥쓰면 에러남
	</sec:authorize>

	var iFrameCnt = 0;
	
	function download() {
		
		var downloadList;
		$("#downloadLists li").each(function(){
			
			var liObj = $(this);
			
			var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
		    
		    if(liObj.data("type")){
		      showImage(path.replace(new RegExp(/\\/g),"/"));
		    }else {
		      //download
		      var url ="/download?fileName="+path;
		    }
		    
			fnCreateIframe(iFrameCnt); // 보이지 않는 iframe 생성, name는 숫자로
            
            $("iframe[name=" + iFrameCnt + "]").attr("src", url);
            iFrameCnt++;
            fnSleep(1000); //각 파일별 시간 텀을 준다
		});
		alert("다운로드가 완료되었습니다.");
		location.href = "/board/li";
	}
	
	fnSleep = function (delay){
        
        var start = new Date().getTime();
        while (start + delay > new Date().getTime());
    };
    
    fnCreateIframe = function (name){
        var frm = $('<iframe name="' + name + '" style="display: none;"></iframe>');
        frm.appendTo("body");
    }
	
	function favorit(){
		var a = '${board.bno}';
		if('${favorit}' == null){
			var b = 'nodata';
		}else{
			var b = '${favorit.bno}';
		}
		
		//alert("board bno" + a);
		//alert("favorit bno" + b);
		
		 if(a == b){
			alert("이미 찜목록에 있습니다.");
			return;
		}else{
			alert("찜목록에 추가 되었습니다.");
			location.href="/info/favorite?bno=${board.bno}&carte=${board.catecode }&id=${board.id }&title=${board.title }&filesize=${board.filesize }&cash=${board.price }";
		    submit();
		}
	}

   $(function(){
	   
      /* $("#btnRecommend").click(function(e){
         if(confirm("이 글을 추천하시겠습니까?") == true){
            alert("이 글이 추천되었습니다.");
         }else{
            e.preventDefault();
            alert("추천을 취소하셨습니다.");
            
         }
          }); */
      
     // ---------- 댓글 -------------
     console.log("============");
     console.log("reply get test");
      
      
      // 등록버튼을 눌렀을 때
   var bno = "${board.bno}";
   var pageNum = "${pageMaker.cri.pageNum }";
   var amount = "${pageMaker.cri.amount }";
   
   $("#finish").on("click", function(e){
        e.preventDefault();
        // 필요한 데이터: 댓글 작성자, 댓글
         var replyer = $("input[name='replyer']").val();
        var reply = $("input[name='reply']").val();
        
        if(reply == "" ) {
           return;
        }
        
        replyService.add({bno: bno, reply:reply, replyer:replyer}, function(result){
           $("input[name='replyer']").val();
           $("input[name='reply']").val(null);
           showList(1);
          });
	});
   
   // 데이터 불러와서 댓글 처리하기
   var replyUL = $(".chat");
   
   // 페이지 번호
  
   function showList(page){
      replyService.getList({bno:bno, page : page || 1}, function(list){
         var str = "";
         if(list == null || list.length == 0){
            replyUL.html("");
            
            return;
         }
         for(var i =0, len = list.length || 0; i<len; i++){
            str += " <div>";
            str += "   <div>";
			str += "      <strong data-rno = '"+list[i].rno+"'>"+list[i].replyer+"</strong>";
			str += "      <input type='hidden' data-oper = '"+list[i].reply+"'>";
			str += "      <input type='hidden' id='username' value = '"+list[i].replyer+"'>";
            str += " 	     <small>" + displayTime(list[i].reply_date) + "</small>";
            if(principal == list[i].replyer){
				str += " 			<button type='button' class='btn-modify replyModify'>수정</button>";
				str += "			<button type='button' class='btn-remove replyRemove'>삭제</button>";
            }
			str += "   </div>";
            str += "   <p class='commentContent'>"+list[i].reply + "</p>";
			str += " </div>"; 
         }
         replyUL.html(str);
      }); // end function
      	
   } // end showList
   

   
   
   // 댓글 삭제
   var rno;
   $(".chat").on("click", ".replyRemove", function(e){ // 이벤트 위임
	   //형제라인에 있는 strong을 찾고 나서 그 객체.data로 가야한다.
	   rno = $(this).siblings('strong').data("rno");
   	  
   	console.log(rno);
	   replyService.remove(rno, function(result){
		   alert("댓글이 삭제되었습니다.");
           showList();
        });

	  });
   
   showList(1);
   
   // 댓글 수정버튼 누르면
   $(".chat").on("click", ".replyModify", function(e){
	   $(this).parents("div").siblings("p").empty();
	   /* alert($(this).parents("div").siblings("p").text()); */
	   rno = $(this).siblings('strong').data("rno");
	   var reply = $(this).siblings('input').data("oper");
	   var replyer = $("input[name='replyer']").val();
	   console.log("수정버튼 누름");
	   console.log(rno);
	   console.log(reply);
	   console.log(replyer);
	   
	   var str ='';
	   
		str += " <div>";
		str += "   <div>";
		str += "     <strong data-rno = '"+rno+"'></strong>";
		str += "  		<input type='text' name='reply' id='reply' class='reply' value='"+reply+"' style='width: 510px; data-oper = '"+reply+"'>";
		str += " 		<button type='button' class='btn-modify replyModify1'>수정완료</button>";
		str += "   </div>";
		str += " </div>"; 
	   
		/*  $('.commentContent').html(str); */
		$('.commentContent').each(function(){
			updateRno = $(this).siblings('div').children("strong").data("rno");
			if(updateRno == rno){
				$(this).html(str);
			}
		});
   });
   
   // 댓글 수정완료 버튼 누르면
   
   $(".chat").on("click", ".replyModify1", function(e){
		 console.log("수정완료버튼 누름 확인");
		   var reply1 = $(this).siblings('input[name=reply]').val();
		   rno = $(this).siblings('strong').data("rno");
		   var reply = {rno:rno,  reply:reply1};
		   //var reply = $("#reply").val();
		   console.log(rno);
		   console.log(reply);
		   replyService.update(reply, function(result){
			   
	           showList(1);
	        });
	   });
   
   
   
   
   
   
   
   
   
   
   });//-- [주의] 함수 종료 괄호임!!
   
    function removeGo(f) {
	    f.method = 'post';
		f.action = '/board/remove';
		f.submit();
    }
   
   
</script>
<style type="text/css">

</style>
</head>

<body>
<div id="detail">
			<!--컨텐츠 상세정보 상단-->
<div class="con_info" style="">
<form method="get" action="/board/recoCount">
	<input type="hidden" id="point" value="50">
	<div class="detail_title clearfix">
		<img class="registerInfo" src="/resources/images/get/registerInfo.png" alt="등록정보">
		<span id="view_idx">${board.bno }번 게시글</span>
		<p>www.cetus.com</p>
	</div>
	<table class="info_view">
		<tbody><tr>
			<th colspan="8">
				<span id="req_icon"></span>
				<span id="view_title">${board.title}</span>
				<span id="view_hd"></span>
				<!--
				<img src="/img/contents/board/icon_hd02.gif" alt="고화질"/>
				<img src="/img/contents/board/icon_hd03.gif" alt="일반화질"/>
				-->
				<span id="view_smi"></span>
			</th>
		</tr>
		<tr>
			<th>포인트</th>
			<td><b id="view_point">${board.price}P</b></td>
			<th>조회수</th>
			<td><span id="view_grade"><b>${board.hit}</b></span></td>
			<th>등록자</th>
			<td class="detail_user"><span id="view_seller">${board.id}</span>
				<input type="hidden" name="id" class="input" value="${board.id}">
                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</td>
			<th>좋아요</th>
			<td><span id="view_mobile">${board.recomendCount}</span></td>
		</tr>
		<tr>
			<th>파일</th>
			<td class="uploadResult" colspan="7">
				<ul id="downloadLists">
               	</ul>
			</td>
		</tr>
	</tbody>
	</table>
	<div class="topButton">
	<sec:authorize access="isAuthenticated()">
                       <!-- <button class="myButton-blue" onclick="download();">내려받기나중에 수정하자</button>&nbsp; -->
                       <c:choose>
		                    	<c:when test="${board.price le userpoint }">
                       				<a href="#" class="myButton-blue" id="btnMyfiles">내려받기</a>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<a href="#" class="myButton-blue" onclick="alert('포인트가 부족합니다');">내려받기</a>
		                    	</c:otherwise>
		                    </c:choose>
                       <sec:authentication property="principal.username" var="pusername"/>
                       		<c:choose>
		                    	<c:when test="${board.id eq pusername }">
			                        <a class="myButton-blue" id="btnFavorit" onclick="alert('자신의 글은 찜할수 없습니다.');">찜하기</a>
                       				<button onclick="alert('자신의글은 추천할 수 없습니다.');" class="myButton-blue">추천하기</button>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<a class="myButton-blue" id="btnFavorit" onclick="favorit()">찜하기</a>
                       				<button type="submit" id="btnRecommend" class="myButton-blue">추천하기</button>
		                    	</c:otherwise>
		                    </c:choose>
                       </sec:authorize>
                       <sec:authorize access="isAnonymous()">
                       		<button class="myButton-blue" onclick="alert('로그인 후 이용 가능합니다.');">내려받기<!-- 나중에 수정하자 --></button>&nbsp;
	                   		<a class="myButton-blue" id="btnFavorit" onclick="alert('로그인 후 이용 가능합니다.');">찜하기</a>
                       		<button onclick="alert('로그인 후 이용 가능합니다.');" class="myButton-blue">추천하기</button>
                       </sec:authorize>
                       <input type="hidden" name="bno" value="${board.bno}">
                   </div>
	<!--상세정보 본문-->
	<div class="textarea" >
	<table>
	<tr>
		<td><p align="center"><br>${board.content }<br></p><td>
	</tr>
	</table>
	</div>
</div>
				<div class="bottomButton">
                    <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.username" var="pusername"/>
                    <c:choose>
                    	<c:when test="${board.id eq pusername }">
	                        <button type="button" data-oper="modify" class="myButton-green" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">수정하기</button>
	                        <button type="button" data-oper="remove" class="myButton-red" onclick="removeGo(this.form);">삭제하기</button>
                    	</c:when>
                    	<c:when test="${pusername eq 'admin'}">
	                        <button type="button" data-oper="modify" class="myButton-green" onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">수정하기</button>
	                        <button type="button" data-oper="remove" class="myButton-red" onclick="removeGo(this.form);">삭제하기</button>
                    	</c:when>
                    	<c:otherwise>
                    		<button type="button" data-oper="modify" class="myButton-green" onclick="alert('작성자만 수정이 가능합니다.');">수정하기</button>
	                        <button type="button" data-oper="remove" class="myButton-red" onclick="alert('작성자만 삭제가 가능합니다.');">삭제하기</button>
                    	</c:otherwise>
                    </c:choose>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                    	<button type="button" data-oper="modify" class="myButton-green" onclick="alert('로그인 후 이용 가능합니다.');">수정하기</button>
	                    <button type="button" data-oper="remove" class="myButton-red" onclick="alert('로그인 후 이용 가능합니다.');">삭제하기</button>
                    </sec:authorize>
                        <button type="button" onclick="location.href='/board/li'" class="myButton-white">닫기</button>
                </div>
                
                
                <!-- 댓글 영역 -->
				<sec:authorize access="isAuthenticated()">
                <tr>
                   <td class="reply" colspan="2">
                      <img src='/resources/images/comment.png' style='width:15px;'>&nbsp;<b>댓글</b><br>
                   </td>
                </tr>
	                <tr>
	                   <td class="replyMake" colspan="2" style="margin-left: 10px;">
	                   	  <div class="replyInput">
	                      	<b><sec:authentication property="principal.username"/><input type="hidden" name="replyer" value='<c:out value="${pusername }"/>'></b>
	                      	<input type="text" name="reply" class="input-reply" placeholder="회원님의 아름다운 댓글은 모든 회원들께 기쁨이 됩니다." style="width: 555px;">&nbsp;
	                      	<button type="button" class="replyRegister" id="finish">댓글등록</button>
	                      </div>
	                   </td>
	                </tr>
                </sec:authorize>
<tr>
                   <td class="replyList" colspan="8">
                      <ul class="chat">
                        <!-- start reply -->
 				
                  <!-- end reply -->
                      </ul>
                   </td>

                </tr>
            </table>
            
            <form id="operForm" action="/board/modify" method="get">
                <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'> <input type='hidden'  name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                     <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
            </form>
            </div>

</body>

</html>