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
 </style>
 
  <!-- fullCalendar 2.2.5-->
  <link rel="stylesheet" href="/plugins/fullcalendar/fullcalendar.min.css">
  <link rel="stylesheet" href="/plugins/fullcalendar/fullcalendar.print.css" media="print">
   <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        출퇴근/근무관리
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/main.page"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">출퇴근</li>
      </ol>
    </section>

  <!-- Modal -->
  <div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">근태 조정 신청</h5>
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
	          </div>
	          <div class="form-row">
	            <div class="form-group col-md-4">
	              <label for="startTime">시작 시간</label>
	              <input type="time" class="form-control" id="startTime">
	            </div>
	            <div class="form-group col-md-4">
	              <label for="endTime">종료 시간</label>
	              <input type="time" class="form-control" id="endTime">
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
		          <button type="button" class="btn btn-danger" id="deleteEventBtn">Delete</button>
		          <button type="submit" class="btn btn-primary" id="saveEventBtn">Save</button>
		        </div>
	        </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Current Date and Time -->
  <div class="current-date-time">
    <h2 id="currentDateTime">1970-01-01(목)</h2>
    <h3 id="currentTime">00:00:00</h3>
	  <input type="hidden" id="recordNo" name="recordNo">
  </div>

  <!-- Buttons -->
  <div class="buttons">
    <button class="btn btn-success" id="inBtn">출근</button>
    <button class="btn btn-danger" id="exitBtn">퇴근</button>
  </div>

  <!-- Status Boxes -->
  <div class="status-box">
    <div class="status-item">
      <div>정상 출근</div>
      <div class="status-number h1" id="attendance_normal">0</div>
    </div>
    <div class="status-item">
      <div>지각 / 조퇴</div>
      <div class="status-number h1" id="attendance_late_or_early_leave">0</div>
    </div>
    <div class="status-item">
      <div>결근</div>
      <div class="status-number h1" id="attendance_absence">0</div>
    </div>
    <div class="status-item">
      <div>휴가</div>
      <div class="status-number h1" id="attendance_annual_leave">0</div>
    </div>
  </div>

  <!-- Calendar Header -->
  <div class="calendar-header">
    <button type="button" class="btn btn-flex btn-primary btn-lg">조정신청현황</button>
  </div>


    <!-- Main content -->
    <section class="content">
      <div class="row" >
        <div class="col-md-9">
          <div class="box box-primary">
            <div class="box-body no-padding">
              <!-- THE CALENDAR -->
              <div id="calendar"></div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /. box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
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
	

	// 현재 날짜와 시간 표시
	function updateDateTime() {
	  var now = new Date();
	  var formattedDate = now.getFullYear() + '-' +
	                      ('0' + (now.getMonth() + 1)).slice(-2) + '-' +
	                      ('0' + now.getDate()).slice(-2) + ' (' +
	                      ['일', '월', '화', '수', '목', '금', '토'][now.getDay()] + ')';
	  var formattedTime = ('0' + now.getHours()).slice(-2) + ':' +
	                      ('0' + now.getMinutes()).slice(-2) + ':' +
	                      ('0' + now.getSeconds()).slice(-2);
	  document.getElementById('currentDateTime').textContent = formattedDate;
	  document.getElementById('currentTime').textContent = formattedTime;
	}
	setInterval(updateDateTime, 1000);

  $(function () {
    /* initialize the calendar
     -----------------------------------------------------------------*/
    //Date for the calendar events (dummy data)
    var date = new Date();
    var d = date.getDate(),
        m = date.getMonth(),
        y = date.getFullYear();
    var currentEvent = null;
    $(document).ready(function() {
    	console.log("Initializing calendar...");
	    $('#calendar').fullCalendar({
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'month,agendaWeek,agendaDay'
	      },
	      buttonText: {
	        today: 'today',
	        month: 'month',
	        week: 'week',
	        day: 'day'
	      },
	      timezone: 'local',
	      selectable: true,
        select: function(start, end, jsEvent, view) {
        	currentEvent = null;
        	// 처음 클릭했을 때 Delete 버튼 숨기기
        	$('#deleteEventBtn').hide(); 
        	
          $('#eventNo').val('');
	        // 모달을 보여주기 전에 선택한 시작 날짜와 종료 날짜를 모달에 반영
	        $('#startDate').val(start.format('YYYY-MM-DD'));
	        $('#endDate').val(end.format('YYYY-MM-DD'));
	        
	        
	        $('#eventModal').modal('show');
	       
	      },
        eventClick: function(event) {
        	// 이벤트 추가 모달을 띄우기 전에 모달 내용을 비운다.
          $('#eventForm')[0].reset();
	        
	        // 클릭한 이벤트 정보를 모달에 반영합니다.
	        currentEvent = event;
	        $('#eventNo').val(event.eventNo);
	        $('#eventTitle').val(event.title);
	        $('#startDate').val(event.start.format('YYYY-MM-DD'));
	        if(event.end === null){
	        	$('#endDate').val(event.start.format('YYYY-MM-DD'));	
	        } else {
	        	$('#endDate').val(event.end.format('YYYY-MM-DD'));	
	        }
	        $('#startTime').val(event.start.format('HH:mm'));
	        if(event.end === null){
	        	$('#endTime').val(event.start.format('HH:mm'));
	        } else {
	        	$('#endTime').val(event.end.format('HH:mm'));
	        }
	        $('#allDay').prop('checked', event.allDay);
	        $('#eventDescription').val(event.description);
	        $('#backgroundColor').val(event.backgroundColor);
	        $('#textColor').val(event.textColor);
  	      $('#eventlat').val(event.lat);
	      	$('#eventlng').val(event.lng);
	      	$('#eventlocation').val(event.location);
	        
	        // 이벤트 수정 모달을 띄웁니다.
	        $('#deleteEventBtn').show(); // 이벤트를 클릭했을 때만 Delete 버튼을 보이도록 설정
	        $('#eventModal').modal('show');

        },
        events: function(start, end, timezone, callback) {
      	  fetch('/attendance/commute/getAttendanceRecords.do?employeeNo=${sessionScope.user.employeeNo}', {
      	    method: 'GET',
      	  })
          .then(response => response.json())
          .then(resData => {
            var records = [];
            var attendance_normal = 0;
            var	attendance_late_or_early_leave = 0;
            var attendance_absence = 0;
            var attendance_annual_leave = 0;
            
            resData.recordList.forEach(record => {
            	if(record.recordDate.substring(0, 10) === moment(new Date()).utcOffset(9).format('YYYY-MM-DD')) {
            		$('#recordNo').val(record.recordNo);
            	}
            	
            	var inTitle = '';
            	var outTitle = '';
            	var color = '';
            	var allDay = false;
            	if(record.status === 1){
            		attendance_normal++;
            		inTitle = normal_in_title;
            		outTitle = normal_out_title;
            		color = normal_color;
            	} else if(record.status === 2) {
            		attendance_late_or_early_leave++;
            		inTitle = late_title;
            		outTitle = late_title;
            		color = late_or_early_leave_color;
            	} else if(record.status === 3) {
            		attendance_late_or_early_leave++;
            		inTitle = early_leave_title;
            		outTitle = early_leave_title;
            		color = late_or_early_leave_color;
            	} else if(record.status === 4) {
            		attendance_absence++;
            		inTitle = absence_title;
            		outTitle = absence_title;
            		color = absence_color;
            		allDay = true;
            	} else if(record.status === 5) {
            		attendance_annual_leave = attendance_annual_leave + 0.5;
            		inTitle = half_day_off_am_title;
            		outTitle = half_day_off_am_title;
            		color = half_day_off_color;
            	} else if(record.status === 6) {
            		attendance_annual_leave = attendance_annual_leave + 0.5;
            		inTitle = half_day_off_pm_title;
            		outTitle = half_day_off_pm_title;
            		color = half_day_off_color;
            	} else if(record.status === 7) {
            		attendance_annual_leave++;
            		inTitle = annual_leave_title;
            		color = annual_leave_color;
            		allDay = true;
                records.push({
                    title: inTitle,
                    start: record.timeIn,
                    end:  record.timeOut,
                    color: color,
                    allDay: allDay
                 });
                return;
            	}
              // timeIn 이벤트 추가
              if(record.timeIn){
	              records.push({
	                title: inTitle,
	                start: record.timeIn,
	                color: color,
	                allDay: allDay
	              });
              }

              // timeOut 이벤트 추가
              if(record.timeOut && !allDay){
	              records.push({
	                title: outTitle,
	                start: record.timeOut,
	                color: color
	              });
              }
            });

            $('#attendance_normal').html(attendance_normal); 
            $('#attendance_late_or_early_leave').html(attendance_late_or_early_leave); 
            $('#attendance_absence').html(attendance_absence); 
            $('#attendance_annual_leave').html(attendance_annual_leave); 
            callback(records);
          })
          .catch(error => {
            console.error('Error fetching events:', error);
            callback([]); // 에러가 발생한 경우 빈 배열을 반환
          });
        }
	    });
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

  });
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />