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
            #box {
              border: 1px solid black;
              margin: auto;
              height: 2000px;
              width: 1500px;
            }
          </style>
        </head>

        <body>
          <%@ include file="../menubar/navbar.jsp" %>

            <div id="box">
              <h3>category-game</h3>
            </div>

            <!-- 푸터 -->
            <%@ include file="../menubar/footer.jsp" %>
        </body>

        </html>