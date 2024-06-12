<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="강의 조회" name="title"/>
 </jsp:include>
 
 <style>
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
 
  .search-bar {
      display: flex;
      justify-content: flex-end;
      margin-bottom: 20px;
  }
  .search-bar select, .search-bar input {
      padding: 10px;
      margin-left: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
  }
  table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
  }
  th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
  }
  th {
      background-color: #f2f2f2;
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
 

   <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        강의 관리
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/main.page"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">강의 관리</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
	  	<div class="search-bar">
	      <select>
	          <option value="강사명">강사명</option>
	      </select>
	      <input type="text" placeholder="강의명 검색">
		  </div>
			<table>
			    <thead>
			        <tr>
			            <th>강의번호</th>
			            <th>강사명</th>
			            <th>강의명</th>
			            <th>기간</th>
			            <th>상태</th>
			        </tr>
			    </thead>
			    <tbody id="courseList">
			    </tbody>
			</table>
	    <div class="pagination" id="pagination">
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
<!-- Page specific script -->
<script src="/resources/js/courseState.js?dt=${dt}"></script>
<script>
	//전역 변수
	var page = 1;
	var totalPage = 0;
	
	const fnGetCourseList = (pageNum) => {
		page = pageNum || page;  // pageNum이 전달되지 않으면 현재 페이지를 유지
		
	  // page 에 해당하는 목록 요청
	  $.ajax({
	    // 요청
	    type: 'GET',
	    url: '${contextPath}/courses/manageCourses/list.do',
	    data: 'page=' + page,
	    // 응답
	    dataType: 'json',
	    success: (resData) => {  // resData = {"courseList": [], "totalPage": 10}
	      totalPage = resData.totalPage;
	    
	      // 기존 리스트 비우기
	      $('#courseList').empty();
	    
	      
	      $.each(resData.courseList, (i, course) => {
	    	  var state;
	    	  var href = "location.href='${contextPath}/courses/manageCourses/detail.do?courseNo=" + course.courseNo + '\'';
		      if(course.courseState == 0){
		    	  state = course_unprocessed;
		      } else if(course.courseState == 1) {
		    	  state = course_accept;
		      } else if(course.courseState == 2) {
		    	  state = course_reject;
		      }
	    	  
	    	  
	        let str = '<tr onclick=' + href + ' class="course" data-employee-no="' + course.employee.employeeNo + '" data-course-no="' + course.courseNo + '">';
          str +=   '<td>' + course.courseNo + '</td>';
          str +=   '<td>' + course.employee.name + '</td>';
          str +=   '<td>' + course.title + '</td>';
          str +=   '<td>' + course.startDate.substring(0, 10) + ' ~ ' + course.endDate.substring(0, 10) + '</td>';
          str +=   '<td>' + state + '</td>';
          str += '</tr>';
	        $('#courseList').append(str);
	      })
	      
	      // 페이징 업데이트
	      updatePagination(resData.paging);
	    },
	    error: (jqXHR) => {
	      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
	    }
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

	const fnCourseDetail = () => {
	  $(document).on('click', '.course', (evt) => {
		    // <div class="blog"> 중 클릭 이벤트가 발생한 <div> : 이벤트 대상
		    // evt.target.dataset.blogNo === $(evt.target).data('blogNo')
		  console.log(evt.target);
		  // location.href = '${contextPath}/course/detail.do?courseNo=' + evt.target.dataset.courseNo;
	  });
	};
	
	$(document).ready(() => {
	  fnGetCourseList();
		fnCourseDetail();
		
	  // 초기 페이지 링크 클릭 이벤트 추가
	  $('#pagination').on('click', 'a', function(event) {
	    event.preventDefault();
	    let href = $(this).attr('href');
	    let params = new URLSearchParams(href.split('?')[1]);
	    let pageNum = params.get('page');
	    fnGetCourseList(pageNum);
	  });
	});
	
	

</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />