<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>상품 관리</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
    <h2>상품 관리</h2>
    <table>
        <tr>
            <th>상품 ID</th>
            <th>상품명</th>
            <th>가격</th>
            <th>재고</th>
            <th>관리</th>
        </tr>
        <%
            // 예시 데이터
            String[] products = {"prod1", "prod2", "prod3"};
            for (String product : products) {
        %>
        <tr>
            <td><%= product %></td>
            <td>상품 이름</td>
            <td>10000원</td>
            <td>50개</td>
            <td><button>수정</button> <button>삭제</button></td>
        </tr>
        <% } %>
    </table>
</body>

</html>
