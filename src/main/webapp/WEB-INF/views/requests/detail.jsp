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
   .modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    justify-content: center;
    align-items: center;
}

/* 모달 내용 스타일 */
.modal-content {
    width: 300px;
    height: auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
}

/* 닫기 버튼 스타일 */
.close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
}     

#btn-reject{
 border-radius: 5px;
}
#btn-approval{
border-radius: 5px;
}
</style>

 <div class="content-wrapper">
  <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
          <c:choose>
            <c:when test="${leaveRequests.requests.requestSort eq '0'}">
                   근무조정서
		    </c:when>
            <c:when test="${leaveRequests.requests.requestSort eq '1'}">
                   연차신청서
		    </c:when>
          </c:choose>
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">내 문서함</li>
      </ol>
    </section>
 
   <!-- Main content -->
   <section class="content">
   <div class="start" data-set-employee-no="${leaveRequests.requests.employees.employeeNo}"
    data-set-request-status="${leaveRequests.requests.requestStatus}">
    
     <div>
   
      <c:if test="${leaveRequests.requests.requestStatus == 0 }">
      <c:if test="${sessionScope.user.employeeNo == leaveRequests.requests.employees.employeeNo}">
      <form id="frm-btn" method="POST">  
        <input type="hidden" name="requestNo" value="${leaveRequests.requests.requestNo}">
        <input type="hidden" name="employeeNo" value="${leaveRequests.requests.employees.employeeNo}">
        <button type="button" id="btn-edit" class="btn btn-warning btn-sm">편집</button>
        <button type="button" id="btn-remove" class="btn btn-danger btn-sm">삭제</button>
        </c:if>
        </c:if>
      </form>
    
  
