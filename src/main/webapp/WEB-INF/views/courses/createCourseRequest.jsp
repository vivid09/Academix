<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="강의 개설 신청" name="title"/>
 </jsp:include>
 
 <style>
	.content-wrapper {
	  padding: 20px;
	}
	.content-header {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	.content-header h1 {
	  font-size: 24px;
	  margin: 0;
	}
	
	
  .form-container {
      margin-top: 50px;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
  }
  
	.form-row {
    display: flex;
  }
  
  .col-md-6 {
  	padding-left: 0px;
  }
 </style>
 

   <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        강의 개설 신청
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/main.page"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">강의 개설 신청</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container">
            <div class="form-container">
							<form id="frm-course-register"
							      method="POST"
							      enctype="multipart/form-data"
							      action="${contextPath}/courses/createCourseRequest.do">
							    <div class="form-row">
							        <div class="form-group col-md-6">
							            <label for="title">강의명</label>
							            <input type="text" class="form-control" id="title" name="title" placeholder="강의 명을 입력하세요">
							        </div>
							        <div class="form-group col-md-6">
							            <label for="coursePlan">강의계획서</label>
							            <div class="custom-file">
							                <input type="file" accept=".pdf" class="custom-file-input" id="coursePlan" name="coursePlan">
							            </div>
							        </div>
							    </div>
							    <div class="form-row">
							        <div class="form-group col-md-6">
							            <label for="description">설명</label>
							            <textarea class="form-control" id="description" name="description" rows="6" placeholder="강의 설명을 입력하세요"></textarea>
							        </div>
							        <div class="form-group col-md-6">
							            <div class="form-group col-md-6">
							                <label for="startDate">시작 일</label>
							                <input type="date" class="form-control" id="startDate" name="startDate">
							            </div>
							            <div class="form-group col-md-6">
							                <label for="endDate">종료 일</label>
							                <input type="date" class="form-control" id="endDate" name="endDate">
							            </div>
					                <label for="courseState">상태</label><br>
					                <select name="courseState" id="courseState">
					                        <option value="0">미처리</option>
					                        <option value="1">승인</option>
					                        <option value="2">반려</option>
			                    </select>
							        </div>
							    </div>
							    <div class="form-row">
							        <input type="hidden" id="empNo" name="empNo" value="${sessionScope.user.employeeNo}">
							        <button type="submit" class="btn btn-primary mr-2">저장</button>
							        <button type="button" class="btn btn-secondary">취소</button>
							    </div>
							</form>
            </div>
        </div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  

<!-- jQuery 2.2.3 -->
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/bootstrap/js/bootstrap.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Slimscroll -->
<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>
<!-- Page specific script -->
<script>
	

</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />