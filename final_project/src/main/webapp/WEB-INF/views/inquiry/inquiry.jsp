<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>고객문의</title>
</head>

<script type="text/javascript">
    function find() {
        
        let search = $("#search").val();
        let search_text = $("#search_text").val().trim();

        if (search === "all") {
            location.href = "inquiry.do";
            return;
        }

        if (search_text === "") {
            alert("검색어를 입력하세요!!");
            $("#search_text").focus();
            return;
        }

        // JavaScript에서 직접 사용
        location.href = "inquiry.do?search=" + search + "&search_text=" + search_text;
    }

    function changeFilter() {
        let search = $("#search").vuserIdxal();
        if (search === "all") {
            location.href = "inquiry.do";
        }
    }

    function check_user(inIdx, userIdx) {
        // JSP에서 자바스크립트로 값을 전달하기 위해 변수로 변환
        var currentUserIdx = "${not empty user ? user.userIdx : -1}";
        var isAdmin = (currentUserIdx == 1);  // 관리자 확인

        // 사용자가 관리자이거나 본인인지 확인
        if ((userIdx == currentUserIdx || isAdmin) && currentUserIdx != -1) {
            location.href = "inquirySelect.do?inIdx=" + inIdx;
        } else {
            alert("해당 내용은 관리자와 본인만 확인 가능합니다.");
        }
    }
</script>

<body>
    <%@ include file="../menubar/navbar.jsp" %>
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
                                onclick="location.href='inquiryWriteForm.do'">게시글 등록</button>
                        </c:if>
                    </div>
                </div>

                <!-- 상단 검색 창 -->
                <div class="search-container">
                    <form class="form-inline search-box">
                        <select id="search" class="form-control" onchange="changeFilter()">
                            <option value="all" <c:if test="${param.search == 'all'}">selected</c:if>>전체</option>
                            <option value="name" <c:if test="${param.search == 'name'}">selected</c:if>>이름
                            </option>
                            <option value="inType" <c:if test="${param.search == 'inType'}">selected</c:if>>제목
                            </option>
                            <option value="name_title" <c:if test="${param.search == 'name_title'}">selected</c:if>
                                >이름+제목</option>
                        </select>
                        <input id="search_text" class="form-control" placeholder="검색어 입력"
                            value="${param.search_text != 'null' ? param.search_text : ''}">
                        <button onclick="find()">검색</button>
                    </form>
                </div>

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
                        <c:if test="${not empty user}">
                            <c:forEach var="vo" items="${list}">
                                <tr onclick="check_user('${vo.inIdx}', '${vo.userIdx}');">
                                    <td style="text-align: center; background-color: #303030; color: #f1f1f1;">
                                        ${vo.inIdx}</td>
                                    <td
                                        style="width: 45%; text-align: center; background-color: #303030; color: #f1f1f1;">
                                        ${vo.inType}</td>
                                    <td
                                        style="width: 25%; text-align: center; background-color: #303030; color: #f1f1f1;">
                                        ${vo.inDate}
                                    </td>
                                    <td
                                        style="width: 20%; text-align: center; background-color: #303030; color: #f1f1f1;">
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