</div>
    <form action="${contextPath}/requests/requestApproval.do" method="post"
          id="frm-requests-approval" onsubmit="submitFormWithApproval()">
          <c:if test="${sessionScope.user.depart.departmentNo == 2}">
          <div>
     <button type="submit" class="state bg-green-active color-palette" id="btn-approval">승인</button>
     <button type="button" class="state bg-red-active color-palette"id="btn-reject" onclick="openModal()">반려</button>
     </c:if>
    </div>
    
        <table>
            <tr>
                <td>결재</td>
                <td  class="split-cell">
                    <div class="left">인사과</div>
                    <div class="right">
                     <c:choose>
                      <c:when test="${leaveRequests.requests.requestStatus eq '0'}">
                        미결재
					 </c:when>
                      <c:when test="${leaveRequests.requests.requestStatus eq '1'}">
                        <img src="/images/approved.png" style="width:100px;">
					 </c:when>
                      <c:when test="${leaveRequests.requests.requestStatus eq '2'}">
                        <img src="/images/rejected.png" style="width:100px;">
					 </c:when>
                </c:choose>
                    </div> 
                </td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">부서명</th>
                <td colspan="3">${leaveRequests.requests.employees.depart.departName}</td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">성명</th>
                <td colspan="3">${leaveRequests.requests.employees.name}</td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">직책</th>
                <td colspan="3">${leaveRequests.requests.employees.rank.rankTitle}</td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">휴가 종류</th>
                <td colspan="3">
                 <c:choose>
                <c:when test="${leaveRequests.leaveType eq '0'}">
					        연차
					    </c:when>
                <c:when test="${leaveRequests.leaveType eq '1'}">
					        오전반차
					    </c:when>
                <c:when test="${leaveRequests.leaveType eq '2'}">
					        오후반차
					    </c:when>
			   </c:choose>
                </td>
            </tr>
            <tr>
                <th class="section-title" colspan="4">사유</th>
            </tr>
            <tr>
                <td colspan="4"><textarea name="reason" rows="5" required readonly="readonly">${leaveRequests.requests.reason}</textarea></td>
            </tr>
            <tr>
                <th class="section-title" colspan="4">기간</th>
            </tr>
            <tr>
                <td> <input type="text" name="startYear" size="4" required readonly="readonly">년 <input type="text" name="startMonth" size="2" required readonly>월 <input type="text" name="startDay" size="2" required readonly>일 부터</td>
                <td> <input type="text" name="endYear" size="4" required readonly="readonly">년 <input type="text" name="endMonth" size="2" required readonly>월 <input type="text" name="endDay" size="2" required readonly>일 까지</td>
                <td colspan="2">(<input type="text" name="days" size="2" required readonly="readonly"> 일간)</td>
                <input type="hidden" name="requestSort" value="1">
               
            </tr>
            <tr>
            <td data-attach-no="${leaveRequests.attach.attachNo}" id="td-attach">첨부파일</td>
            <td id="down-path">${leaveRequests.attach.originalFileName}</td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: 20px;">
         <input type="hidden" name="requestStatus" id="requestStatus" value="${leaveRequests.requests.requestStatus}">   
         <input type="hidden" name="picNo" id="picNo" value="${leaveRequests.requests.picNo}">   
         <input type="hidden" name="requestNo" id="requestNo" value="${leaveRequests.requests.requestNo}">
         <input type="hidden" name="attachNo" id="attachNo" value="${leaveRequests.attach.attachNo}">
         <input type="hidden" name="employeeNo" id="employeeNo" value="${leaveRequests.requests.employees.employeeNo}">
        </div>
    </form>
  
  
   <div id="myModal" class="modal">
   <form action="${contextPath}/requests/reject.do"
   		 method="POST" id="frm-reject">
     <div class="modal-content">
        <!-- 닫기 버튼 -->
        <span class="close" onclick="closeModal()">&times;</span>
        <!-- 사유 입력란 -->
        <label for="rejectReason">사유:</label>
        <textarea id="rejectReason" name="rejectReason" rows="4" cols="50"></textarea>
        <input type="hidden" name="requestNo" id="requestNo" value="${leaveRequests.requests.requestNo}">
        <input type="hidden" name="requestStatus" id="requestStatus" value="2">   
         <input type="hidden" name="picNo" id="picNo" value="1">
        <br>
        <!-- 반려 버튼 -->
        <button onclick="submit">반려하기</button>
        <button onclick="closeModal()">취소</button>
    </div>
   </form>
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
  
  <script>
  
  // 시작일 및 종료일 날짜 설정
  document.addEventListener('DOMContentLoaded', function() {
  // 시작일 및 종료일 날짜 설정
  let startDateStr = '${leaveRequests.startDate}';
  let endDateStr = '${leaveRequests.endDate}';

  // 시작일 날짜 형식화 및 설정
  const startYear = startDateStr.substring(0, 4);
  const startMonth = startDateStr.substring(5, 7);
  const startDay = startDateStr.substring(8, 10);
  document.querySelector('input[name="startYear"]').value = startYear;
  document.querySelector('input[name="startMonth"]').value = startMonth;
  document.querySelector('input[name="startDay"]').value = startDay;

  // 종료일 날짜 형식화 및 설정
  const endYear = endDateStr.substring(0, 4);
  const endMonth = endDateStr.substring(5, 7);
  const endDay = endDateStr.substring(8, 10);
  document.querySelector('input[name="endYear"]').value = endYear;
  document.querySelector('input[name="endMonth"]').value = endMonth;
  document.querySelector('input[name="endDay"]').value = endDay;

  // 휴가 일수 계산
  let daysDiff = Math.ceil((new Date(endDateStr) - new Date(startDateStr)) / (1000 * 60 * 60 * 24));
  
  // 휴가 종류가 반차인 경우
  if ('${leaveRequests.leaveType}' === '1' || '${leaveRequests.leaveType}' === '2') {
    daysDiff = 0.5; // 휴가 일수를 0.5일로 설정
  }
  
  document.querySelector('input[name="days"]').value = daysDiff;
});

  
  
   
    function submitFormWithApproval() {
	   
        // requestStatus 필드의 값을 1로 변경
        document.getElementById("requestStatus").value = "1";
        document.getElementById("picNo").value = "${sessionScope.user.employeeNo}";
        
    } 
   
    
     function rejectRequest() {
        // requestStatus 필드의 값을 2로 변경
        document.getElementById("requestStatus").value = "2";
        document.getElementById("picNo").value = "${sessionScope.user.employeeNo}";
        document.getElementById("frm-requests-approval").submit();
    }
    
     
     const fnDownload = () => {
    	 var attachNo = document.getElementById('td-attach').dataset.attachNo;
    	  $('#down-path').on('click', (evt) => {
    	    if(confirm('해당 첨부 파일을 다운로드 할까요?')) {
    	      location.href = '${contextPath}/requests/download.do?attachNo=' +attachNo;
    	    }
    	  })
    	} 
     fnDownload();
     
     const fnEditRequests = () => {
    		document.getElementById('btn-edit').addEventListener('click', (evt) => {
    			frmBtn.action = '${contextPath}/requests/edit.do';
    			frmBtn.submit();
    		})
    	}
     
     
     
   var frmBtn = document.getElementById('frm-btn');
     
     const fnRemoveRequest = () => {
    		document.getElementById('btn-remove').addEventListener('click', (evt) => {
    			if(confirm('해당 기안서를 삭제할까요?')){
    	      frmBtn.action = '${contextPath}/requests/removeRequest.do';
    	      frmBtn.submit();
    			}
    	  })
    	} 
     
     
  // 모달 열기 함수
     function openModal() {
         var modal = document.getElementById('myModal');
         modal.style.display = 'flex';
     }

     // 모달 닫기 함수
     function closeModal() {
         var modal = document.getElementById('myModal');
         modal.style.display = 'none';
     }
     
     
     

     
     fnRemoveRequest();
     fnEditRequests();
     
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />