<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="채팅" name="title"/>
 </jsp:include>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>
  <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<!-- Bootstrap 3.3.6 -->
<script src="/bootstrap/js/bootstrap.min.js"></script>

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
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>
<script src="/dist/js/pages/dashboard.js"></script>  

  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        채팅
        <!-- <small>it all starts here</small> -->
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li><a href="#">Examples</a></li>
        <li class="active">Blank page</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content chat-content">

      <!-- Default box -->
      <div class="box chat-box">
        <div class="box-header with-border">
          <div class="box-title-choice">
            <i class="fa fa-user"></i>
            <i class="fa fa-commenting"></i>
          </div>
          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
              <i class="fa fa-minus"></i></button>
            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
              <i class="fa fa-times"></i></button>
          </div>
        </div>
        <div class="box-body chat-member">
          <p class="chat-member-title" data-toggle="modal" data-target="#modal-default">직원 목록</p>
          <input type="text" class="searchInput" placeholder="직원 검색">
          <div id="memberArea"></div>
        </div>
        <div class="btn-addChatroom">
          <button type="button" class="btn btn-block btn-primary">+새 채팅방 만들기</button>
        </div>
        
      </div>
      
      <!-- 모달창 -->
      <div class="example-modal">
        <div class="modal fade" id="modal-default" style="display: none;">
          <div class="modal-dialog">
            <div class="modal-content">
            
              <!-- 이 부분 프로필 조회, 채팅방 이름 변경에 따라 동적 생성 -->


              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">프로필 조회</h4>
              </div>
              <div class="modal-body chatModal-body">
              	<!-- 여기에 내용 넣으면 됨. -->
              	<div class="chat-modal-profile">
	              	<img src="/dist/img/user8-128x128.jpg" class="img-circle" alt="User Image">
	              	<p>이름</p>
	              	<span>부서</span>
	              	<div class="btn-oneToOneChat">
	              	  <i class="fa fa-commenting"></i>
	              	  <p>1:1 채팅</p>
	              	</div>
              	</div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
              </div>
              
              
        
              

              
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
      
      
      
<!-- 	<div class="modal fade" id="modal-default" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span></button>
					<h4 class="modal-title">Default Modal</h4>
				</div>
					<div class="modal-body">
						<p>One fine body…</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save changes</button>
					</div>
			</div>
		
		</div>
	
	</div> -->
      
      

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  
  <style>
    
    .chat-content {
      height: 100vh;
      width: 100%;
    }
    
    .chat-box {
      height: 100%;
      width: 30%;
      border-top-color: #3c8dbc;
    }
    
    /* 화면 너비가 768px 이하일 때 */
   	@media screen and (max-width: 768px) {
      .chat-box {
        width: 100%;
      }
    }

    /* 화면 너비가 425px 이하일 때 */
    @media screen and (max-width: 425px) {
      .chat-box {
        width: 100%;
      }
    }    
    
    .chat-member {
	  	height: 80%;
  	    padding: 5%;
    }
    
    .box-title-choice {
      margin-left: 3%;
      font-size: 20px;
    }
    
    .box-title-choice > i {
	    margin-right: 3%;
		}
    
    
    /* 모달창 */
    
    
/*    
     .example-modal .modal {
      position: relative;
      top: auto;
      bottom: auto;
      right: auto;
      left: auto;
      display: block;
      z-index: 150;
    }

    .example-modal .modal {
      background: transparent !important;
    }
*/
    .chat-modal-profile {
      text-align: center;
    }
    
    .chat-modal-profile > p {
      font-size: 24px;
      padding: 10px 0;
    }
    
    .chat-member-title {
      font-size: 18px;
      font-weight: 600;
    }    
    
	.btn-oneToOneChat i {
      font-size: 23px;
	}     
	
	.btn-addChatroom {
	  width: 90%;
      margin: 0 auto;
	}

  </style>
  
  <script>
  
  // 조직도 가져오기
  $(document).ready(function() {
    $.ajax({
        type: 'GET',
        url: '${contextPath}/user/getUserList.do',
        dataType: 'json',
        success: (resData) => {
      	  
      	  // 변환한 데이터 담을 배열 선언
      	  var jstreeData = [];
      	  
      	  // employee 데이터에서 대표데이터만 빼서 root node 설정
      	  var ceo = resData.employee.find(employee => employee.rank.rankTitle === '대표이사');
      	  console.log(ceo);
      	  if(ceo) {
      		  jstreeData.push({
      			  id: (ceo.employeeNo - 1).toString(),
      			  parent: '#',
      			  text: ceo.name + ' ' + ceo.rank.rankTitle,
      			  icon: "fas fa-user-tie"
      		  });
      	  }
      	  
      	  // 부서 데이터
      	  resData.departments.forEach(function(department) {
      		  if(department.departName !== '대표실') { // 대표실 제외
      			  jstreeData.push({
      				  id: department.departmentNo.toString(),
      				  parent: department.parentDepartNo.toString(),
      				  text: department.departName,
      				  icon: "fas fa-user-group"
      			  });
      		  }
      	  });
      	  
      	  // 직원 데이터
      	  resData.employee.forEach(function(employee) {
      		  if(employee.depart.departmentNo !== 0 && employee.employeeStatus !== 0){ // 대표이사 제외
      			  if(employee.rank.rankNo === 5) {
           		  jstreeData.push({
           			  id: 'emp_' + employee.employeeNo,
           			  parent: employee.depart.departmentNo.toString(),
           			  text: employee.name + ' ' + employee.rank.rankTitle,
           			  icon: "fas fa-chalkboard-teacher"
           		  });
      			  } else {
	           		  jstreeData.push({
	           			  id: 'emp_' + employee.employeeNo,
	           			  parent: employee.depart.departmentNo.toString(),
	           			  text: employee.name + ' ' + employee.rank.rankTitle,
	           			  icon: "fas fa-user"
	           		  });
      			  }
      		  }
      	  });
      	  
      	  console.log('jstreeData: ', jstreeData);
      	  
      	  
      	  // jstree 데이터 추가 - jstree가 로드되면 모든 노드 열리게 설정
      	  $('#memberArea').jstree({
      		  'core': {
      			  'data': jstreeData,
     	        'themes': {
    	           'icons': false  
     	        }
      		  },
      		  'plugins': ['search', 'checkbox'],
		   		  'checkbox': {
				       'keep_selected_style': true,
				       'three_state': false,
				       'whole_node' : false,
				       'tie_selection' : false,
				       'cascade': 'down'
				    }      		  
      	  }).on('ready.jstree', function() {
      		  $(this).jstree(true).open_all();
      	  })
      	  
	       },
	       error: function(jqXHR, textstatus, errorThrown) {
	    	   console.error("실패", textStatus, errorThrown);
	       }
	     });
			
	    // 검색 기능 추가
	    $('.searchInput').on('keyup', function() {
	  	  var searchString = $(this).val();
	  	  $('#memberArea').jstree('search', searchString);
	    });
    
	});
  
  
  // 프로필 조회하기
  fnGetProfile = () => {
	  
	  $('#memberArea').bind('select_node.jstree', function(event, data) {
		  var selectedNode = data.node;
		  var employeeNo;
		  
		  // id가 emp를 포함하지 않는데 0인 경우 -> 대표이사
		  // id가 emp를 포함하는데 0이 아닌 경우 -> return;
		  // id가 emp를 포함하는 경우 -> 그대로..
		  if(selectedNode.id.includes('emp_')) {
			  employeeNo = selectedNode.id.replace('emp_', '');
		  } else if(selectedNode.id === '0' && !selectedNode.id.includes('emp_')){
			  employeeNo = 1
		  } else {
			  return;
		  }
		  
	  $.ajax({
	      type: 'GET',
	      url: '${contextPath}/user/getUserProfileByNo.do',
	      data: {
	    	  employeeNo: employeeNo
	      },
	      dataType: 'json',
	      success: (resData) => {
	    	  
	    	  console.log(resData);
	    	  
	    	  $('.chat-modal-profile > p').text(resData.employee.name);
	    	  $('.chat-modal-profile > span').text(resData.employee.depart.departName);
	    	  $('#modal-default').modal('show');
	    	  
	      },
	      error: (xhr, status, error) => {
	    	  console.log(error);
	      }
	    })
	  })
  }
 
  fnGetProfile();
  
  </script>
  
<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />