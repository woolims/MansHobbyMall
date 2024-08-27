<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>MansHobby</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link
      rel="stylesheet"
      href="${ pageContext.request.contextPath }/resources/css/navbar.css"
    />
  <script>
      function send(f){
        
        let id   = f.id.value.trim();
        let password  = f.password.value.trim();
        
        if(id==''){
          alert("아이디를 입력하세요!!");
          f.id.value="";
          f.id.focus();
          return;
        }
        
        if(password==''){
          alert("비밀번호를 입력하세요!!");
          f.password.value="";
          f.password.focus();
          return;
        }
            
        
        f.action="user/login.do";
        f.submit();
        
      }//end:send()
    </script>
    <script type="text/javascript">
      //javascript 초기화
      //window.onload = function(){};
      
      //jQuery 초기화
      $(document).ready(function(){
        
        //showMessage();
        setTimeout(showMessage,100);//0.1초후에 메시지 띄워라
        
      });
      
      function showMessage(){
        // /member/login_form.do?reason=fail_id => "true"
        if("${ param.reason == 'fail_id'}" == "true"){
          alert("아이디가 틀립니다!!");
        }		
        
        // /member/login_form.do?reason=fail_pwd => "true"
        if("${ param.reason == 'fail_pwd'}" == "true"){
          alert("비밀번호가 틀립니다!!");
        }	
        
        // /member/login_form.do?reason=session_timeout
        if("${ param.reason == 'session_timeout'}" == "true"){
          alert("로그아웃되었습니다\n로그인후 사진을 등록하세요!!");
        }	
        
      }
    
    </script>
  </head>
  <body>
    <!-- 네비게이션 바 -->
    <nav class="navbar">
      <div class="logo"><a href="home.do">Logo</a></div>
      <ul class="menu">
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
        <li><a href="#">메뉴 2</a></li>
        <li><a href="#">메뉴 3</a></li>
        <!-- 로그인이 안 된 경우 -->
        <c:if test="${ empty user }">
          <li><input type="button" id="openLoginModal" value="로그인" />
          </li>
        </c:if>
        <!-- 로그인이 된 경우 -->
        <c:if test="${ not empty user }">
          <li><b>${ user.nickName }</b>님<input type="button" value="로그아웃" onclick="location.href='../user/logout.do'"></li>
        </c:if>
      </ul>
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
          <input type="email" name="email" placeholder="이메일" required />
          <input
            type="password"
            name="password"
            placeholder="비밀번호"
            required
          />
          <input type="text" name="nickName" placeholder="닉네임" required />
          <input type="text" name="name" placeholder="이름" required />
          <input type="text" name="phone" placeholder="전화번호" required />
          <input type="text" name="addr" placeholder="주소" required />
          <input type="text" name="addr" placeholder="상세주소" required />
          <button type="submit" class="login-btn">회원가입</button>

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

      // 모달 외부 클릭 시 닫기
      window.onclick = function (event) {
        if (event.target == loginModal) {
          loginModal.style.display = "none";
        }
        if (event.target == registerModal) {
          registerModal.style.display = "none";
        }
      };

      //   회원가입 모달 기능

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
