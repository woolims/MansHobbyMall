<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    <style>
        .ck-editor__editable {
                    min-height: 800px;
        }
        
        @media ( max-width : 768px) {
            .login-container {
                margin-top: 50px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="../menubar/navbar.jsp" %>

    <div class="container">
        <div class="row">
            <div class="col-md-12 col-md-offset-0">
                <h2>게시글 등록</h2>
                <form style="margin-top: 100px;">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" class="form-control" id="qnaTitle" name="qnaTitle" required>
                    </div>
                    <div class="form-group" style="color: black;">
                        <label for="content" style="color: white !important;">내용</label>
                        <div id="editor">
                        	<textarea name="qnaContent"></textarea>
                        </div>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="send(this.form)">등록</button>
                </form>
            </div>
        </div>
    </div>

    <script>
		let editor;
        // Classic Editor를 생성하고 설정
        ClassicEditor
            .create( document.querySelector( '#editor' ), {removePlugins: [ '' ], language: 'ko'} )
            .then(newEditor => {
                editor = newEditor;
            })
            .catch( error => {
                console.error( '에디터 로드 중 오류가 발생했습니다.', error );
            } );
    </script>
	<script>
		$(function() {
			$('#QnA').attr('class', 'active');
		});
	</script>
</body>
</html>