<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="공지사항" name="title"/>
 </jsp:include>
 



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

.blog-list-container {
    max-width: 80%;
    margin: 20px auto;
    margin-left: 18%;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.blog-list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.blog-list-header h1 {
    margin: 0;
    font-size: 24px;
    color: #555;
}

.blog-list-header a {
    padding: 10px 20px;
    background-color: tomato;
    color: #fff;
    border-radius: 4px;
    text-decoration: none;
}

.blog-list-header a:hover {
    background-color: #e04e4e;
}

table.blog-list-table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
}

table.blog-list-table thead tr {
    background-color: #f5f5f5;
}

table.blog-list-table th, table.blog-list-table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

table.blog-list-table th {
    font-weight: bold;
    color: #333;
}

table.blog-list-table td {
    color: #666;
}

table.blog-list-table tbody tr:hover {
    background-color: #f1f1f1
    }
    
    .board-tag-txt {
    display: block;
    width: 56px;
    height: 21px;
    box-sizing: border-box;
    border-radius: 3px;
    font-size: 11px;
    font-weight: 800;
    line-height: 19px;
    border: 1px solid #ffc6c9;
    background-color: #ffe3e4;
    color: #ff4e59;
    text-align: center;
}

.inner {
    text-align: center;
    color: #ff4e59;
    font-size: 11px;
    font-weight: 800;
    line-height: 19px;
}

</style>

   <!-- Main content -->
<section class="content">
  <div class="blog-list-container">
    <div class="blog-list-header">
      <h1 class="title">공지사항 목록</h1>
        <a href="${contextPath}/blog/write.page">공지사항 작성</a>
    </div>

    <table id="blog-list" class="blog-list-table">
      <thead>
        <tr>
          <th>종류</th>
          <th>제목</th>
          <th>부서 및 작성자</th>
          <th>이메일</th>
          <th>작성일</th>
        </tr>
      </thead>
      <tbody>
        <!-- 데이터가 여기에 추가될 예정 -->
      </tbody>
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

<script>
  // 전역 변수
  var page = 1;
  var totalPage = 0;

  const categoryMap = {
    0: '(대표실)',
    1: '(행정부)',
    2: '(인사팀)',
    3: '(운영팀)',
    4: '(강사팀)'
  };

  const fnGetBlogList = () => {
	    // page에 해당하는 목록 요청
	    $.ajax({
	        // 요청
	        type: 'GET',
	        url: '${contextPath}/blog/getBlogList.do',
	        data: 'page=' + page,
	        // 응답
	        dataType: 'json',
	        success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
	            totalPage = resData.totalPage;
	            $.each(resData.blogList, (i, blog) => {
	                let categoryName = categoryMap[blog.employee.departmentNo];
	                let str = '<tr class="blog" data-author-no="' + blog.authorNo + '" data-notipost-no="' + blog.notiPostNo + '">';
	                str += '<td class="board-tag"><span class="board-tag-txt">공지</span></td>';
	                str += '<td>' + blog.title + '</td>';
	                str += '<td>' + categoryName + " : " + blog.employee.name + '</td>';
	                str += '<td>' + blog.employee.email + '</td>';
	                str += '<td>' + moment(blog.postDate).format('YYYY.MM.DD') + '</td>';
	                str += '</tr>';
	                $('#blog-list tbody').append(str);
	            });
	        },
	        error: (jqXHR) => {
	            alert(jqXHR.statusText + '(' + jqXHR.status + ')');
	        }
	    });
	}

  const fnScrollHandler = () => {
    // 스크롤이 바닥에 닿으면 page 증가(최대 totalPage 까지) 후 새로운 목록 요청
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
    $(document).on('click', '.blog', (evt) => {
      location.href = '${contextPath}/blog/detail.do?notiPostNo=' + evt.currentTarget.dataset.notipostNo;
    });
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