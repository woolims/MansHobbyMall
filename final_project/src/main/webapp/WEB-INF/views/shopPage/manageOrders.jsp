<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>주문 관리</title>
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
    <h2>주문 관리</h2>
    <table>
        <tr>
            <th>주문 번호</th>
            <th>회원 ID</th>
            <th>상품명</th>
            <th>수량</th>
            <th>주문일</th>
            <th>상태</th>
        </tr>
        <%
            // 예시 데이터
            String[] orders = {"order1", "order2", "order3"};
            for (String order : orders) {
        %>
        <tr>
            <td><%= order %></td>
            <td>user1</td>
            <td>상품 이름</td>
            <td>2개</td>
            <td>2023-02-15</td>
            <td>배송중</td>
        </tr>
        <% } %>
    </table>
</body>

</html>
