<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp"/>

<style>

.content {
    min-height: 1080px;
}

.main-footer {
    margin-left: 18%;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
    color: #333;
}

.anon-list-container {
    max-width: 80%;
    margin: 20px auto;
    margin-left: 18%;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.anon-list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.anon-list-header h1 {
    margin: 0;
    font-size: 24px;
    color: #555;
}

.anon-list-header a {
    padding: 10px 20px;
    background-color: tomato;
    color: #fff;
    border-radius: 4px;
    text-decoration: none;
}

.anon-list-header a:hover {
    background-color: #e04e4e;
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
}

table thead tr {
    background-color: #f5f5f5;
}

table th, table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

table th {
    font-weight: bold;
    color: #333;
}

table td {
    color: #666;
}

table tbody tr:hover {
    background-color: #f1f1f1;
}

table tbody tr td:nth-of-type(1) {
    width: 10%;
}

table tbody tr td:nth-of-type(2) {
    width: 50%;
}

table tbody tr td:nth-of-type(3) {
    width: 20%;
}

table tbody tr td:nth-of-type(4) {
    width: 20%;
    text-align: right; /* 조회수를 오른쪽으로 정렬 */
    padding-right: 20px; /* 오른쪽 구석으로 더 밀기 위해 패딩 추가 */
}

table th:nth-of-type(4) {
    text-align: right; /* 조회수 헤더를 오른쪽으로 정렬 */
}

.headtitle {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    margin: 10px 0;
    border-radius: 4px;
    background-color: #fff;
    cursor: pointer;
    transition: background-color 0.3s;
}
  .delete-time {
    margin-left: 400px; /* 원하는 간격으로 조절 */
  }
  
</style>

   <!-- Main content -->
<section class="content">
  <div class="anon-list-container">
    <div class="anon-list-header">
      <h1 class="title">익명게시판 목록</h1>
      <a href="${contextPath}/anon/write.page">익명게시글 작성</a>
    </div>
    
    <table>
      <thead>
        <tr>
          <th>게시글번호</th>
          <th>제목</th>
          <th>작성일자</th>
          <th>조회수</th>
        </tr>
      </thead>
      <tbody id="anon-list"></tbody>
    </table>
  </div>
</section>
<!-- /.content -->

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
		
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
       <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>

<script>
  // 전역 변수
  var page = 1;
  var totalPage = 0;

  const fnGetBlogList = () => {
	    // page 에 해당하는 목록 요청
	    $.ajax({
	      // 요청
	      type: 'GET',
	      url: '${contextPath}/anon/getAnonList.do',
	      data: 'page=' + page,
	      // 응답
	      dataType: 'json',
	      success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
	        totalPage = resData.totalPage;
	        $.each(resData.anonList, (i, anon) => {
	          let str = '';
	          // 삭제된 게시글 status 0
	          if (anon.status === 0) {
	            str += '<tr class="anon">';
	            str += '<td colspan="4">삭제된 게시글입니다.<span class="delete-time">삭제시간 : ' + moment(anon.postDate).format('YYYY.MM.DD HH:mm:ss') + '</span></td>';
	            str += '</tr>';
	          } else if (anon.status === 2) {
	            str += '<tr class="anon">';
	            str += '<td colspan="4" style="color:red">관리자에 의해 삭제된 게시글입니다.<span class="delete-time">삭제시간 : ' + moment(anon.postDate).format('YYYY.MM.DD HH:mm:ss') + '</span></td>';
	            str += '</tr>';
	          } else {
	            str += '<tr class="anon correctPost" data-author-no="' + anon.authorNo + '" data-post-no="' + anon.postNo + '">';
	            str += '<td>' + anon.postNo + '</td>';
	            str += '<td>' + anon.title + '</td>';
	            str += '<td>' + moment(anon.postDate).format('YYYY.MM.DD') + '</td>';
	            str += '<td>' + anon.hit + '</td>';
	            str += '</tr>';
	          }

	          $('#anon-list').append(str);
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

  
  const fnBlogDetail = () => {
    
    $(document).on('click', '.correctPost', (evt) => {
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

  fnGetBlogList();
  fnScrollHandler();
  fnBlogDetail();
  fnInsertResult();
  fnRemoveResult();
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />
