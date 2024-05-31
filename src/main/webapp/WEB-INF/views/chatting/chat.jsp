<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="../layout/header.jsp"/>

  <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="../../dist/css/skins/_all-skins.min.css">
  
  
  
  
  
  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Blank page
        <small>it all starts here</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">Examples</a></li>
        <li class="active">Blank page</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content chat-content">

      <!-- Default box -->
      <div class="box chat-box">
        <div class="box-header with-border">
          <h3 class="box-title">직원 목록</h3>


          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
              <i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
              <i class="fa fa-times"></i></button>
          </div>
        </div>
        <div class="box-body chat-member">
        
          <input type="text" class="searchInput" placeholder="직원 검색">
          <div id="memberArea"></div>



        
        
<!--           <div class="box box-primary">
            
            <div class="box-body box-profile"> 여기에 직원 리스트 추가

            </div>
            /.box-body
          </div>  -->




        </div>
      </div>
      <!-- /.box -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  
  <style>
    
    .chat-content {
      height: 95vh;
      width: 100%;
    }
    
    .chat-box {
      height: 100%;
      width: 30%;
      border-top-color: #3c8dbc;
    }
    
    .chat-member {
	  height: 80%;
    }
  
  </style>
  
  <script>
  
  // 조직도 가져오기
  $(document).ready(function() {
    $.ajax({
        type: 'GET',
        url: '${contextPath}/user/getMemberList.do',
        dataType: 'json',
        success: (resData) => {
      	  
      	  // 변환한 데이터 담을 배열 선언
      	  var jstreeData = [];
      	  
      	  // employee 데이터에서 대표데이터만 빼서 root node 설정
      	  var ceo = resData.employee.find(employee => employee.rank.rankTitle === '대표이사');
      	  console.log(ceo);
      	  if(ceo) {
      		  jstreeData.push({
      			  id: (ceo.employeeNo - 1).toString(),
      			  parent: '#',
      			  text: ceo.name + ' ' + ceo.rank.rankTitle,
      			  icon: "fas fa-user-tie"
      		  });
      	  }
      	  
      	  // 부서 데이터
      	  resData.departments.forEach(function(department) {
      		  if(department.departName !== '대표실') { // 대표실 제외
      			  jstreeData.push({
      				  id: department.departmentNo.toString(),
      				  parent: department.parentDepartNo.toString(),
      				  text: department.departName,
      				  icon: "fas fa-user-group"
      			  });
      		  }
      	  });
      	  
      	  // 직원 데이터
      	  resData.employee.forEach(function(employee) {
      		  if(employee.depart.departmentNo !== 0 && employee.employeeStatus !== 0){ // 대표이사 제외
      			  if(employee.rank.rankNo === 5) {
           		  jstreeData.push({
           			  id: 'emp_' + employee.employeeNo,
           			  parent: employee.depart.departmentNo.toString(),
           			  text: employee.name + ' ' + employee.rank.rankTitle,
           			  icon: "fas fa-chalkboard-teacher"
           		  });
      			  } else {
	           		  jstreeData.push({
	           			  id: 'emp_' + employee.employeeNo,
	           			  parent: employee.depart.departmentNo.toString(),
	           			  text: employee.name + ' ' + employee.rank.rankTitle,
	           			  icon: "fas fa-user"
	           		  });
      			  }
      		  }
      	  });
      	  
      	  console.log('jstreeData: ', jstreeData);
      	  
      	  
      	  // jstree 데이터 추가 - jstree가 로드되면 모든 노드 열리게 설정
      	  $('#memberArea').jstree({
      		  'core': {
      			  'data': jstreeData
      		  },
      		  'plugins': ['search'],
      	  }).on('ready.jstree', function() {
      		  $(this).jstree(true).open_all();
      	  })
      	  
	       },
	       error: function(jqXHR, textstatus, errorThrown) {
	    	   console.error("실패", textStatus, errorThrown);
	       }
	     });
			
	    // 검색 기능 추가
	    $('.searchInput').on('keyup', function() {
	  	  var searchString = $(this).val();
	  	  $('#memberArea').jstree('search', searchString);
	    });
    
	});
  

  
  </script>
  
  

<%@ include file="../layout/footer.jsp" %>