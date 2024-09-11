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
                <title>상품수정</title>

                <script>
                    function pUpdate() {

                        let pName = $("#pName").val().trim();
                        let price = $("#price").val().trim();
                        let pEx = $("#pEx").val().trim();
                        let pIdx = $("#pIdx").val();
                        let categoryName = $("#categorySearch").val();
                        let mcategoryName = $("#mcategorySearch").val();
                        let dcategoryName = $("#dcategorySearch").val();
                        let amount = $("#amount").val(); 

                        
                        const numberRegex = /^[0-9]+$/;

                        if(categoryName=='대분류 선택'){
                            alert("대분류를 선택하세요");
                            return;
                        }
                        if(mcategoryName=='중분류 선택'){
                            alert("중분류를 선택하세요");
                            return;
                        }
                        if(dcategoryName=='소분류 선택'){
                            alert("소분류를 선택하세요");
                            return;
                        }
                        if (pName == "") {
                            alert("상품명을 입력하세요");
                            $("#pName").focus();
                            return;
                        }
                        if (amount == "") {
                            alert("수량을 입력하세요");
                            $("#amount").focus();
                            return;
                        }
                        if (!numberRegex.test(amount)) {
                            alert("상품수량에는 숫자만 입력가능합니다");
                            $("#amount").val("");
                            $("#amount").focus();
                            return;
                        }
                        if (price == "") {
                            alert("가격을 입력하세요");
                            $("#price").focus();
                            return;
                        }
                        if (!numberRegex.test(price)) {
                            alert("가격은 숫자만 입력가능합니다");
                            $("#price").val("");
                            $("#price").focus();
                            return;
                        }
                        if (pEx == "") {
                            alert("상품설명을 입력하세요");
                            $("#pEx").focus();
                            return;
                        }
                        if (confirm("등록하시겠습니까?") == false) {
                            return;
                        }else{
                            location.href = "pUpdate.do?amount=" + amount + "&pName=" + pName + "&price=" + price + "&pEx=" + pEx + "&pIdx=" + pIdx + "&categoryName=" + categoryName + "&mcategoryName=" + mcategoryName + "&dcategoryName=" + dcategoryName;
                            alert("상품정보가 수정되었습니다.")
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
                                // 데이터가 배열이라고 가정하고 수정
                                $.each(data, function(index, item) {
                                    // 옵션 생성
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
                                dSelect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
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

                function updateCancel(){
                    if(confirm("수정을 취소하시겠습니까?\n내용은 저장되지 않습니다.")==false) return;
                    location.href='/admin/admin.do'
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
                            <td><input type="text" class="form-control" value="${shop.getPIdx()}" id="pIdx" name="pIdx"
                                    readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <select name="categorySearch" id="categorySearch" onchange="mcategoryName(this.value);">
                                <option value="${shop.categoryName}" hidden selected>${shop.categoryName}</option>
                                <c:forEach var="vo" items="${categoryName}">
                                    <option value="${vo.categoryName}">${vo.categoryName}</option>
                                </c:forEach>
                            </select>
                            <br>
                            <select name="mcategorySearch" id="mcategorySearch" onchange="dcategoryName(this.value);">
                                <option value="${shop.mcategoryName}">${shop.mcategoryName}</option>
                            </select>
                            <br>
                            <select name="dcategorySearch" id="dcategorySearch">
                                <option value="${shop.dcategoryName}">${shop.dcategoryName}</option>
                            </select>
                        </tr>
                        <tr>
                            <th>상품이름</th>
                            <td><input type="text" class="form-control" value="${shop.getPName()}" name="pName" id="pName"></td>
                        </tr>
                        <tr>
                            <th>상품수량</th>
                            <td><input type="text" class="form-control" value="${shop.getAmount()}" name="amount" id="amount"></td>
                        </tr>
                        <tr>
                            <th>상품가격</th>
                            <td><input type="text" class="form-control" value="${shop.price}" name="price" id="price"></td>
                        </tr>

                    </table>
                    <table>
                        <th>상품설명</th>
                        <td><textarea name="pEx" id="pEx" cols="50" rows="20">${pEx}</textarea></td>
                    </table>
                    <input type="button" class="btn btn-default" id="updateBtn" value="수정하기"
                        onclick="pUpdate();">
                    <input type="button" class="btn btn-danger" id="canselBtn" value="수정취소" onclick="updateCancel();">
                </form>
            </body>

            </html>