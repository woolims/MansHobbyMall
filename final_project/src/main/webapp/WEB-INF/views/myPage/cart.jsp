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

</head>
<body>
    <header>
        <h1>장바구니</h1>
    </header>
    <main>
        <div class="cart-item">
            <input type="checkbox" id="item1" class="item-checkbox">
            <label for="item1" class="item-content">
                <img src="https://via.placeholder.com/100" alt="상품 이미지">
                <div class="item-details">
                    <h2>상품 이름</h2>
                    <p>가격: <span class="price">₩50,000</span></p>
                    <label for="quantity1">수량:</label>
                    <input type="number" id="quantity1" name="quantity1" value="1" min="1">
                </div>
                <button class="remove-btn">삭제</button>
            </label>
        </div>
        <div class="cart-summary">
            <p>총 합계: <span class="total-price">₩50,000</span></p>
            <button class="checkout-btn">결제하기</button>
        </div>
    </main>
</body>
</html>
