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
.title-right{
  width:30%;
  margin:auto;
}
.dept-approval{
  width:50%;
}
.stamp-box{
  width:50%;
  border: 1px solid black;
  
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
                    <h2>연차 신청서</h2>
                </div>
                <div class="title-right">
                    <div class="dept-approval">
                        <span>결재:</span>
                        <span>인사과</span>
                    </div>
                    <div class="stamp-box">
                        <span>결재 도장</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="departName">부서명</label>
                <input type="text" name="departName" id="departName" value="${sessionScope.user.depart.departmentNo}" readonly>
                <label for="name">성명</label>
                <input type="text" name="name" id="name" value="${sessionScope.user.name}" readonly>
            </div>
            <div class="form-group">
                <label for="rankTitle">직책</label>
                <input type="text" name="rankTitle" id="rankTitle" value="${sessionScope.user.rank.rankNo}" readonly>
                <select name="leaveType" id="leaveType">
                        <option value="0">연차</option>
                        <option value="1">오전 반차</option>
                        <option value="2">오후 반차</option>
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
	            </div>
            <button type="submit">기안하기</button>
            <div>
			    <label for="files">첨부</label>
			    <input type="file" name="files" id="files" multiple>
			</div>
        </div>
        <input type="hidden" name="employeeNo" value="${sessionScope.user.employeeNo}"> 
        <input type="hidden" name="picNo" value="0">
        <input type="hidden" name="requestStatus" value="0">
        <input type="hidden" name="requestSort" value="1">
    </form>

</div>
</div>
<script>

// 부서명과 번호 매핑
const departmentMap = {
    0: '대표실',
    1: '행정부',
    2: '인사팀',
    3: '운영팀',
    4: '강사'
};

// 직급명과 번호 매핑
const rankMap = {
    0: '대표이사',
    1: '수석',
    2: '책임',
    3: '주임',
    4: '사원',
    5: '강사'
};

function formFill() {
	
   	document.getElementById('departName').value = departmentMap[${sessionScope.user.depart.departmentNo}];
   	document.getElementById('rankTitle').value = rankMap[${sessionScope.user.rank.rankNo}];
}
  
  const selectElement = document.getElementById('optionSelect');
  const option1Div = document.getElementById('option1');
  const option2Div = document.getElementById('option2');

  function handleSelectChange() {
    if (selectElement.value === '1') {
      option1Div.style.display = 'block';
      //option2Div.style.display = 'none';
    } else if (selectElement.value === '2') {
      option1Div.style.display = 'none';
      //option2Div.style.display = 'block';
    }
  }

  selectElement.addEventListener('change', handleSelectChange);

  // 초기 로드 시 초기화
  handleSelectChange();
  
  
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

  document.addEventListener('DOMContentLoaded', function() {
      calculateDuration(); // Calculate duration when the page loads
      document.querySelector('input[name="startDate"]').addEventListener('change', calculateDuration);
      document.querySelector('input[name="endDate"]').addEventListener('change', calculateDuration);
      document.getElementById('leaveType').addEventListener('change', calculateDuration);
  });
  
  formFill();
  
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />