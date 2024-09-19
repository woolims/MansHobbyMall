<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>공지사항 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>

        @media (max-width : 768px) {
            .login-container {
                margin-top: 50px;
            }
        }
    </style>
    <script>
        function nInsert(f) {

            //입력값 검증
            let inType = f.inType.value;
            let inContent = f.inContent.value;

            if (inType.trim() == '') {
                alert("제목을 입력하세요");
                f.inType.focus();
                return;
            }

            if (inContent.trim() == '') {
                alert("내용을 입력하세요");
                f.inContent.focus();
                return;
            }

            f.action = "${pageContext.request.contextPath}/admin/nInsert.do"; // 전송대상
            f.submit(); // 전송
        }

        function nInsertCancel() {
            if (confirm("등록을 취소하시겠습니까?\n내용은 저장되지 않습니다.") == false) return;
            location.href = '${pageContext.request.contextPath}/admin/admin.do'
        }
    </script>
</head>

<body>
    <%@ include file="../menubar/navbar.jsp" %>
    <br><br><br><br><br>
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0">
                <h2>공지사항 등록</h2>
                <form>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" class="form-control" value="" name="inType" id="inType" placeholder="제목을 입력하세요"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><textarea name="inContent" id="inContent" cols="50" rows="20" placeholder="내용을 입력하세요"></textarea></td>
                    </tr>
                    <input type="button" class="btn btn-primary" value="등록하기" onclick="nInsert(this.form);">
                    <input type="button" class="btn btn-danger" value="등록취소"onclick="nInsertCancel();">
                </form>
            </div>
        </div>
    </div>
</body>

</html>
