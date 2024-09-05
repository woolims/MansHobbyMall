<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <!-- Bootstrap 3.x-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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

            /* $$$$$$$$ */

            table {

                text-align: center;
                width: 100%;
                border-collapse: collapse;
            }

            th,
            td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
                width: 12.5%;
                /* 예시로 전체 열 너비를 12.5%로 설정 */
            }

            td {
                /* 필요에 따라 추가적인 스타일을 설정할 수 있습니다 */
            }

            #menu2 {
                margin: auto;
                width: 80%;
            }

            #menu2 td {

                text-align: center;
            }

            #menu2 th {

                text-align: center;
            }
        </style>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
            function confirmDelete(f) {
                if (confirm("정말 삭제하시겠습니까?") == false) return;


                f.action = "delete.do";
                f.submit();
            }


            function confirmProductDelete(f) {
                if (confirm("정말 삭제하시겠습니까?") == false) return;
                f.action = "pDelete.do";
                f.submit();
            }

            function pUpdate(f) {
                // let pIdx = f.pIdx.value;
                // let categoryName = f.categoryName.value;
                // let mcategoryName = f.mcategoryName.value;
                // let dcategoryName = f.dcategoryName.value;
                // let pName = f.pName.value;
                // let amount = f.amount.value;
                // let price = f.price.value;
                if (confirm("수정하시겠습니까?") == false) return;
                f.action = "pUpdateForm.do";
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
                                                <input type="button" value="삭제하기"
                                                    onclick="confirmProductDelete(this.form);">
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div id="menu2" class="tab-pane">
                    <h2>상품 관리</h2>

                    <c:choose>
                        <c:when test="${empty list}">
                            <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
                            <h1>내역이 없습니다.</h1>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="pVo" items="${pList}">
                                <table>

                                    <tr id="p_th">
                                        <th>상품번호</th>
                                        <th>대분류</th>
                                        <th>중분류</th>
                                        <th>소분류</th>
                                        <th>상품이름</th>
                                        <th>상품갯수</th>
                                        <th>상품가격</th>
                                    </tr>
                                    <tr>

                                        <td>${pVo.getPIdx()}</td>
                                        <td>${pVo.getCategoryName()}</td>
                                        <td>${pVo.getMcategoryName()}</td>
                                        <td>${pVo.getDcategoryName()}</td>
                                        <td>${pVo.getPName()}</td>
                                        <td>${pVo.getAmount()}</td>
                                        <td>${pVo.getPrice()}</td>
                                        <form>
                                            <input type="hidden" name="pIdx" value="${pVo.getPIdx()}">
                                            <input type="hidden" name="categoryName" value="${pVo.getCategoryName()}">
                                            <input type="hidden" name="mcategoryName" value="${pVo.getMcategoryName()}">
                                            <input type="hidden" name="dcategoryName" value="${pVo.getDcategoryName()}">
                                            <input type="hidden" name="pName" value="${pVo.getPName()}">
                                            <input type="hidden" name="amount" value="${pVo.getAmount()}">
                                            <input type="hidden" name="price" value="${pVo.getPrice()}">
                                            <input type="button" class="btn btn-default" value="수정"
                                                onclick="pUpdate(this.form);">
                                        </form>
                                        <form>
                                            <input type="hidden" name="pIdx" value="${pVo.getPIdx()}">
                                            <input type="button" class="btn btn-danger" value="삭제"
                                                onclick="confirmProductDelete(this.form);">
                                        </form>
                                    </tr>
                                </table>
                                <br>
                                <br>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>


                </div>
            </div>
            <!-- 푸터 -->
            <%@ include file="../menubar/footer.jsp" %>
    </body>

    </html>