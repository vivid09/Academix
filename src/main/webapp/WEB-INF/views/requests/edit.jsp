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

  table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #f2f2f2;
        }
        .section-title {
            background-color: #f2f2f2;
            text-align: center;
        }
        .split-cell {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .left {
            width: 50%;
            text-align: left;
        }
        .right {
            width: 50%;
            text-align: right;
        }
   input {
            
        }
   textarea {
    width: 100%;
    box-sizing: border-box;
   }
  #btn-modify{
   background-color: #007BFF;
    color: #fff;
    border-radius: 10px;
    border: none;
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
	   <div class="start" data-set-employee-no="${leaveRequests.requests.employees.employeeNo}"
	    data-set-request-status="${leaveRequests.requests.requestStatus}">
	    
	     <h2>연차 신청서</h2>
	    <form action="${contextPath}/requests/requestModify.do" method="post"
	          id="frm-requests-modify"
	          enctype="multipart/form-data">
	          <div>
	    </div>
	        <table>
	            <tr>
	                <td colspan="2">결재</td>
	                <td colspan="2" class="split-cell">
	                    <div class="left">인사과</div>
	                    <div class="right">
	                     <c:choose>
	                      <c:when test="${leaveRequests.requests.requestStatus eq '0'}">
	                        미결재
						 </c:when>
	                      <c:when test="${leaveRequests.requests.requestStatus eq '1'}">
	                        승인
						 </c:when>
	                      <c:when test="${leaveRequests.requests.requestStatus eq '2'}">
	                        반려
						 </c:when>
	                </c:choose>
	                    </div> 
	                </td>
	            </tr>
	            <tr>
	                <th class="section-title" colspan="1">부서명</th>
	                <td colspan="3"><textarea name="departName">${leaveRequests.requests.employees.depart.departName}</textarea></td>
	            </tr>
	            <tr>
	                <th class="section-title" colspan="1">성명</th>
	                <td colspan="3"><textarea name="name">${leaveRequests.requests.employees.name}</textarea></td>
	            </tr>
	            <tr>
	                <th class="section-title" colspan="1">직책</th>
	                <td colspan="3"><textarea name="rankTitle">${leaveRequests.requests.employees.rank.rankTitle}</textarea></td>
	            </tr>
	            <tr>
	                <th class="section-title" colspan="1">휴가 종류</th>
	                <td colspan="3">
	                <select name="leaveType" id="leaveType">
					    <option value="${leaveRequests.leaveType}">
					        <c:choose>
					            <c:when test="${leaveRequests.leaveType eq '0'}">연차</c:when>
					            <c:when test="${leaveRequests.leaveType eq '1'}">오전반차</c:when>
					            <c:when test="${leaveRequests.leaveType eq '2'}">오후반차</c:when>
					        </c:choose>
					    </option>
					    <option value="0">연차</option>
					    <option value="1">오전 반차</option>
					    <option value="2">오후 반차</option>
				    </select>
	
	                </td>
	            </tr>
	            <tr>
	                <th class="section-title" colspan="4">사유</th>
	            </tr>
	            <tr>
	                <td colspan="4"><textarea name="reason" rows="5" required>${leaveRequests.requests.reason}</textarea></td>
	            </tr>
	            <tr>
	                <th class="section-title" colspan="4">기간</th>
	            </tr>
	            <tr> 
	                <td> <input type="date" name="startDate" value="${leaveRequests.startDate}" >
	                <td> <input type="date" name="endDate" value="${leaveRequests.endDate}"> 
	                <td colspan="2">(<input type="text" name="duration" size="2" value="${leaveRequests.duration }"> 일간)</td>
	                <input type="hidden" name="requestSort" value="1">
	               
	            </tr>
	            <tr>
	            <td><label for="files">첨부파일</label>
				    <input type="file" name="files" id="files" multiple  value="${leaveRequests.attach.uploadPath}"></td>
	            <td><span>${leaveRequests.attach.uploadPath}</span></td>
	            </tr>
	        </table>
	        <div style="text-align: center; margin-top: 20px;">
	         <input type="hidden" name="requestStatus" id="requestStatus" value="${leaveRequests.requests.requestStatus}">   
	         <input type="hidden" name="picNo" id="picNo" value="${leaveRequests.requests.picNo}">   
	         <input type="hidden" name="requestNo" id="requestNo" value="${leaveRequests.requests.requestNo}">   
	         <input type="hidden" name="employeeNo" id="employeeNo" value="${leaveRequests.requests.employees.employeeNo}">   
	        </div>
	        <div>
	          <button id="btn-modify" type="submit">수정완료</button>
	      	  <a href="${contextPath}/requests/detail.do?requestNo=${leaveRequests.requests.requestNo}">작성취소</button></a>
	        </div>
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
  
  <script>
 
  
  function calculateDuration() {
	    const startDateField = document.querySelector('input[name="startDate"]');
	    const endDateField = document.querySelector('input[name="endDate"]');
	    const durationField = document.querySelector('input[name="duration"]');
	    const leaveType = document.getElementById('leaveType').value;
	    const startDate = startDateField.value;
	    const endDate = endDateField.value;

	    if (leaveType === '1' || leaveType === '2') { // 반차
	        durationField.value = 0.5;
	        if (startDate) {
	            endDateField.value = startDate; // 종료일을 시작일과 동일하게 설정
	        }
	    } else {
	        if (startDate && endDate) {
	            const start = new Date(startDate);
	            const end = new Date(endDate);
	            const duration = Math.ceil((end - start) / (1000 * 60 * 60 * 24)) + 1; // 시작일 포함
	            durationField.value = duration > 0 ? duration : 0;
	        } else {
	            durationField.value = 0;
	        }
	    }
	}

	window.onload = function() {
	    calculateDuration(); // 페이지가 로드될 때 휴가 일수 계산
	    document.querySelector('input[name="startDate"]').addEventListener('change', calculateDuration);
	    document.querySelector('input[name="endDate"]').addEventListener('change', calculateDuration);
	    document.querySelector('select[name="leaveType"]').addEventListener('change', calculateDuration); // 휴가 종류 변경 시에도 계산
	}


   
   
    
  function updateFileName() {
      const fileInput = document.getElementById('files');
      const fileNameDisplay = document.getElementById('file-name-display');

      if (fileInput.files.length > 0) {
          fileNameDisplay.textContent = Array.from(fileInput.files).map(file => file.name).join(', ');
      } else {
          fileNameDisplay.textContent = '선택된 파일 없음';
      }
  }

  document.addEventListener('DOMContentLoaded', function() {
      // 페이지 로드 시 파일 이름 업데이트
      updateFileName();

      // 파일 입력 필드 변경 시 파일 이름 업데이트
      document.getElementById('files').addEventListener('change', updateFileName);
  });   
     
     
     
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />