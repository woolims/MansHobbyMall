<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>게시물 상세</title>
</head>
<script>
    function del(inIdx) {
        if (confirm('정말 삭제 하시겠습니까?') == false) return;
        location.href = "inquiryDelete.do?inIdx=" + encodeURIComponent(inIdx);
    }

    function comment_insert() {
        // 로그인이 안 되었으면
        if ("${ empty user }" == "true") {

            loginModal.style.display = 'flex';
            alert('로그아웃되었습니다.\n로그인하세요.')
            return;
        }

        let aContent = $("#aContent").val().trim();
        if (aContent == '') {
            alert("댓글 내용을 입력하세요!!");
            $("#aContent").val("");
            $("#aContent").focus();
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/answer/insert.do",
            data: {
                aContent: aContent,
                inIdx: "${vo.inIdx}",
                userIdx: "${sessionScope.user.userIdx}",
                name: "${sessionScope.user.name}"
            },
            dataType: "json",
            success: function (res_data) {
                $("#aContent").val("");
                if (res_data.result == false) {
                    alert("댓글 등록 실패!!");
                    return;
                }
            },
            error: function (err) {
                alert(err.responseText);
            }
        });
    }

    function comment_delete(aIdx, btn) {
        if (confirm("정말 삭제하시겠습니까?") == false) return;

        $(btn).prop('disabled', true); // 버튼 비활성화하여 중복 클릭 방지

        $.ajax({
            url: "${pageContext.request.contextPath}/answer/delete.do",
            data: {
                "aIdx": aIdx
            },
            dataType: "json",
            success: function (res_data) {
                $(btn).prop('disabled', false); // 버튼 다시 활성화

                if (res_data.result == false) {
                    alert("삭제 실패!!");
                    return;
                }
            },
            error: function (err) {
                $(btn).prop('disabled', false); // 버튼 다시 활성화
                alert(err.responseText);
            }
        });
    }

    $(document).ready(function () {
        comment_list(1); // 페이지 로드 시 첫 페이지 댓글 목록을 로드
    });
</script>

<body>
    <%@ include file="../menubar/navbar.jsp" %>
    <br><br><br><br><br>
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0" style="margin-bottom: 50px;">
                <div class="panel-heading" style="margin-bottom: 20px; margin-top: 50px;">
                    <h3 class="panel-title" style="font-size: 30px;">제목 : ${ vo.inType }</h3>
                    <div style="display: inline-block; float: right;">
                        <c:if test="${ (user.id eq 'admin') or (user.userIdx eq vo.userIdx) }">
                            <input class="btn btn-success" type="button" value="수정"
                                onclick="location.href='inquiryModifyForm.do?inIdx=${ vo.inIdx }'">
                            <input class="btn btn-danger" type="button" value="삭제" onclick="del('${ vo.inIdx }');">
                        </c:if>
                    </div>
                </div>
                <br>
                <div class="panel panel-default" style="background-color: #8f8f8fed; color: #f1f1f1;">
                    <div class="panel-body" style="min-height: 500px;">
                        <p><strong>작성자:</strong> ${ vo.name }</p>
                        <p><strong>작성일:</strong> ${ vo.inDate }</p>
                        <hr>
                        <p>${ vo.inContent }</p>
                    </div>
                </div>
                <button style="background-color: #303030; color: #f1f1f1;" type="button" class="btn btn-default"
                    onclick="location.href='${pageContext.request.contextPath}/inquiry/inquiry.do'">목록으로 돌아가기</button>
            </div>
        </div>

        <!-- 댓글 섹션 -->
        <div class="comment-section" style="color: black;">
            <div class="comment-section-header">
                <h5 style="font-weight: bold; margin-bottom: 10px;">댓글</h5>
            </div>

            <!-- 댓글 작성 폼 -->
            <div class="comment-form" style="color: #f1f1f1;">
                <textarea style="background-color: #303030; color: #f1f1f1;" class="form-control" id="aContent"
                    placeholder="댓글을 작성하세요"></textarea>
                <button class="btn btn-primary" onclick="comment_insert();" style="align-self: flex-end;">등록</button>
            </div>

            <!-- 댓글 목록 -->
            <div id="comment_display" style="background-color: #303030; color: #f1f1f1;"></div>
        </div>
    </div>
</body>

</html>