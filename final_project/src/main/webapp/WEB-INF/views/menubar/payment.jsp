<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <title>MansHobby</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/payment.css" />
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

    <script type="text/javascript">
        var IMP = window.IMP;
        IMP.init("imp33361271");

        var merchant_uid = "O" + new Date().getTime(); // 고유한 주문번호 생성

        function requestPay() {


            // 로그인이 안되었으면
            if ("${ empty user }" == "true") {
                if (confirm("로그인 후 충전이 가능합니다.\n로그인 하시겠습니까?") == true) {
                    // 로그인 모달창을 띄웁니다.
                    loginModal.style.display = "flex";
                }
                return;
            }

            IMP.request_pay({
                pg: "uplus",
                pay_method: 'uplus',
                merchant_uid: merchant_uid,
                name: '포인트충전',
                amount: 1000000,
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
            });

        } //end:requestPay()

        function tossPay() {


            // 로그인이 안되었으면
            if ("${ empty user }" == "true") {
                if (confirm("로그인 후 충전이 가능합니다.\n로그인 하시겠습니까?") == true) {
                    // 로그인 모달창을 띄웁니다.
                    loginModal.style.display = "flex";
                }
                return;
            }

            IMP.request_pay({
                pg: "tosspay",
                pay_method: 'tosspay',
                merchant_uid: merchant_uid,
                name: '포인트충전',
                amount: 1000000,
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
            });

        } //end:requestPay()

        function kakaoPay() {


            // 로그인이 안되었으면
            if ("${ empty user }" == "true") {
                if (confirm("로그인 후 충전이 가능합니다.\n로그인 하시겠습니까?") == true) {
                    // 로그인 모달창을 띄웁니다.
                    loginModal.style.display = "flex";
                }
                return;
            }

            IMP.request_pay({
                pg: "kakaopay",
                pay_method: 'kakaopay',
                merchant_uid: merchant_uid,
                name: '포인트충전',
                amount: 1000000,
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
            });

        } //end:requestPay()
    </script>
</head>

<body>
    <!-- 상품 페이지 내용 -->
    <div class="paymentbar">
        <h1>상품 제목</h1>
        <p>상품 설명 텍스트가 여기에 들어갑니다...</p>
    </div>

    <!-- 고정된 푸터 -->
    <div class="fixed-footer">
        <div class="button-container">
            <button class="btn npay-btn">T Pay 구매하기</button>
            <button class="btn simple-buy-btn">간편구매</button>
            <button class="btn buy-btn">구매하기</button>
        </div>
    </div>

    <!-- 숨겨진 구매 섹션 -->
    <div id="purchaseSection" class="purchase-section">
        <div class="purchase-content">
            <h2>구매 옵션</h2>
            <div class="purchase-options">

                <!-- 색상 선택 -->
                <div class="option">
                    <label for="color">색상 *</label>
                    <select id="color">
                        <option value="white">흰색</option>
                        <option value="black">검정색</option>
                        <option value="blue">파랑색</option>
                    </select>
                </div>

                <!-- 사이즈 선택 -->
                <div class="option">
                    <label for="size">SIZE *</label>
                    <select id="size">
                        <option value="small">S</option>
                        <option value="medium">M</option>
                        <option value="large">L</option>
                    </select>
                </div>

                <!-- 배송 옵션 -->
                <div class="option">
                    <label for="delivery">배송 옵션</label>
                    <select id="delivery">
                        <option value="standard">택배</option>
                        <option value="pickup">방문수령</option>
                        <option value="express">퀵배송</option>
                    </select>
                </div>

                <!-- 가격 표시 -->
                <div class="price">
                    <p>판매가: <span id="price">1,000,000원</span></p>
                </div>

                <!-- 구매 버튼 -->
                <div class="purchase-actions">
                    <button class="btn npay-btn" onclick="tossPay()">Toss Pay 구매하기</button>
                    <button class="btn simple-buy-btn" onclick="kakaoPay()">카카오 간편구매</button>
                    <button class="btn buy-btn" onclick="requestPay()">구매하기</button>
                </div>
            </div>

            <!-- 닫기 버튼 -->
            <button id="closeButton" class="close-btn">닫기</button>
        </div>
    </div>

    <script>
        document.querySelector('.button-container').addEventListener('click', function () {
            document.getElementById('purchaseSection').style.bottom = '0';
        });

        document.getElementById('closeButton').addEventListener('click', function () {
            document.getElementById('purchaseSection').style.bottom = '-100%';
        });
    </script>

</body>

</html>