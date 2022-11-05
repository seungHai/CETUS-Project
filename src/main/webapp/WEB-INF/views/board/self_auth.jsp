<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style type="text/css">
	.centered{
		width: 700px;
		text-align: center;
	}

	img.infinite_rotating_logo{
    animation: rotate_image 3s linear infinite;
    transform-origin: 50% 50%;
	}
	img.infinite_rotating_logo:hover {
		transform: rotate( 720deg ); 
	}
	
	@keyframes rotate_image{
		100% {
	    	transform: rotate(-360deg);
	    }
}
</style>
<script type="text/javascript">

</script>
<%@include file="../include/header.jsp" %>
<aside> 
<div>
	<button onclick="iamport();">본인인증</button>
	<div class="centered">
	<br>
		<div>
			<img src="../resources/joonzis1.jpg" class="infinite_rotating_logo" alt="slide" width="200">
			<img src="../resources/joonzis1.jpg" class="infinite_rotating_logo" alt="slide" width="200">
		</div>
		<br><h1>로딩중....</h1><br>
		<div>
			<img src="../resources/joonzis1.jpg" class="infinite_rotating_logo" alt="slide" width="200">
			<img src="../resources/joonzis1.jpg" class="infinite_rotating_logo" alt="slide" width="200">
		</div>
		<br>
	</div>
</div>
</aside>
<%@include file="../include/footer.jsp" %>