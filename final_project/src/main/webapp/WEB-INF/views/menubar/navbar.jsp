<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>MansHobby</title>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <!-- Bootstrap 3.x -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

      <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/navbar.css" />
      <script type="text/javascript">
        //javascript 초기화
        //window.onload = function(){};

        //jQuery 초기화
        $(document).ready(function () {

          //showMessage();
          setTimeout(showMessage, 100);//0.1초후에 메시지 띄워라

        });

        function showMessage() {
          // /member/login_form.do?reason=fail_id => "true"
          if ("${ param.reason == 'fail_id'}" == "true") {
            loginModal.style.display = "flex";
            alert("아이디가 틀립니다.");
          }

          // /member/login_form.do?reason=fail_pwd => "true"
          if ("${ param.reason == 'fail_pwd'}" == "true") {
            loginModal.style.display = "flex";
            alert("비밀번호가 틀립니다.");
          }

          // /member/login_form.do?reason=session_timeout
          if ("${ param.reason == 'session_timeout'}" == "true") {
            loginModal.style.display = "flex";
            alert("로그아웃되었습니다.\n로그인하세요.");
          }

        }

      </script>
      <script>
        function send(f) {

          let id = f.id.value.trim();
          let password = f.password.value.trim();

          if (id == '') {
            alert("아이디를 입력하세요!!");
            f.id.value = "";
            f.id.focus();
            return;
          }

          if (password == '') {
            alert("비밀번호를 입력하세요!!");
            f.password.value = "";
            f.password.focus();
            return;
          }


          f.action = "user/login.do";
          f.submit();

        }//end:send()

        function check_id() {

          //회원가입 버튼은 비활성화
          // <input id="btn_register" type="button" ...  disabled="disabled">
          $("#btn_register").prop("disabled", true);


          //           document.getElementById("mem_id").value
          let re_id = $("#re_id").val();

          if (re_id.length == 0) {

            $("#id_msg").html("");
            return;
          }


          if (re_id.length < 3) {

            $("#id_msg").html("id는 3자리 이상 입력하세요").css("color", "red");
            return;
          }

          //서버에 현재 입력된 ID를 체크요청(jQuery Ajax이용)
          $.ajax({
            url: "user/check_id.do",     //MemberCheckIdAction
            data: { "id": re_id }, //parameter   => check_id.do?mem_id=one
            dataType: "json",
            success: function (res_data) {
              // res_data = {"result": true}  or {"result": false}
              if (res_data.result) {

                $("#id_msg").html("사용가능한 아이디 입니다").css("color", "blue");

                //가입버튼 활성화
                $("#btn_register").prop("disabled", false);

              } else {

                $("#id_msg").html("이미 사용중인 아이디 입니다").css("color", "red");

              }
            },
            error: function (err) {
              alert(err.responseText);
            }
          });
        }//end:check_id()

        function find_addr() {

          var themeObj = {
            bgColor: "#B51D1D" //바탕 배경색
          };

          new daum.Postcode({
            theme: themeObj,
            oncomplete: function (data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
              // 예제를 참고하여 다양한 활용법을 확인해 보세요.
              $("#addr").val(data.zonecode); //우편번호 넣기
              $("#subAddr").val(data.address);     //주소넣기

            }
          }).open();
        }//end:find_addr()

        function registerUser(f) {
          let re_id = f.re_id.value.trim();
          let re_password = f.re_password.value.trim();
          let nickName = f.nickName.value.trim();
          let name = f.name.value.trim();
          let phone = f.phone.value.trim();
          let addr = f.addr.value.trim();
          let subAddr = f.subAddr.value.trim();

          if (re_id == '') {
            alert("아이디를 입력하세요.");
            f.re_id.value = "";
            f.re_id.focus();
            return;
          }

          if (re_password == '') {
            alert("비밀번호를 입력하세요.");
            f.re_password.value = "";
            f.re_password.focus();
            return;
          }

          if (nickName == '') {
            alert("닉네임을 입력하세요.");
            f.nickName.value = "";
            f.nickName.focus();
            return;
          }

          if (name == '') {
            alert("이름을 입력하세요.");
            f.name.value = "";
            f.name.focus();
            return;
          }

          if (phone == '') {
            alert("전화번호를 입력하세요.");
            f.phone.value = "";
            f.phone.focus();
            return;
          }

          if (addr == '') {
            alert("주소를 입력하세요.");
            f.addr.value = "";
            f.addr.focus();
            return;
          }

          f.action = "user/insert.do";
          f.submit();
        }//end:registerUser()

      </script>

    </head>

    <body>
      <!-- 네비게이션 바 -->
      <nav class="navbar">
        <div class="logo col-sm-2" style="display: inline-block;"><a href="home.do">Logo</a></div>
        <div class="col-sm-10" style="display: inline-block; margin-top: 10px;">
          <ul class="menu" style="text-align: right !important;">
            <li>
              <a href="game.do">Gaming</a>
              <ul class="dropdown">
                <li><a href="#">게임 메뉴 1</a></li>
                <li><a href="#">게임 메뉴 2</a></li>
                <li><a href="#">게임 메뉴 3</a></li>
              </ul>
            </li>
            <li>
              <a href="${ pageContext.request.contextPath }/sports.do">Sports</a>
              <ul class="dropdown">
                <li><a href="#">스포츠 메뉴 1</a></li>
                <li><a href="#">스포츠 메뉴 2</a></li>
                <li><a href="#">스포츠 메뉴 3</a></li>
              </ul>
            </li>
            <li><a href="#">고객문의</a></li>
            <c:if test="${ not empty user }">
              <c:if test="${ user.getName() ne '관리자'}">
                <li><a href="mypage.do">마이페이지</a></li>
              </c:if>
              <c:if test="${ user.getName() eq '관리자'}">
                <li><a href="#">관리페이지</a></li>
              </c:if>
            </c:if>
            <!-- 로그인이 안 된 경우 -->
            <c:if test="${ empty user }">
              <li><input type="button" id="openLoginModal" value="로그인" />
              </li>
            </c:if>
            <!-- 로그인이 된 경우 -->
            <c:if test="${ not empty user }">
              <li id="userStatus"><b>${ user.nickName }님</b></li>
              <li><a onclick="location.href='../user/logout.do'">로그아웃</a></li>
            </c:if>
          </ul>
        </div>
      </nav>

      <!-- 로그인 모달 -->
      <div id="loginModal" class="modal">
        <div class="modal-content">
          <span class="close">&times;</span>
          <h2>로그인</h2>
          <form>
            <input type="text" name="id" id="id" placeholder="아이디" required />
            <input type="password" name="password" id="password" placeholder="비밀번호" required />
            <input type="button" class="login-btn" value="로그인" onclick="send(this.form);" />
            <div class="links">
              <input type="button" class="register-btn" id="openRegisterModal" value="회원가입" />
              <a href="#">아이디 · 비밀번호 찾기</a>
            </div>
            <div class="divider">또는</div>
            <button type="button" class="social-btn naver-btn">
              네이버로 시작하기
            </button>
            <button type="button" class="social-btn kakao-btn">
              카카오로 시작하기
            </button>
            <button type="button" class="social-btn google-btn">
              Google로 시작하기
            </button>
          </form>
        </div>
      </div>

      <!-- 회원가입 모달 -->
      <div id="registerModal" class="modal">
        <div class="modal-content">
          <span class="close">&times;</span>
          <h2>회원가입</h2>
          <form>
            <input type="text" id="re_id" name="re_id" placeholder="아이디" onkeyup="check_id();" required /><span
              id="id_msg"></span>
            <input type="password" id="re_password" name="re_password" placeholder="비밀번호" required />
            <input type="text" id="nickName" name="nickName" placeholder="닉네임" required />
            <input type="text" id="name" name="name" placeholder="이름" required />
            <input type="text" id="phone" name="phone" placeholder="전화번호(ex.010-1234-1234)" required />
            <input type="text" id="addr" name="addr" placeholder="주소" required />
            <input type="text" id="subAddr" name="subAddr" placeholder="상세주소" required />
            <input type="button" id="btn_register" class="login-btn" value="회원가입" disabled="disabled"
              onclick="registerUser(this.form);" />
            <!-- <input type="button" class="login-btn" value="회원가입" onclick="registerUser(this.form);" /> -->

            <div class="divider">또는</div>
            <button type="button" class="social-btn naver-btn">
              네이버로 시작하기
            </button>
            <button type="button" class="social-btn kakao-btn">
              카카오로 시작하기
            </button>
            <button type="button" class="social-btn google-btn">
              Google로 시작하기
            </button>
          </form>
        </div>
      </div>
      <script>
        // 로그인 모달 기능
        const loginModal = document.getElementById("loginModal");
        const openLoginModalBtn = document.getElementById("openLoginModal");
        const closeLoginModalBtn = document.getElementsByClassName("close")[0];

        const registerModal = document.getElementById("registerModal");
        const openRegisterModalBtn = document.getElementById("openRegisterModal");
        const closeRegisterModalBtn = document.getElementsByClassName("close")[1];

        // 모달 열기
        openLoginModalBtn.onclick = function () {
          loginModal.style.display = "flex";
        };

        // 모달 닫기
        closeLoginModalBtn.onclick = function () {
          loginModal.style.display = "none";
        };

        // 모달 열기
        openRegisterModalBtn.onclick = function () {
          loginModal.style.display = "none";
          registerModal.style.display = "flex";
        };

        // 모달 닫기
        closeRegisterModalBtn.onclick = function () {
          registerModal.style.display = "none";
        };
      </script>
    </body>

    </html>