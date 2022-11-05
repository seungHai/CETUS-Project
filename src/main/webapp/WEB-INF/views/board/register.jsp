<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src = "${path}/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/register.css" />
<meta charset="UTF-8">
<title>즐거운 세상! CETUS</title>
</head>
<body>
      <div id="upload_form">
         
          <form action="/board/register" method="post" class="form" id="myForm">

            <!--분류 start-->
            <p class="pop_tit">컨텐츠 등록하기</p>
            <div class="upload_form_con">
               <table>
                  <tbody>
                  <tr class="upload_tit">
                     <th>제목</th>
                     <td>
                        <input name="title" id="chgitem" type="text" placeholder="컨텐츠와 관련없는 특수문자, 이모티콘, 부호의 사용을 제한하며 삭제될 수 있습니다." value="" tabindex="1" onfocus="this.style.background=&#39;#f8f8f8 url()&#39;" onkeyup="title_strlength();" style="">
                     </td>
                  </tr>
                  <tr class="uploader_tit">
                     <th>등록자</th>
                     <td>
                        <sec:authentication property="principal.username" var="pusername"/>
                             <sec:authentication property="principal.username"/>
                             <input type="hidden" name="id" class="input" value="${pusername }">
                     </td>
                  </tr>
                  <tr>
                     <th>파일/폴더</th>
                           <td class="uploadResult">
                                <input type="file" name="uploadFile" multiple="multiple">
                                <ul>
                                </ul>
                          </td>
                     <td class="uploadResult-all" style="display: none;">
                           <ul>
                           </ul>
                     </td>
                  </tr>
                  <tr>
                     <th>포인트</th>
                     <td class="data_point">
                        <ul>
                           <li><input type="number" class="input" name="price" readonly="readonly"> <span>P</span></li>
                        </ul>
                     </td>
                  </tr>
                  <tr>
                     <th>분류</th>
                     <td class="file_kind">
                        <select name="catecode" id="category1" class="search-slt">
                                 <option id="cate" value="">::분류선택::</option>
                                 <c:forEach var="cat1" items="${clist }">
                                    <c:if test="${cat1.catecode % 100 eq 0 }">
                                    <option value="${cat1.catecode }">${cat1.catename }</option>
                                    </c:if>
                                    </c:forEach>
                              </select>
                        
                              <select name="catecoderef" id="category2" class="search-slt">
                                 <option value="">::소분류선택::</option>
                              </select>
                     </td>
                  </tr>
                  <tr>
                  </tr>
                  <tr>
                     <td colspan="2" class="upload_editor">
                        <!--CK에디터 인서트 공간-->
                        <textarea rows="50" cols="100" name="content" placeholder="내용을 작성하세요" id="description"></textarea>
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
                  <button type="submit" class="myButton-blue" data-oper="submit">작성</button>
                  <button type="button" id="btnClose" onclick="location.href='/remove.do'" class="myButton-white">닫기</button>
               </div>

            </div>
                     <input type="hidden" name="pageNum" value="${cri.pageNum }">
                     <input type="hidden" name="amount" value="${cri.amount }">
                     <input type="hidden" name="filesize" value="1">
         </form>
         
      </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
   
