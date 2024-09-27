<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>구매 내역</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    margin: 0;
                    padding: 0;
                }

                .container {
                    width: 70%;
                    /* 테이블 너비를 70%로 설정 */
                    margin: 2rem auto;
                    padding: 1.5rem;
                    background-color: #fff;
                    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                }

                h1 {
                    text-align: center;
                    color: #1a1a1a;
                    font-size: 28px;
                    margin-bottom: 1.5rem;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                    background-color: white;
                    border-radius: 3px;
                    /* 테이블 모서리 둥글게 */
                    overflow: hidden;
                }

                thead th {
                    background-color: #1a1a1a;
                    color: white;
                    font-weight: bold;
                    padding: 12px 15px;
                    text-align: center;
                    border-bottom: 2px solid #ddd;
                }

                tbody td {
                    background-color: #f9f9f9;
                    padding: 12px;
                    text-align: center;
                    color: #333;
                    border: 1px solid #ddd;
                    /* 테두리 추가 */
                }

                tbody tr:nth-child(even) td {
                    background-color: #f1f1f1;
                    /* 짝수 행에 대한 배경색 */
                }

                tbody tr:hover td {
                    background-color: #aff0f8;
                    /* 마우스 오버 시 배경색 변경 */
                }

                td,
                th {
                    font-size: 16px;
                }

                /* 테이블에 간격을 추가해 더 깔끔한 느낌을 줌 */
                tbody td {
                    padding: 15px;
                }
            </style>


        </head>

        <body>
            <div class="container">
                <h1>구매 내역</h1>
            </div>
            <div class="container" style="width: 800px; min-height: 600px;">
                <table class="table table-striped" style="margin-top: 20px; table-layout: fixed;">
                    <thead>
                        <tr>
                            <th style="text-align: center;">상품번호</th>
                            <th style="text-align: center;">상품명</th>
                            <th style="text-align: center;">상품가격</th>
                            <th style="text-align: center;">구매 수량</th>
                            <th style="text-align: center;">구매 금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="buy" items="${buyList}">
                            <tr>
                                <td>${buy.getPIdx()}</td>
                                <td>${buy.getPName()}</td>
                                <td>${buy.getPrice()}</td>
                                <td>${buy.getBamount()}</td>
                                <td>${buy.getPrice() * buy.getBamount()}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>