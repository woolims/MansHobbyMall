<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

        <!DOCTYPE html>
        <html>

        <head>
          <!-- Bootstrap 3.x-->
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <meta charset="UTF-8" />
          <title>Game</title>
          <style>
            #top {
              border: 1px solid black;
              margin: auto;
              height: 150px;
              width: 80%;
              margin-top: 92px;

            }

            #main {
              margin: auto;
              width: 73%;
              height: 100px;
              align-items: center;
            }

            #mcategory {
              margin: auto;
              height: auto;
              width: 100%;
              margin-top: 30px;
              text-align: center;
            }

            #mcategory-btn {
              width: 100px;
              height: 50px;
              margin-left: 30px;
              margin-right: 30px;
            }
          </style>
        </head>

        <body>
          <!-- 메뉴바 -->
          <%@ include file="../menubar/navbar.jsp" %>
            <div id="top">
              상단 이미지 넣기
            </div>
            <div id="main">
              <div id="mcategory">
                <hr>
                <input type="button" id="mcategory-btn" class="btn btn-default" value="마우스">
                <input type="button" id="mcategory-btn" class="btn btn-default" value="키보드">
                <input type="button" id="mcategory-btn" class="btn btn-default" value="컴퓨터">
                <input type="button" id="mcategory-btn" class="btn btn-default" value="??????">
                <hr>
              </div>
              <div id="dcategory">
                <c:forEach var="i" begin="1" end="20" step="1">
                  <div style="border: 1px solid red; width: 150px; height: 200px; display: inline-block;">
                    이미지
                    <span>제목 ${i}</span>
                    <span>가격 ${i*300}</span>
                  </div>
                </c:forEach>
              </div>
              <!-- 푸터 -->
              <div>
                <%@ include file="../menubar/footer.jsp" %>
              </div>
            </div>

        </body>

        </html>