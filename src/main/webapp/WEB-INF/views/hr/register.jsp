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

  
</style>
  
  
  <div class="content-wrapper">
  <h2 class="title">직원 및 강사 등록</h2>
  
  
  <form action="${contextPath}/hr/employeeRegister.do"
        method="POST">
    <div>
  	  <div>
  	  <label for="profile">프로필</label>
  	  <img>
  	  </div>
  	  <div>
  	    <label for="name">이름</label>
  	    <input type="text" name="name" id="name">
  	    <label for="email">이메일</label>
  	    <input type="text" name="email" id="email">
  	  </div>
  	  <div>
  	     <label for="pw">비밀번호</label>
  	    <input type="text" name="pw" id="pw">
  	     <label for="phone">전화번호</label>
  	    <input type="text" name="phone" id="phone">
  	  </div>
  	  <div>
  	    <label for="address">주소</label>
  	    <input type="text" name="address" id="address">
  	    <label for="departName">부서명</label>
  	    <input type="text" name="departName" id="departName">
  	  </div>
  	  <div>
  	    <label for="rankTitle">직급명</label>
  	    <input type="text" name="rankTitle" id="rankTitle">
  	    <label for="employeeStatus">사원상태</label>
  	    <input type="text" name="employeeStatus" id="employeeStatus">
  	  </div>
  	  <div>
  	    <label for="hireDate">입사일</label>
  	    <input type="date" name="hireDate" id="hireDate">
  	    <label for="exitDate">퇴사일</label>
  	    <input type="date" name="exitDate" id="exitDate">
  	    <label for="parentDepartNo">부모부서번호</label>
  	    <input type="text" name="parentDepartNo" id="parentDepartNo">
  	  </div>
  	</div>  
  </form>
  
  <script >
  
  
  
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />