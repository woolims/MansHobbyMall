<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 조회</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/accountInfo.css">

</head>
<body>
    <div class="container">
        <h1>배송 조회</h1>
    </div>
    <div class="container" style="width: 800px; min-height: 600px;">
        <table class="table table-striped" style="margin-top: 20px; table-layout: fixed;">
            <thead>
                <tr>
                    <th style="text-align: center;">상품명</th>
                    <th style="text-align: center;">구매자</th>
                    <th style="text-align: center;">배송상태</th>
                </tr>
            </thead>
            <tbody>
                    <c:forEach var="orders" items="${orderList}">
                        <tr>
                            <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                                ${orders.getPName()}</td>
                            <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                                ${orders.getName()}</td>
                            <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                                ${orders.getDsContent()}</td>
                        </tr>
                    </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
