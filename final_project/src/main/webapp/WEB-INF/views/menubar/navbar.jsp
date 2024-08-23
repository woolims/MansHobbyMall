<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/navbar.css">
</head>
<body>
    

    <!-- 네비게이션 바 -->
    <nav class="navbar">
        <div class="logo">Logo</div>
        <ul class="menu">
            <li>
                <a href="#">메뉴 1</a>
                <ul class="dropdown">
                    <li><a href="#">서브 메뉴 1</a></li>
                    <li><a href="#">서브 메뉴 2</a></li>
                    <li><a href="#">서브 메뉴 3</a></li>
                </ul>
            </li>
            <li><a href="#">메뉴 2</a></li>
            <li><a href="#">메뉴 3</a></li>
            <li><input type="button" id="openModal" value="로그인"></li>
        </ul>
    </nav>

    <!-- 로그인 모달 -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>로그인</h2>
            <form>
                <input type="email" placeholder="이메일" required>
                <input type="password" placeholder="비밀번호" required>
                <div class="remember-me">
                    <input type="checkbox" id="remember">
                    <label for="remember">로그인상태유지</label>
                </div>
                <button type="submit" class="login-btn">로그인</button>
                <div class="links">
                    <a href="#">회원가입</a>
                    <a href="#">아이디 · 비밀번호 찾기</a>
                </div>
                <div class="divider">또는</div>
                <button type="button" class="social-btn naver-btn">네이버로 시작하기</button>
                <button type="button" class="social-btn kakao-btn">카카오로 시작하기</button>
                <button type="button" class="social-btn google-btn">Google로 시작하기</button>
            </form>
        </div>
    </div>

    <!-- 로그인 모달 기능 -->
    <script>

        const modal = document.getElementById("loginModal");
        const openModalBtn = document.getElementById("openModal");
        const closeModalBtn = document.getElementsByClassName("close")[0];

        // 모달 열기
        openModalBtn.onclick = function () {
        modal.style.display = "flex";
        };

        // 모달 닫기
        closeModalBtn.onclick = function () {
        modal.style.display = "none";
        };

        // 모달 외부 클릭 시 닫기
        window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        };

    </script>
</body>
</html>