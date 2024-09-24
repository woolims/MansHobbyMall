<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배송지 관리</title>
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

        .address-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 1rem 0;
        }

        .address-content {
            flex: 1;
            margin-left: 1rem;
        }

        .address-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .edit-btn, .delete-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            cursor: pointer;
            margin-bottom: 0.5rem;
            width: 100px;
        }

        .delete-btn {
            background-color: #e74c3c;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .add-address-btn {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            cursor: pointer;
            font-size: 1.1rem;
            margin-top: 1rem;
        }

        .add-address-btn:hover {
            background-color: #27ae60;
        }
    </style>

    <script>
        
    </script>
</head>
<body>
    <header>
        <h1>배송지 관리</h1>
    </header>
    <main>
        <c:forEach var="address" items="${addressList}">
            <div class="address-item" id="">
                <div class="address-content">
                    <h2>양금모</h2> <!-- 수령인 이름 -->
                    <p>전화번호: </p> <!-- 전화번호 -->
                    <p>주소: </p> <!-- 주소 및 우편번호 -->
                </div>
                <div class="address-actions">
                    <button class="edit-btn" onclick="">수정</button>
                    <button class="delete-btn" onclick="">삭제</button>
                </div>
            </div>
        </c:forEach>

        <button class="add-address-btn" onclick="">새 주소 추가</button>
    </main>
</body>
</html>
