<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>장바구니</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 0;
                    background-color: #f8f9fa;
                }

                header {
                    background-color: white;
                    color: #1a1a1a;
                    padding: 1rem;
                    text-align: center;
                    font-size: 1.5rem;
                }

                main {
                    padding: 2rem;
                    max-width: 1200px;
                    margin: 0 auto;
                }

                .cart-items {
                    width: 80%;
                    /* 너비를 80%로 줄임 */
                    background-color: white;
                    padding: 1.5rem;
                    border-radius: 10px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    margin: 0 auto 2rem auto;
                    /* 상단 0, 좌우 auto, 하단 2rem으로 중앙 정렬 */
                }

                .cart-item {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    flex-wrap: wrap;
                    /* 이 부분을 추가하여 큰 화면에서 깨지는 레이아웃 방지 */
                    background-color: #ffffff;
                    padding: 1.5rem;
                    border-radius: 10px;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    margin-bottom: 1.5rem;
                    position: relative;
                    /* 체크박스 위치 조정을 위한 상대 위치 */
                }

                .item-checkbox {
                    position: absolute;
                    top: 10px;
                    /* 이미지와 상단 간격 조정 */
                    left: 5px;
                    /* 이미지와 좌측 간격 조정 */
                    margin-right: 100px;
                    /* 간격 조정 */
                    transform: scale(1.2);
                    /* 체크박스 크기 약간 확대 */
                }

                .cart-item img {
                    width: 100px;
                    height: 100px;
                    object-fit: cover;
                    margin-left: 1rem;
                    margin-right: 1rem;
                    /* 이미지와 텍스트 사이 간격 조정 */
                }

                .item-content {
                    display: flex;
                    align-items: center;
                    flex: 1;
                    flex-wrap: wrap;
                    /* 상품 정보가 공간이 부족하면 아래로 내려가도록 */
                }

                .item-details {
                    flex: 1;
                    margin-left: 1rem;
                    text-align: left;
                    min-width: 150px;
                }

                .item-details h2 {
                    font-size: 18px;
                    margin: 0 0 10px;
                    color: #333;
                }

                .item-details p {
                    margin: 0;
                    color: #666;
                    font-size: 14px;
                }

                .item-controls {
                    margin-top: 10px;
                    font-size: 15px;
                    display: flex;
                    align-items: center;
                }

                .item-controls input[type="number"] {
                    width: 40px;
                    padding: 3px;
                    border: 1px solid #ddd;
                    text-align: center;
                }

                .remove-btn {
                    background-color: #e74c3c;
                    color: white;
                    border: none;
                    padding: 5px 12px;
                    font-size: 16px;
                    cursor: pointer;
                    border-radius: 5px;
                    margin-left: 1rem;
                    /* 삭제 버튼이 텍스트와 겹치지 않도록 간격 조정 */
                }

                .remove-btn:hover {
                    background-color: #c0392b;
                }

                .cart-summary {
                    width: 80%;
                    /* 너비를 80%로 설정 */
                    margin: 20px auto 0;
                    /* 상단 20px, 좌우 중앙 배치, 하단 0 */
                    text-align: right;

                }

                .cart-summary p {
                    font-size: 24px;
                }

                .checkout-btn {
                    background-color: #2ecc71;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    font-size: 1.2rem;
                    cursor: pointer;
                    border-radius: 5px;
                    width: 120px;
                    margin-top: 20px;
                }

                .checkout-btn:hover {
                    background-color: #27ae60;
                }

                .container {
                    width: 70%;
                    margin: 2rem auto;
                    padding: 1.5rem;
                    background-color: #fff;
                    border-radius: 10px;
                    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                }

                h1 {
                    text-align: center;
                    color: #1a1a1a;
                    font-size: 28px;
                    margin-bottom: 1.5rem;
                }

                header {
                    background: #fff;
                    color: #000;
                    padding-top: 30px;
                    min-height: 70px;
                    border-bottom: #fff 3px solid;
                    font-size: 1.4rem;
                    margin-bottom: 10px;
                    /* 간격을 줄이기 위해 margin-bottom을 추가 */
                }
            </style>
            <script>
                function updateTotalPrice() {
                    let totalPrice = 0;
                    document.querySelectorAll('.cart-item').forEach(item => {
                        const price = parseFloat(item.querySelector('.price').innerText);
                        const quantity = parseInt(item.querySelector('input[type="number"]').value);
                        totalPrice += price * quantity;
                    });
                    document.querySelector('.total-price').innerText = totalPrice;
                }

                document.querySelectorAll('input[type="number"]').forEach(input => {
                    input.addEventListener('change', function () {
                        const itemId = this.id.split('-')[1]; // ID에서 상품 ID 추출
                        const newQuantity = this.value;

                        // AJAX 요청 보내기
                        fetch(`/user/updateQuantity?scIdx=` + itemId + `&scamount=` + newQuantity, {
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

                // 페이지 로드 시 총 금액 초기 계산
                document.addEventListener('DOMContentLoaded', updateTotalPrice);

                function cartDelete(scIdx) {
                    if (confirm("장바구니에서 빼시겠습니까?") == false) return;

                    // AJAX 요청 보내기
                    fetch(`/user/cartDelete.do?scIdx=` + scIdx, {
                        method: 'DELETE'
                    })
                        .then(response => {
                            if (response.ok) {
                                return response.json(); // 서버에서 JSON 응답을 받음
                            }
                            throw new Error('네트워크 오류 발생');
                        })
                        .then(data => {
                            console.log(data.message);
                            const itemElement = document.getElementById(`item-` + scIdx);

                            if (itemElement) {
                                itemElement.closest('.cart-item').remove(); // itemElement가 null이 아닐 경우에만 closest 호출
                                // 총 금액 업데이트
                                updateTotalPrice();
                            } else {
                                console.error('아이템을 찾을 수 없습니다:', scIdx);
                            }
                        })
                        .catch(error => {
                            console.error('오류:', error);
                        });
                }
            </script>

        </head>

        <body>
            <header class="container">
                <h1>장바구니</h1>
            </header>
            <main>
                <section class="cart-items">
                    <c:set var="totalPrice" value="0" />
                    <c:forEach var="item" items="${cartList}">
                        <div class="cart-item">
                            <input type="checkbox" id="item-${item.getScIdx()}" class="item-checkbox">
                            <label for="item-${item.getScIdx()}" class="item-content">
                                <!--<img src="" alt="상품 이미지">  상품 이미지 URL -->
                                <img src="https://via.placeholder.com/100" alt="상품 이미지">
                                <div class="item-details">
                                    <h2>${item.getPName()}</h2>
                                    <p>상품 가격: <span class="price">${item.getPrice()}</span>원</p>
                                    <div class="item-controls">
                                        <label for="scamount-${item.getScIdx()}">수량:</label>
                                        <input type="number" id="scamount-${item.getScIdx()}" name="scamount"
                                            value="${item.getScamount()}" min="1">
                                    </div>
                                </div>
                                <button class="remove-btn" onclick="cartDelete('${item.getScIdx()}')">삭제</button>
                            </label>
                        </div>
                        <c:set var="totalPrice" value="${totalPrice + item.price * item.scamount}" />
                    </c:forEach>
                </section>


                <div class="cart-summary">
                    <p>총 합계: <span class="total-price">${totalPrice}</span></p> <!-- 총 합계 -->
                    <button class="checkout-btn">결제하기</button>
                </div>
            </main>
        </body>

        </html>