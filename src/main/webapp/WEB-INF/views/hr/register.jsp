<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>


<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="전자결재" name="title"/>
 </jsp:include>

<style>
       
          <style>
     
        .title {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }
        .form-st {
            background-color: white;
            width: 95%;
            margin: 0 auto;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .form-row {
            display: flex;
            justify-content: space-between;
            gap: 15px;
        }
        .form-group {
            flex: 1;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group input[type="text"], 
        .form-group input[type="password"], 
        .form-group input[type="date"], 
        .form-group input[type="file"], 
        .form-group select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group input[type="file"] {
            padding: 3px;
        }
        button {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .upload-cover-photo {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .upload-cover-photo img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>

    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        직원 및 강사 등록
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">직원 및 강사 등록</li>
      </ol>
    </section>
    
    <!-- Main content -->
    <section class="content">
        <div class="form-st">
            <form action="${contextPath}/hr/employeeRegister.do" method="POST" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="form-group">
                        <label for="profile">프로필</label>
                        <input type="file" name="profile" id="profile">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" name="name" id="name">
                    </div>
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="text" name="email" id="email">
                        <button type="button" id="btn-email">중복확인</button>
                        <span id="msg-email"></span>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="pw">비밀번호</label>
                        <input type="password" name="pw" id="pw">
                    </div>
                    <div class="form-group">
                        <label for="phone">전화번호</label>
                        <input type="text" name="phone" id="phone">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="address">주소</label>
                        <input type="text" name="address" id="address">
                    </div>
                    <div class="form-group">
                        <label for="departmentNo">부서명</label>
                        <select name="departmentNo" id="departmentNo">
                            <option>부서 선택</option>
                            <option value="0">대표실</option>
                            <option value="2">인사팀</option>
                            <option value="3">운영팀</option>
                            <option value="4">강사</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="rankNo">직급명</label>
                        <select name="rankNo" id="rankNo">
                            <option>직급 선택</option>
                            <option value="0">대표이사</option>
                            <option value="1">수석</option>
                            <option value="2">책임</option>
                            <option value="3">주임</option>
                            <option value="4">사원</option>
                            <option value="5">강사</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="employeeStatus">사원상태</label>
                        <select name="employeeStatus" id="employeeStatus">
                            <option>직원 상태</option>
                            <option value="1">재직</option>
                            <option value="0">퇴직</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="hireDate">입사일</label>
                        <input type="date" name="hireDate" id="hireDate">
                    </div>
                    <div class="form-group">
                        <label for="exitDate">퇴사일</label>
                        <input type="date" name="exitDate" id="exitDate">
                    </div>
                </div>
                <button type="submit">등록하기</button>
            </form>
        </div>
        
        
        <div class="modal fade" id="modal-email">
          <div>
           <input type="text">
          </div>
        </div>
        
    </section>    
  </div>
  
<!-- jQuery 2.2.3 -->
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>  
  
  <script >
  var emailCheck = false;
  
  // 이메일 유효성 및 중복 체크 함수
const fnCheckEmail = () => {
    let inpEmail = document.getElementById('email');
    let regEmail = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    
    if (!regEmail.test(inpEmail.value)) {
        alert('이메일 형식이 올바르지 않습니다.');
        return false;
    }
    
    fetch('${contextPath}/hr/checkEmail.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            'email': inpEmail.value
        })
    })
    .then(response => response.json())
    .then(resData => {
        if (resData.enableEmail) {
            document.getElementById('msg-email').innerHTML = '사용 가능한 이메일 입니다';
            return true; // 이메일 중복 없음
        } else {
            document.getElementById('msg-email').innerHTML = '이미 사용 중인 이메일입니다.';
            return false; // 이메일 중복 있음
        }
    })
    .catch(error => {
        console.error('Error checking email:', error);
        return false;
    });
}



  

 document.getElementById('btn-email').addEventListener('click',fnCheckEmail);
    
 
  
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />