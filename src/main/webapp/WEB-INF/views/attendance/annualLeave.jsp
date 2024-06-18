<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="출퇴근/근무관리" name="title"/>
 </jsp:include>
 
 <style>

	 .row {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
   .form-row {
    height: 80px;
    display: flex;
    align-items: center;
  }
  
  .all-day {
  	margin-top: 15px;
  }

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
  .status-box {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
  }
  .status-item {
    text-align: center;
		height: 200px;
    width: 200px;
    padding: 20px;
    background-color: #f4f4f4;
    margin: 30px 30px;
    border-radius: 10px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  }
  .status-number {
    line-height: 90px;
  }
  .current-date-time {
    text-align: center;
    margin-bottom: 20px;
  }
  .buttons {
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
  }
  .buttons button {
    margin: 0 10px;
  }
  
  table {
      width: 100%;
      border-collapse: collapse;
  }
  th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
  }
  th {
      background-color: #f2f2f2;
  }
  tr:nth-child(even) {
      background-color: #f9f9f9;
  }
  .state {
      padding: 5px 10px;
      border-radius: 5px;
      display: inline-block;
  }
  .pagination {
      display: flex;
      justify-content: center;
      padding: 10px 0;
  }
  .pagination a {
      margin: 0 5px;
      padding: 8px 16px;
      text-decoration: none;
      border: 1px solid #ddd;
      color: #000;
  }
  .pagination a.active {
      background-color: #4CAF50;
      color: white;
      border: 1px solid #4CAF50;
  }
  .pagination a:hover:not(.active) {
      background-color: #ddd;
  }
 </style>
 
  <!-- fullCalendar 2.2.5-->
  <link rel="stylesheet" href="/plugins/fullcalendar/fullcalendar.min.css">
  <link rel="stylesheet" href="/plugins/fullcalendar/fullcalendar.print.css" media="print">
   <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        내 연차내역
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/main.page"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">내 연차내역</li>
      </ol>
    </section>

  <!-- Status Boxes -->
  <div class="status-box">
    <div class="status-item">
      <div>총 연차</div>
      <div class="status-number h1" id="leaveTotal">0</div>
    </div>
    <div class="status-item">
      <div>사용 연차</div>
      <div class="status-number h1" id="leaveUsed">0</div>
    </div>
    <div class="status-item">
      <div>잔여 연차</div>
      <div class="status-number h1" id="leaveLeft">0</div>
    </div>
  </div>

    <!-- Main content -->
    <section class="content">
      <table>
       <thead>
           <tr>
               <th>연차신청번호</th>
               <th>처리상태</th>
               <th>사용 연차 일</th>
               <th>연차사용날짜</th>
               <th>연차신청날짜</th>
           </tr>
       </thead>
		   <tbody id="requestList">
		   </tbody>
	    </table>
	    <div class="pagination"id="pagination">
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
<!-- fullCalendar 2.2.5 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src='/plugins/fullcalendar/locale/ko.js'></script>
<!-- Page specific script -->
<script src="/resources/js/attendanceLabels.js?dt=${dt}"></script>
<script src="/resources/js/state.js?dt=${dt}"></script>
<script>
//전역 변수
var page = 1;
var totalPage = 0;

var leaveUsed = 0;
var leaveTotal = 0;
var leaveLeft = 0;


const fnGetLeaveStatus = () => {
	return fetch('/attendance/annualLeave/getAnnualLeaveStatus.do?employeeNo=${sessionScope.user.employeeNo}', {
	  method: 'GET',
	})
	.then(response => response.json())
	.then(resData => {
		leaveTotal = resData.annualLeaveStatus[0].totalLeaves;
	})
	.catch(error => {
	  console.error('Error fetching events:', error);
	});
	
}

const fnGetLeaveRequestList = async (pageNum) => {
	await fnGetLeaveStatus();
	page = pageNum || page;  // pageNum이 전달되지 않으면 현재 페이지를 유지
	fetch('/attendance/annualLeave/getLeaveRequestList.do?employeeNo=${sessionScope.user.employeeNo}', {
	  method: 'GET',
	})
	.then(response => response.json())
	.then(resData => {
		totalPage = resData.totalPage;
		console.log(resData);
	  
	  // resData.recordList.forEach(record => {});
		// 기존 리스트 비우기
	      $('#courseList').empty();
	    
	       
	      $.each(resData.requestsList, (i, request) => {
	    	  var state;
		      if(request.requests.requestStatus == 0){
		    	  state = stateUnprocessed;
		      } else if(request.requests.requestStatus == 1) {
		    	  state = stateAccept;
		      	leaveUsed += request.duration;
		      } else if(request.requests.requestStatus == 2) {
		    	  state = stateReject + ' 사유 : ' + request.requests.rejectReason;
		      }
	    	  
	        let str = '<tr class="request">';
	        str +=   '<td>' + request.requests.requestNo + '</td>';
	        str +=   '<td>' + state + '</td>';
	        str +=   '<td>' + request.duration + '</td>';
	        str +=   '<td>' + request.startDate.substring(0, 10) + ' ~ ' + request.endDate.substring(0, 10) + '</td>';
	        str +=   '<td>' + request.requests.requestDate + '</td>';
	        str += '</tr>';
	        $('#requestList').append(str);
	      })
	      
	    	
	      
			  leaveLeft = leaveTotal - leaveUsed;
			  $('#leaveTotal').html(leaveTotal);
			  $('#leaveUsed').html(leaveUsed);
			  $('#leaveLeft').html(leaveLeft);
	      // 페이징 업데이트
	      updatePagination(resData.paging);
	
	})
	.catch(error => {
	  console.error('Error fetching events:', error);
	});
}
  
// 페이징 업데이트 함수
const updatePagination = (pagingHtml) => {
  $('#pagination').empty();
  $('#pagination').append($.parseHTML(pagingHtml));

  // 현재 페이지를 비활성화
  $('#pagination a').each(function() {
    let href = $(this).attr('href');
    if (href) {
      let params = new URLSearchParams(href.split('?')[1]);
      let pageNum = params.get('page');
      if (pageNum == page) {
        $(this).addClass('disabled').css({
          'pointer-events': 'none',
          'color': 'grey',
          'background-color': '#f2f2f2',
          'border-color': '#ddd'
        });
      }
    }
  });

  // 페이지 링크 클릭 이벤트 추가
  $('#pagination a').click((event) => {
    event.preventDefault();
    if (!$(event.target).hasClass('disabled')) {
      let href = $(event.target).attr('href');
      let params = new URLSearchParams(href.split('?')[1]);
      let pageNum = params.get('page');
      fnGetCourseList(pageNum);
    }
  });
}

$(document).ready(() => {
	fnGetLeaveRequestList();
  // 초기 페이지 링크 클릭 이벤트 추가
  $('#pagination').on('click', 'a', function(event) {
    event.preventDefault();
    let href = $(this).attr('href');
    let params = new URLSearchParams(href.split('?')[1]);
    let pageNum = params.get('page');
    fnGetLeaveRequestList(pageNum);
  });
});

</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />