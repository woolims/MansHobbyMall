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
            width: 300px;
        }
        .grade-info {
            margin-bottom: 10px;
            text-align: center;
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
        <c:forEach var="condition" items="${gConditionList}">
            <div class="grade-container">
                <div class="grade-info">
                    <h2>총 구매 금액: ${condition.bpAmount}원</h2>
                </div>
                <div class="grade-info">
                    리뷰 수: ${condition.rCount}개
                </div>
                <div class="grade-info">
                    현재 등급: ${condition.grade.gradeName}
                </div>
                <div class="grade-info">
                    할인율: ${condition.grade.discount}%
                </div>
                <div class="grade-info">
                    권한: ${condition.grade.authority}
                </div>

                <!-- 다음 등급까지 남은 금액을 계산하여 표시 -->
                <c:choose>
                    <c:when test="${condition.nextGrade != null}">
                        <div class="grade-info next-grade">
                            다음 등급까지 남은 금액: ${condition.nextGrade.requiredAmount - condition.bpAmount}원
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="grade-info">
                            최고 등급입니다!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </div>
</body>
</html>
