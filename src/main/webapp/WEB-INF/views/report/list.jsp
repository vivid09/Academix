<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp"/>

<style>
/* 공통 스타일 */

.content {
    min-height: 1080px;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    color: #333;
}
  
.container {
    max-width: 80%;
    margin: 20px auto;
    padding: 10px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.header h1 {
    margin: 0;
    font-size: 24px;
    color: #555;
}

.header a {
    padding: 10px 20px;
    background-color: tomato;
    color: #fff;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color 0.3s;
}

.header a:hover {
    background-color: #e04e4e;
}

/* 신고 목록 스타일 */
.report-list {
    margin-left: 18%;
}

.report-list .body {
    margin-top: 20px;
}

.report  {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #fff;
    cursor: pointer;
    transition: background-color 0.3s;
}



.report:hover {
    background-color: #f1f1f1;
}

.report span {
    display: inline-block;
    box-sizing: border-box;
    padding: 0 10px;
    font-size: 14px;
}

.report span:nth-of-type(1) {
    width: 20%; /* 신고번호 칸 너비 */
    color: #333;
    font-weight: bold;
}

.report span:nth-of-type(2) {
    width: 60%; /* 신고내용 칸 너비 */
    color: #888;
}

.report span:nth-of-type(3) {
    width: 30%; /* 신고시간 칸 너비 */
    color: #666;
    text-align: right;
}

/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.7); /* 배경 투명도 조절 */
}

.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 60%; /* 모달 너비 */
    max-width: 600px; /* 최대 너비 설정 */
    height: auto; /* 내용에 따라 높이 조정 */
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    position: relative;
    top: 50%;
    transform: translateY(-50%);
}

