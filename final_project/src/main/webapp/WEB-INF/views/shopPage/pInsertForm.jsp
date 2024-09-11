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
                <title>insert title here</title>

                <script>
                    function pInsert() {
                        let pName = $("#pName").val().trim();
                        let price = $("#price").val().trim();
                        let pEx = $("#pEx").val().trim();
                        let pIdx = $("#pIdx").val();
                        let categoryName = $("#categorySearch").val();
                        let mcategoryName = $("#mcategorySearch").val();
                        let dcategoryName = $("#dcategorySearch").val();
                        let amount = $("#amount").val(); 

                        if (pName == "") {
                            alert("상품명을 입력해야합니다.");
                            pName.focus();
                            return;
                        }
                        if (price == "") {
                            alert("가격을 입력해야합니다.");
                            price.focus();
                            return;
                        }
                        if (pEx == "") {
                            alert("상품설명을 입력해야합니다.");
                            return;
                        }
                        if (confirm("등록하시겠습니까?") == false) {
                            return;
                        }else{
                            location.href = "pInsert.do?amount=" + amount + "&pName=" + pName + "&price=" + price + "&pEx=" + pEx + "&pIdx=" + pIdx + "&categoryName=" + categoryName + "&mcategoryName=" + mcategoryName + "&dcategoryName=" + dcategoryName;
                            alert("상품이 등록되었습니다.")
                        }
                    }

                    function mcategoryName(val){
                        if($("#categorySearch").val()=='대분류 선택') {
                            let categoryName = val;
                            $.ajax({
                                url: "/admin/adminAjax.do",
                                data: {"categoryName": categoryName},
                                dataType: "json",
                                method: 'GET',
                                success: function (data) {
                                    var mSelect = $('#mcategorySearch');
                                    var dSelect = $('#dcategorySearch');
                                    mSelect.empty();
                                    dSelect.empty();
                                    mSelect.append($('<option disabled selected hidden></option>').val('중분류 선택').text('중분류 선택'))
                                    dSelect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                                },
                                error: function (err) {
                                    console.log(err.responseText);
                                }
                            });
                            return;
                        }

                        let categoryName = val;
                        $.ajax({
                            url: "/admin/adminAjax.do",
                            data: {"categoryName": categoryName},
                            dataType: "json",
                            method: 'GET',
                            success: function (data) {
                                var mselect = $('#mcategorySearch');
                                var dselect = $('#dcategorySearch');
                                mselect.empty();
                                dselect.empty();
                                mselect.append($('<option disabled selected hidden></option>').val('중분류 선택').text('중분류 선택'))
                                dselect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))                                
                                $.each(data, function(index, item) {
                                    mselect.append($('<option></option>').val(item.mcategoryName).text(item.mcategoryName));
                                });
                            },
                            error: function (err) {
                                console.log(err.responseText);
                            }
                        });
                    }

                function dcategoryName(val){
                    if($("#mcategorySearch").val()=='중분류 선택') {
                        let mcategoryName = val;
                        $.ajax({
                            url: "/admin/adminAjax.do",
                            data: {"mcategoryName": mcategoryName},
                            dataType: "json",
                            method: 'GET',
                            success: function (data) {
                                var dSelect = $('#dcategorySearch');
                                dSelect.empty();
                                dSelect.append($('<option disabled selected></option>').val('소분류 선택').text('소분류 선택'))
                            },
                            error: function (err) {
                                console.log(err.responseText);
                            }
                        });
                        return;
                    }

                    let mcategoryName = val;
                    $.ajax({
                        url: "/admin/adminAjax.do",
                        data: {"mcategoryName": mcategoryName},
                        dataType: "json",
                        method: 'GET',
                        success: function (data) {
                            var select = $('#dcategorySearch');
                            select.empty();
                            select.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                            $.each(data, function(index, item) {
                                select.append($('<option></option>').val(item.dcategoryName).text(item.dcategoryName));
                            });
                        },
                        error: function (err) {
                            console.log(err.responseText);
                        }
                    });
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
                            <td><input type="text" class="form-control" value="${maxPIdx}" id="pIdx" name="pIdx"
                                    readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <select name="categorySearch" id="categorySearch" onchange="mcategoryName(this.value);">
                                <option value="대분류 선택" hidden selected>대분류 선택</option>
                                <c:forEach var="vo" items="${categoryName}">
                                    <option value="${vo.categoryName}">${vo.categoryName}</option>
                                </c:forEach>
                            </select>
                            <br>
                            <select name="mcategorySearch" id="mcategorySearch" onchange="dcategoryName(this.value);">
                                <option value="${shop.mcategoryName}">중분류 선택</option>
                            </select>
                            <br>
                            <select name="dcategorySearch" id="dcategorySearch">
                                <option value="${shop.dcategoryName}">소분류 선택</option>
                            </select>
                        </tr>
                        <tr>
                            <th>상품이름</th>
                            <td><input type="text" class="form-control" value="" name="pName" id="pName" placeholder="상품명을 입력하세요"></td>
                        </tr>
                        <tr>
                            <th>상품수량</th>
                            <td><input type="text" class="form-control" value="" name="amount" id="amount" placeholder="상품수량을 입력하세요"></td>
                        </tr>
                        <tr>
                            <th>상품가격</th>
                            <td><input type="text" class="form-control" value="" name="price" id="price" placeholder="가격을 입력하세요"></td>
                        </tr>

                    </table>
                    <table>
                        <th>상품설명</th>
                        <td><textarea name="pEx" id="pEx" cols="50" rows="20" placeholder="상품설명을 입력하세요"></textarea></td>
                    </table>
                    <input type="button" class="btn btn-default" id="insertBtn" value="등록하기"
                        onclick="pInsert();">
                </form>
            </body>

            </html>