$("#category1").change(function(){
      var catecode = $(this).val();
      //alert(catecode);
      $("#cate").attr("disabled","disabled");
      opener.parent.subCateService.get(catecode, function(result){
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
   
   /* $(document).ready(function() { 
      $("form").submit(function(event) { 
         
      }); 
   });  */
      var amount = "${cri.amount}";
      var pageNum = "${cri.pageNum}"
      
      // -------버튼 클릭 이벤트 start
      $("button").click(function(e){
         
         var oper = $(this).data("oper");
         
         if(oper == "submit"){
            e.preventDefault();
            
             var title = $("input[name=title]").val();
               var id = $("input[name=id]").val();
               var price = $("input[name=price]").val();
               var content = CKEDITOR.instances.description.getData();
               var cate1 = $("#category1").on("click option").val();
               var cate2 = $("#category2").on("click option").val();
               
               if(title ==''){
                  alert("제목을 입력하세요.");
                  return false;
               }
               if(id ==''){
                  alert("아이디를 입력하세요.");
                  return false;
               }
               if(cate1 == ''){
                  alert("분류를 선택해주세요.");
                  return false;
               }
               if(cate2 == ''){
                  alert("소분류를 선택해주세요.");
                  return false;
               }
               if(price ==''){
                  alert("캐쉬를 설정하세요.");
                  return false;
               }
               if(content ==''){
                  alert("내용을 입력하세요.");
                  return false;
               }
            
            var str = "";
            $(".uploadResult ul li").each(function(i, obj){
               var jobj = $(obj);
               str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value = '" + jobj.data("filename")+"'>";
               str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '" + jobj.data("uuid") + "'>";
               str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value = '" + jobj.data("path") + "'>";
               str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value = '" + jobj.data("type") + "'>";
            });
            $("form").append(str).submit();
         }
      });
      // -------버튼 클릭 이벤트 end
      
      
      
      // ------------------- 파일 업로드 관련 스크립트 start
      // 버튼 클릭 이벤트 (눌렀을때 전송)
        // 파일 업로드 후 input=file을 초기화 하기 위해 초기화 된 상태 객체를 복사
      var cloneObj = $(".uploadResult").clone(); // 호이스팅때문에 위치 상관 없음
      var formData = new FormData();
      
      // 파일 용량 저장
      var fileSizeSave;
      
      function fileInputChange(){
         // 변경 전/후 모든 파일 내용 삭제
         removeUploadFile();
         $(".uploadResult-all ul").empty();
         
         $(".uploadResult ul").empty(); // 파일 초기화
         
         var inputFile = $("input[name='uploadFile']");
         var files = inputFile[0].files;
         
         formData = new FormData();
         
         for(var i=0; i<files.length; i++){
            // 파일 확장자 및 사이즈 체크
            if(!checkExtension(files[i].name, files[i].size)){
               return false;
            }
            // 문제 없는 파일 내용들 formData에 저장 -> 추후 submit 시 저장
            fileSizeSave += files[i].size;
            formData.append("uploadFile", files[i]);
         }
         $.ajax({
            url : "/uploadAjaxAction",
            processData : false,
            contentType : false,
            data : formData,
            type : "post",
            dataType : 'json',
            success : function(result){
               console.log(result);
               showUploadResult(result);
            }
         });
      }
      $("input[type='file']").change(function(){
         fileInputChange();
      });
      
      // 정규식, 파일 사이즈 체크
      var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
      var maxSize = 20971520; //20MB
      
      // 파일들마다 체크할거임, 일정 파일 이상 안올라가고 특정 확장자들 안올라가게
      function checkExtension(fileName, fileSize){
         
         if(fileSize >= maxSize){
            alert("파일 사이즈 초과");
            return false;
         }
         if(regex.test(fileName)){  // 정규식 테스트하는 메소드
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
         }
         return true;
      }
      
      // ------------------- 파일 업로드 관련 스크립트 end
      
      function showUploadResult(uploadResultArr){
         if(!uploadResultArr || uploadResultArr.length == 0){return ;}
         var str = "";
           
         $(uploadResultArr).each(function(i, obj){
            var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);  
            var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
            str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'>";
            str +=    "<div>";
            str +=       "<img src='/resources/images/get/fileIcon.png' style='width:15px;'>";
            str +=       "<span> "+ obj.fileName+ "</span>";
            str +=       "<button type='button' data-file=\'"+fileCallPath+"\' class='deleteBtn'>삭제</button><br>";
            str +=    "</div>";
            str += "</li>";
         });
         $(".uploadResult ul").append(str);
         $(".uploadResult-all ul").append(str);
         
         // 파일 용량 및 가격 설정 관련 ajax
         $.ajax({
            url : "/updatePrice",
            type : "post",
            dataType : "json",
            success : function(result){
               //alert(result.filesize);
               var ceil_3 = Math.ceil(result.price / 10) * 10; 
               $("input[name=price]").val(ceil_3);
               $("input[name=filesize]").val(result.filesize);
            }
         });
      }
      
      //----------------------파일 삭제 이벤트 (버튼 클릭)
      // 파일 삭제 이벤트 (버튼 클릭)
        // on -> uploadResult 하위 객체에 이벤트를 줄떄 사용
      $(".uploadResult").on("click", "button", function(){
         var targetFile = $(this).data("file");
         var targetLi = $(this).closest("li");
         
         $.ajax({
            url : "/deleteFile",
            data : {fileName : targetFile},
            type : "post",
            dataType : 'text',
            success : function(result){
               targetLi.remove();
               // 파일 용량 및 가격 설정 관련 ajax
               $.ajax({
                  url : "/updatePrice",
                  type : "post",
                  dataType : "json",
                  success : function(result){
                     //alert(result.filesize);
                     var ceil_3 = Math.ceil(result.price / 10) * 10; 
                     $("input[name=price]").val(ceil_3);
                     $("input[name=filesize]").val(result.filesize);
                  }
               });
            }
         });
      });
      
      function removeUploadFile(){
         $(".uploadResult-all ul li div button").each(function(i, obj){
            var targetFile = $(this).data("file");
            $.ajax({
               url : "/deleteFile",
               data : {fileName : targetFile},
               type : "post",
               dataType : 'text',
               success : function(result){
               }
            });
         });
      }
      
   });
</script>
</body>


</html>