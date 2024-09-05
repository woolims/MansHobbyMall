<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


            <!DOCTYPE html>
            <html>

            <head>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
                <meta charset="UTF-8">
                <title>Insert title here</title>

                <script>
                    function pUpdate(f) {

                        if (confirm("수정하시겠습니까?") == false) {
                            return;
                        }
                        f.action = "pUpdate.do";
                        f.submit();
                        alert("상품정보가 수정되었습니다.")

                    }
                </script>

                <style>
                    textarea {
                        resize: none;
                    }
                </style>
            </head>

            <body>
                <form>
                    <table>
                        <tr>
                            <th>상품번호</th>
                            <td><input type="text" class="form-control" value="${shop.getPIdx()}" name="pIdx"
                                    readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <th>대분류</th>
                            <td><input type="text" class="form-control" value="${shop.getCategoryName()}"
                                    name="categoryName"></td>
                        </tr>
                        <tr>
                            <th>중분류</th>
                            <td><input type="text" class="form-control" value="${shop.getMcategoryName()}"
                                    name="mcategoryName"></td>
                        </tr>
                        <tr>
                            <th>소분류</th>
                            <td><input type="text" class="form-control" value="${shop.getDcategoryName()}"
                                    name="dcategoryName"></td>
                        </tr>
                        <tr>
                            <th>상품이름</th>
                            <td><input type="text" class="form-control" value="${shop.getPName()}" name="pName"></td>
                        </tr>
                        <tr>
                            <th>상품갯수</th>
                            <td><input type="text" class="form-control" value="${shop.getAmount()}" name="amount"></td>
                        </tr>
                        <tr>
                            <th>상품가격</th>
                            <td><input type="text" class="form-control" value="${shop.getPrice()}" name="price"></td>
                        </tr>

                    </table>
                    <table>
                        <th>상품설명</th>
                        <td><textarea name="pEx" id="pEx" cols="50" rows="20">${pEx}</textarea></td>
                    </table>
                    <input type="button" class="btn btn-default" id="updateBtn" value="수정하기"
                        onclick="pUpdate(this.form);">

                </form>
            </body>

            </html>