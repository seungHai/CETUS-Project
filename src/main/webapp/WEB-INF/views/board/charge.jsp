<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp" %>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 아래 제이쿼리는 1.0이상이면 원하는 버전을 사용하셔도 무방합니다. -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript">
function iamport1000(){
	//가맹점 식별코드
	IMP.init('imp49631049');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '캐시 1,000 원' , //결제창에서 보여질 이름
	    amount : 100, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	// 포인트 충전 관련 ajax
			$.ajax({
				url : "/chargePoint/1000.json",
				type : "get",
				dataType : "json",
				success : function(result){
				}
			});
			var msg = '결제가 완료되었습니다. ';
	        msg += '결제 금액 : 1000';
	    } else {
	    	 var msg = ' 결제에 실패하였습니다.';
	         msg += ' 에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}
function iamport3000(){
	//가맹점 식별코드
	IMP.init('imp49631049');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '캐시 3,000 원' , //결제창에서 보여질 이름
	    amount : 300, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	// 포인트 충전 관련 ajax
			$.ajax({
				url : "/chargePoint/3000.json",
				type : "get",
				dataType : "json",
				success : function(result){
				}
			});
			var msg = '결제가 완료되었습니다. ';
	        msg += '결제 금액 : 3000';
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
	         msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}
function iamport5000(){
	//가맹점 식별코드
	IMP.init('imp49631049');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '캐시 5,000 원' , //결제창에서 보여질 이름
	    amount : 500, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	// 포인트 충전 관련 ajax
			$.ajax({
				url : "/chargePoint/5000.json",
				type : "get",
				dataType : "json",
				success : function(result){
				}
			});
			var msg = '결제가 완료되었습니다. ';
	        msg += '결제 금액 : 5000';
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
	         msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}
function iamport10000(){
	//가맹점 식별코드
	IMP.init('imp49631049');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '캐시 10,000 원' , //결제창에서 보여질 이름
	    amount : 1000, //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울 강남구 도곡동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	// 포인트 충전 관련 ajax
			$.ajax({
				url : "/chargePoint/10000.json",
				type : "get",
				dataType : "json",
				success : function(result){
				}
			});
			var msg = '결제가 완료되었습니다. ';
	        msg += '결제 금액 : 10000';
	    } else {
	    	 var msg = '결제에 실패하였습니다.';
	         msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}
</script>
<aside>
<div>
<h3 class="head">◎ 충전샵</h3>
<div class="eventCashBanner">
	<div>
		<img src="../resources/images/web_cash_top_bn.jpg" style="width: 100%">
	</div>
</div>
<div class="cashText">
	<div class="cash_text">
		<strong>
			<span class="money">충전금액</span>을 선택해 주세요.
		</strong>
	</div>
</div>
<div onclick="iamport1000();" class="images" style="background:url(../resources/images/1000원.png) no-repeat; background-size: 100px; background-position: center;">
	<div class="img_text" style="padding-top:139px; text-align:center; color:#000; font-weight:bold; font-size:14px;">
		<div>캐시</div>
		<div>1,000원</div>
	</div>
	<!-- <button onclick="iamport();">결제하기</button> -->
</div>

<div onclick="iamport3000();" class="images" style="background:url(../resources/images/3000.png) no-repeat; background-size: 150px; background-position: center;">
	<div class="img_text" style="padding-top:139px; text-align:center; color:#000; font-weight:bold; font-size:14px;">
		<div>캐시</div>
		<div>3,000원</div>
	</div>
	<!-- <button onclick="iamport();">결제하기</button> -->
</div>

<div onclick="iamport5000();" class="images" style="background:url(../resources/images/5000.png) no-repeat; background-size: 130px; background-position: center;">
	<div class="img_text" style="padding-top:139px; text-align:center; color:#000; font-weight:bold; font-size:14px;">
		<div>캐시</div>
		<div>5,000원</div>
	</div>
	<!-- <button onclick="iamport();">결제하기</button> -->
</div>

<div onclick="iamport10000();" class="images" style="background:url(../resources/images/10000.png) no-repeat; background-size: 150px; background-position: center;">
	<div class="img_text" style="padding-top:139px; text-align:center; color:#000; font-weight:bold; font-size:14px;">
		<div>캐시</div>
		<div>10,000원</div>
	</div>
	<!-- <button onclick="iamport();">결제하기</button> -->
</div>


</div>
</aside>
<style type="text/css">

aside {
    font-size: 12px;
    line-height: 14px;
    color: #636363;
    letter-spacing: 0px;
    font-style: normal;
    text-decoration: none;
    }

.images {
 	width: 160px;
    height: 160px;
    float: left;
    margin: 10px;
    margin-top: inherit;
    cursor: pointer;
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
 
 .cash_text {
 	padding-top: 35px;
 	padding-left: 10px;

 }
 
 .money {
 	font-size: 14px !important;
 	color: #395ec4 !important;
 	font-weight: bold;
 }

#logout{
		visibility: collapse;
	}
</style>
<%@include file="../include/footer.jsp" %>