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
 /* KAKAO MAP CSS */
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:30px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList {padding-inline-start: 0px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}


    /* CSS for the overlay */
   .event-overlay {
   		 width: 500px;
       position: absolute;
       background: white;
       border: 1px solid #ddd;
       padding: 10px;
       box-shadow: 0 2px 10px rgba(0,0,0,0.2);
       display: none;
       z-index: 1000;
   }
   #eventmap {
	    width: 100%;
	    height: 200px;
	 }

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
  
	#modal-map {
	    width: 100%;
	    height: 500px;
	}
  
  .form-map {
  	height: 550px;
  }
  
  .all-day {
  	margin-top: 15px;
  }

 </style>
 
  <!-- fullCalendar 2.2.5-->
  <link rel="stylesheet" href="/plugins/fullcalendar/fullcalendar.min.css">
  <link rel="stylesheet" href="/plugins/fullcalendar/fullcalendar.print.css" media="print">
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=29f2120483735c64c72dce2989d136bc&libraries=services"></script>
   <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        일정
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/main.page"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">일정</li>
      </ol>
    </section>

	<!-- Event-Overlay -->
	<div class="event-overlay" id="eventOverlay">
      <div id="eventmap"></div>
	    <h3 id="OverlayTitle"></h3>
	    <p id="OverlayDescription"></p>
	    <p id="OverlayTime"></p>
	    <p id="OverlayLocation"></p>
	</div>

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
	        		<input id="eventlat" name="eventlat">
	            <input id="eventlng" name="eventlng">
	            <input id="eventlocation" name="eventlocation">
		        	<input type="hidden" id="eventNo" name="eventNo">
		          <button type="button" class="btn btn-danger" id="deleteEventBtn">Delete</button>
		          <button type="submit" class="btn btn-primary" id="saveEventBtn">Save</button>
		        </div>
	        </form>
	        <div class="form-row form-map">
	          <div class="form-group col-md-12">
	            <label for="modal-map">장소</label>
	            <div id="modal-map"></div>
	            <div id="menu_wrap" class="bg_white">
				        <div class="option">
				            <div>
			                <form id="searchForm">
			                    키워드 : <input type="text" value="" id="keyword" size="15"> 
			                    <button type="submit">검색하기</button> 
			                </form>
				            </div>
				        </div>
				        <hr>
				        <ul id="placesList"></ul>
				        <div id="pagination"></div>
				    	</div>
	          </div>
          </div>
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



	function initializeMap(event, mapContainer) {
		
			var maplat;
			var maplng;
			if(event) {
				maplat = event.lat;
				maplng = event.lng;
			} else {
				maplat = 33.450701;
				maplng = 126.570667;
			}
			
    	var markers = [];
      var mapOption = {
          center: new kakao.maps.LatLng(parseFloat(maplat), parseFloat(maplng)),
          level: 3
      };
      var map = new kakao.maps.Map(mapContainer, mapOption);
      
      if(event) {
        var markerPosition = new kakao.maps.LatLng(parseFloat(event.lat), parseFloat(event.lng));
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
				marker.setMap(map);
			}

  		//장소 검색 객체를 생성합니다
  		var ps = new kakao.maps.services.Places();  
  		
  		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
  		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		 	document.getElementById('searchForm').addEventListener('submit', function(event) {
			    event.preventDefault(); // 폼 제출을 막습니다
			    searchPlaces(ps, map, infowindow, markers);
			    return false;
			});

	
	    
	}

	function searchPlaces(ps, map, infowindow, markers) {
	    var keyword = document.getElementById('keyword').value;

	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }

	    ps.keywordSearch(keyword, function(data, status, pagination) {
	        placesSearchCB(data, status, pagination, map, infowindow, markers);
	    });
	}

	function placesSearchCB(data, status, pagination, map, infowindow, markers) {
	    if (status === kakao.maps.services.Status.OK) {
	        displayPlaces(data, map, infowindow, markers);
	        displayPagination(pagination);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        alert('검색 결과가 존재하지 않습니다.');
	    } else if (status === kakao.maps.services.Status.ERROR) {
	        alert('검색 결과 중 오류가 발생했습니다.');
	    }
	}

	function displayPlaces(places, map, infowindow, markers) {
	    var listEl = document.getElementById('placesList'), 
	        menuEl = document.getElementById('menu_wrap'),
	        fragment = document.createDocumentFragment(), 
	        bounds = new kakao.maps.LatLngBounds();

	    removeAllChildNods(listEl);
	    removeMarker(markers);

	    for (var i = 0; i < places.length; i++) {
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i, map, markers), 
	            itemEl = getListItem(i, places[i]);

	        bounds.extend(placePosition);

	        (function(marker, title) {
	        		kakao.maps.event.addListener(marker, 'click', function() {
	        	      $('#eventlat').val(marker.getPosition().getLat());
	        	      $('#eventlng').val(marker.getPosition().getLng());
	        	      $('#eventlocation').val(title);
	        	      alert('장소를 선택했습니다.');
	        		});
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title, infowindow, map);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });

	            itemEl.onmouseover = function() {
	                displayInfowindow(marker, title, infowindow, map);
	            };

	            itemEl.onmouseout = function() {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);

	        fragment.appendChild(itemEl);
	    }

	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	    map.setBounds(bounds);
	}

	function getListItem(index, places) {
	    var el = document.createElement('li'),
	        itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                    '<div class="info">' +
	                    '   <h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                     
	    itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	function addMarker(position, idx, map, markers) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
	        imageSize = new kakao.maps.Size(36, 37),
	        imgOptions = {
	            spriteSize: new kakao.maps.Size(36, 691),
	            spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
	            offset: new kakao.maps.Point(13, 37)
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	        marker = new kakao.maps.Marker({
	            position: position,
	            image: markerImage,
	            clickable: true
	        });

	    marker.setMap(map);
	    markers.push(marker);

	    return marker;
	}

	function removeMarker(markers) {
	    for (var i = 0; i < markers.length; i++) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i;

	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild(paginationEl.lastChild);
	    }

	    for (i = 1; i <= pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i === pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }

	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	function displayInfowindow(marker, title, infowindow, map) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

	function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
   }
	}
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
        	console.log("select");
        	currentEvent = null;
        	// 처음 클릭했을 때 Delete 버튼 숨기기
        	$('#deleteEventBtn').hide(); 
        	// 이벤트 추가 모달을 띄우기 전에 모달 내용을 비운다.
          $('#eventForm')[0].reset();
          $('#eventNo').val('');
	        // 모달을 보여주기 전에 선택한 시작 날짜와 종료 날짜를 모달에 반영
	        $('#startDate').val(start.format('YYYY-MM-DD'));
	        $('#endDate').val(end.format('YYYY-MM-DD'));
	        
	        
	        $('#eventModal').modal('show');
	        
	        $('#eventModal').on('shown.bs.modal', function () {
	        	var mapContainer = document.getElementById('modal-map');
	        	initializeMap(event, mapContainer);
		  	  });
	        
	      },
        eventClick: function(event) {
	       	console.log("eventClick");
        	// 이벤트 추가 모달을 띄우기 전에 모달 내용을 비운다.
          $('#eventForm')[0].reset();
	        currentEvent = event;
	       	console.log(currentEvent);
	        
	        // 클릭한 이벤트 정보를 모달에 반영합니다.
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
	        
	        $('#eventModal').on('shown.bs.modal', function () {
	        	var mapContainer = document.getElementById('modal-map');
	        	initializeMap(event, mapContainer);
		  	  });

        },
        eventMouseover: function(event, jsEvent) {
            $('#OverlayTitle').text(event.title);
            $('#OverlayDescription').text(event.description);
            $('#OverlayTime').text(moment(event.start).format('MMMM Do YYYY, h:mm a'));
            $('#OverlayLocation').text(event.location);
            
            $('#eventOverlay').css({
                top: jsEvent.pageY + 10 + "px",
                left: jsEvent.pageX + 10 + "px"
            }).show();
            
            if(event.lat && event.lng){
	            	var markerPosition  = new kakao.maps.LatLng(event.lat, event.lng); 
	
	            	// 이미지 지도에 표시할 마커입니다
	            	// 이미지 지도에 표시할 마커는 Object 형태입니다
	            	var marker = {
	            	    position: markerPosition
	            	};
	
	            	var staticMapContainer  = document.getElementById('eventmap'), // 이미지 지도를 표시할 div  
	            	    staticMapOption = { 
	            	        center: new kakao.maps.LatLng(event.lat, event.lng), // 이미지 지도의 중심좌표
	            	        level: 3, // 이미지 지도의 확대 레벨
	            	        marker: marker // 이미지 지도에 표시할 마커 
	            	    };    
	            	staticMapContainer.innerHTML = '';
	            	// 이미지 지도를 생성합니다
	            	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
                $('#eventmap').show();
            } else {
                $('#eventmap').hide();
            }
        },
        eventMouseout: function(event, jsEvent) {
            $('#eventOverlay').hide();
        }
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
        	  alert('일정을 등록했습니다.');

            
          })
          .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
          });
      $('#eventModal').modal('hide');
      $('#calendar').fullCalendar('removeEvents');
		  fnGetEventList();
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
    	  alert('일정을 삭제했습니다.');

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