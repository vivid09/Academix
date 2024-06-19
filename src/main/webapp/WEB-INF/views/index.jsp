<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="메인" name="title"/>
 </jsp:include>

<link rel="stylesheet" href="/css/index.css">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- User Info -->
                <div class="col-md-4">
                    <div class="panel panel-default rounded-panel">
                        <div class="panel-body text-center">
                            <div class="img-pro"><c:if test="${sessionScope.user.profilePicturePath != null}">
							          ${sessionScope.user.profilePicturePath}
							        </c:if>
							        <c:if test="${sessionScope.user.profilePicturePath == null}">
							          <img src="${contextPath}/resources/images/default_profile_image.png" style="width:50px;">
							        </c:if></div>
			                            <h5 class="panel-title">${sessionScope.user.name} 님 만나서 반갑습니다.</h5>
			                            <p class="panel-text">
			                              <c:choose>
									        <c:when test="${sessionScope.user.depart.departmentNo == '0'}">
									            Academix
									        </c:when>
									        <c:when test="${sessionScope.user.depart.departmentNo == '1'}">
									            행정부
									        </c:when>
									        <c:when test="${sessionScope.user.depart.departmentNo == '2'}">
									            인사팀
									        </c:when>
									        <c:when test="${sessionScope.user.depart.departmentNo == '3'}">
									            운영팀
									        </c:when>
									        <c:when test="${sessionScope.user.depart.departmentNo == '4'}">
									            강사
									        </c:when>
									        <c:otherwise>
									            Unknown Department
									        </c:otherwise>
									    </c:choose>
			                           </p>
			                            <p class="panel-text">${sessionScope.user.email}</p>
			                            <p class="panel-text">${sessionScope.user.phone}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Notices -->
                <div class="col-md-8">
                    <div class="panel panel-default rounded-panel">
                        <div class="panel-heading">
                            공지사항
                        </div>
                        <div class="panel-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>작성자</th>
                                        <th>게시글</th>
                                        <th>작성일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Christine Brooks</td>
                                        <td>089 Kutch Green Apt. 448</td>
                                        <td>04 Sep 2019</td>
                                    </tr>
                                    <tr>
                                        <td>Rosie Pearson</td>
                                        <td>979 Immanuel Ferry Suite 526</td>
                                        <td>28 May 2019</td>
                                    </tr>
                                    <tr>
                                        <td>Darrell Caldwell</td>
                                        <td>8587 Frida Ports</td>
                                        <td>23 Nov 2019</td>
                                    </tr>
                                    <tr>
                                        <td>Gilbert Johnston</td>
                                        <td>768 Destiny Lake Suite 600</td>
                                        <td>05 Feb 2019</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row mt-4">
                <!-- Recent Emails -->
                <div class="col-md-8">
                    <div class="panel panel-default rounded-panel">
                        <div class="panel-heading">
                            최근 메시지
                        </div>
                        <div class="panel-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>보낸사람</th>
                                        <th>내용</th>
                                        <th>시간</th>
                                    </tr>
                                </thead>
                                <tbody class="message-table">
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td>Jullu Jalal</td>
                                        <td>Our Bachelor of Commerce program is ACBSP.</td>
                                        <td>8:38 AM</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td>Minerva Barnett</td>
                                        <td>Get Best Advertiser In Your Side Pocket</td>
                                        <td>8:13 AM</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td>Peter Lewis</td>
                                        <td>Vacation Home Rental Success</td>
                                        <td>7:52 PM</td>
                                    </tr>
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td>Peter Lewis</td>
                                        <td>Free Classifieds Using Them To Promote Your Stuff</td>
                                        <td>7:52 PM</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
						<!-- Weather and Time -->
            <div class="row mt-4">
                <!-- Time -->
                <div class="col-md-4">
                    <div class="panel panel-default rounded-panel shadow">
                        <div class="panel-body text-center">
                            <h5 class="panel-title">시간</h5>
                            <div class="time-container">
															<div class="current-date-time">
														    <h4 id="currentDateTime">1970-01-01(목)</h2>
														    <h4 id="currentTime">00:00:00</h3>
														  </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Weather -->
                <div class="col-md-4">
                    <div class="panel panel-default rounded-panel shadow">
                        <div class="panel-body text-center">
                            <h5 class="panel-title place"></h5>
                            <div class="mb-3">
                                <span class="temperature" style="font-size: 48px;"></span>
                            </div>
                            <img class="WeatherIcon" alt="Weather Icon">
                            <p class="panel-text description"></p>
                        </div>
                    </div>
                </div>
            </div>
        	</div>
        </div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
<!-- footer js 코드 -->  

  <!-- jQuery 2.2.3 -->
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.6 -->
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="/plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>
<!-- 메인페이지 JS -->
<script src="/js/index.js"></script>
  
<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />