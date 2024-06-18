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
       
    .profile-container img {
	  width: 100px;
	  height: 100px;
	  border-radius: 50%;
	  object-fit: cover;
	  display: block;
	  margin: 0 auto 20px;
	} 
       
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
  
  
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        수정
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">수정</li>
      </ol>
    </section>
    
      <!-- Main content -->
    <section class="content"> 
        <div class="form-st">
         <form action="${contextPath}/hr/employeeModify.do" 
              method="POST" enctype="multipart/form-data">
           <div class="form-row">
             <div class="form-group profile-container">
                <label for="profile">프로필</label>
                <span>${employee.profilePicturePath}</span>
                <input type="file" name="profile" id="profile" value="${employee.profilePicturePath}">
             </div>
           </div> 
           <div class="form-row">
              <div class="form-group">
                <label for="name">이름</label>
                <input type="text" name="name" id="name" value="${employee.name}">
              </div>
              <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" name="email" id="email" value="${employee.email}">
              </div>
            </div>
            
           <div class="form-row">
             <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" name="pw" id="pw">
             </div>
             <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" name="phone" id="phone" value="${employee.phone}">
             </div>
           </div>
           <div class="form-row">
             <div class="form-group">
                <label for="address">주소</label>
                <input type="text" name="address" id="address" value="${employee.address}">
             </div>
             <div class="form-group">
                <label for="departName">부서명</label>
                <select name="departName" id="departName">
                  <option>${employee.depart.departName}</option>
                  <option value="대표실">대표실</option>
                  <option value="행정부">행정부</option>
                  <option value="인사팀">인사팀</option>
                  <option value="운영팀">운영팀</option>
                  <option value="강사">강사</option>
                </select>
            </div>
           </div> 
           <div class="form-row">
             <div class="form-group">
                <label for="rankTitle">직급명</label>
                <select name="rankTitle" id="rankTitle" >
                 <option>${employee.rank.rankTitle}</option>
                 <option value="대표이사">대표이사</option>
                 <option value="수석">수석</option>
                 <option value="책임">책임</option>
                 <option value="주임">주임</option>
                 <option value="사원">사원</option>
                 <option value="강사">강사</option>
                </select>
             </div >
             <div class="form-group">
                <label for="employeeStatus">사원상태</label>
                <select name="employeeStatus" id="employeeStatus">
                  <option value="${employee.employeeStatus}">
                    <c:choose>
				            <c:when test="${employee.employeeStatus eq '1'}">재직</c:when>
				            <c:when test="${employee.employeeStatus eq '0'}">퇴직</c:when>
				        </c:choose>
                  </option>
                  <option value="1">재직</option>
                  <option value="0">퇴직</option>
                  <option></option>
                </select>
            </div>
           </div>
            <div>
	                <input type="hidden" name="departmentNo" id="departmentNo" value="${employee.depart.departmentNo}">
            </div>
            <div>
                <input type="hidden" name="rankNo" id="rankNo" value="${employee.rank.rankNo}">
            </div>
            <div class="form-row">
             <div class="form-group">
                <label for="hireDate">입사일</label>
                <input type="date" name="hireDate" id="hireDate"  value="${employee.hireDate}">
             </div>
             <div class="form-group">
                <label for="exitDate">퇴사일</label>
                <input type="date" name="exitDate" id="exitDate" value="${employee.exitDate}">
             </div>
           </div>
            <div>
                
                <input type="hidden" name="employeeNo" value="${employee.employeeNo}">
                
            </div>
            <button type="submit">수정하기</button>
        </form>
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

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />