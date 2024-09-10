<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/accountInfo.css">
</head>
<body>
    <div class="container">
        <h1>회원 정보 수정</h1>
        <form>
            <input type="hidden" name="userIdx" value="${user.userIdx}"/>
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" value="${user.id}" readonly />
            </div>
    
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" value="${user.password}" readonly />
            </div>
    
            <div class="form-group">
                <label for="nickName">닉네임</label>
                <input type="text" id="nickName" name="nickName" value="${user.nickName}" />
            </div>
    
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="${user.name}" />
            </div>
    
            <div class="form-group">
                <label for="phone">핸드폰 번호</label>
                <input type="text" id="phone" name="phone" value="${user.phone}" />
            </div>
    
            <div class="form-group">
                <label for="addr">주소</label>
                <input type="text" id="addr" name="addr" value="${user.addr}" />
            </div>
    
            <div class="form-group">
                <label for="subAddr">상세 주소</label>
                <input type="text" id="subAddr" name="subAddr" value="${user.subAddr}" />
            </div>
    
            <div class="form-group">
                <label for="gradeName">등급</label>
                <input type="text" id="gradeName" name="gradeName" value="${user.gradeName}" readonly />
            </div>
    
            <div class="form-group">
                <label for="point">포인트</label>
                <input type="text" id="point" name="point" value="${user.point}" readonly />
            </div>
    
            <div class="form-group">
                <input type="button" value="정보 수정"/>
            </div>
        </form>
    </div>
</body>
</html>
