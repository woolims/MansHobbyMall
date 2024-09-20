<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <title>MansHobby</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css" />
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

    <script type="text/javascript">
        var IMP = window.IMP;
        IMP.init("imp33361271");

        var merchant_uid = "O" + new Date().getTime(); // 고유한 주문번호 생성

        var bamount = document.getElementById('scamount').value || 1; // 수량 받아오기
        console.log("1"+bamount);

        var originalPrice = parseFloat("${shop.getPrice()}"); // 상품 원래 가격을 숫자로 변환
        var couponDiscount = 0; // 처음에는 쿠폰 할인이 0으로 설정
        var finalPrice = originalPrice - couponDiscount; // 쿠폰 적용 후 가격
        

        // 쿠폰 선택에 따른 할인 적용
        function applyCoupon() {
            var couponSelect = document.getElementById('coupon');
            var selectedValue = couponSelect.value; // 선택한 쿠폰의 value 값

            if (selectedValue.includes('%')) { // 할인율 쿠폰일 경우
                var discountPercentage = parseFloat(selectedValue.replace('%', '')); // %를 제거하고 숫자로 변환
                couponDiscount = originalPrice * (discountPercentage / 100); // 퍼센트 할인 계산
            } else {
                couponDiscount = parseFloat(selectedValue); // 금액 할인일 경우
            }
            console.log("2"+bamount);
            var finalPrice = originalPrice - couponDiscount; // 쿠폰 적용 후 최종 금액 계산
            console.log("3"+bamount);
            // 할인 금액 및 최종 결제 금액 표시 업데이트
            document.getElementById('discountAmount').textContent = couponDiscount.toLocaleString(); // 숫자를 콤마로 포맷
            document.getElementById('finalPrice').textContent = finalPrice.toLocaleString(); // 숫자를 콤마로 포맷

            console.log("Updated Coupon Discount: " + couponDiscount);
            console.log("Updated Final Price: " + finalPrice);
        }

        // 쿠폰 비활성화 여부 체크
        function checkCouponValidity() {
            var couponOptions = document.querySelectorAll("#coupon option");

            couponOptions.forEach(function (option) {
                var value = option.value;

                // 금액 쿠폰일 때, 판매가보다 크면 비활성화
                if (!value.includes('%') && parseFloat(value) >= originalPrice && value !== "0") {
                    option.disabled = true; // 비활성화
                    option.textContent += " (적용 불가)";
                }
            });
        }

        // 페이지 로드 후 쿠폰 비활성화 여부 체크
        window.onload = function () {
            checkCouponValidity();
        };

        function requestPay() {

            if ("${empty user}" == "true") {
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
                name: '${shop.getPName()}',
                amount: finalPrice, // 쿠폰 할인 적용된 최종 금액
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
                if (rsp.success) {
                    alert("결제 완료하였습니다.");
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "../buyList/buy.do",
                        method: "POST",
                        // headers: {
                        //     "Content-Type": "application/json"
                        // },
                        data: {
                            imp_uid: rsp.imp_uid, // 결제 고유번호
                            merchant_uid: rsp.merchant_uid // 주문번호
                        },
                        dataType: "json",
                        success: function (rsp) {

                            if (res.result > 0) {

                                location.href = "home.do";

                                return;
                            }
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
                amount: finalPrice, // 쿠폰 할인 적용된 최종 금액
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
                if (rsp.success) {
                    alert("결제 완료하였습니다.");
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "../buyList/buy.do",
                        method: "POST",
                        // headers: {
                        //     "Content-Type": "application/json"
                        // },
                        data: {
                            imp_uid: rsp.imp_uid, // 결제 고유번호
                            merchant_uid: rsp.merchant_uid // 주문번호
                        },
                        dataType: "json",
                        success: function (rsp) {

                            if (res.result > 0) {

                                location.href = "home.do";

                                return;
                            }
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
                amount: finalPrice, // 쿠폰 할인 적용된 최종 금액
                buyer_email: '${ user.id }',
                buyer_name: '${ user.name }',
                buyer_tel: '${ user.phone }',
                buyer_addr: '${ user.addr }',
                buyer_postcode: ''
            }, function (rsp) { // callback
                //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
                console.log(rsp);
                if (rsp.success) {
                    alert("결제 완료하였습니다.");
                    // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
                    // jQuery로 HTTP 요청
                    jQuery.ajax({
                        url: "../buyList/buy.do",
                        method: "GET",
                        // headers: {
                        //     "Content-Type": "application/json"
                        // },
                        data: {
                            imp_uid: rsp.imp_uid, // 결제 고유번호
                            merchant_uid: rsp.merchant_uid, // 주문번호
                            userIdx: "${ user.userIdx }",
                            pIdx: "${ shop.getPIdx() }",
                            // 수정 필요
                            bamount: bamount
                        },
                        dataType: "json",

                    }).done(function (data) {
                        // 가맹점 서버 결제 API 성공시 로직
                    })
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
            });

        } //end:kakaoPay()
    </script>

    <script>
        function updateTotalPrice() {
            document.querySelectorAll('.product-container').forEach(item => {
                const price = parseFloat(item.querySelector('.price').innerText);
                const quantity = parseInt(item.querySelector('input[type="number"]').value);
                finalPrice = price * quantity;
            });
            document.getElementById('finalPrice').textContent = finalPrice.toLocaleString();
        }

        document.querySelectorAll('input[type="number"]').forEach(input => {
            input.addEventListener('change', function () {
                const itemId = this.id.split('-')[1]; // ID에서 상품 ID 추출
                const newQuantity = this.value;

                // AJAX 요청 보내기
                fetch(`/user/updateQuantity1`, {
                        method: 'POST'
                    })
                    .then(response => {
                        if (response.ok) {
                            return response.json(); // 서버에서 JSON 응답을 받음
                        }
                        throw new Error('네트워크 오류 발생');
                    })
                    .then(data => {
                        console.log(data.message);
                        // 총 금액 업데이트
                        updateTotalPrice();
                    })
                    .catch(error => {
                        console.error('오류:', error);
                    });
            });
        });
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

                <!-- 쿠폰 선택 박스 -->
                <div class="option">
                    <label for="coupon">쿠폰 선택</label>
                    <select id="coupon" onchange="applyCoupon()">
                        <option value="0">쿠폰을 선택하세요</option>
                        <option value="5000">회원가입 축하 쿠폰: 5000원 할인</option>
                        <option value="10%">오픈 기념: 10% 할인</option>
                        <option value="5%">가을맞이 쿠폰 : 5% 할인</option>
                        <option value="1000">첫 이용 기념: 1000원 할인</option>
                    </select>
                </div>

                <!-- 가격 표시 -->
                <div class="price">
                    <p>판매가: <span id="price">${shop.getPrice()}</span>원</p>
                    <p>할인 금액: <span id="discountAmount">0</span>원</p>
                    <p>최종 결제 금액: <span id="finalPrice">${shop.getPrice()}</span>원</p>
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