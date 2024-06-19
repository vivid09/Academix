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

  
</style>
  
  
  <div class="content-wrapper">
  <h2 class="title">결제함</h2>
  
  <div>
    
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
        <option value="all">전체</option>
        <option value="1">미결재</option>
        <option value="2">승인</option>
        <option value="3">반려</option>
      </select> 
    </div>
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
    <tbody id="requestsBody">
      <!-- 데이터가 여기에 추가됩니다. -->
    </tbody>
    <tfoot>
      <tr>
        <td colspan="4">${paging}</td>
      </tr>
    </tfoot>
  </table>
</div>

<script>
var page =1;
const fetchDataAndRender = (status) => {
	 $.ajax({
	      type: 'GET',
	      url: '${contextPath}/requests/getList.do',
	      data: 'page=' + page,
	      dataType: 'json',
	      success: (resData) => {
	        totalPage = resData.totalPage;
	        $('#requestsBody').empty(); // 기존 데이터 초기화
	        $.each(resData.RequestsList, (i, requests) => {
	          console.log(requests);
	          let rowClass = 'requests'; // 기본 클래스 설정
	          if (requests.requestStatus === 1) {
	            rowClass += ' option1';
	          } else if (requests.requestStatus === 0) {
	            rowClass += ' option2';
	          } else {
	            rowClass += ' option3';
	          }
	          let row = '<tr class="' + rowClass + '" data-request-no="' + requests.requestNo + '">';
	          row += '<td>' + requests.requests.requestNo + '</td>';
	          let requestSortText = '';
	         
	          row += '<td>' + requests.requests.requestSort + '</td>';
	          row += '<td>' + requests.requests.employees.name + '</td>';
	          row += '<td>' + requests.requests.requestDate +'</td>';
	          row += '<td>' + requests.requests.requestStatus + '</td>';
	          row += '</tr>';
	          $('#requestsBody').append(row);
	        });
	      },
	      error: (jqXHR) => {
	        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
	      }
	    });
	  };

document.getElementById('status').addEventListener('change', (evt) => {
  fetchDataAndRender(evt.target.value);
});

fetchDataAndRender('all'); // 페이지가 로드될 때 모든 데이터를 가져옵니다.

const fnDisplay = () => {
  document.getElementById('display').value = '${display}';
  document.getElementById('display').addEventListener('change', (evt) => {
    location.href = '${contextPath}/requests/requestsList.do?page=1&sort=${sort}&display=' + evt.target.value;
  })
}



fnDisplay();

</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />