<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        body {
            margin: auto;
            width: 80%;
            background-color: #f8f9fa; /* 연한 배경색 */
            padding: 20px;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
            background-color: #ffffff; /* 흰색 배경 */
            border-radius: 5px; /* 둥근 모서리 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
            padding: 20px; /* 내부 여백 */
        }
        th {
            text-align: left; /* 왼쪽 정렬 */
            padding-bottom: 10px;
            color: #495057; /* 텍스트 색상 */
        }
        td {
            padding: 10px 0; /* 세로 여백 */
        }
        textarea {
            resize: none;
            width: 100%; /* 전체 너비 */
            height: 200px; /* 고정 높이 */
        }
        .btn {
            margin-right: 10px; /* 버튼 간격 */
        }
        img {
            width: 100%;
            height: auto; /* 비율 유지 */
            border-radius: 5px; /* 둥근 모서리 */
        }
        .alert {
            margin-top: 20px;
        }
        select{
            display: inline;
            margin-bottom: 60px;
        }
    </style>

    <script>
        function pUpdate(f) {
            let pName = f.pName.value.trim();
            let price = f.price.value.trim();
            let pEx = f.pEx.value.trim();
            let pIdx = f.pIdx.value;
            let categoryName = f.categoryName.value;
            let mcategoryName = f.mcategoryName.value;
            let dcategoryName = f.dcategoryName.value;
            let amount = f.amount.value;

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
            }

            f.method = "POST";
            f.enctype = "multipart/form-data";
            f.action = "/admin/pUpdate.do";
            f.submit();
        }

        function mcategoryNameSearch(val) {
            let categoryName = val;
            $.ajax({
                url: "/admin/adminAjax.do",
                data: {"categoryName": categoryName},
                dataType: "json",
                method: 'GET',
                success: function (res_data) {
                    var mselect = $('#mcategorySearch');
                    var dselect = $('#dcategorySearch');
                    mselect.empty();
                    dselect.empty();
                    mselect.append($('<option disabled selected hidden></option>').val('중분류 선택').text('중분류 선택'))
                    dselect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                    $.each(res_data, function(index, item) {
                        mselect.append($('<option></option>').val(item.mcategoryName).text(item.mcategoryName));
                    });
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        }

        function dcategoryNameSearch(val) {
            let categoryName = $("#categorySearch").val();
            if($("#mcategorySearch").val()=='중분류 선택') {
                let mcategoryName = val;
                $.ajax({
                    url: "/admin/adminAjax.do",
                    data: {"mcategoryName": mcategoryName, "categoryName":categoryName},
                    dataType: "json",
                    method: 'GET',
                    success: function (res_data) {
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
                data: {"mcategoryName": mcategoryName, "categoryName":categoryName},
                dataType: "json",
                method: 'GET',
                success: function (res_data) {
                    var select = $('#dcategorySearch');
                    select.empty();
                    select.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                    $.each(res_data, function(index, item) {
                        select.append($('<option></option>').val(item.dcategoryName).text(item.dcategoryName));
                    });
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        }

        function updateCancel() {
            if(confirm("수정을 취소하시겠습니까?\n내용은 저장되지 않습니다.")==false) return;
            location.href='/admin/admin.do'
        }

        function pImageDelete(fileIdx , pIdx) {
            if(confirm("이미지를 삭제하시겠습니까?")==false) return;
            $.ajax({
                url: "/admin/pImageDelete.do",
                data: {"fileIdx" : fileIdx, "pIdx" : pIdx},
                dataType: "json",
                method: 'POST',
                success: function (res_data) {
                    let pImgTable = $("#pImgTable");
                    pImgTable.empty();
                    let pImgTableHtml = `
                        <tr>
                            <th>상품사진</th>
                            <td><input type="file" name="photo" id="pImg" multiple></td>
                        </tr>
                        <tr>
                            <th>현재등록된 상품사진</th>
                            `;

                    if (res_data.length == 0 || res_data == null) {
                        pImgTableHtml += `등록된 사진이 없습니다`;
                    } else {
                        $.each(res_data, function (i, photoList) {
                            console.log(photoList.fileName);
                            if(photoList.fileNameLink == 'Y'){
                                pImgTableHtml += `
                            <td style="display: inline-block; width: 200px; height: 160px;"><img src="\${photoList.fileName}"
                            onclick="pImageDelete('\${photoList.fileIdx}', '\${photoList.pidx}')">
                            </td>`;
                            } else if(photoList.fileNameLink == 'N'){
                                pImgTableHtml += `
                            <td style="display: inline-block; width: 200px; height: 160px;"><img src="/resources/images/\${photoList.fileName}"
                            onclick="pImageDelete('\${photoList.fileIdx}', '\${photoList.pidx}')">
                            </td>`;
                            }
                            
                        });
                    }
                    pImgTableHtml += `</tr>`;

                    $('#pImgTable').html(pImgTableHtml);
                },
                error: function (err) {
                    console.log(err.responseText);
                }
            });
        }
    </script>
</head>
<body>
    <form>
        <table>
            <tr>
                <th>상품번호</th>
                <td><input type="text" class="form-control" value="${shop.getPIdx()}" id="pIdx" name="pIdx" readonly="readonly"></td>
            </tr>
            <tr>
                <h3>상품분류선택</h3>
                <select name="categoryName" id="categorySearch" onchange="mcategoryNameSearch(this.value);">
                    <option value="${shop.categoryName}" hidden selected>${shop.categoryName}</option>
                    <c:forEach var="vo" items="${categoryName}">
                        <option value="${vo.categoryName}">${vo.categoryName}</option>
                    </c:forEach>
                </select>
                <select name="mcategoryName" id="mcategorySearch" onchange="dcategoryNameSearch(this.value);">
                    <option value="${shop.mcategoryName}">${shop.mcategoryName}</option>
                </select>
                <select name="dcategoryName" id="dcategorySearch">
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
        <table id="pImgTable">
            <tr>
                <th>상품사진</th>
                <td><input type="file" name="photo" id="pImg" multiple></td>
            </tr>
            <tr>
                <th>현재등록된 상품사진</th>
                <c:if test="${empty pImageList}">
                    <td>등록된 사진이 없습니다</td>
                </c:if>
                <c:if test="${not empty pImageList && pImageList.size() != 0}">
                    <c:forEach var="vo" items="${pImageList}">
                        <td style="display: inline-block; width: 200px; height: 160px;">
                            <img style="width: 100%; height: 100%;" 
                            src="${pageContext.request.contextPath}/resources/images/${vo.fileName}"
                            onclick="pImageDelete('${vo.fileIdx}', '${vo.getPIdx()}')"></td>
                    </c:forEach>
                </c:if>
            </tr>
        </table>
        <table>
            <tr>
                <th>상품설명</th>
                <td><textarea name="pEx" id="pEx" cols="50" rows="20">${pEx}</textarea></td>
            </tr>
        </table>
        <input type="button" class="btn btn-default" id="updateBtn" value="수정하기" onclick="pUpdate(this.form);">
        <input type="button" class="btn btn-danger" id="canselBtn" value="수정취소" onclick="updateCancel();">
    </form>
</body>
</html>
