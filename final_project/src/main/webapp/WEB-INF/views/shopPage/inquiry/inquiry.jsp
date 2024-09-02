<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>고객문의</title>
</head>

<body>
    <%@ include file="../../menubar/navbar.jsp" %>
    <br><br><br><br><br>
    <div class="container div-size" style="min-height: 1000px;">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="row">
                    <div class="col-md-6">
                        <h2>게시글 목록</h2>
                    </div>
                    <div class="col-md-6 text-right" style="margin-top: 20px;">
                        <c:if test="${ not empty user }">
                            <button type="button" class="btn btn-primary"
                                onclick="location.href='qna_write_form.do'">게시글 등록</button>
                        </c:if>
                    </div>
                </div>

                <!-- 상단 검색 창 -->
                <!-- <div class="search-container">
                      <form class="form-inline search-box">
                        <select id="search" class="form-control" onchange="changeFilter()">
                          <option value="all" <c:if test="${param.search == 'all'}">selected</c:if>>전체</option>
                          <option value="userName" <c:if test="${param.search == 'userName'}">selected</c:if>>이름</option>
                          <option value="qnaTitle" <c:if test="${param.search == 'qnaTitle'}">selected</c:if>>제목</option>
                          <option value="name_title" <c:if test="${param.search == 'name_title'}">selected</c:if>>이름+제목</option>
                        </select>
                        <input id="search_text" class="form-control" placeholder="검색어 입력" value="${param.search_text != 'null' ? param.search_text : ''}">
                        <button onclick="find()">검색</button>
                      </form>
                    </div> -->

                <table class="table table-striped" style="margin-top: 20px; table-layout: fixed;
                        ">
                    <thead>
                        <tr>
                            <th style="text-align: center;">번호</th>
                            <th style="width: 45%; text-align: center;">제목</th>
                            <th style="width: 25%; text-align: center;">작성일</th>
                            <th style="width: 20%; text-align: center;">답변 여부</th>
                        </tr>
                    </thead>
                    <tbody style="background-color: white;">
                        <c:if test="${empty user}">
                </table>
                <h1 style="text-align: center; margin-top: 50px;">로그인 후에 이용해주세요.</h1>

                </c:if>
                <c:if test="${not empty user}">
                    <c:forEach var="vo" items="${list}">
                        <tr onclick="check_user('${vo.inIdx}', '${vo.userIdx}');">
                            <td style="text-align: center; background-color: #303030; color: #f1f1f1;">${vo.inIdx}</td>
                            <td style="width: 45%; text-align: left; background-color: #303030; color: #f1f1f1;">
                                ${vo.qnaTitle}</td>
                            <td style="width: 25%; text-align: center; background-color: #303030; color: #f1f1f1;">
                                <fmt:formatDate value="${vo.inDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                            <td style="width: 20%; text-align: center; background-color: #303030; color: #f1f1f1;">
                                <c:choose>
                                    <c:when test="${answerMap[vo.inIdx] eq true}">답변 완료</c:when>
                                    <c:otherwise>답변 미완료</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
                </table>
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