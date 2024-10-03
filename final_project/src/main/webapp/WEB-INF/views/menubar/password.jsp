<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>MansHobby</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
      body {
        width: 70%;
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        color: #333;
        margin: 150px auto;
        padding: 20px;
      }

      h2 {
        text-align: center;
        color: black;
      }

      form {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
        max-width: 400px;
        margin: 0 auto;
      }

      div {
        margin-bottom: 15px;
      }

      label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
      }

      input[type="text"] {
        margin: auto;
        margin-top: 20px;
        width: calc(100% - 20px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
      }

      input[type="button"] {
        margin-top: 20px;
        background-color: #4caf50;
        color: white;
        padding: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
      }

      input[type="button"]:hover {
        background-color: #45a049;
      }

      input[type="radio"] {
        margin-right: 5px;
      }

      p {
        margin-top: 10px;
        margin: 10px 0;
      }
    </style>

    <script>
      function passwordSearch(f) {
        name = f.name.value.trim();
        id = f.id.value.trim();

        if (name == "") {
          alert("이름을 입력해주세요!");
          f.name.focus();
          return;
        }
        if (id == "") {
          alert("아이디를 입력해주세요!");
          f.id.focus();
          return;
        }

        $.ajax({
          url: "/passwordSearchAjax.do",
          data: { "name": name, "id": id },
          dataType: "json",
          method: "GET",
          success: function (res_data) {
            html = ``;
            if (res_data.length > 0) {
              $.each(res_data, function (index, vo) {
                html += `
                    <input type="radio" name="email" value="\${vo.email}" id="emailRadio">
                    <label for="emailRadio">\${vo.email}</label>`;
              });

              html += `
                    <p>비밀번호를 찾을 이메일을 선택하세요.</p>
                    <input type="button" id="sendEmail" value="선택완료" onclick="checkEmail()">`;

              $("#emailSearch").html(html);
            } else {
              console.log($("#name").val());
              console.log($("#id").val());
              alert(
                "이메일을 찾을 수 없습니다\n이름과 아이디를 다시 확인해주세요!"
              );
            }
          },
          error: function (err) {},
        });
      }

      function checkEmail() {
        let email = document.querySelector('input[name="email"]:checked');
        console.log(email);
        if (email) {
          alert("비밀번호를 전송했습니다");
          location.href = "sendEmail.do?email=" + email.value;
        } else {
          alert("이메일을 선택하세요.");
        }
      }
    </script>
  </head>

  <body>
    <h2>비밀번호 찾기</h2>

    <form>
      <div>
        <input type="text" id="name" name="name" placeholder="이름을 입력해주세요"/><br />
        <input type="text" id="id" name="id" placeholder="아이디를 입력해주세요"/><br />
        <input type="button" value="검색" onclick="passwordSearch(this.form)" />
      </div>
      <div id="emailSearch"></div>
    </form>
      
  </body>
</html>
