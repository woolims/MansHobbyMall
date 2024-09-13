<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매 내역</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/accountInfo.css">

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
                        <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                            ${buy.getPIdx()}</td>
                        <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                            ${buy.getPName()}</td>
                        <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                            ${buy.getPrice()}</td>
                        <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                            ${buy.getBamount()}</td>
                        <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                            ${buy.getPrice() * buy.getBamount()}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
