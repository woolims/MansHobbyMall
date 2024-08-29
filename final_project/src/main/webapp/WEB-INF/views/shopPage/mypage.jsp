<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
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
            }
        </style>
    </head>
    
    <body>
        <%@ include file="../menubar/navbar.jsp" %>
    
        <header>
            <div>
                <h1>My Page</h1>
                <ul>
                    <li><a href="#">장바구니</a></li>
                    <li><a href="#">구매내역</a></li>
                    <li><a href="#">배송조회</a></li>
                    <li><a href="#">정보수정</a></li>
                </ul>
            </div>
        </header>
    
        <div class="container">
            <div class="col-sm-12" style="background: #ccc; height: 800px; margin-bottom: 50px;">
            </div>
        </div>
    
        <!-- 푸터 -->
        <%@ include file="../menubar/footer.jsp" %>
    </body>
    
    </html>