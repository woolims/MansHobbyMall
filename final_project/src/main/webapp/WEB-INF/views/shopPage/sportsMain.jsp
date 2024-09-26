<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

        <!DOCTYPE html>
        <html>

        <head>
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <!-- Bootstrap 3.x -->
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <meta charset="UTF-8" />
          <title>Sports</title>

          <style>
            /* 전체 페이지 높이를 100%로 설정 */
            html,
            body {
              height: 100%;
              margin: 0;
              padding: 0;
              display: flex;
              flex-direction: column;
            }

            /* 메인 컨텐츠를 flexbox로 설정 */
            #main {
              flex: 1;
              width: 73%;
              margin: auto;
              text-align: center;
              align-items: center;
            }

            #footer-container {
              width: 100%;
              text-align: center;
              background-color: #f8f8f8;
              padding: 20px 0;
              margin-top: auto;
            }

            #top {
              margin: auto;
              width: 88%;
              margin-top: 45px;
            }

            .carousel-inner .item {
              text-align: center;
            }

            .carousel-inner img {
              width: 420px;
              height: 420px;
              margin-top: 60px;
              border-radius: 3px;
            }

            .carousel-control {
              background: none;
              color: black;
            }

            #mcategory {
              margin: auto;
              height: auto;
              width: 100%;
              margin-top: 30px;
              text-align: center;
            }

            #dcategory {
              margin-bottom: 50px;
            }

            /* 활성화된 버튼 스타일 */
            .highlight {
              background-color: black !important;
              color: white !important;
              font-weight: bold !important;
            }

            /* 제품 카드 */
            #product {
              margin-top: 30px;
            }

            .product-card {
              margin: auto;
              border: 1px solid #ddd;
              width: 300px;
              height: 400px;
              /* 카드의 높이를 높여서 내용이 더 잘 보이도록 함 */
              display: inline-block;
              margin-bottom: 20px;
              /* 카드 사이의 간격을 넓힘 */
              padding: 20px;
              text-align: center;
              border-radius: 8px;
              transition: box-shadow 0.3s ease;
              cursor: pointer;
              position: relative;
            }

            .product-card:hover {
              box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            .product-card img {
              width: 200px;
              height: 200px;
              margin-top: 5px;
            }

            .product-card .product-name {
              margin-top: 50px;
              font-weight: bold;
              font-size: 20px;
              white-space: nowrap;
              overflow: hidden;
              text-overflow: ellipsis;
            }

            .product-price {
              margin-top: 10px;
              /* 가격이 이름보다 더 떨어져 보이게 함 */
              font-size: 18px;
              font-weight: bolder;
              color: #333;
            }
          </style>

          <script>

            function product(categoryNo, mcategoryName) {
              $.ajax({
                url: "/productAjax.do",
                data: { "categoryNo": categoryNo, "mcategoryName": mcategoryName},
                datatype: "json",
                method: 'GET',
                success: function (res_data) {
                  console.log(res_data);
                  $("#product").empty();
                  productHtml = ``;
                  $.each(res_data, function (index, pVo) {
                    productHtml += `<div class="col-sm-3">
                       <div class="product-card" onclick="location.href='productOne.do?categoryNo=\${pVo.categoryNo}&pIdx=\${pVo.pidx}';">`
                    if (pVo.fileNameLink == 'Y') {
                      productHtml +=
                      `<div>
                             <img src="\${pVo.fileName}" alt="상품이미지">
                           </div>`
                    } else if (pVo.fileNameLink == 'Y') {
                      productHtml +=
                      `<div>
                             <img src="/resources/images/\${pVo.fileName}"
                               alt="상품이미지">
                           </div>`
                    }
                    productHtml +=`
                         <div class="product-name">\${pVo.pname}</div>
                         <div class="product-price">\${pVo.price} 원</div>
                       </div>
                     </div>`
                  });
                  $("#product").html(productHtml);
                }
              });
            }
            function mCategoryNoParam(id) {
              let categoryNo_param = '${shop.categoryNo}';
              let mcategoryName_param = id.value;
              $.ajax({
                url: "/categoryAjax.do",
                data: { "categoryNo": categoryNo_param, "mcategoryName": mcategoryName_param },
                datatype: "json",
                method: 'GET',
                success: function (res_data) {
                  console.log(res_data);
                  let dcategory = $("#dcategory");
                    dcategory.empty();
                    dcategoryHtml = ``;
                    $.each(res_data, function (index, pVo) {
                      dcategoryHtml +=
                      `<input type="button" id="\${pVo.dcategoryNo}" class="btn btn-default"
                        value="\${pVo.dcategoryName}" onclick="dCategoryNoParam(this);">`;
                    });
                    dcategory.html(dcategoryHtml);

                  product(categoryNo_param, mcategoryName_param);
                },
                error: function () {
                  alert("error");
                }
              });
            }

            

            function dCategoryNoParam(id) {
              let categoryNo_param = '${shop.categoryNo}';
              let dcategoryNo_param = id.id;
              
              $.ajax({
                url: "/productAjax.do",
                data: { "categoryNo": categoryNo_param, "dcategoryNo": dcategoryNo_param },
                datatype: "json",
                method: 'GET',
                success: function (res_data) {
                  console.log(res_data);
                  let product = $("#product");
                  product.empty();
                  productHtml = ``;

                  $.each(res_data, function (index, pVo) {
                    productHtml += `<div class="col-sm-3">
                      <div class="product-card" onclick="location.href='productOne.do?categoryNo=\${pVo.categoryNo}&pIdx=\${pVo.pidx}';">`
                    if (pVo.fileNameLink == 'Y') {
                      productHtml += `<div>
                                        <img src="\${pVo.fileName}" alt="상품이미지">
                                      </div>
                           <div class="product-name">\${pVo.pname}</div>
                         <div class="product-price">\${pVo.price} 원</div>
                       </div>
                     </div>`
                    } else if (pVo.fileNameLink == 'N') {
                      productHtml += `<div>
                                        <img src="/resources/images/\${pVo.fileName}" alt="상품이미지">
                                      </div>
                           <div class="product-name">\${pVo.pname}</div>
                         <div class="product-price">\${pVo.price} 원</div>
                       </div>
                     </div>`
                    };
                  });
                  product.html(productHtml);
                }
              });
            }



            //  ajax 처리하기 여기까지


            // 스크롤 위치를 로컬 스토리지에 저장
            window.onbeforeunload = function () {
              localStorage.setItem('scrollPosition', window.scrollY);
            };

            // URL 파라미터 읽기 및 버튼 하이라이트 설정
            window.onload = function () {
              const savedScrollPosition = localStorage.getItem('scrollPosition');
              if (savedScrollPosition !== null) {
                window.scrollTo(0, parseInt(savedScrollPosition));
              }
              const urlParams = new URLSearchParams(window.location.search);
              const mcategory = urlParams.get('mcategoryName'); // 중분류 파라미터
              const dcategory = urlParams.get('dcategoryName'); // 소분류 파라미터

              // 중분류 input에 highlight 클래스 추가
              if (mcategory) {
                document.querySelectorAll('#mcategory input').forEach(function (input) {
                  if (input.value === mcategory) {
                    input.classList.add('highlight');
                  }
                });
              }

              // 소분류 input에 highlight 클래스 추가
              if (dcategory) {
                document.querySelectorAll('#dcategory input').forEach(function (input) {
                  if (input.value === dcategory) {
                    input.classList.add('highlight');
                  }
                });
              }
            };
          </script>
        </head>

        <body>
          <!-- 메뉴바 -->
          <%@ include file="../menubar/navbar.jsp" %>

            <!-- 메인 컨텐츠 -->
            <div id="main">
              <div id="top">
                <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000">
                  <div class="carousel-inner">
                    <div class="item active">
                      <div class="row">
                        <div class="col-sm-4">
                          <img src="${pageContext.request.contextPath}/resources/images/이미지1.png" alt="이미지 1">
                        </div>
                        <div class="col-sm-4">
                          <img src="${pageContext.request.contextPath}/resources/images/이미지2.png" alt="이미지 2">
                        </div>
                        <div class="col-sm-4">
                          <img src="${pageContext.request.contextPath}/resources/images/이미지3.png" alt="이미지 3">
                        </div>
                      </div>
                    </div>
                    <div class="item">
                      <div class="row">
                        <div class="col-sm-4">
                          <img src="${pageContext.request.contextPath}/resources/images/이미지4.png" alt="이미지 4">
                        </div>
                        <div class="col-sm-4">
                          <img src="${pageContext.request.contextPath}/resources/images/이미지5.png" alt="이미지 5">
                        </div>
                        <div class="col-sm-4">
                          <img src="${pageContext.request.contextPath}/resources/images/이미지6.png" alt="이미지 6">
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- 좌우 화살표 -->
                  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="right carousel-control" href="#myCarousel" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next</span>
                  </a>
                </div>
              </div>

              <hr>

              <div id="mcategory">
                <c:forEach var="shopM" items="${mCategoryNameList}">
                  <input type="button" id="${shopM.mcategoryName}" class="btn btn-default"
                    value="${shopM.mcategoryName}" onclick="mCategoryNoParam(this);">
                </c:forEach>
              </div>

              <hr>
                <div id="dcategory">
                </div>
              <hr>

              <div id="product" class="row">
                <c:forEach var="shopP" items="${productList}">
                  <div class="col-sm-3">
                    <div class="product-card"
                      onclick="location.href='productOne.do?categoryNo=${shopP.getCategoryNo()}&pIdx=${shopP.getPIdx()}';">
                      <c:if test="${shopP.fileNameLink == 'Y'}">
                        <div>
                          <img src="${shopP.fileName}" alt="상품이미지">
                        </div>
                      </c:if>
                      <c:if test="${shopP.fileNameLink == 'N'}">
                        <div>
                          <img src="${ pageContext.request.contextPath }/resources/images/${shopP.fileName}"
                            alt="상품이미지">
                        </div>
                      </c:if>
                      <div class="product-name">${shopP.getPName()}</div>
                      <div class="product-price">${shopP.getPrice()} 원</div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>

            <!-- 푸터 -->
            <div id="footer-container">
              <%@ include file="../menubar/footer.jsp" %>
            </div>
        </body>

        </html>