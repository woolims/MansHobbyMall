<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배송지 관리</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #f4f4f4;
            padding: 1rem;
            text-align: center;
        }

        main {
            padding: 1rem;
        }

        .address-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 1rem 0;
        }

        .address-content {
            flex: 1;
            margin-left: 1rem;
        }

        .address-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-right: 100px;
        }

        .edit-btn, .delete-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            cursor: pointer;
            margin-bottom: 0.5rem;
            width: 100px;
        }

        .delete-btn {
            background-color: #e74c3c;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .add-address-btn {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            cursor: pointer;
            font-size: 1.1rem;
            margin-top: 1rem;
        }

        .add-address-btn:hover {
            background-color: #27ae60;
        }

        /* 모달 스타일 */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgba(0, 0, 0, 0.5);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 90%; 
            max-width: 500px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        label {
            text-align: left;
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin: 4px 0 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <header>
        <h1>배송지 관리</h1>
    </header>
    <main>
        <c:forEach var="address" items="${addressList}" varStatus="status">
            <div class="address-item" id="address-${status.index}">
                <div class="address-content" style="text-align: left; margin-left: 100px;">
                    <h2>배송지 ${status.index + 1}</h2>
                    <p><strong>주소:</strong> ${address.daAddr}</p>
                    <p><strong>상세주소:</strong> ${address.subDaAddr}</p>
                </div>
                <div class="address-actions">
                    <button class="edit-btn" onclick="openEditModal('${address.daIdx}', '${address.daAddr}', '${address.subDaAddr}')">수정</button>
                    <button class="delete-btn" onclick="deleteAddress('${address.daIdx}')">삭제</button>
                </div>
            </div>
        </c:forEach>

        <button class="add-address-btn" onclick="openAddModal()">새 주소 추가</button>
    </main>

    <!-- 수정 모달 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>주소 수정</h2>
            <form id="editAddressForm" onsubmit="submitEdit(event)">
                <input type="hidden" id="daIdx" name="daIdx">
                <label for="daAddr">주소:</label>
                <input type="text" id="daAddr" name="daAddr" required>
                <label for="subDaAddr">상세주소:</label>
                <input type="text" id="subDaAddr" name="subDaAddr" required>
                <input type="submit" value="수정">
            </form>
        </div>
    </div>

    <!-- 새 주소 추가 모달 -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeAddModal()">&times;</span>
            <h2>새 주소 추가</h2>
            <form id="addAddressForm" onsubmit="submitAdd(event)">
                <label for="newDaAddr">주소:</label>
                <input type="text" id="newDaAddr" name="daAddr" required>
                <label for="newSubDaAddr">상세주소:</label>
                <input type="text" id="newSubDaAddr" name="subDaAddr" required>
                <input type="submit" value="추가">
            </form>
        </div>
    </div>

    <script>
        function openEditModal(daIdx, daAddr, subDaAddr) {
            document.getElementById("daIdx").value = daIdx;
            document.getElementById("daAddr").value = daAddr;
            document.getElementById("subDaAddr").value = subDaAddr;
            document.getElementById("editModal").style.display = "block";
        }

        function closeEditModal() {
            document.getElementById("editModal").style.display = "none";
        }

        function submitEdit(event) {
            event.preventDefault();
            const addressId = document.getElementById("daIdx").value;
            const address = document.getElementById("daAddr").value;
            const subAddress = document.getElementById("subDaAddr").value;
            
            // AJAX 요청을 통해 수정된 주소와 관련된 데이터 전송
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "updateAddress.do", true); // 서버의 수정 API 호출
            xhr.setRequestHeader("Content-Type", "application/json");

            xhr.onload = function () {
                if (xhr.status === 200) {
                    alert("주소 수정 완료!");
                    // 여기에 구매 금액 또는 리뷰 개수 업데이트 로직 추가
                    location.reload();
                } else {
                    alert("수정 중 오류가 발생했습니다.");
                }
                closeEditModal();
            };

            // 서버에 수정된 주소 정보를 JSON 형식으로 전송
            const data = JSON.stringify({
                daIdx: addressId,
                daAddr: address,
                subDaAddr: subAddress
            });
            xhr.send(data);
        }

        function openAddModal() {
            document.getElementById("newDaAddr").value = '';
            document.getElementById("newSubDaAddr").value = '';
            document.getElementById("addModal").style.display = "block";
        }

        function closeAddModal() {
            document.getElementById("addModal").style.display = "none";
        }

        function submitAdd(event) {
            event.preventDefault();
            const newAddress = document.getElementById("newDaAddr").value;
            const newSubAddress = document.getElementById("newSubDaAddr").value;

            // AJAX 요청을 통해 새 주소 정보를 서버에 전송
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "addAddress.do", true); // 서버의 추가 API 호출
            xhr.setRequestHeader("Content-Type", "application/json");

            xhr.onload = function () {
                if (xhr.status === 200) {
                    alert("새 주소 추가 완료!");
                    // 여기에서 추가된 주소를 UI에 반영하는 로직을 추가할 수 있습니다.
                    location.reload(); // 페이지 새로고침으로 업데이트 반영
                } else {
                    alert("주소 추가 중 오류가 발생했습니다.");
                }
                closeAddModal();
            };

            // 서버에 새 주소 정보를 JSON 형식으로 전송
            const data = JSON.stringify({
                daAddr: newAddress,
                subDaAddr: newSubAddress
            });
            xhr.send(data);
        }

        function deleteAddress(addressId) {
            if (confirm("정말로 이 주소를 삭제하시겠습니까?")) {
                console.log("주소 삭제 요청: " + addressId);
                // AJAX 요청을 통해 삭제 요청을 서버에 전송하는 로직 추가
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "deleteAddress.do", true);
                xhr.setRequestHeader("Content-Type", "application/json");

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        alert("주소 삭제 완료!");
                        location.reload(); // 페이지 새로고침으로 업데이트 반영
                    } else {
                        alert("주소 삭제 중 오류가 발생했습니다.");
                    }
                };

                const data = JSON.stringify({ daIdx: addressId });
                xhr.send(data);
            }
        }
    </script>
</body>
</html>
