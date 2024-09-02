<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
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
    <h2>회원 관리</h2>
    <table>
        <tr>
            <th>회원 ID</th>
            <th>이름</th>
            <th>이메일</th>
            <th>가입일</th>
            <th>관리</th>
        </tr>
        <%
            // 예시 데이터
            String[] users = {"user1", "user2", "user3"};
            for (String user : users) {
        %>
        <tr>
            <td><%= user %></td>
            <td>홍길동</td>
            <td>hong@domain.com</td>
            <td>2023-01-01</td>
            <td><button>삭제</button></td>
        </tr>
        <% } %>
    </table>
</body>

</html>
