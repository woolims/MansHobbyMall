<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세 페이지</title>
    <!-- Bootstrap 3.x -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
        .container {
            width: 73%;
            margin-top: 102.2px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            margin: 20px 0;
        }

        .product-image {
            flex: 1;
            padding: 20px;
        }

        .product-details {
            flex: 2;
            padding: 20px;
        }

        .product-image img {
            max-width: 100%;
            height: auto;
        }

        .product-details h1 {
            font-size: 2em;
            margin-bottom: 20px;
        }

        .product-details p {
            font-size: 1.2em;
            margin-bottom: 20px;
        }

        .product-details .price {
            font-size: 1.5em;
            color: black;
        }

        .product-details .add-to-cart {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 15px 20px;
            font-size: 1.2em;
            cursor: pointer;
            border-radius: 5px;
        }

        .product-details .add-to-cart:hover {
            background-color: #45A049;
        }
    </style>
    <script>
        // 장바구니 추가 함수
        function addToCart() {
            if ("${empty user}" == "true") {
                alert("장바구니는 로그인 후 이용가능합니다");
                return;
            } else {
                alert('장바구니에 추가되었습니다!');
            }
        }

        // 좋아요 토글 함수
        function toggleLike(rvIdx, btn) {
            console.log("==========toggleLike 호출==========");
            console.log("rvIdx:", rvIdx);
            
            $.ajax({
                url: "${pageContext.request.contextPath}/review/toggle.do", // 컨트롤러의 좋아요 토글 URL
                type: "GET",
                data: { rvIdx: rvIdx },
                dataType: "json",
                success: function (response) {
                    if (response.result === "success") {
                        var likeBtn = $("#like-btn-" + rvIdx);
                        var likeCount = $("#like-count-" + rvIdx);

                        if (response.action === "added") {
                            $(btn).addClass("liked");
                        } else {
                            $(btn).removeClass("liked");
                        }
                        likeCount.text(response.count); // 좋아요 수 업데이트
                    } else {
                        alert(response.message || "오류가 발생했습니다.");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        }

        function updateLikeCount(rvIdx) {
            $.ajax({
                url: "${pageContext.request.contextPath}/review/count.do",
                data: { rvIdx : rvIdx },
                dataType: "json",
                success: function(response) {
                $("#like-count-" + rvIdx).text(response.count);
                }
            });
        }
        

        $(document).ready(function() {

            // 초기화 작업 수행
            $(".like-button").each(function() {
                var rvIdx = $(this).data("rvidx");
                var btn = this;
                $.ajax({
                    url: "${pageContext.request.contextPath}/review/isLiked.do",
                    data: { rvIdx: rvIdx },
                    dataType: "json",
                    success: function(response) {
                        if (response.isLiked) {
                            $(btn).addClass("liked");
                        }
                }
                });
                updateLikeCount(rvIdx);
            });
        });


        function send1(f) {
            let url = new URL(window.location.href);
            if ("${ empty user }" == "true") {
                alert('로그아웃되었습니다.\n로그인하세요.');
                return;
            }

            let rvContent = f.rvContent.value;

            if (rvContent.trim() == '') {
                alert("내용을 입력하세요");
                f.rvContent.focus();
                return;
            }
            
            f.url.value = url.href;
            console.log(url.href);

            f.action = "${pageContext.request.contextPath}/review/reviewWrite.do";
            f.submit();
        }

        function send2(f) {
            if ("${ empty user }" == "true") {
                alert('로그아웃되었습니다.\n로그인하세요.');
                return;
            }

            let rvContent = f.rvContent.value;

            if (rvContent.trim() == '') {
                alert("내용을 입력하세요");
                f.rvContent.focus();
                return;
            }

            f.action = "${pageContext.request.contextPath}/review/reviewModify.do"; // 리뷰 수정 전송
            f.submit();
        }

        function check_user(rvIdx, userIdx) {
            if ("${not empty user}") {
                if ("${user.userIdx}" == userIdx) {
                    // AJAX 요청으로 리뷰 정보를 가져와서 모달에 채워넣기
                    $.ajax({
                        url: 'getReviewInfo.do',
                        type: 'GET',
                        data: { rvIdx: rvIdx },
                        success: function(data) {
                            // 모달을 열고 데이터를 채웁니다.
                            $('#reviewModifyModal').show();
                            $('textarea[name="rvContent"]').val(data.rvContent);
                            $('input[name="rvIdx"]').val(data.rvIdx);
                        },
                        error: function () {
                            alert('리뷰 정보를 가져오는 데 실패했습니다.');
                        }
                    });
                    return;
                }
            }
            alert('수정 권한이 없습니다.');
        }

       
    </script>
</head>

<body>
    <!-- 메뉴바 -->
    <%@ include file="../menubar/navbar.jsp" %>
    <div class="container">
        <div class="product-container">
            <div class="product-image">
                <img id="product-image" src="" alt="상품 이미지">
            </div>
            <div class="product-details">
                <h1 id="product-name">${shop.getPName()}</h1>
                <p class="price" id="product-price">${shop.getPrice()} 원</p>
                <button class="add-to-cart" onclick="addToCart()" style="margin-bottom: 20px;">장바구니에 추가</button>
                <p id="product-description">${shop.getPEx()}</p>
            </div>
        </div>
        <!-- 푸터 -->
        <%@ include file="../menubar/payment.jsp" %>
    </div>

    <h1 style="margin-left: 380px; margin-top: 50px;">후기</h1>

            <c:if test="${ not empty user }">
                <button type="button" class="btn btn-primary" id="openReviewModal">리뷰 등록</button>
            </c:if>

    <c:forEach var="review" items="${reviewList}">
        <div class="container" style="margin-top: 0px;">
            <!-- 리뷰 목록 출력 -->
            <div class="review-item">
                <p><strong>작성자:</strong> ${review.nickName}</p>
                <p><strong>평점:</strong> ${review.reviewPoint}</p>
                <p><strong>리뷰 내용:</strong> ${review.rvContent}</p>
                <p><strong>리뷰 이미지:</strong> <img src="${review.rvImg}" alt="리뷰 이미지"></p>

                <!-- 좋아요 버튼과 좋아요 수 -->
                <button id="like-btn-${review.rvIdx}" class="like-button" data-rvIdx="${review.rvIdx}" onclick="toggleLike('${review.rvIdx}', this)">
                    좋아요
                </button>
                <span>좋아요 수: <span id="like-count-${review.rvIdx}">${review.likeCount}</span></span>
            </div>
        </div>
    </c:forEach>


    <!-- 리뷰 작성 모달 -->
    <div id="reviewModal" class="modal">
        <div class="modal-content">
          <span class="close" onclick="document.getElementById('reviewModal').style.display='none'">&times;</span>
          <h2>리뷰 작성</h2>
          <form>
            <input type="hidden" name="url" id="url" value="../home.do"/>
            <input type="hidden" name="userIdx" value="${user.userIdx}" />
            상품번호 : <input type="text" name="pIdx" value="1"/><br>
            <div class="form-group" style="color: black;">
                <label for="content" style="color: black;">내용</label>
                <textarea name="rvContent" required style="width: 100%; min-height: 400px;"></textarea>
            </div>
            <button type="button" class="btn btn-primary" onclick="send1(this.form)">등록</button>
          </form>
        </div>
    </div>

    <!-- 리뷰 수정 모달 -->
    <div id="reviewModifyModal" class="modal">
        <div class="modal-content">
          <span class="close" onclick="document.getElementById('reviewModifyModal').style.display='none'">&times;</span>
          <h2>리뷰 수정</h2>
          <form>
            <input type="hidden" name="rvIdx" />
            <input type="hidden" name="userIdx" value="${user.userIdx}" />
            <div class="form-group" style="color: black;">
                <label for="content" style="color: white;">내용</label>
                <textarea name="rvContent" required style="width: 100%; min-height: 400px;"></textarea>
            </div>
            <button type="button" class="btn btn-primary" onclick="send2(this.form)">등록</button>
          </form>
        </div>
    </div>

    <script>
        const reviewModal = document.getElementById("reviewModal");
        const openReviewModalBtn = document.getElementById("openReviewModal");
        const reviewModifyModal = document.getElementById("reviewModifyModal");

        openReviewModalBtn.onclick = function () {
            reviewModal.style.display = "flex";
        };

        document.querySelectorAll(".close").forEach(el => {
            el.onclick = function () {
                el.closest(".modal").style.display = "none";
            };
        });
    </script>
    
</body>

</html>
