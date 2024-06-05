<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="전자결재" name="title"/>
 </jsp:include>

<style>

 .requests-wrapper {
    width: 80%;
    margin: 0 auto;
    border: 1px solid #000;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    color: black;
}

.header-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #000;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.title h1 {
    margin: 0;
}

.title-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
}

.title-right span {
    font-weight: bold;
    margin-bottom: 5px;
}

.dept-approval {
    border: 1px solid #000;
    padding: 5px 10px;
}

.form-group {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.form-group label {
    flex: 1;
    margin-right: 10px;
    text-align: right;
    line-height: 2.5;
}

.form-group input {
    flex: 3;
    padding: 5px;
}

.reason input {
    width: 100%;
}

.period input {
    width: calc(50% - 10px);
    margin-right: 20px;
}

button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007BFF;
    color: #fff;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}
 #option1 {
 display:none;
}

</style>

  <div class="content-wrapper">
  
   <div class="top-ele">
   <span>문서종류</span>
  <select id="optionSelect">
      <option value="1">연차신청서</option>
      <option value="2">2</option>
    </select>
  
  </div>
  
  
  <div id="option1">
  <form action="${contextPath}/requests/write.do" method="POST"
        enctype="multipart/form-data">
        <div class="requests-wrapper">
            <div class="header-wrapper">
                <div class="title">
                    <h1>연차 신청서</h1>
                </div>
                <div class="title-right">
                    <span>결재</span>
                    <div class="dept-approval">
                        <span>인사과</span>
                    </div>
                    <div class="stamp-box">
                        <span>결재 도장</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="departName">부서명</label>
                <input type="text" name="departName" id="departName">
                <label for="name">성명</label>
                <input type="text" name="name" id="name">
            </div>
            <div class="form-group">
                <label for="rankTitle">직책</label>
                <input type="text" name="rankTitle" id="rankTitle">
                <select name="leaveType" id="leaveType">
                        <option value="0">연차</option>
                        <option value="1">반차</option>
                    </select>
            </div>
            <div class="form-group reason">
                <label for="reason">사유</label>
                <input type="text" name="reason" id="reason">
            </div>
            <div class="form-group period">
                <label for="startDate">시작일</label>
		        <input type="date" name="startDate" id="startDate">
		        <label for="endDate">종료일</label>
		        <input type="date" name="endDate" id="endDate">
		        <label for="duration">기간</label>
		        <input type="text" name="duration" id="duration">
		        <label for="employeeNo">사원번호</label>
            <input type="text" name="employeeNo" id="employeeNo">
	            </div>
            <button type="submit">기안하기</button>
            <div>
			    <label for="files">첨부</label>
			    <input type="file" name="files" id="files" multiple>
			</div>
        </div>
        <!--<input type="hidden" name="employeeNo" value="1"> -->
        <input type="hidden" name="picNo" value="0">
        <input type="hidden" name="requestStatus" value="0">
        <input type="hidden" name="requestSort" value="1">
    </form>

</div>
</div>
<script>

  
// 폼 제출 이벤트 리스너를 추가합니다.
document.querySelector('form').addEventListener('submit', function(event) {
    // 휴가종류 필드의 값을 가져옵니다.
    var leaveTypeValue = document.getElementById('leaveType').value;
    
    // 만약 휴가종류가 "연차"라면
    if (leaveTypeValue === "연차") {
        // 해당 필드의 값을 "0"으로 변경합니다.
        document.getElementById('leaveType').value = "0";
    }
    // 만약 휴가종류가 "반차"라면
    else if (leaveTypeValue === "반차") {
        // 해당 필드의 값을 "1"으로 변경합니다.
        document.getElementById('leaveType').value = "1";
    }
    // 그 외의 경우에는 아무 작업도 하지 않습니다.
});
  
  const selectElement = document.getElementById('optionSelect');
  const option1Div = document.getElementById('option1');
  const option2Div = document.getElementById('option2');

  function handleSelectChange() {
    if (selectElement.value === '1') {
      option1Div.style.display = 'block';
      //option2Div.style.display = 'none';
    } else if (selectElement.value === '2') {
      option1Div.style.display = 'none';
      option2Div.style.display = 'block';
    }
  }

  selectElement.addEventListener('change', handleSelectChange);

  // 초기 로드 시 초기화
  handleSelectChange();
  
  
  function calculateDuration() {
      const startDate = document.querySelector('input[name="startDate"]').value;
      const endDate = document.querySelector('input[name="endDate"]').value;
      const durationField = document.querySelector('input[name="duration"]');
      
      if (startDate && endDate) {
          const start = new Date(startDate);
          const end = new Date(endDate);
          const duration = Math.ceil((end - start) / (1000 * 60 * 60 * 24)) + 1; // Include start day
          durationField.value = duration > 0 ? duration : 0;
      } else {
          durationField.value = 0;
      }
  }

  document.addEventListener('DOMContentLoaded', function() {
      calculateDuration(); // Calculate duration when the page loads
      document.querySelector('input[name="startDate"]').addEventListener('change', calculateDuration);
      document.querySelector('input[name="endDate"]').addEventListener('change', calculateDuration);
  });
  
  
  
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />