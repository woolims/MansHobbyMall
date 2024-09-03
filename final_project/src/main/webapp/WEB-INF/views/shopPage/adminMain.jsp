<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Admin Page</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        header {
            background: #333;
            color: #fff;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #ccc 3px solid;
        }

        header a {
            color: #fff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
        }

        header ul {
            margin: 50px;
            padding: 0;
            list-style: none;
            text-align: center;
        }

        header ul li {
            display: inline;
            margin: 0 50px;
            cursor: pointer;
        }

        #content {
            background: #fff;
            height: 850px;
            margin-bottom: 50px;
            padding: 20px;
        }

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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>
    <header>
        <div>
            <h1>Admin Dashboard</h1>
            <ul>
                <li data-page="manageUsers.jsp">회원 관리</li>
                <li data-page="manageProducts.jsp">상품 관리</li>
                <li data-page="manageOrders.jsp">주문 관리</li>
                <li data-page="manageNotices.jsp">공지사항 관리</li>
            </ul>
        </div>
    </header>

    <div class="container">
        <div id="content" class="col-sm-12">
            <!-- 기본적으로 로드할 초기 컨텐츠 -->
            <h2>관리자 페이지에 오신 것을 환영합니다.</h2>
            <p>위 메뉴에서 관리할 항목을 선택하세요.</p>
        </div>
    </div>

    

    <!-- 푸터 -->
    <%@ include file="../menubar/footer.jsp" %>
</body>

</html>
