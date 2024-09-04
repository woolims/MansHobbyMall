<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <!-- 절대 경로 바꾸기 -->
            <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/home.css">

            <title>MansHobby</title>

        </head>

        <body>

            <!-- 헤더 -->
            <%@ include file="menubar/navbar.jsp" %>

                <!-- 메인 섹션 -->
                <section class="main-section">
                    <div class="image-container">
                        <div class="image-box" style="background-image: url(../../resources/images/img.png);">
                            <div class="overlay">
                                <h2>e-sports</h2>
                                <p>절대 들키지 말 것.</p>
                                <a href="/game.do?categoryNo=1" class="cta-btn">자세히 보기</a>
                            </div>
                        </div>
                        <div class="image-box" style="background-image: url(../../resources/images/도커.png);">
                            <div class="overlay">
                                <h2>sports</h2>
                                <p>관리하는 사람들의 건전한 취미</p>
                                <a href="/sports.do?categoryNo=2" class="cta-btn">자세히 보기</a>
                            </div>
                        </div>
                    </div>
                </section>
                </header>

                <div style="text-align: center;">
                    <c:forEach var="vo" items="${ list }">${vo.getName()}</c:forEach>
                </div>

                <!-- 서비스 카드 섹션 -->
                <section class="services">
                    <h2>우리의 서비스</h2>
                    <div class="service-cards">
                        <div class="card">
                            <img src="service1.jpg" alt="Service 1">
                            <h3>서비스 1</h3>
                            <p>서비스 설명</p>
                        </div>
                        <div class="card">
                            <img src="service2.jpg" alt="Service 2">
                            <h3>서비스 2</h3>
                            <p>서비스 설명</p>
                        </div>
                        <div class="card">
                            <img src="service3.jpg" alt="Service 3">
                            <h3>서비스 3</h3>
                            <p>서비스 설명</p>
                        </div>
                    </div>
                </section>

                <!-- 푸터 -->
                <%@ include file="menubar/footer.jsp" %>


        </body>

        </html>