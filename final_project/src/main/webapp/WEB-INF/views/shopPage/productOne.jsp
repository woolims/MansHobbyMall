<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>상품 상세 페이지</title>
                <!-- Bootstrap 3.x -->
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
                <style>
                    .container {
                        width: 73%;
                        margin-top: 102.2px;
                        background-color: #fff;
                        padding: 20px;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }

                    .product-container {
                        display: flex;
                        flex-wrap: wrap;
                        margin: 20px 0;
                    }

                    .product-image {
                        flex: 1;
                        padding: 20px;
                    }

                    .product-details {
                        flex: 2;
                        padding: 20px;
                    }

                    .product-image img {
                        max-width: 100%;
                        height: auto;
                    }

                    .product-details h1 {
                        font-size: 2em;
                        margin-bottom: 20px;
                    }

                    .product-details p {
                        font-size: 1.2em;
                        margin-bottom: 20px;
                    }

                    .product-details .price {
                        font-size: 1.5em;
                        color: black;
                    }

                    .product-details .add-to-cart {
                        background-color: #4CAF50;
                        color: white;
                        border: none;
                        padding: 15px 20px;
                        font-size: 1.2em;
                        cursor: pointer;
                        border-radius: 5px;
                    }

                    .product-details .add-to-cart:hover {
                        background-color: #45a049;
                    }
                </style>
                <script>
                    function addToCart() {
                        if ("${ empty user }" == "true") {

                            alert("장바구니는 로그인 후 이용가능합니다");

                            return;
                        } else {
                            alert('장바구니에 추가되었습니다!');
                        }


                    }
                </script>
            </head>

            <body>
                <!-- 메뉴바 -->
                <%@ include file="../menubar/navbar.jsp" %>
                    <div class="container">
                        <div class="product-container">
                            <div class="product-image">
                                <img id="product-image" src="" alt="상품 이미지">
                            </div>
                            <div class="product-details">
                                <h1 id="product-name">${shop.getPName()}</h1>
                                <p class="price" id="product-price">${shop.getPrice()} 원</p>
                                <button class="add-to-cart" onclick="addToCart()" style="margin-bottom: 20px;">장바구니에
                                    추가</button>
                                <p id="product-description">${shop.getPEx()}</p>
                            </div>
                        </div>
                        <!-- 푸터 -->
                        <%@ include file="../menubar/payment.jsp" %>
                    </div>
                    <a href="/review/review.do">리뷰 테스트</a>
            </body>

            </html>