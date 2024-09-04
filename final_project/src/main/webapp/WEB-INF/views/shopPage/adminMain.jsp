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

    <script>
        function confirmDelete(f) {
            if(confirm("정말 삭제하시겠습니까?") == false) return;


	        f.action="delete.do";
	        f.submit();
        }
    </script>

</head>

<body>
    <%@ include file="../menubar/navbar.jsp" %>
    <header>
        <div>
            <h1>Admin Dashboard</h1>
            <ul class="nav nav-tabs">
                <li class="disactive active"><a data-toggle="tab" href="#menu1">회원 관리</a></li>
                <li class="disactive"><a data-toggle="tab" href="#menu2">상품 관리</a></li>
                <li class="disactive"><a data-toggle="tab" href="#menu3">주문 관리</a></li>
                <li class="disactive"><a data-toggle="tab" href="#menu4">공지사항 관리</a></li>
            </ul>
        </div>
    </header>

    <div class="tab-content">
        <div id="menu1" class="tab-pane fade in active">
            <h2>회원 관리</h2>

            <c:choose>
            <c:when test="${empty list}">
                <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
                <h1>내역이 없습니다.</h1>
            </c:when>
                <c:otherwise>
                    <c:forEach var="vo" items="${list}">
                        <table>
                            <tr>
                                <th>회원 ID</th>
                                <th>이름</th>
                                <th>이메일</th>
                                <th>가입일</th>
                                <th>보유포인트</th>
                                <th>회원삭제</th>
                            </tr>
                            <tr>
                                <td>${vo.getId()}</td>
                                <td>${vo.getName()}</td>
                                <td>${vo.getEmail()}</td>
                                <td>${vo.getCreateAt()}</td>
                                <td>${vo.getPoint()}</td>
                                <td>
                                    <form>
                                        <input type="hidden" name="userIdx" value="${vo.getUserIdx()}">
                                        <input type="button" value="삭제하기" onclick="confirmDelete(this.form);">
                                    </form>
                                </td>
                            </tr>
                        </table>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
    </div>
    </div>

    

    <!-- 푸터 -->
    <%@ include file="../menubar/footer.jsp" %>
</body>

</html>