.close {
    color: #aaa;
    position: absolute;
    top: 10px;
    right: 15px;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.go-to-post-button {
    position: absolute;
    top: 10px;
    right: 15px;
    padding: 8px 16px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.go-to-post-button:hover {
    background-color: #45a049;
}

.modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
}

.delete-button {
    padding: 10px 20px;
    background-color: #f44336;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.delete-button:hover {
    background-color: #e53935;
}

.cancel-button {
    padding: 10px 20px;
    background-color: #aaa;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.cancel-button:hover {
    background-color: #888;
}
</style>


   <!-- Main content -->
    <section class="content">
     <div class="container report-list">
    <div class="header">
        <h1>신고게시판 목록</h1>
    </div>
    <div class="body">
        <div id="report-list"></div>
    </div>
</div>
    </section>
    <!-- /.content -->



<!-- 모달 구조 -->
<div id="reportModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <button id="goToPostButton" class="go-to-post-button">게시글로 이동</button>
        <h2>신고 상세 정보</h2>
        <div id="reportDetails">
            <!-- 여기에 동적으로 내용이 채워집니다 -->
        </div>
        <div class="modal-actions">
            <button id="deleteReportButton" class="delete-button">신고 삭제</button>
            <button id="deletePostButton" class="delete-button">게시글 삭제</button>
            <button id="cancelButton" class="cancel-button">취소</button>
        </div>
    </div>
</div>

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

<script>
  // 전역 변수
  var page = 1;
  var totalPage = 0;
  
  const categoryMap = {
		    1: '스팸홍보/도배글.',
		    2: '음란물.',
		    3: '불법정보 포함.',
		    4: '불쾌한 표현.'
		    // 필요에 따라 다른 카테고리도 추가
		  };

  const fnGetBlogList = () => {
	    $.ajax({
	      type: 'GET',
	      url: '${contextPath}/report/getReportList.do',
	      data: 'page=' + page,
	      dataType: 'json',
	      success: (resData) => {
	        totalPage = resData.totalPage;
	        $.each(resData.reportList, (i, report) => {
	            let categoryName = categoryMap[report.reportCategory] || '기타'; // 매핑된 카테고리 이름 또는 기본값
	            let str = '<div class="report" data-author-no="' + report.authorNo + '" data-report-no="' + report.reportNo + '" data-post-no="'+ report.postNo + '" data-description="' + report.description + '">';
	            str += '<span>' +"신고번호 : " + report.reportNo + '</span>';
	            str += '<span>' +"사유 : " + categoryName + '</span>';
	            
	            if(report.anon.status == 0 || report.anon.status == 2) {
	            	str += '<span style="color:red;"> 처리완료 </span>';
	            } else {
                str += '<span style="color:blue;"> 처리대기 </span>';	            	
	            }
	            str += '<span>' + moment(report.reportDate).format('YYYY.MM.DD HH:mm:ss') + '</span>';
	            str += '</div>';
	            $('#report-list').append(str);
	        })
	      },
	      error: (jqXHR) => {
	        alert(jqXHR.statusText + '(' + jqXHR.status + ')');
	      }
	    });
	  }

  const fnScrollHandler = () => {
    // 스크롤이 바닥에 닿으면 page 증가(최대 totalPage 까지) 후 새로운 목록 요청

    // 타이머 id (동작한 타이머의 동작 취소를 위한 변수)
    var timerId;

    $(window).on('scroll', (evt) => {
      if (timerId) {
        clearTimeout(timerId);
      }

      timerId = setTimeout(() => {
        let scrollTop = window.scrollY;
        let windowHeight = window.innerHeight;
        let documentHeight = $(document).height();

        if ((scrollTop + windowHeight + 50) >= documentHeight) {
          if (page > totalPage) {
            return;
          }
          page++;
          fnGetBlogList();
        }
      }, 500);
    });
  }

 /*  const fnBlogDetail = () => {
    $(document).on('click', '.anon', (evt) => {
      console.log("evt::: " + evt.target.dataset.postNo);
      location.href = '${contextPath}/anon/detail.do?postNo=' + evt.currentTarget.dataset.postNo;
    });
  } */
  
  const fnBlogDetail = () => {
	  
	  $(document).on('click', '.anon', (evt) => {
	    // <div class="blog"> 중 클릭 이벤트가 발생한 <div> : 이벤트 대상
	    // evt.target.dataset.blogNo === $(evt.target).data('blogNo')
	    // evt.target.dataset.userNo === $(evt.target).data('userNo')
	    
	    // 내가 작성한 블로그는 /detail.do 요청 (조회수 증가가 없음)
	    // 남이 작성한 블로그는 /updateHit.do 요청 (조회수 증가가 있음)
	    if('${sessionScope.user.employeeNo}' === evt.target.dataset.authorNo) {
	    	location.href = '${contextPath}/anon/detail.do?postNo=' + evt.currentTarget.dataset.postNo;
	    } else {
	      	location.href = '${contextPath}/anon/updateHit.do?postNo=' + evt.currentTarget.dataset.postNo;      
	    }
	    
	  })
	  
	}

  const fnInsertResult = () => {
    const insertResult = '${insertResult}';
    if (insertResult !== '') {
      alert(insertResult);
    }
  }

  const fnRemoveResult = () => {
    const removeResult = '${removeResult}';
    if (removeResult !== '') {
      alert(removeResult);
    }
  }
  
  
  const chkAdmin = () => {	  
	  if(${sessionScope.user.depart.departmentNo != 3 && sessionScope.user.depart.departmentNo != 0}){ // 운영팀 번호로 수정 
		  alert("잘못된 접근입니다.");
		  location.href = "${contextPath}/main.page";
	  } else {		
		  $(document).ready(function() {
		      // 모달 열기 함수
		      function openModal(reportNo, categoryName, description, reportDate, postNo) {
		          $('#goToPostButton').data('post-no', postNo);
		          let modal = $('#reportModal');
		          let reportDetails = $('#reportDetails');

		          // 모달에 신고 상세 정보 채우기
		          reportDetails.empty();
		          reportDetails.append('<p><strong>신고번호:</strong> ' + reportNo + '</p>');
		          reportDetails.append('<p><strong>신고사유:</strong> ' + categoryName + '</p>');
		          reportDetails.append('<p><strong>신고내용:</strong> ' + description + '</p>');
		          reportDetails.append('<p><strong>신고현황:</strong> ' + reportDate + '</p>');

		          // 모달 보이기
		          modal.css('display', 'block');
		      }

		      // 모달 닫기 함수
		      function closeModal() {
		          $('#reportModal').css('display', 'none');
		      }

		      // 동적으로 추가된 요소에 대한 이벤트 위임
		      $('#report-list').on('click', '.report', function() {
		          let reportNo = $(this).data('report-no');
		          let categoryName = $(this).find('span:nth-of-type(2)').text();
		          let description = $(this).data('description');
		          let reportDate = $(this).find('span:nth-of-type(3)').text();
		          let postNo = $(this).data('post-no');

		          openModal(reportNo, categoryName, description, reportDate, postNo);
		      });

		      // 게시글로 이동 버튼 클릭 이벤트
		      $('#goToPostButton').click(function() {
		          let postNo = $(this).data('post-no');
		          location.href = '${contextPath}/anon/detail.do?postNo=' + postNo;
		      });

		      // 삭제 버튼 클릭 이벤트 (신고 삭제)
		      $('#deleteReportButton').click(function() {
		          let reportNo = $('#reportDetails p:first').text().split(': ')[1];
		          $.ajax({
		              type: 'POST',
		              url: '${contextPath}/report/removeReport.do',
		              data: { reportNo: reportNo },
		              success: function(response) {
		                  alert('신고가 삭제되었습니다.');
		                  closeModal();
		                  location.reload(); // 페이지 새로고침
		              },
		              error: function(jqXHR) {
		                  alert('삭제 실패: ' + jqXHR.statusText + '(' + jqXHR.status + ')');
		              }
		          });
		      });

		      // 삭제 버튼 클릭 이벤트 (게시글 삭제)
		      $('#deletePostButton').click(function() {
		          let postNo = $('#goToPostButton').data('post-no');
		          $.ajax({
		              type: 'POST',
		              url: '${contextPath}/anon/updatePostStatus.do',
		              data: { postNo: postNo, employeeStatus: 2},
		              success: function(response) {
		                  alert('게시글이 삭제되었습니다.');
		                  closeModal();
		                  location.reload(); // 페이지 새로고침
		              },
		              error: function(jqXHR) {
		                  alert('삭제 실패: ' + jqXHR.statusText + '(' + jqXHR.status + ')');
		                  closeModal();
		              }
		          });
		      });

		      // 취소 버튼 클릭 이벤트
		      $('#cancelButton').click(function() {
		          closeModal();
		      });

		      // 초기 데이터 로드 및 이벤트 핸들러 설정
		      fnGetBlogList();
		  });
	  }
  }
  
  chkAdmin();
  
  /* $(document).ready(function() {
      // 모달 열기 함수
      function openModal(reportNo, categoryName, description, reportDate, postNo) {
          $('#goToPostButton').data('post-no', postNo);
          let modal = $('#reportModal');
          let reportDetails = $('#reportDetails');

          // 모달에 신고 상세 정보 채우기
          reportDetails.empty();
          reportDetails.append('<p><strong>신고번호:</strong> ' + reportNo + '</p>');
          reportDetails.append('<p><strong>신고사유:</strong> ' + categoryName + '</p>');
          reportDetails.append('<p><strong>신고내용:</strong> ' + description + '</p>');
          reportDetails.append('<p><strong>신고시간:</strong> ' + reportDate + '</p>');

          // 모달 보이기
          modal.css('display', 'block');
      }

      // 모달 닫기 함수
      function closeModal() {
          $('#reportModal').css('display', 'none');
      }

      // 동적으로 추가된 요소에 대한 이벤트 위임
      $('#report-list').on('click', '.report', function() {
          let reportNo = $(this).data('report-no');
          let categoryName = $(this).find('span:nth-of-type(2)').text();
          let description = $(this).data('description');
          let reportDate = $(this).find('span:nth-of-type(3)').text();
          let postNo = $(this).data('post-no');

          openModal(reportNo, categoryName, description, reportDate, postNo);
      });

      // 게시글로 이동 버튼 클릭 이벤트
      $('#goToPostButton').click(function() {
          let postNo = $(this).data('post-no');
          location.href = '${contextPath}/anon/detail.do?postNo=' + postNo;
      });

      // 삭제 버튼 클릭 이벤트 (신고 삭제)
      $('#deleteReportButton').click(function() {
          let reportNo = $('#reportDetails p:first').text().split(': ')[1];
          $.ajax({
              type: 'POST',
              url: '${contextPath}/report/removeReport.do',
              data: { reportNo: reportNo },
              success: function(response) {
                  alert('신고가 삭제되었습니다.');
                  closeModal();
                  location.reload(); // 페이지 새로고침
              },
              error: function(jqXHR) {
                  alert('삭제 실패: ' + jqXHR.statusText + '(' + jqXHR.status + ')');
              }
          });
      });

      // 삭제 버튼 클릭 이벤트 (게시글 삭제)
      $('#deletePostButton').click(function() {
          let postNo = $('#goToPostButton').data('post-no');
          $.ajax({
              type: 'POST',
              url: '${contextPath}/anon/updatePostStatus.do',
              data: { postNo: postNo, employeeStatus: 2},
              success: function(response) {
                  alert('게시글이 삭제되었습니다.');
                  closeModal();
                  location.reload(); // 페이지 새로고침
              },
              error: function(jqXHR) {
                  alert('삭제 실패: ' + jqXHR.statusText + '(' + jqXHR.status + ')');
                  closeModal();
              }
          });
      });

      // 취소 버튼 클릭 이벤트
      $('#cancelButton').click(function() {
          closeModal();
      });

      // 초기 데이터 로드 및 이벤트 핸들러 설정
      fnGetBlogList();
  }); */

  
/*   fnScrollHandler();
  fnBlogDetail();
  fnInsertResult();
  fnRemoveResult(); */
</script>

<%@ include file="../layout/footer.jsp" %>
