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
      <h1>학생 상담 등록</h1>

    </section>
      
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <!-- left column -->
        <div class="col-md-1"></div>
        <div class="col-md-10">
          <!-- general form elements -->
          <div class="box box-primary">

            <!-- form start -->
            <form role="form">
              <div class="box-body">
                <div class="row">
	                <div class="col-md-1"></div>
	                <div class="col-md-5">
		                <div class="form-group">
		                  <label for="exampleInputEmail1">학생명</label>
		                  <input type="email" class="form-control" id="exampleInputEmail1" placeholder="학생 이름을 입력해주세요.">
		                </div>
		                <div class="form-group">
		                  <label for="exampleInputPassword1">상담사명</label>
		                  <input type="password" class="form-control" id="exampleInputPassword1" placeholder="직원 이름을 입력해주세요.">
		                </div>
		                <div class="form-group">
		                  <label for="exampleInputPassword1">상담시간</label>
			                <div class="input-group">
			                  <div class="input-group-addon">
			                    <i class="fa fa-clock-o"></i>
			                  </div>
			                  <input type="text" class="form-control pull-right" id="reservationtime">
			                </div>
			                <!-- /.input group -->
		                </div>
	                </div>
	                <div class="col-md-5">
	                  <div class="form-group">
	                    <label for="exampleInputEmail1">상담내용</label>
	                    <textarea class="form-control" rows="10" id="exampleInputEmail1" placeholder="상담 내용을 입력해주세요."></textarea>
	                  </div>
	                </div>
	                <div class="col-md-1"></div>
	              </div>
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
        <div class="col-md-1"></div>
        <!--/.col (left) -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
    
    





<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />