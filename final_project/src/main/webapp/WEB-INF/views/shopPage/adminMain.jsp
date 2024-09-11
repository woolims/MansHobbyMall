<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <!-- Bootstrap 3.x-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <meta charset="UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: auto;
                overflow: hidden;
            }

            header {
                background: #333;
                color: #fff;
                padding-top: 30px;
                min-height: 70px;
                border-bottom: #ccc 3px solid;
            }

            header a {
                color: #fff;
                text-decoration: none;
                text-transform: uppercase;
                font-size: 16px;
            }

            header ul {
                margin: 50px;
                padding: 0;
                list-style: none;
                text-align: center;
            }

            header ul li {
                display: inline;
                margin: 0 50px;
                cursor: pointer;
            }

            #content {
                background: #fff;
                height: 850px;
                margin-bottom: 50px;
                padding: 20px;
            }

            /* $$$$$$$$ */

            table {

                text-align: center;
                width: 100%;
                border-collapse: collapse;
            }

            th,
            td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
                width: 12.5%;
                /* 예시로 전체 열 너비를 12.5%로 설정 */
            }

            td {
                /* 필요에 따라 추가적인 스타일을 설정할 수 있습니다 */
            }

            #menu2 {
                margin: auto;
                width: 80%;
            }

            #menu2 td {

                text-align: center;
            }

            #menu2 th {

                text-align: center;
            }

            select{
                display: inline-block;
                width: 97px;
            }

            #searchs{
                display: inline-block;
            }
            #searchParam{
                width: 300px;
            }
        </style>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
            function confirmDelete(f) {
                if (confirm("정말 삭제하시겠습니까?") == false) return;


                f.action = "delete.do";
                f.submit();
            }


            function confirmProductDelete(f) {
                if (confirm("정말 삭제하시겠습니까?") == false) return;
                f.action = "pDelete.do";
                f.submit();
            }

            function pUpdate(f) {
                // let pIdx = f.pIdx.value;
                // let categoryName = f.categoryName.value;
                // let mcategoryName = f.mcategoryName.value;
                // let dcategoryName = f.dcategoryName.value;
                // let pName = f.pName.value;
                // let amount = f.amount.value;
                // let price = f.price.value;
                if (confirm("수정하시겠습니까?") == false) return;
                f.action = "pUpdateForm.do";
                f.submit();
            }

            function mcategoryName(val){
                // 대분류가 전체보기일 때
                if($("#categorySearch").val()=='전체보기') {
                    let categoryName = val;
                    $.ajax({
                        url: "/admin/adminAjaxPList.do",
                        data: {"categoryName": categoryName},
                        dataType: "json",
                        method: 'GET',
                        success: function (res_data) {
                            var mSelect = $('#mcategorySearch');
                            var dSelect = $('#dcategorySearch');
                            var searchParam = $('#searchParam');
                            
                            searchParam.val("");
                            mSelect.empty();
                            dSelect.empty();
                            mSelect.append($('<option></option>').val('선택 안 함').text('선택 안 함'))
                            dSelect.append($('<option></option>').val('선택 안 함').text('선택 안 함'))
                        },
                        error: function (err) {
                            console.log(err.responseText);
                        }
                    });
                    return;
                }
                // 대분류가 전체보기가 아닐 때
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
                        mselect.append($('<option></option>').val('선택 안 함').text('선택 안 함'))
                        dselect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                        dselect.append($('<option></option>').val('선택 안 함').text('선택 안 함'))
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
                if(val == '선택 안 함') {
                    let mcategoryName = val;
                    $.ajax({
                        url: "/admin/adminAjax.do",
                        data: {"mcategoryName": mcategoryName},
                        dataType: "json",
                        method: 'GET',
                        success: function (res_data) {
                            var dSelect = $('#dcategorySearch');
                            dSelect.empty();
                            dSelect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                            dSelect.append($('<option></option>').val('선택 안 함').text('선택 안 함'))
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
                    success: function (res_data) {
                        console.log(res_data)
                        var dselect = $('#dcategorySearch');
                        dselect.empty();
                        dselect.append($('<option disabled selected hidden></option>').val('소분류 선택').text('소분류 선택'))
                        dselect.append($('<option></option>').val('선택 안 함').text('선택 안 함'))
                        $.each(res_data, function(index, item) {
                            dselect.append($('<option></option>').val(item.dcategoryName).text(item.dcategoryName));
                        });
                    },
                    error: function (err) {
                        console.log(err.responseText);
                    }
                });
            }

            function pSearch(f){
                let searchParam = f.searchParam.value.trim();
                let categoryName = $("#categorySearch").val();
                let mcategoryName = $("#mcategorySearch").val();
                let dcategoryName = $("#dcategorySearch").val();

                if(categoryName=='대분류 선택'){
                    if(searchParam==""){
                        alert('카테고리를 선택하거나 검색어를 입력하세요')
                        f.searchParam.focus();
                        return;
                    }
                    categoryName="";
                }

                if(categoryName=="전체보기" && searchParam==""){
                    $.ajax({
                    url: "/admin/adminAjaxPList.do",
                    dataType: "json",
                    method: 'GET',
                    success: function(res_data) {
                        var pListHtml = ``;
                        $.each(res_data, function(index, pVo) { 
                            pListHtml +=`
                            <table>
                                <tr id="p_th">
                                    <th>상품번호</th>
                                    <th>대분류</th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>상품이름</th>
                                    <th>상품갯수</th>
                                    <th>상품가격</th>
                                    <th>작업</th>
                                </tr>
                                <tr>
                                    <td>\${pVo.pidx}</td>
                                    <td>\${pVo.categoryName}</td>
                                    <td>\${pVo.mcategoryName}</td>
                                    <td>\${pVo.dcategoryName}</td>
                                    <td>\${pVo.pname}</td>
                                    <td>\${pVo.amount}</td>
                                    <td>\${pVo.price}</td>
                                    <td>
                                        <form>
                                            <input type="hidden" name="pIdx" value="\${pVo.pidx}">
                                            <input type="hidden" name="categoryName" value="\${pVo.categoryName}">
                                            <input type="hidden" name="mcategoryName" value="\${pVo.mcategoryName}">
                                            <input type="hidden" name="dcategoryName" value="\${pVo.dcategoryName}">
                                            <input type="hidden" name="pName" value="\${pVo.pname}">
                                            <input type="hidden" name="amount" value="\${pVo.amount}">
                                            <input type="hidden" name="price" value="\${pVo.price}">
                                            <input type="button" class="btn btn-default" value="수정" onclick="pUpdate(this.form);">
                                        </form>
                                        <form>
                                            <input type="hidden" name="pIdx" value="\${pVo.pidx}">
                                            <input type="button" class="btn btn-danger" value="삭제" onclick="confirmProductDelete(this.form);">
                                        </form>
                                    </td>
                                </tr>
                            </table><br><br>`
                        });
                        // HTML을 특정 컨테이너에 삽입
                        $("#pList").html(pListHtml);
                    },
                    error: function(err){
                        console.log(err.responseText);
                    }
                });
                }

                if(mcategoryName=='선택 안 함'){
                    mcategoryName="";
                }

                if(dcategoryName=='선택 안 함'){
                    dcategoryName="";
                }

                $.ajax({
                    url: "/admin/adminAjaxPList.do",
                    data: { "searchParam":searchParam,"categoryName":categoryName ,"mcategoryName": mcategoryName,"dcategoryName":dcategoryName},
                    dataType: "json",
                    method: 'GET',
                    success: function(res_data) {
                        if(res_data.length==0){
                            alert("검색결과가 없습니다");
                            return;
                        }
                        console.log(res_data);
                        var pListHtml = ``;
                        $.each(res_data, function(index, pVo) { 
                            pListHtml +=`
                            <table>
                                <tr id="p_th">
                                    <th>상품번호</th>
                                    <th>대분류</th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>상품이름</th>
                                    <th>상품갯수</th>
                                    <th>상품가격</th>
                                    <th>작업</th>
                                </tr>
                                <tr>
                                    <td>\${pVo.pidx}</td>
                                    <td>\${pVo.categoryName}</td>
                                    <td>\${pVo.mcategoryName}</td>
                                    <td>\${pVo.dcategoryName}</td>
                                    <td>\${pVo.pname}</td>
                                    <td>\${pVo.amount}</td>
                                    <td>\${pVo.price}</td>
                                    <td>
                                        <form>
                                            <input type="hidden" name="pIdx" value="\${pVo.pidx}">
                                            <input type="hidden" name="categoryName" value="\${pVo.categoryName}">
                                            <input type="hidden" name="mcategoryName" value="\${pVo.mcategoryName}">
                                            <input type="hidden" name="dcategoryName" value="\${pVo.dcategoryName}">
                                            <input type="hidden" name="pName" value="\${pVo.pname}">
                                            <input type="hidden" name="amount" value="\${pVo.amount}">
                                            <input type="hidden" name="price" value="\${pVo.price}">
                                            <input type="button" class="btn btn-default" value="수정" onclick="pUpdate(this.form);">
                                        </form>
                                        <form>
                                            <input type="hidden" name="pIdx" value="\${pVo.pidx}">
                                            <input type="button" class="btn btn-danger" value="삭제" onclick="confirmProductDelete(this.form);">
                                        </form>
                                    </td>
                                </tr>
                            </table><br><br>`
                        });
                        // HTML을 특정 컨테이너에 삽입
                        $("#pList").html(pListHtml);
                    },
                    error: function(err){
                        console.log(err.responseText);
                    }
                });
                return;
            }

            function pInsert(){
                location.href = "/admin/pInsertForm.do";
            }
        </script>

    </head>

    <body>
        <%@ include file="../menubar/navbar.jsp" %>
            <header>
                <div>
                    <h1>Admin Dashboard</h1>
                    <ul class="nav nav-tabs">
                        <li class="disactive active"><a data-toggle="tab" href="#menu1">회원 관리</a></li>
                        <li class="disactive"><a data-toggle="tab" href="#menu2">상품 관리</a></li>
                        <li class="disactive"><a data-toggle="tab" href="#menu3">주문 관리</a></li>
                        <li class="disactive"><a data-toggle="tab" href="#menu4">공지사항 관리</a></li>
                    </ul>
                </div>
            </header>

            <div class="tab-content">
                <div id="menu1" class="tab-pane fade in active">
                    <h2>회원 관리</h2>

                    <c:choose>
                        <c:when test="${empty list}">
                            <!-- list2가 null이거나 비어있을 때 표시할 내용 -->
                            <h1>내역이 없습니다.</h1>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="vo" items="${list}">
                                <table>
                                    <tr>
                                        <th>회원 ID</th>
                                        <th>이름</th>
                                        <th>이메일</th>
                                        <th>가입일</th>
                                        <th>보유포인트</th>
                                        <th>회원삭제</th>
                                    </tr>
                                    <tr>
                                        <td>${vo.getId()}</td>
                                        <td>${vo.getName()}</td>
                                        <td>${vo.getEmail()}</td>
                                        <td>${vo.getCreateAt()}</td>
                                        <td>${vo.getPoint()}</td>
                                        <td>
                                            <form>
                                                <input type="hidden" name="userIdx" value="${vo.getUserIdx()}">
                                                <input type="button" value="삭제하기"
                                                    onclick="confirmProductDelete(this.form);">
                                            </form>
                                        </td>
                                    </tr>
                                </table>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div id="menu2" class="tab-pane">
                    <div style="display: inline-block;">
                        <h2>상품 관리</h2>  
                    </div>
                    <div style="display: inline-block;">
                        <input type="button" class="btn btn-success" name="pInsert" id="pInsert" onclick="pInsert();" value="상품 등록">
                    </div>
                        <div>
                            <select name="categorySearch" id="categorySearch" onchange="mcategoryName(this.value);">
                                <option value="대분류 선택" hidden selected>대분류 선택</option>
                                <option value="전체보기">전체보기</option>
                                <c:forEach var="vo" items="${categoryName}">
                                    <option value="${vo.getCategoryName()}">${vo.getCategoryName()}</option>
                                </c:forEach>
                            </select>
                            <select name="mcategorySearch" id="mcategorySearch" onchange="dcategoryName(this.value);">
                                <option value="중분류 선택" hidden selected disabled>중분류 선택</option>
                                <option value="선택 안 함">선택 안 함</option>
                            </select>
                            <select name="dcategorySearch" id="dcategorySearch">
                                <option value="소분류 선택" hidden selected disabled>소분류 선택</option>
                                <option value="선택 안 함">선택 안 함</option>
                            </select>
                        </div>
                        <form id="searchs">
                            <input type="text" name="searchParam" id="searchParam" placeholder="상품명을 입력하세요" autofocus>
                            <input type="button" class="btn btn-default" name="searchBtn" id="searchBtn" value="검색" onclick="pSearch(this.form);">
                        </form>
                    <c:choose>
                        <c:when test="${empty pList}">
                            <h1>내역이 없습니다.</h1>
                        </c:when>
                        <c:otherwise>
                            <div id="pList">
                                <c:forEach var="pVo" items="${pList}">
                                    <table>
                                        <tr id="p_th">
                                            <th>상품번호</th>
                                            <th>대분류</th>
                                            <th>중분류</th>
                                            <th>소분류</th>
                                            <th>상품이름</th>
                                            <th>상품갯수</th>
                                            <th>상품가격</th>
                                        </tr>
                                        <tr>
                                            <td>${pVo.getPIdx()}</td>
                                            <td>${pVo.getCategoryName()}</td>
                                            <td>${pVo.getMcategoryName()}</td>
                                            <td>${pVo.getDcategoryName()}</td>
                                            <td>${pVo.getPName()}</td>
                                            <td>${pVo.getAmount()}</td>
                                            <td>${pVo.getPrice()}</td>
                                            <form>
                                                <input type="hidden" name="pIdx" value="${pVo.getPIdx()}">
                                                <input type="hidden" name="categoryName" value="${pVo.getCategoryName()}">
                                                <input type="hidden" name="mcategoryName" value="${pVo.getMcategoryName()}">
                                                <input type="hidden" name="dcategoryName" value="${pVo.getDcategoryName()}">
                                                <input type="hidden" name="pName" value="${pVo.getPName()}">
                                                <input type="hidden" name="amount" value="${pVo.getAmount()}">
                                                <input type="hidden" name="price" value="${pVo.getPrice()}">
                                                <input type="button" class="btn btn-default" value="수정"
                                                    onclick="pUpdate(this.form);">
                                            </form>
                                            <form>
                                                <input type="hidden" name="pIdx" value="${pVo.getPIdx()}">
                                                <input type="button" class="btn btn-danger" value="삭제"
                                                    onclick="confirmProductDelete(this.form);">
                                            </form>
                                        </tr>
                                    </table>
                                    <br>
                                    <br>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>


                </div>
            </div>
            <!-- 푸터 -->
            <%@ include file="../menubar/footer.jsp" %>
    </body>

    </html>