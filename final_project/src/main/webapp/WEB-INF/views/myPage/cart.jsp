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
        }

        header {
            background-color: #f4f4f4;
            padding: 1rem;
            text-align: center;
        }

        main {
            padding: 1rem;
        }

        .cart-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 1rem 0;
        }

        .item-checkbox {
            margin-right: 1rem;
            flex-shrink: 0; /* Prevent checkbox from shrinking */
        }

        .item-content {
            display: flex;
            align-items: center;
            flex: 1;
        }

        .cart-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 1rem;
        }

        .item-details {
            flex: 1;
        }

        .remove-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            cursor: pointer;
        }

        .remove-btn:hover {
            background-color: #c0392b;
        }

        .cart-summary {
            margin-top: 1rem;
            text-align: right;
        }

        .total-price {
            font-weight: bold;
        }

        .checkout-btn {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            cursor: pointer;
            font-size: 1.1rem;
        }

        .checkout-btn:hover {
            background-color: #27ae60;
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
            input.addEventListener('change', function() {
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
                const itemElement = document.getElementById(`item-`+scIdx);

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
    <header>
        <h1>장바구니</h1>
    </header>
    <main>
        <c:set var="totalPrice" value="0" />
        <c:forEach var="item" items="${cartList}">
            <div class="cart-item">
                <input type="checkbox" id="item-${item.getScIdx()}" class="item-checkbox">
                <label for="item-${item.getScIdx()}" class="item-content">
                    <img src="" alt="상품 이미지"> <!-- 상품 이미지 URL -->
                    <div class="item-details">
                        <h2>${item.getPName()}</h2> <!-- 상품 이름 -->
                        <p>상품 가격: <span class="price">${item.getPrice()}</span></p> <!-- 상품 가격 -->
                        <label for="quantity-${item.getPIdx()}">수량:</label>
                        <input type="number" id="scamount-${item.getScIdx()}" name="scamount" value="${item.getScamount()}" min="1"> <!-- 수량 -->
                    </div>
                    <button class="remove-btn" onclick="cartDelete('${item.getScIdx()}')">삭제</button>
                </label>
            </div>
            <c:set var="totalPrice" value="${totalPrice + item.price * item.scamount}" />
        </c:forEach>

        <div class="cart-summary">
            <p>총 합계: <span class="total-price">${totalPrice}</span></p> <!-- 총 합계 -->
        </div>
    </main>
</body>
</html>
