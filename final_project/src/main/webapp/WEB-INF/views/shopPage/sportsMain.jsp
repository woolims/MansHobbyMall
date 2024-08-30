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
          <title>Sports</title>
          <style>
            #top {
              margin: auto;
              height: 150px;
              width: 80%;
              margin-top: 102.2px;
            }

            #top img {
              width: 100%;
              height: 100%;
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

            #dcategory {
              margin-bottom: 50px;
            }
          </style>
        </head>

        <body>
          <!-- 메뉴바 -->
          <%@ include file="../menubar/navbar.jsp" %>
            <div id="top">
              <img src="${ pageContext.request.contextPath }/resources/images/스포츠메인페이지.jpg" alt="스포츠메인페이지">
            </div>
            <div id="main">
              <div>

              </div>

              <div id="dcategory">
                <hr>
                <c:forEach var="shop" items="${dCategoryNameList}">
                  <input type="button" id="dcategory-btn" class="btn btn-default" value="${}">
                  <!-- 이 위에 수정해야해~~~~~~~~~~~~~~~~~~~~~~~~~~~ 소카테고리 띄우기! -->
                  <!-- onclick으로 함수호출해서 ajax에 mcategory 파라미터 이용해서 출력 -->
                </c:forEach>
                <hr>
                <br><br><br>
                <hr>
                <input type="button" id="dcategory-btn" class=" btn">
                <hr>
              </div>
              <div id="product">
                <c:forEach var="shop" items="${list}">
                  <div
                    style="border: 1px solid black; width: 160px; height: 200px; display: inline-block;  margin-bottom: 10px; text-align: center;">
                    <div> ${shop.getPName()} </div>
                  </div>
                </c:forEach>

                <!-- Page Menu -->
                <div style="text-align: center; margin-top: 20px; font-size: 15px;">
                  ${ pageMenu }
                </div>

              </div>
              <!-- 푸터 -->
              <%@ include file="../menubar/footer.jsp" %>
            </div>

        </body>

        </html>