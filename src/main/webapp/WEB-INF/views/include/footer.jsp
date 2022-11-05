<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- footer 영역 -->
        <footer class="footer" >
        <hr>
           <p><a href="/resources/fakeHtml/introduce.html" target="_blank">회사소개</a> | <a href="/resources/fakeHtml/hire.html" target="_blank">채용정보</a> | <a href="/resources/fakeHtml/agree.html" target="_blank">이용약관</a> | 
           <a href="/resources/fakeHtml/person.html" target="_blank">개인정보처리방침</a> | <a href="/resources/fakeHtml/teen.html" target="_blank">청소년보호정책</a> | <a href="/resources/fakeHtml/copyright.html" target="_blank">저작권보호센터</a> 
           | <a href="/resources/fakeHtml/victim.html" target="_blank">피해구제센터</a></p>
           <br>
           <div>
           		<img alt="footer" src="/resources/images/footer/footer2.png">
           </div>
        </footer>
 </div>
 <script>
$(document).ready(function(){  
  //티스토리 공감버튼 이벤트
  function reAction(){
  	$("#startButton").trigger("click");
  	setTimeout(function(){
  		$("#stopButton").trigger("click");
  	}, 2000);
  }  
  reAction(); 
});
</script>
</body>
</html>