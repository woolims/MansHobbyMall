<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>My Page</title>
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
            background: #fff;
            color: #000;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #fff 3px solid;
        }

        header a {
            color: #000;
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
            background: #ccc;
            margin-bottom: 50px;
            padding: 20px;
            min-height: 850px; /* 최소 높이 설정 */
        }


    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            $("header ul li").click(function () {
                var page = $(this).data("page");
                $.ajax({
                    url: page,
                    method: 'GET',
                    success: function (data) {
                        $("#content").html(data);
                    },
                    error: function () {
                        alert("삐빅 오류");
                    }
                });
            });
        });
    </script>
</head>

<body>
    <%@ include file="../menubar/navbar.jsp" %>

    <header>
        <div>
            <h1>My Page</h1>
            <ul>
                <li data-page="cart.do">장바구니</li>
                <li data-page="purchaseHistory.do">구매내역</li>
                <li data-page="shippingTracking.do">배송조회</li>
                <li data-page="accountInfo.do">정보수정</li>
            </ul>
        </div>
    </header>

    <div class="container">
        <div id="content" class="col-sm-12">
            <!-- Default content can be loaded here -->
            <div style="text-align: center;">
                <c:forEach var="i" begin="1" end="20" step="1">
                    <div style="border: 1px solid red; width: 180px; height: 200px; display: inline-block;  margin-top: 10px; text-align: center;">
                        이미지
                        <span>제목 ${i}</span>
                        <span>가격 ${i*300}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- 푸터 -->
    <%@ include file="../menubar/footer.jsp" %>
</body>

</html>
