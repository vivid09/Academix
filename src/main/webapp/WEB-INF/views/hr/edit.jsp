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
       
        .content-wrapper {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 500px;
           
        }
        .title {
            text-align: center;
            margin-bottom: 20px;
        }
        form div {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        label {
            flex-basis: 45%;
            display: flex;
            align-items: center;
        }
        input[type="text"], input[type="password"], input[type="date"], input[type="file"], select {
            flex-basis: 45%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
  
  
  <div class="content-wrapper">
        <h2 class="title">직원 및 강사 수정</h2>
        <form action="${contextPath}/hr/employeeModify.do" 
              method="POST" enctype="multipart/form-data">
            <div>
                <label for="profile">프로필</label>
                <input type="file" name="profile" id="profile" value="${employee.profilePicturePath}">
            </div>
            <div>
                <label for="name">이름</label>
                <input type="text" name="name" id="name" value="${employee.name}">
            </div>
            <div>
                <label for="email">이메일</label>
                <input type="text" name="email" id="email" value="${employee.email}">
            </div>
            <div>
                <label for="pw">비밀번호</label>
                <input type="password" name="pw" id="pw" value="${employee.password}">
            </div>
            <div>
                <label for="phone">전화번호</label>
                <input type="text" name="phone" id="phone" value="${employee.phone}">
            </div>
            <div>
                <label for="address">주소</label>
                <input type="text" name="address" id="address" value="${employee.address}">
            </div>
            <div>
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
            <div>
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
            </div>
            <div>
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
            <div>
	                <input type="hidden" name="departmentNo" id="departmentNo" value="${employee.depart.departmentNo}">
            </div>
            <div>
                <input type="hidden" name="rankNo" id="rankNo" value="${employee.rank.rankNo}">
            </div>
            <div>
                <label for="hireDate">입사일</label>
                <input type="date" name="hireDate" id="hireDate"  value="${employee.hireDate}">
            </div>
            <div>
                <label for="exitDate">퇴사일</label>
                <input type="date" name="exitDate" id="exitDate" value="${employee.exitDate}">
            </div>
            <div>
                <label for="parentDepartNo">부모부서번호</label>
                <select name="parentDepartNo" id="parentDepartNo" >
                  <option value="${employee.depart.parentDepartNo}">
                   <c:choose>
				        <c:when test="${employee.depart.parentDepartNo eq '1'}">행정부</c:when>
				        </c:choose>
                  </option>
                  <option value="1">행정부</option>
                </select>
                <input type="hidden" name="employeeNo" value="${employee.employeeNo}">
                
            </div>
            <button type="submit">수정하기</button>
        </form>
    </div>
  
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