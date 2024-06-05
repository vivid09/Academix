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
  
  
  
  <div class="top-ele">
   <span>문서종류</span>
  <select id="optionSelect">
      <option value="all">전체</option>
      <option value="1">미결재</option>
      <option value="2">승인</option>
      <option value="3">반려</option>
    </select> 
  </div>
  
  
  
  
  <table class="req-list">
  <thead>
    <tr>
      <th>신청서 번호</th>
      <th>기안서 종류</th>
      <th>기안자</th>
      <th>기안일</th>
      <th>결재 상태</th>
    </tr>
  </thead>
  <tbody id="requestTableBody">
    <!-- 데이터를 여기에 추가합니다 -->
  </tbody>
</table>
  
 </div>
  
  <script>
   
  var page = 1;
  
  
  

  const RequestsList = () => {
    $.ajax({
      type: 'GET',
      url: '${contextPath}/requests/getList.do',
      data: 'page=' + page,
      dataType: 'json',
      success: (resData) => {
        totalPage = resData.totalPage;
        $('#requestTableBody').empty(); // 기존 데이터 초기화
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
          row += '<td>' + requests.requestNo + '</td>';
          row += '<td>' + requests.requestSort + '</td>';
          row += '<td>' + requests.employees.name + '</td>';
          row += '<td>' + moment(requests.createDt).format('YYYY.MM.DD') + '</td>';
          row += '<td>' + requests.requestStatus + '</td>';
          row += '</tr>';
          $('#requestTableBody').append(row);
        });
      },
      error: (jqXHR) => {
        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
      }
    });
  };

  const handleSelectChange = () => {
    const selectedValue = $('#optionSelect').val();
    if (selectedValue === 'all') {
      $('.requests').show(); // 모든 행 보이기
    } else {
      $('.requests').hide(); // 모든 행 숨기기
      $('.option' + selectedValue).show(); // 선택된 옵션에 해당하는 행만 보이기
    }
  };

  $('#optionSelect').change(handleSelectChange);

  // 초기 로드 시 데이터 로드
  RequestsList();
    
    const fnPostDetail = () => {
      
      $(document).on('click', '.requests', (evt) => {
          // 클릭된 요소로부터 가장 가까운 '.post' 클래스 요소를 찾음
          const $requests = $(evt.target).closest('.requests');
  
          // .post 요소에서 데이터셋을 읽음
          const requestNo = $requests.data('requestNo');
          
      
       
              location.href = '${contextPath}/requests/detail.do?requestNo=' + requestNo;
         
      })
    }
    
    
   

    
    
    
    
    fnPostDetail();
    
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />