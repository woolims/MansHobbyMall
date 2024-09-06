<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>리뷰 등록</title>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    <style>
        .ck-editor__editable {
            min-height: 800px;
        }

        @media (max-width : 768px) {
            .login-container {
                margin-top: 50px;
            }
        }
    </style>
    <script>
        function send1(f) {

            // 로그인이 안 되었으면
            if ("${ empty user }" == "true") {

                loginModal.style.display = 'flex';
                alert('로그아웃되었습니다.\n로그인하세요.')
                return;
            }

            //입력값 검증
            let inContent = editor.getData();

            // 에디터 데이터를 숨겨진 textarea에 설정
            f.inContent.value = inContent;

            if (inContent == '') {
                alert("내용을 입력하세요");
                f.inContent.value = '';
                f.inContent.focus();
                return;
            }

            f.action = "reviewWrite.do"; // 전송대상
            f.submit(); // 전송
        }
    </script>
</head>

<body>
    <%@ include file="../menubar/navbar.jsp" %>
    <br><br><br><br><br>
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0">
                <h2>리뷰 등록</h2>
                <form>
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" class="form-control" id="inType" name="inType" required>
                    </div>
                    <div class="form-group" style="color: black;">
                        <label for="content" style="color: white;">내용</label>
                        <div id="editor">
                            <textarea name="inContent"></textarea>
                        </div>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="send1(this.form)">등록</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        let editor;
        // Classic Editor를 생성하고 설정
        ClassicEditor
            .create(document.querySelector('#editor'), {
                removePlugins: [''],
                language: 'ko'
            })
            .then(newEditor => {
                editor = newEditor;
            })
            .catch(error => {
                console.error('에디터 로드 중 오류가 발생했습니다.', error);
            });
    </script>
</body>

</html>