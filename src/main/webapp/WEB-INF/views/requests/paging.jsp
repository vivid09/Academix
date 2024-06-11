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
.document-papers{
  width:1000px;
  height:200px;
  display:flex;
  justify-content: flex-end;
  text-align: center;
  
  
}
.pending {
  width:250px;
  height:100px;
  border: 1px solid black;
  border-radius: 10px;
  margin-right: 50px; 
  margin-left: 50px; 
  display:flex;
  align-items: center;
  text-align: center;
}
.approval-document-papers {
   width:250px;
  height:100px;
  border: 1px solid black;
  border-radius: 10px;
  margin-right: 50px; 
  margin-left: 50px;
  display:flex;
  align-items: center;
  text-align: center;
}
.notapproval-document-papers {
   width:250px;
  height:100px;
  border: 1px solid black;
  border-radius: 10px;
  margin-right: 50px; 
  margin-left: 50px;
  display:flex;
  align-items: center;
  text-align: center;
}
.table{
 background-color: white;
 border-radius: 20px;
}
.table tbody tr {
  border: 1px solid black;
  padding-top: 10px;
  padding-bottom: 10px;
}
  tfoot tr {
        display: flex;
    }
  
</style>
  
  
  <div class="content-wrapper">
  <h2 class="title">결재함</h2>
   <div class="document-papers">
    <div class="pending">
     대기문서:
    </div>
    <div class="approval-document-papers">
      승인문서:
  </div>
    <div class="notapproval-document-papers">
      반려문서:
  </div>
   </div>
  
  <div>
  <div>
    <input type="radio" name="sort" value="DESC" id="descending" checked>
    <label for="descending">내림차순</label>
    <input type="radio" name="sort" value="ASC" id="ascending">
    <label for="ascending">오름차순</label>
  </div>
  <div>
    <select id="display" name="display">
      <option>5</option>
      <option>10</option>
      <option>20</option>
    </select>
  </div>
  <div>
   <span>문서종류</span>
  <select id="status" name="status">
      <option value="5">전체</option>
      <option value="0">미결재</option>
      <option value="1">승인</option>
      <option value="2">반려</option>
    </select> 
  </div>
  
  <table class="table align-middle">
    <thead>
      <tr>
        <td>기안서 번호</td>
        <td>기안서 종류</td>
        <td>기안자</td>
        <td>기안일</td>
        <td>결재 상태</td>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${requestsList}" var="leaveRequests" varStatus="vs">
        <tr class="sta" id="req-list" data-request-status="${leaveRequests.requests.requestStatus}">
          <td>${leaveRequests.requests.requestNo}</td>
          <td>
            <a href="${contextPath}/requests/detail.do?requestNo=${leaveRequests.requests.requestNo}">
             <c:choose>
                      <c:when test="${leaveRequests.requests.requestSort eq '0'}">
                        근태조정서
					 </c:when>
                      <c:when test="${leaveRequests.requests.requestSort eq '1'}">
                        연차신청서
					 </c:when>
                </c:choose></a>
          </td>
          <td>${leaveRequests.requests.employees.name}</td>
          <td>${leaveRequests.requests.requestDate}</td>
          <td> <c:choose>
                      <c:when test="${leaveRequests.requests.requestStatus eq '0'}">
                        미결재
					 </c:when>
                      <c:when test="${leaveRequests.requests.requestStatus eq '1'}">
                        승인
					 </c:when>
                      <c:when test="${leaveRequests.requests.requestStatus eq '2'}">
                        반려
					 </c:when>
                </c:choose></td>
        </tr>
      </c:forEach>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="5">${paging}</td>
      </tr>
    </tfoot>
  </table>
</div>
  
  
  
  
  
  
  
  </div>
  
  <script>
   
  const fnDisplay = () => {
	  document.getElementById('display').value = '${display}';
	  document.getElementById('display').addEventListener('change', (evt) => {
	    location.href = '${contextPath}/requests/requestsList.do?page=1&sort=${sort}&display=' + evt.target.value;
	  })
	}

	const fnSort = () => {
	  $(':radio[value=${sort}]').prop('checked', true);
	  $(':radio').on('click', (evt) => {
	    location.href = '${contextPath}/requests/requestsList.do?page=${page}&sort=' + evt.target.value + '&display=${display}';
	  })
	}
	
	document.getElementById('status').addEventListener('change', (evt) => {
	    const status = evt.target.value; // 선택된 옵션의 값
	    const rows = document.querySelectorAll('.sta'); // 모든 행 요소를 선택

	    // 각 상태에 따라 행을 숨기거나 보여주는 로직
	    rows.forEach(row => {
	        const rowStatus = row.getAttribute('data-request-status');
	        if (status === '5') {
	            row.style.display = ''; // 전체를 선택한 경우 모든 행 보이기
	        } else {
	            if (rowStatus === status) {
	                row.style.display = ''; // 선택한 상태에 해당하는 행 보이기
	            } else {
	                row.style.display = 'none'; // 선택한 상태가 아닌 경우 행 숨기기
	            }
	        }
	    });
	});

	var requestStatus = document.getElementById('req-list').dataset.requestStatus;
	
	const fnpending = ()=> {
		fetch('${contextPath}/requests/pending.do',{
			 method: 'GET',
		})
		.then((response) => response.json())
		.then(resData =>{
			//console.log(requestStatus);
			console.log(resData);
			let str = '';
			str += '<span>' + resData[0] + '</span>';
			
			$('.pending').append(str);
			let str2 = '';
			str2 += '<span>' + resData[1] + '</span>';
			$('.approval-document-papers').append(str2);
			let str3='';
			str3 += '<span>' + resData[2] + '</span>';
			$('.notapproval-document-papers').append(str3);
		})
	}
	
	
	

	    fnpending();
		fnDisplay();
		fnSort();
 </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />