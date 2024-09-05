<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <%@ include file="../menubar/navbar.jsp" %>
    <br><br><br><br><br>
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0" style="margin-bottom: 50px;">
                <div class="panel-heading" style="margin-bottom: 20px; margin-top: 50px;">
                    <h3 class="panel-title" style="font-size: 30px;">제목 : ${ vo.inType }</h3>
                    <!-- <div style="display: inline-block; float: right;">
                        <c:if test="${ (user.id eq 'admin') or (user.userIdx eq vo.userIdx) }">
                            <input class="btn btn-success" type="button" value="수정" onclick="location.href='inquiryModifyForm.do?inIdx=${ vo.inIdx }'">
                            <input class="btn btn-danger" type="button" value="삭제" onclick="del(${ vo.inIdx });">
                        </c:if>
                    </div> -->
                </div>
                <br>
                <div class="panel panel-default" style="background-color: #303030; color: #f1f1f1;">
                    <div class="panel-body" style="min-height: 500px;">
                        <p><strong>작성자:</strong> ${ vo.name }</p>
                        <p><strong>작성일:</strong> ${ vo.inDate }</p>
                        <hr>
                        <p>${ vo.inContent }</p>
                    </div>
                </div>
                <button style="background-color: #303030; color: #f1f1f1;" type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/inquiry/inquiry.do'">목록으로 돌아가기</button>
            </div>
        </div>
</body>
</html>