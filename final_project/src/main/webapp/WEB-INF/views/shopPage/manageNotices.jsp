<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
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
    <h2>공지사항 관리</h2>
    <table>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>관리</th>
        </tr>
        <%
            // 예시 데이터
            String[] notices = {"notice1", "notice2", "notice3"};
            for (String notice : notices) {
        %>
        <tr>
            <td><%= notice %></td>
            <td>공지 제목</td>
            <td>관리자</td>
            <td>2023-03-10</td>
            <td><button>수정</button> <button>삭제</button></td>
        </tr>
        <% } %>
    </table>
</body>

</html>
