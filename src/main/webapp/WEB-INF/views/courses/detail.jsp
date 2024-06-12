<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="강의 조회" name="title"/>
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
 
  .content {
    width: 100%;
    padding: 20px;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
  }
  .buttons {
    display: flex;
    justify-content: left;
    margin-bottom: 20px;
  }
  .buttons .btn {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border: none;
    background-color: #f9f9f9;
    color: #007BFF;
    border-radius: 5px;
    margin: 0 10px;
    transition: background-color 0.3s;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  .buttons button:hover {
    background-color: #e6e6e6;
    border-color: #adadad;
  }
  .content-section {
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 5px;
    background-color: #f9f9f9;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
  }
  .content-section h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
  }
  .content-section p {
    margin: 10px 0;
    font-size: 16px;
    display: flex;
    align-items: center;
  }
  .content-section .field-label {
    font-size: large;
    font-weight: bold;
    color: #555;
    margin-right: 10px;
    flex: 0 0 120px;
  }
  .content-section .field-value {
    flex: 1;
  }
  .content-section .state {
    padding: 5px 10px;
    border-radius: 5px;
    display: inline-block;
  }
  .content-section .description {
    width: 100%;
    height: 100px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
    margin-top: 10px;
  }
  .hidden { 
    display: none; 
  }
 </style>
 

   <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        강의 조회
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/main.page"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="/courses/manageCourses.page"><i class="fa fa-dashboard"></i> 강의 관리</a></li>
        <li class="active">강의 조회</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="buttons">
       <button class="btn btn-flex btn-default btn-lg" onclick="showCourseInfo()">강의 정보</button>
       <button class="btn btn-flex btn-default btn-lg" onclick="showCoursePlan()">강의 계획서</button>
       <button class="btn btn-flex btn-default btn-lg" onclick="showStudentList()">학생 목록</button>
      </div>
	    <div id="course-info" class="content-section">
	      <h2>${course.title}</h2>
	      <p><span class="field-label">강의번호</span><span class="field-value">${course.courseNo}</span></p>
	      <p><span class="field-label">강의명</span><span class="field-value">${course.title}</span></p>
	      <p><span class="field-label">기간</span><span class="field-value">${fn:substring(course.startDate, 0, 10)} ~ ${fn:substring(course.endDate, 0, 10)}</span></p>
	      <p><span class="field-label">강사명</span><span class="field-value">${course.employee.name}</span></p>
	      <p id="courseStateContainer"><span class="field-label">상태</span></p>
	      <div>
	        <p><span class="field-label">설명:</span></p>
	        <textarea class="description" placeholder="description" readonly>${course.description}</textarea>
	      </div>
	    </div>
	    <div id="course-plan" class="content-section hidden">
				<h2>강의 계획서</h2>
      	<iframe src="${course.coursePlan}" width="100%" height="600px"></iframe>
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
<script src="/resources/js/courseState.js?dt=${dt}"></script>
<script>

	function showCourseInfo() {
	  document.getElementById('course-info').classList.remove('hidden');
	  document.getElementById('course-plan').classList.add('hidden');
	  document.getElementById('student-list').classList.add('hidden');
	}
	
	function showCoursePlan() {
	  document.getElementById('course-info').classList.add('hidden');
	  document.getElementById('course-plan').classList.remove('hidden');
	  // document.getElementById('student-list').classList.add('hidden');
	}
	
	function showStudentList() {
	  document.getElementById('course-info').classList.add('hidden');
	  document.getElementById('course-plan').classList.add('hidden');
	  document.getElementById('student-list').classList.remove('hidden');
	}
	
  var courseState = ${course.courseState};

  var stateHtml = '';
  if (courseState == 0) {
    stateHtml = course_unprocessed;
  } else if (courseState == 1) {
    stateHtml = course_accept;
  } else if (courseState == 2) {
    stateHtml = course_reject;
  }

  document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('courseStateContainer').innerHTML += stateHtml;
  });
	
  
//전역 객체
var frmBtn = $('#frm-btn');

//블로그 편집 화면으로 이동
const fnEditBlog = () => {
  $('#btn-edit-blog').on('click', (evt) => {
    frmBtn.attr('action', '${contextPath}/blog/editBlog.do');
    frmBtn.submit();
  })
}

// 블로그 수정 결과 메시지
const fnModifyResult = () => {
  const modifyResult = '${modifyResult}';
  if(modifyResult !== '') {
    alert(modifyResult);
  }
}

// 블로그 삭제
const fnRemoveBlog = () => {
  $('#btn-remove-blog').on('click', (evt) => {
    fnCheckSignin();
    if(confirm('블로그를 삭제하면 모든 댓글이 함께 삭제됩니다. 삭제할까요?')){
      frmBtn.attr('action', '${contextPath}/blog/removeBlog.do');
      frmBtn.submit();
    }
  })
}
	
	

</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />