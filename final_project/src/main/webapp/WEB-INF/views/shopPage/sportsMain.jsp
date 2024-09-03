<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


        <!DOCTYPE html>
        <html>

        <head>
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
          <script>

            function mCategoryNoParam(id) {
              let categoryNo_param = '${shop.categoryNo}';
              let mcategoryName_param = id.value;

              location.href = "/sports.do?categoryNo=" + categoryNo_param + "&mcategoryName=" + mcategoryName_param;
            }

            function dCategoryNoParam(id) {
              let categoryNo_param = '${shop.categoryNo}';
              let mcategoryName_param = '${shop.mcategoryName}';
              let dcategoryName_param = id.value;

              location.href = "/sports.do?categoryNo=" + categoryNo_param + "&mcategoryName=" + mcategoryName_param + "&dcategoryName=" + dcategoryName_param;
            }

          </script>
        </head>

        <body>
          <!-- 메뉴바 -->
          <%@ include file="../menubar/navbar.jsp" %>
            <div id="top">
              <img src="${ pageContext.request.contextPath }/resources/images/스포츠메인페이지.jpg" alt="스포츠메인페이지">
            </div>
            <div id="main">
              <hr>
              <div id="mcategory">
                <c:forEach var="shop_m" items="${mCategoryNameList}">
                  <input type="button" id="${shop_m.mcategoryName}" class="btn btn-default"
                    value="${shop_m.mcategoryName}" onclick="mCategoryNoParam(this);">
                </c:forEach>
              </div>
              <hr>
              <c:if test="${mcategoryName != 'emptyMcategoryName'}">
                <div id="dcategory" style="text-align: center;">
                  <c:forEach var="shop" items="${dCategoryName}">
                    <input type="button" id="${shop.dcategoryNo}" class="btn btn-default" value="${shop.dcategoryName}"
                      style="text-align: center;" onclick="dCategoryNoParam(this);">
                    <!-- onclick으로 함수호출해서 ajax에 mcategory 파라미터 이용해서 출력 -->
                  </c:forEach>
                </div>
                <hr>
              </c:if>

              <div id="product">
                <c:forEach var="shop" items="${productList}">
                  <div
                    style="border: 1px solid black; width: 160px; height: 200px; display: inline-block;  margin-bottom: 10px; text-align: center;">
                    <div style="text-align: center;"> ${shop.getPName()} </div>
                  </div>
                </c:forEach>
              </div>
              <!-- 푸터 -->
              <%@ include file="../menubar/footer.jsp" %>
            </div>

        </body>

        </html>