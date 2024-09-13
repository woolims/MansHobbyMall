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
                name: '${ shop.getPName() }',
                amount: '${ shop.getPrice() }',
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
                if (rsp.success) {
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "{서버의 결제 정보를 받는 가맹점 endpoint}",
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        data: {
                            imp_uid: rsp.imp_uid, // 결제 고유번호
                            merchant_uid: rsp.merchant_uid // 주문번호
                        }
                    }).done(function (data) {
                        // 가맹점 서버 결제 API 성공시 로직
                    })
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
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
                name: '${ shop.getPName() }',
                amount: '${ shop.getPrice() }',
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
                if (rsp.success) {
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "{서버의 결제 정보를 받는 가맹점 endpoint}",
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        data: {
                            imp_uid: rsp.imp_uid, // 결제 고유번호
                            merchant_uid: rsp.merchant_uid // 주문번호
                        }
                    }).done(function (data) {
                        // 가맹점 서버 결제 API 성공시 로직
                    })
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
                
            });

        } //end:tossPay()

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
                name: '${ shop.getPName() }',
                amount: '${ shop.getPrice() }',
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
                if (rsp.success) {
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "{서버의 결제 정보를 받는 가맹점 endpoint}",
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        data: {
                            imp_uid: rsp.imp_uid, // 결제 고유번호
                            merchant_uid: rsp.merchant_uid // 주문번호
                        }
                    }).done(function (data) {
                        // 가맹점 서버 결제 API 성공시 로직
                    })
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
            });

        } //end:kakaoPay()
    </script>
</head>

<body>
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
            <h2>구매 정보</h2>
            <div class="purchase-options">

                <!-- 색상 선택 -->
                <!-- <div class="option">
                    <label for="color">색상 *</label>
                    <select id="color">
                        <option value="white">흰색</option>
                        <option value="black">검정색</option>
                        <option value="blue">파랑색</option>
                    </select>
                </div> -->

                <!-- 사이즈 선택 -->
                <!-- <div class="option">
                    <label for="size">SIZE *</label>
                    <select id="size">
                        <option value="small">S</option>
                        <option value="medium">M</option>
                        <option value="large">L</option>
                    </select>
                </div> -->

                <!-- 배송 옵션 -->
                <!-- <div class="option">
                    <label for="delivery">배송 옵션</label>
                    <select id="delivery">
                        <option value="standard">택배</option>
                        <option value="pickup">방문수령</option>
                        <option value="express">퀵배송</option>
                    </select>
                </div> -->

                <!-- 가격 표시 -->
                <div class="price">
                    <p>판매가: <span id="price">${ shop.getPrice() }</span></p>
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