<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp" />

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>학생 상담</h1>
      <div class="col-md-2">
        <a href="${contextPath}/studentMng/registerConsulting.page" class="btn btn-primary btn-block margin-bottom">상담 등록하기</a>
      </div>
      <div class="col-md-10"></div>
    
    </section>
    
    
    
    
    
    
  </div>




<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />