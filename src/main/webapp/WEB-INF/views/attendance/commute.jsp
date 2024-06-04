<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="일정" name="title"/>
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
          <h5 class="modal-title" id="exampleModalLabel">일정 등록 / 수정</h5>
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
	            <div class="form-group col-md-4">
	              <label for="startTime">시작 시간</label>
	              <input type="time" class="form-control" id="startTime">
	            </div>
	            <div class="form-group col-md-4">
	              <label for="endTime">종료 시간</label>
	              <input type="time" class="form-control" id="endTime">
	            </div>
	            <div class="form-group col-md-4 all-day">
	              <label for="allDay">종일</label>
	              <input type="checkbox" class="form-check-input" id="allDay">
	            </div>
	          </div>
	          <div class="form-row">
	            <div class="form-group col-md-6">
	              <label for="backgroundColor">배경 색</label>
	              <input type="color" class="form-control" id="backgroundColor">
	            </div>
	            <div class="form-group col-md-6">
	              <label for="textColor">글자 색</label>
	              <input type="color" class="form-control" id="textColor">
	            </div>
	          </div>
 	          <div class="form-row">
		          <div class="form-group col-md-12">
		            <label for="eventDescription">설명</label>
		            <textarea class="form-control" id="eventDescription" rows="3"></textarea>
		          </div>
	          </div>
		        <div class="modal-footer">
	        		<input type="hidden" id="eventlat" name="eventlat">
	            <input type="hidden" id="eventlng" name="eventlng">
	            <input type="hidden" id="eventlocation" name="eventlocation">
		        	<input type="hidden" id="eventNo" name="eventNo">
		          <button type="button" class="btn btn-danger" id="deleteEventBtn">Delete</button>
		          <button type="submit" class="btn btn-primary" id="saveEventBtn">Save</button>
		        </div>
	        </form>
        </div>
      </div>
    </div>
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
<script>

	// 이벤트 목록 가져와서 캘린더 에 표시하기
	const fnGetEventList = () => {
	  fetch('/calendar/getEvents.do', {
	    method: 'GET'
	  })
	  .then(response => response.json())
	  .then(resData => {  // resData = {"event": []}
	  	console.log(resData);
	  	$.each(resData.eventList, (i, event) => {
	    	$('#calendar').fullCalendar('renderEvent', event, true);
	  	})
    })
  }

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
	    });
    });

    $('#eventForm').submit(function(event) {
         event.preventDefault();
        
        var eventData = {
        		eventNo: $('#eventNo').val(),
            title: $('#eventTitle').val(),
            start: $('#startDate').val() + 'T' + $('#startTime').val(),
            end: $('#endDate').val() + 'T' + $('#endTime').val(),
            allDay: $('#allDay').prop('checked'),
            description: $('#eventDescription').val(),
            backgroundColor: $('#backgroundColor').val(),
            textColor: $('#textColor').val(),
            lat: $('#eventlat').val(),
            lng: $('#eventlng').val(),
            location: $('#eventlocation').val()
        };

        var url = eventData.eventNo ? '/calendar/updateEvent.do' : '/calendar/registerEvent.do';
        fetch(url, { 
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(eventData)
          }) 
          .then(response => response.json())
          .then(resData => {
        	  alert(resData.insertResult);
            $('#calendar').fullCalendar('removeEvents');
    		  	fnGetEventList();
          })
          .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
          });
      $('#eventModal').modal('hide');

    });
    
    $('#eventModal').on('hidden.bs.modal', function () {
        $('#deleteEventBtn').hide(); // 모달이 닫힐 때 Delete 버튼을 숨깁니다.
    });
    
    $('#deleteEventBtn').click(function() {
    	fetch( '/calendar/removeEvent.do', { 
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
          },
        body: $('#eventNo').val()
      }) 
      .then(response => response.json())
      .then(resData => {
    	  alert(resData.removeCount);

        $('#eventModal').modal('hide');
      })
      .catch(error => {
        console.error('There was a problem with the fetch operation:', error);
      });
        if (currentEvent) {
            $('#calendar').fullCalendar('removeEvents', currentEvent._id);
            $('#eventModal').modal('hide');
            currentEvent = null;
        }
    });

  });
  
	fnGetEventList();
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />