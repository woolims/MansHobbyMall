<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>MansHobby</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
          data: { name: name, id: id },
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
          alert('비밀번호를 전송했습니다');
          location.href = "sendEmail.do?email=" + email.value;
        } else {
          alert("이메일을 선택하세요.");
        }
      }
    </script>
  </head>

  <body>
    <h2>비밀번호 찾기</h2>

    <form action="">
      <div>
        이름을 입력하세요 <br />
        <input type="text" id="name" name="name" /><br />
        아이디를 입력하세요 <br />
        <input type="text" id="id" name="id" /><br />
        <input type="button" value="검색" onclick="passwordSearch(this.form)" />
      </div>
    </form>
    <div id="emailSearch"></div>
  </body>
</html>
