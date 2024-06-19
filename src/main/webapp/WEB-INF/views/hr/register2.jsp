<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Contact</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .content-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f9;
        }
        .title {
            font-size: 24px;
            margin-bottom: 20px;
        }
        form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        form > div {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        form > div label {
            width: 150px;
            font-weight: bold;
        }
        form > div input,
        form > div select {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        form > div input[type="file"] {
            padding: 3px;
        }
        form > button {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }
        form > button:hover {
            background-color: #0056b3;
        }
        .profile-picture {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        .profile-picture img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="content-wrapper">
        <h2 class="title">직원 및 강사 등록</h2>
        <form action="${contextPath}/hr/employeeRegister.do" method="POST" enctype="multipart/form-data">
            <div class="profile-picture">
                <img src="path_to_default_image.png" alt="Profile Picture">
                <input type="file" name="profile" id="profile">
            </div>
            <div>
                <label for="name">이름</label>
                <input type="text" name="name" id="name">
            </div>
            <div>
                <label for="email">이메일</label>
                <input type="text" name="email" id="email">
            </div>
            <div>
                <label for="pw">비밀번호</label>
                <input type="password" name="pw" id="pw">
            </div>
            <div>
                <label for="phone">전화번호</label>
                <input type="text" name="phone" id="phone">
            </div>
            <div>
                <label for="address">주소</label>
                <input type="text" name="address" id="address">
            </div>
            <div>
                <label for="departName">부서명</label>
                <input type="text" name="departName" id="departName">
            </div>
            <div>
                <label for="rankTitle">직급명</label>
                <input type="text" name="rankTitle" id="rankTitle">
            </div>
            <div>
                <label for="employeeStatus">사원상태</label>
                <input type="text" name="employeeStatus" id="employeeStatus">
            </div>
            <div>
                <label for="departmentNo">부서번호</label>
                <input type="text" name="departmentNo" id="departmentNo">
            </div>
            <div>
                <label for="rankNo">직책번호</label>
                <input type="text" name="rankNo" id="rankNo">
            </div>
            <div>
                <label for="hireDate">입사일</label>
                <input type="date" name="hireDate" id="hireDate">
            </div>
            <div>
                <label for="exitDate">퇴사일</label>
                <input type="date" name="exitDate" id="exitDate">
            </div>
            <div>
                <label for="parentDepartNo">부모부서번호</label>
                <input type="text" name="parentDepartNo" id="parentDepartNo">
            </div>
            <button type="submit">등록하기</button>
        </form>
    </div>

    <script>
        // 부서명과 번호 매핑
        const departmentMap = {
            '대표실': 0,
            '행정부': 1,
            '인사팀': 2,
            '운영팀': 3,
            '강사': 4
        };

        // 직급명과 번호 매핑
        const rankMap = {
            '대표이사': 0,
            '수석': 1,
            '책임': 2,
            '주임': 3,
            '사원': 4,
            '강사': 5
        };

        // 부서명 입력 필드에 이벤트 리스너 추가
        document.getElementById('departName').addEventListener('input', function() {
            const departmentNo = departmentMap[this.value] !== undefined ? departmentMap[this.value] : '';
            document.getElementById('departmentNo').value = departmentNo;
        });

        // 직급명 입력 필드에 이벤트 리스너 추가
        document.getElementById('rankTitle').addEventListener('input', function() {
            const rankNo = rankMap[this.value] !== undefined ? rankMap[this.value] : '';
            document.getElementById('rankNo').value = rankNo;
        });
    </script>
</body>
</html>
