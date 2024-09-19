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
                <title>상품등록</title>

                <script>
                    function pInsert(f) {
                        let pName = $("#pName").val().trim();
                        let price = $("#price").val().trim();
                        let pEx = $("#pEx").val().trim();
                        let categoryNameForm = $("#categorySearch").val();
                        let mcategoryNameForm = $("#mcategorySearch").val();
                        let dcategoryNameForm = $("#dcategorySearch").val();
                        let amount = $("#amount").val();
                        let photo = $("#photo");

                        const numberRegex = /^[0-9]+$/;

                        if (categoryNameForm == '대분류 선택') {
                            alert("대분류를 선택하세요");
                            return;
                        }
                        if (mcategoryNameForm == '중분류 선택') {
                            alert("중분류를 선택하세요");
                            return;
                        }
                        if (dcategoryNameForm == '소분류 선택') {
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
                        if(photo[0].files.length == 0) {
                            if(confirm("사진을 선택하지 않았습니다. 등록하시겠습니까?") == false)
                            return;
                        }else if (confirm("등록하시겠습니까?") == false) return;

                        f.method = "POST";
                        f.enctype = "multipart/form-data";
                        f.action = "/admin/pInsert.do";
                        f.submit();
                    }

                    function mcategoryNameList(val) {
                        if ($("#categorySearch").val() == '대분류 선택' || $("#categorySearch").val() == '전체보기') {
                            let categoryName = val;
                            $.ajax({
                                url: "/admin/adminAjax.do",
                                data: { "categoryName": categoryName },
                                dataType: "json",
                                method: 'GET',
                                success: function (data) {
                                    var mSelect = $('#mcategorySearch');
                                    var dSelect = $('#dcategorySearch');
                                    mSelect.empty();
                                    dSelect.empty();
                                    mSelect.append($('<option selected hidden></option>').val('중분류 선택').text('중분류 선택'))
                                    dSelect.append($('<option selected hidden></option>').val('소분류 선택').text('소분류 선택'))
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
                            data: { "categoryName": categoryName },
                            dataType: "json",
                            method: 'GET',
                            success: function (data) {
                                var mselect = $('#mcategorySearch');
                                var dselect = $('#dcategorySearch');
                                mselect.empty();
                                dselect.empty();
                                mselect.append($('<option selected hidden disabled></option>').val('중분류 선택').text('중분류 선택'))
                                dselect.append($('<option selected hidden disabled></option>').val('소분류 선택').text('소분류 선택'))
                                $.each(data, function (index, item) {
                                    mselect.append($('<option></option>').val(item.mcategoryName).text(item.mcategoryName));
                                });
                            },
                            error: function (err) {
                                console.log(err.responseText);
                            }
                        });
                    }

                    function dcategoryNameList(val) {
                        if ($("#mcategorySearch").val() == '선택 안 함') {
                            let mcategoryName = val;
                            $.ajax({
                                url: "/admin/adminAjax.do",
                                data: { "mcategoryName": mcategoryName },
                                dataType: "json",
                                method: 'GET',
                                success: function (data) {
                                    var dSelect = $('#dcategorySearch');
                                    dSelect.empty();
                                    dSelect.append($('<option selected></option>').val('소분류 선택').text('소분류 선택'))
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
                            data: { "mcategoryName": mcategoryName },
                            dataType: "json",
                            method: 'GET',
                            success: function (data) {
                                var select = $('#dcategorySearch');
                                select.empty();
                                select.append($('<option selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                                $.each(data, function (index, item) {
                                    select.append($('<option></option>').val(item.dcategoryName).text(item.dcategoryName));
                                });
                            },
                            error: function (err) {
                                console.log(err.responseText);
                            }
                        });
                    }

                    function insertCancel() {
                        if (confirm("등록을 취소하시겠습니까?\n내용은 저장되지 않습니다.") == false) return;
                        location.href = '/admin/admin.do'
                    }
                </script>

                <style>
                    textarea {
                        resize: none;
                    }
                </style>

            </head>

            <body>
                <form enctype="multipart/form-data" method="POST">
                    <select name="categoryName" id="categorySearch" onchange="mcategoryNameList(this.value);">
                        <option value="대분류 선택" hidden selected>대분류 선택</option>
                        <c:forEach var="vo" items="${categoryName}">
                            <option value="${vo.categoryName}">${vo.categoryName}</option>
                        </c:forEach>
                    </select>
                    <br>
                    <select name="mcategoryName" id="mcategorySearch" onchange="dcategoryNameList(this.value);">
                        <option value="중분류 선택">중분류 선택</option>
                    </select>
                    <br>
                    <select name="dcategoryName" id="dcategorySearch">
                        <option value="소분류 선택">소분류 선택</option>
                    </select>
                    <table>
                        <tr>
                            <th>상품이름</th>
                            <td><input type="text" class="form-control" value="" name="pName" id="pName"
                                    placeholder="상품명을 입력하세요"></td>
                        </tr>
                        <tr>
                            <th>상품수량</th>
                            <td><input type="text" class="form-control" value="" name="amount" id="amount"
                                    placeholder="상품수량을 입력하세요"></td>
                        </tr>
                        <tr>
                            <th>상품가격</th>
                            <td><input type="text" class="form-control" value="" name="price" id="price"
                                    placeholder="가격을 입력하세요"></td>
                        </tr>

                    </table>
                    <table>
                        <tr>
                            <th>상품사진</th>
                            <td><input type="file" name="photo" id="photo" multiple></td>
                        </tr>
                        <tr>
                            <th>상품설명</th>
                            <td><textarea name="pEx" id="pEx" cols="50" rows="20" placeholder="상품설명을 입력하세요"></textarea>
                            </td>
                        </tr>
                    </table>
                    <input type="button" class="btn btn-default" id="insertBtn" name="insertBtn" value="등록하기"
                        onclick="pInsert(this.form);">
                </form>
                <input type="button" class="btn btn-danger" id="canselBtn" name="canselBtn" value="등록취소"
                    onclick="insertCancel();">

            </body>

            </html>