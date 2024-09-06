<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
    <%@ include file="../menubar/navbar.jsp" %>
    <br><br><br><br><br>
    <div class="container div-size" style="min-height: 1000px;">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="row">
                    <div class="col-md-6">
                        <h2>리뷰 목록</h2>
                    </div>
                    <div class="col-md-6 text-right" style="margin-top: 20px;">
                        <c:if test="${ not empty user }">
                            <button type="button" class="btn btn-primary" onclick="location.href='reviewWriteForm.do'">리뷰 등록</button>
                        </c:if>
                    </div>
                </div>

                <table class="table table-striped" style="margin-top: 20px; table-layout: fixed;
                        ">
                    <thead>
                        <tr>
                            <th style="text-align: center;">작성자</th>
                            <th style="text-align: center;">내용</th>
                            <th style="width: 25%; text-align: center;">작성일</th>
                        </tr>
                    </thead>
                    <tbody style="background-color: white;">
                        <c:if test="${not empty user}">
                            <c:forEach var="vo" items="${list}">
                                <tr onclick="check_user('${vo.rvIdx}', '${vo.userIdx}');">
                                    <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                                        ${vo.name}</td>
                                    <td style="text-align: center; background-color: #f1f1f1; color: #303030;">
                                        ${vo.rvContent}</td>
                                    <td
                                        style="width: 25%; text-align: center; background-color: #f1f1f1; color: #303030;">
                                        ${vo.rvDate}
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
                <c:if test="${empty user}">
                    <h1 style="text-align: center; margin-top: 50px;">로그인 후에 이용해주세요.</h1>
                </c:if>
            </div>
        </div>
        <c:if test="${not empty user}">
            <!-- 페이지 메뉴 -->
            <div class="pagination-container" style="text-align: center;">
                <nav aria-label="Page navigation">
                    <ul class="pagination">${pageMenu}
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
</body>
</html>
