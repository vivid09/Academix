<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="주소록" name="title"/>
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

.anon-list-container {
    max-width: 80%;
    margin: 20px auto;
    margin-left: 18%;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

.anon-list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.anon-list-header h1 {
    margin: 0;
    font-size: 28px;
    color: #333;
}

.anon-list-header a {
    padding: 10px 20px;
    background-color: tomato;
    color: #fff;
    border-radius: 4px;
    text-decoration: none;
    font-size: 16px;
}

.anon-list-header a:hover {
    background-color: #e04e4e;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead {
    background-color: #f1f1f1;
}

thead tr {
    border-bottom: 2px solid #ddd;
}

thead th {
    padding: 15px;
    text-align: left;
    font-size: 16px;
    color: #666;
}

tbody tr {
    border-bottom: 1px solid #ddd;
    transition: background-color 0.3s;
}

tbody tr:hover {
    background-color: #f9f9f9;
}

tbody td {
    padding: 15px;
    font-size: 14px;
    color: #333;
}

tbody td:nth-of-type(1) {
    width: 20%;
}

tbody td:nth-of-type(2) {
    width: 20%;
}

tbody td:nth-of-type(3) {
    width: 20%;
}

tbody td:nth-of-type(4) {
    width: 25%;
}

tbody td:nth-of-type(5) {
    width: 15%;
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


 
  
</style>

   <!-- Main content -->
<section class="content">
  <div class="anon-list-container">
    <div class="anon-list-header">
	    <h1 class="title">직원연락처</h1>
	  </div> 
    <table>
		  <thead>
		    <tr>
		      <th>부서</th>
		      <th>이름</th>
		      <th>직책</th>
		      <th>이메일</th>
		      <th>전화번호</th>
		    </tr>
		  </thead>
		  <tbody id="anon-list">
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

  const fnGetBlogList = () => {
    // page 에 해당하는 목록 요청
    $.ajax({
      // 요청
      type: 'GET',
      url: '${contextPath}/user/getUserList.do',
      data: 'page=' + page,
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
        totalPage = resData.totalPage;
        var sortdata = resData.employee.sort((a, b) => {
        	if (a.depart.departmentNo === b.depart.departmentNo) {
                return a.rank.rankNo - b.rank.rankNo;
            }
            return a.depart.departmentNo - b.depart.departmentNo;
            
        });
        $.each(sortdata, (i, user) => {
          let str = '';
          
                        
          str += '<tr class="anon correctPost">';
          str += '<td>' + user.depart.departName+ '</td>';
          str += '<td>' + user.name + '</td>';
          str += '<td>' + user.rank.rankTitle + '</td>';
          str += '<td>' + user.email + '</td>';
          str += '<td>' + user.phone + '</td>';
          
          str += '</tr>';           
          
          
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
  
  
  fnGetBlogList();
  fnScrollHandler();
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />
