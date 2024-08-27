<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

        <!DOCTYPE html>
        <html>

        <head>
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <meta charset="UTF-8" />
          <title>Game</title>
          <style>
            #top {
              border: 1px solid black;
              margin: auto;
              height: 150px;
              width: 100%;
              margin-top: 81px;

            }

            #mcategory {
              margin: auto;
              height: auto;
              width: 80%;
              margin-top: 30px;
            }

            #main {
              width: 100%;
              height: 100px;
              text-align: center;
            }

            #list {
              height: 65px;
              width: 100%;
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
                <div id="list">
                  <!-- <c:forEach var="vo" items="${vo.mcategory}">
                      
                    </c:forEach> -->
                  list로 가져올 데이터
                </div>
                <hr>
              </div>
              <div id="dcategory">
                <c:forEach var="i" begin="1" end="60" step="1">
                  <div style="border: 1px solid red; width: 150px; height: 200px; display: inline-block;">이미지
                    <span>제목 ${i}</span>
                    <span>가격 ${i*300}</span>
                  </div>
                </c:forEach>
              </div>
              <!-- 푸터 -->
              <%@ include file="../menubar/footer.jsp" %>
            </div>
        </body>

        </html>