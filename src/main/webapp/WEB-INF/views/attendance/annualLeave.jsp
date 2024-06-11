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
  .calendar-header {
    display: flex;
    text-align: center;
    margin-bottom: 20px;
    justify-content: end;
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

  <!-- Modal -->
  <div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">연차 신청</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
	        <form id="eventForm">
	          <div class="form-group">
	            <label for="eventTitle">제목</label>
	            <input type="text" class="form-control" id="eventTitle" placeholder="Event Title">
	          </div>
						<div class="form-row">
	            <div class="form-group col-md-6">
	              <label for="startDate">시작 일</label>
	              <input type="date" class="form-control" id="startDate">
	            </div>
	            <div class="form-group col-md-6">
	              <label for="endDate">종료 일</label>
	              <input type="date" class="form-control" id="endDate">
	            </div>
	          </div>
          <div class="form-row">
            <div class="form-group col-md-12">
              <label for="leaveType">종류</label>
              <select class="form-control" id="leaveType">
                <option value="5">오전반차</option>
                <option value="6">오후반차</option>
                <option value="7">연차</option>
              </select>
            </div>
          </div>
 	          <div class="form-row">
		          <div class="form-group col-md-12">
		            <label for="eventDescription">설명</label>
		            <textarea class="form-control" id="eventDescription" rows="3"></textarea>
		          </div>
	          </div>
		        <div class="modal-footer">
		        	<input type="hidden" id="recordNo" name="recordNo">
		          <button type="submit" class="btn btn-primary" id="saveEventBtn">Save</button>
		        </div>
	        </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Status Boxes -->
  <div class="status-box">
    <div class="status-item">
      <div>총 연차</div>
      <div class="status-number h1" id="attendance_normal">0</div>
    </div>
    <div class="status-item">
      <div>사용 연차</div>
      <div class="status-number h1" id="attendance_late_or_early_leave">0</div>
    </div>
    <div class="status-item">
      <div>잔여 연차</div>
      <div class="status-number h1" id="attendance_absence">0</div>
    </div>
  </div>

  <!-- Calendar Header -->
  <div class="calendar-header">
    <button type="button" class="btn btn-flex btn-primary btn-lg" id="applicationLeave">연차 신청</button>
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
       <tbody>
           <tr>
               <td>00001</td>
               <td>승인</td>
               <td>3.0</td>
               <td>2024/10/25 ~ 2024/10/28</td>
               <td>2024/10/25</td>
           </tr>
           <tr>
               <td>00001</td>
               <td>처리중</td>
               <td></td>
               <td></td>
               <td>2024/10/25</td>
           </tr>
           <tr>
               <td>00001</td>
               <td>처리중</td>
               <td></td>
               <td></td>
               <td>2024/10/25</td>
           </tr>
           <tr>
               <td>00001</td>
               <td>처리중</td>
               <td></td>
               <td></td>
               <td>2024/10/25</td>
           </tr>
           <tr>
               <td>00001</td>
               <td>처리중</td>
               <td></td>
               <td></td>
               <td>2024/10/25</td>
           </tr>
       </tbody>
	    </table>
	    <div class="pagination">
	        <a href="#">&lt;</a>
	        <a href="#">1</a>
	        <a href="#">2</a>
	        <a href="#">3</a>
	        <a href="#">4</a>
	        <a href="#">5</a>
	        <a href="#">6</a>
	        <a href="#">7</a>
	        <a href="#">8</a>
	        <a href="#">9</a>
	        <a href="#">10</a>
	        <a href="#">&gt;</a>
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
<!-- fullCalendar 2.2.5 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src='/plugins/fullcalendar/locale/ko.js'></script>
<!-- Page specific script -->
<script src="/resources/js/attendanceLabels.js?dt=${dt}"></script>
<script>
	
	$('#applicationLeave').click(function(event) {
	  $('#eventForm')[0].reset();
	  
	  $('#eventNo').val();
	  $('#eventTitle').val();
	  $('#startDate').val();
	  if(event.end === null){
	  	$('#endDate').val();	
	  } else {
	  	$('#endDate').val();	
	  }
	  $('#startTime').val();
	  if(event.end === null){
	  	$('#endTime').val();
	  } else {
	  	$('#endTime').val();
	  }
	
	  $('#eventDescription').val();
	
	
	  // 이벤트 수정 모달을 띄웁니다.
	  $('#deleteEventBtn').show(); // 이벤트를 클릭했을 때만 Delete 버튼을 보이도록 설정
	  $('#eventModal').modal('show');
		
	});

    $('#inBtn').click(function(event) {
        event.preventDefault();
        if($('#recordNo').val() !== ""){
        	return;
        }
        
        var recordData = {
            timeIn: moment(new Date()).utcOffset(9).format('YYYY-MM-DDTHH:mm:ss.SSS'),
            employeeNo: ${sessionScope.user.employeeNo}
        };

        fetch('/attendance/commute/registerAttendanceRecord.do', { 
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(recordData)
          }) 
          .then(response => response.json())
          .then(resData => {
        	  alert(resData.insertResult);
            $('#calendar').fullCalendar('refetchEvents');
          })
          .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
          });
      $('#eventModal').modal('hide');

    });
    
    $('#eventModal').on('hidden.bs.modal', function () {
        $('#deleteEventBtn').hide(); // 모달이 닫힐 때 Delete 버튼을 숨깁니다.
    });
    
    $('#exitBtn').click(function() {
      event.preventDefault();
      
      var recordData = {
    		  recordNo: Number($('#recordNo').val()),
          date: moment(new Date()).utcOffset(9).format('YYYY-MM-DDTHH:mm:ss.SSS'),
          timeOut: moment(new Date()).utcOffset(9).format('YYYY-MM-DDTHH:mm:ss.SSS'),
          employeeNo: ${sessionScope.user.employeeNo}
      };

      fetch('/attendance/commute/updateAttendanceRecord.do', { 
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(recordData)
        }) 
        .then(response => response.json())
        .then(resData => {
      	  alert(resData.insertResult);
          $('#calendar').fullCalendar('refetchEvents');
        })
        .catch(error => {
          console.error('There was a problem with the fetch operation:', error);
        });
    });

</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />