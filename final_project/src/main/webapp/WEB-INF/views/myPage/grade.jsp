<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등급 관리</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/accountInfo.css">
    <style>
        .grade-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 20px 0;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 400px;
        }
        .grade-info {
            margin-bottom: 10px;
        }
        .grade-info h2 {
            margin-bottom: 15px;
        }
        .next-grade {
            font-weight: bold;
            color: #d9534f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>사용자 등급 정보</h1>
    </div>
    <div class="container" style="display: flex; justify-content: center; flex-wrap: wrap;">
  
            <div class="grade-container">
                <div class="grade-info">
                    <h2>총 구매 금액: ${gvo.totalPurchaseAmount}원</h2>
                </div>
                <div class="grade-info">
                    후기 수: ${gvo.totalReviewCount}개
                </div>
                <div class="grade-info">
                    현재 등급: ${gvo.gradeName}
                </div>
                <div class="grade-info">
                    할인율: ${gvo.discount}%
                </div>

                <!-- 다음 등급까지 남은 금액을 계산하여 표시 -->
                <c:choose>
                    <c:when test="${gvo.gradeName != '마스터'}">
                        <div class="grade-info next-grade">
                            다음 등급까지 남은 금액: <br> ${gcvo.bpAmount - gvo.totalPurchaseAmount}원<br>
                            다음 등급까지 남은 후기: <br> ${gcvo.getRCount() - gvo.totalReviewCount}개
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="grade-info">
                            최고 등급입니다!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
    </div>
</body>
</html>